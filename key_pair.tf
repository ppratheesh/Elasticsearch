resource "aws_key_pair" "dev_key" {
  key_name = "dev_key"
  public_key = file(var.PUBLIC_KEY)
}
