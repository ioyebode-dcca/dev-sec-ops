def call() {

  withCredentials([usernamePassword(credentialsId: 'xx-xpi-key', passwordVariable: 'SECRET_KEY', usernameVariable: 'ACCESS_KEY')]) {
    dir("${terraformHome}") {
      sh '/usr/local/bin/terraform init -backend-config=access_key=${ACCESS_KEY} -backend-config=secret_key=${SECRET_KEY} -input=false'
    }
  }
}
