### Here's an example of how to create an EBS snapshot resource in Terraform:
### To create backups or snapshots of EBS volumes associated with your EC2 instances using Terraform, 
# you would typically use the aws_ebs_snapshot resource


resource "aws_ebs_snapshot" "example_snapshot" {
  volume_id = "vol-07b9f8e7277bbc5f4" ## VolumeID either from the EC2 instance or EBS section 
  storage_tier = "standard"  # Replace with your EBS volume ID
  
  tags = {
    Name = "MyBackup-YV"
  }
}

resource "aws_backup_plan" "example" {
  name = "my-backup-plan"
  rule {
    rule_name         = "daily-backup"
    target_vault_name = "my-backup-vault"
    schedule          = "cron(0 12 * * ? *)"
    start_window      = 360
  }
}


