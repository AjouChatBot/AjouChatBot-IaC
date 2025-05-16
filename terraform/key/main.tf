# Keypair Config Module
resource "aws_key_pair" "Amate-Instance-Key" {
  key_name = "amate_key"
  public_key = file("../.ssh/amate_ecdsa_key.pub")
}