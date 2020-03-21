pipeline {
    agent any

    stages {

        stage('Terraform started') {
            steps {
                sh 'echo "Started...."'
                sh 'echo `pwd`'
            }
        }
	
        stage('git clone') {
            steps {
                sh 'rm -rf *;git clone https://github.com/abhpadhi/POC-Project.git'
            }
        }
        
        stage('Copy provider') {
            steps {
                sh 'cp -pr /project/provider.tf `pwd`/POC-Project'
            }
        }
        
        stage('terraform init') {
            steps {
		//sh 'cp -pr /project/.terraform `pwd`/POC-Project'
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform init -input=false `pwd`/POC-Project/'
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform plan -input=false -out `pwd`/POC-Project/terraformplan `pwd`/POC-Project' 
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform show -no-color `pwd`/POC-Project/terraformplan > `pwd`/POC-Project/terraformplan.txt'
            }
        }
        
        stage('Approval') {
            when {
                not {
                    equals expected: true, actual: params.autoApprove
                }
            }
	    
	    steps {
                script {
                        def plan = readFile '`pwd`/POC-Project/terraformplan.txt'
                        input message: "Do you want to apply the plan?",
                            parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }

        stage('Apply') {
            steps {
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform apply -input=false `pwd`/POC-Project/terraformplan'
            }
        }
    }
}
