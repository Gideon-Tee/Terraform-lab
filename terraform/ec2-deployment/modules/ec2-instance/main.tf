resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  associate_public_ip_address = true
  security_groups = var.security_groups
  user_data = base64encode(<<-EOF
              #cloud-config
              package_update: true
              package_upgrade: true
              packages:
                - docker.io
                - nginx
              runcmd:
                - [sudo, systemctl, start, docker]
                - [sudo, systemctl, enable, docker]
                - [sudo, usermod, -aG, docker, ubuntu]
                - [sudo, systemctl, start, nginx]
                - [sudo, systemctl, enable, nginx]
                - [sudo, docker, pull, gideontee/dwom:latest]
                - [sudo, docker, run, -d, -p, 8000:8000, --name, myapp, gideontee/dwom:latest]
                - |
                  cat > /etc/nginx/sites-available/default <<NGINXCONF
                  server {
                      listen 80;
                      location / {
                        proxy_pass http://127.0.0.1:5000/;
                        proxy_set_header Host $host;
                        proxy_set_header X-Real-IP $remote_addr;
                        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                        proxy_set_header X-Forwarded-Proto $scheme;
                      }
                  }
                  NGINXCONF
                - [nginx, -t]
                - [systemctl, restart, nginx]
              EOF
              )
}

output "instance_id" {
  value = aws_instance.web.id
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}