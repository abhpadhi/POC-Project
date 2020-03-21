pipeline {
    agent any

    stages {

        stage('Terraform started') {
            steps {
                sh 'echo "Started...."'
                sh 'echo pwd'
            }
        }
	
        stage('git clone') {
            steps {
                sh 'git clone https://github.com/abhpadhi/POC-Project.git'
            }
        }
        
        stage('Copy provider') {
            steps {
                sh 'cp /project/provider.tf ./jenkins'
            }
        }
        
        stage('terraform init') {
            steps {
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform init -input=false ./jenkins'
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform plan -input=false -out terraformplan ./jenkins' 
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform show -no-color terraformplan > terraformplan.txt ./jenkins'
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
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform -input=false terraformplan ./jenkins'
            }
        }
    }
}
