// infraConfigureApplication.groovy

// Install and Configure ISRAEL application stack

import org.jenkinsci.plugins.pipeline.modeldefinition.actions.ExecutionModelAction
import org.jenkinsci.plugins.pipeline.modeldefinition.ast.ModelASTStages

def call() {

  when(deployAction.equals('Deploy-New-Gold-AMI') || deployAction.equals('Ansible-Config-Change')) {

  if (!currentBuild.rawBuild.getAction(ExecutionModelAction))
    currentBuild.rawBuild.addAction(new ExecutionModelAction(new ModelASTStages(null)))

    stage('Configure Application') {

      parallel 'FUSE-AZ': {
        stage('FUSE-AZ') {
          env.ANSIBLE_HOST_KEY_CHECKING = "False"

          dir("${ansibleHome}") {
            env.ANSIBLE_LOG_PATH = "${ansibleHome}/Ansible_Fuse_AZ.txt"
            ansiblePlaybook(
            playbook: "ansible_env.yml",
            tags: 'fuseaz',
            inventory: "environments/${deployEnv}/hosts",
            credentialsId: "${deployEnv}-az-ec2",
            hostKeyChecking: false)
          }
        }
      }, 'AMQ-DZ': {
        stage('AMQ-DZ') {
          env.ANSIBLE_HOST_KEY_CHECKING = "False"

          dir("${ansibleHome}") {
            sleep 5
            env.ANSIBLE_LOG_PATH = "${ansibleHome}/Ansible_AMQ_DZ.txt"
            ansiblePlaybook(
            playbook: "ansible_env.yml",
            tags: 'amq',
            inventory: "environments/${deployEnv}/hosts",
            credentialsId: "${deployEnv}-dz-ec2",
            hostKeyChecking: false)
          }
        }
      }, 'FUSE-DZ': {
        stage('FUSE-DZ') {
          env.ANSIBLE_HOST_KEY_CHECKING = "False"

          dir("${ansibleHome}") {
            sleep 10
            env.ANSIBLE_LOG_PATH = "${ansibleHome}/Ansible_Fuse_DZ.txt"
            ansiblePlaybook(
            playbook: "ansible_env.yml",
            tags: 'fusedz',
            inventory: "environments/${deployEnv}/hosts",
            credentialsId: "${deployEnv}-dz-ec2",
            hostKeyChecking: false)
          }
        }
      }, 'RHPAM-DZ': {
        stage('RHPAM-DZ') {
          env.ANSIBLE_HOST_KEY_CHECKING = "False"

          dir("${ansibleHome}") {
            sleep 15
            env.ANSIBLE_LOG_PATH = "${ansibleHome}/Ansible_RHPAM_DZ.txt"
            ansiblePlaybook(
            playbook: "ansible_env.yml",
            tags: 'rhpam',
            inventory: "environments/${deployEnv}/hosts",
            credentialsId: "${deployEnv}-dz-ec2",
            hostKeyChecking: false)
          }
        }
      }, 'TOOLS': {
        stage('TOOLS') {
          stage('NIFI-DZ') {
            env.ANSIBLE_HOST_KEY_CHECKING = "False"
            dir("${ansibleHome}") {
              sleep 30
              env.ANSIBLE_LOG_PATH = "${ansibleHome}/Ansible_Nifi_DZ.txt"
              ansiblePlaybook(
              playbook: "ansible_env.yml",
              tags: 'nifi',
              inventory: "environments/${deployEnv}/hosts",
              credentialsId: "${deployEnv}-dz-ec2",
              hostKeyChecking: false)
            }
          }

          stage('NGINX-DZ') {
            env.ANSIBLE_HOST_KEY_CHECKING = "False"
            dir("${ansibleHome}") {
              env.ANSIBLE_LOG_PATH = "${ansibleHome}/Ansible_Nginx_DZ.txt"
              ansiblePlaybook(
              playbook: "ansible_env.yml",
              tags: 'nginx',
              inventory: "environments/${deployEnv}/hosts",
              credentialsId: "${deployEnv}-dz-ec2",
              hostKeyChecking: false)
            }
          }
        }
      }
    }
  }
}
