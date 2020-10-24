// infrastructureBackup.groovy

// Create EC2 Image For Infrastructure Pipeline

def call() {

  stage('Backup') {
    when(deployAction.equals('Deploy-New-Gold-AMI')) {
      withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-s3-access', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {

        // Get ImageID Of Existing Images
        def fuseAppImageId = sh(script: "aws ec2 describe-images  --region us-east-1 --filters Name=name,Values=FuseAppPreDeploy-${deployEnv} --query Images[*].{ID:ImageId}|jq .[].ID",returnStdout: true).trim()
        def activemqDataImageId = sh(script: "aws ec2 describe-images  --region us-east-1 --filters Name=name,Values=ActivemqDataPreDeploy-${deployEnv} --query Images[*].{ID:ImageId}|jq .[].ID",returnStdout: true).trim()
        def fuseDataImageId = sh(script: "aws ec2 describe-images  --region us-east-1 --filters Name=name,Values=FuseDataPreDeploy-${deployEnv} --query Images[*].{ID:ImageId}|jq .[].ID",returnStdout: true).trim()
        def rhpamDataImageId = sh(script: "aws ec2 describe-images  --region us-east-1 --filters Name=name,Values=RhpamDataPreDeploy-${deployEnv} --query Images[*].{ID:ImageId}|jq .[].ID",returnStdout: true).trim()
        def nifiDataImageId = sh(script: "aws ec2 describe-images  --region us-east-1 --filters Name=name,Values=NifiDataPreDeploy-${deployEnv} --query Images[*].{ID:ImageId}|jq .[].ID",returnStdout: true).trim()

        // Get InstanceID Of Existing Instances
        def fuseAppInstanceId = sh(script: "aws ec2 describe-instances --region us-east-1 --query Reservations[].Instances[].[InstanceId] --filters Name=tag:Name,Values=fuse-${deployEnv}-app Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped|jq .[]|jq .[]",returnStdout: true ).trim()
        def amqDataInstanceId = sh(script: "aws ec2 describe-instances --region us-east-1 --query Reservations[].Instances[].[InstanceId] --filters Name=tag:Name,Values=amq-${deployEnv}-data Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped|jq .[]|jq .[]",returnStdout: true ).trim()
        def fuseDataInstanceId = sh(script: "aws ec2 describe-instances --region us-east-1 --query Reservations[].Instances[].[InstanceId] --filters Name=tag:Name,Values=fuse-${deployEnv}-data Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped|jq .[]|jq .[]",returnStdout: true ).trim()
        def rhpamDataInstanceId = sh(script: "aws ec2 describe-instances --region us-east-1 --query Reservations[].Instances[].[InstanceId] --filters Name=tag:Name,Values=rhpam-${deployEnv}-data Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped|jq .[]|jq .[]",returnStdout: true ).trim()
        def nifiDataInstanceId = sh(script: "aws ec2 describe-instances --region us-east-1 --query Reservations[].Instances[].[InstanceId] --filters Name=tag:Name,Values=nifi-${deployEnv}-data Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped|jq .[]|jq .[]",returnStdout: true ).trim()

        // De-Register Existing Images
        def amiImageNames = ["${fuseAppImageId}", "${activemqDataImageId}", "${fuseDataImageId}", "${rhpamDataImageId}", "${nifiDataImageId}"]

        for(item in amiImageNames) {
          if(item){
            sh "aws ec2 deregister-image --region us-east-1 --image-id ${item}"
          }
        }

        // Create New EC2 Images
        def argsForCreateImage = [
          ["instanceId" : "${fuseAppInstanceId}", "instanceName" : "FuseAppPreDeploy-${deployEnv}", "instanceDesc" : "PreAMIDeployFuseAppZone-${deployEnv}"],
          ["instanceId" : "${amqDataInstanceId}", "instanceName" : "ActivemqDataPreDeploy-${deployEnv}", "instanceDesc" : "PreAMIDeployActivemqDataZone-${deployEnv}"],
          ["instanceId" : "${fuseDataInstanceId}", "instanceName" : "FuseDataPreDeploy-${deployEnv}", "instanceDesc" : "PreAMIDeployFuseDataZone-${deployEnv}"],
          ["instanceId" : "${rhpamDataInstanceId}", "instanceName" : "RhpamDataPreDeploy-${deployEnv}", "instanceDesc" : "PreAMIDeployRHPAMDataZone-${deployEnv}"],
          ["instanceId" : "${nifiDataInstanceId}", "instanceName" : "NifiDataPreDeploy-${deployEnv}", "instanceDesc" : "PreAMIDeployNifiDataZone-${deployEnv}"]
        ]

        argsForCreateImage.each{ argument ->
           if("${argument['instanceId']}") {
             sh "aws ec2 create-image --region us-east-1 --instance-id ${argument['instanceId']} --name ${argument['instanceName']} --description ${argument['instanceDesc']}"
           }
        }
      }
    }
  }
}
