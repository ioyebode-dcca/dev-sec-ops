// infrastructureProvisionAwsResources.groovy

// Provision AWS Resources

def call() {
  stage('Provision AWS Resources') {
    when(deployAction.equals('Deploy-New-Gold-AMI') || deployAction.equals('Terraform-Config-Change')) {
      withCredentials([usernamePassword(credentialsId: 'xx-xpi-key', passwordVariable: 'SECRET_KEY', usernameVariable: 'ACCESS_KEY')]) {
        dir("${terraformHome}") {
          sh "/usr/local/bin/terraform workspace select ${deployEnv}"
          sh '/usr/local/bin/terraform apply -input=false -auto-approve tfplan'

          if(deployAction.equals('Deploy-New-Gold-AMI')) {
            println "Starting Sleep"
            sleep 120
          }
        }
      }
    }
  }
}
