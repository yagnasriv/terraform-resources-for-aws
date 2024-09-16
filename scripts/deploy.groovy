// deploy.groovy
def deploy() {
    println "Deploying AWS resources with Terraform..."
    sh 'terraform init'
    sh 'terraform apply -auto-approve'
}

return this