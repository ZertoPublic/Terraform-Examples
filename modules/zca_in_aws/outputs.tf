output "SecondZCAprivateIPaddress" {
  value       = aws_instance.zertozca.private_ip
  description = "The private IP address of the ZCA instance."
}
output "ZCADecrypted_Password" {
  value=rsadecrypt(aws_instance.zertozca.password_data, file("location of pem file to decrypt AWS ZCA"))
  description = "Decrypted password of the ZCA instance."
}
