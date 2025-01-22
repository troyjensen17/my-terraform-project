# outputs.tf

# Output the public IP of the Kali Linux instance
output "kali_public_ip" {
  value = aws_instance.kali_linux.public_ip
}

# Output the public IP of the Ubuntu instance
output "ubuntu_public_ip" {
  value = aws_instance.ubuntu.public_ip
}

# Output the public IP of the Windows Server instance
output "windows_public_ip" {
  value = aws_instance.windows_server_2008.public_ip
}

