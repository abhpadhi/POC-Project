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
		sh 'cd POC-Project'
            }
        }
        
        stage('Copy provider') {
            steps {
                sh 'cp -pr /project/provider.tf `pwd`'
            }
        }
        
        stage('terraform init') {
            steps {
                //sh '/mnt/dr-scripts/cwh-terraform-dr/terraform init -input=false'
		sh 'cp -pr /project/.terraform `pwd`'
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform init -input=false'
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform plan -input=false -out terraformplan' 
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform show -no-color terraformplan > terraformplan.txt'
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
                        def plan = readFile 'terraformplan.txt'
                        input message: "Do you want to apply the plan?",
                            parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }

        stage('Apply') {
            steps {
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform -input=false terraformplan'
            }
        }
    }
}
