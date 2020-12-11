output "SecondZCAprivateIPaddress" {
  value       = module.zca-in-aws.SecondZCAprivateIPaddress
  description = "The private IP address of the ZCA instance."
}
output "ZCADecrypted_Password" {
  value=module.zca-in-aws.ZCADecrypted_Password
  description = "Decrypted password of the ZCA instance."
}
