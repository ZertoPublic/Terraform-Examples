#provider "aws" {
#  profile = "default"
#  region  = "us-east-1"
#}

resource "aws_instance" "zertozca" {
  ami                    = "ami-049a9302e4495ceca"
  instance_type          = "m5.xlarge"
  key_name               = "str - enter keypair here"
  subnet_id              = "str - enter subnet id here"
  vpc_security_group_ids = ["str - enter sg ids here"]
  private_ip             = "str - enter requested IP here"
  iam_instance_profile   = "str - enter instance profile info here"
  get_password_data      = true
  user_data              = <<EOF
<powershell>
& 'C:\Users\Administrator\Desktop\Zerto ZCA AWS Installer.exe' -s -SiteName 'AWS' -SiteExternalIp 'str - enter ip here'
</powershell>
EOF

  tags = {
    Name = "str - enter name of ZCA here"
  }
}
