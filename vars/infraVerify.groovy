def call() {
  stage('Verify') {
    parallel 'Verify Terraform': {
      stage('verify Terraform') {
        sh '/usr/local/bin/terraform -v'
      }

    }, 'Verify Ansible': {
      stage('Verify Ansible') {
        sh 'ansible --version'
      }

    }, 'Verify AWS Cli': {
      stage('verify AWS Cli') {
        sh 'aws --version'
      }

    }, 'Verify Inspec': {
      stage('Verify Inspec') {
        sh 'inspec -v'
      }

    }, 'Verify Jq': {
      stage('Verify Jq') {
        sh 'jq --version'
      }
    }
  }
}
