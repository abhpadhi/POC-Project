pipeline {
    agent any

    stages {

        stage('Terraform started') {
            steps {
                sh 'echo "Started...."'
                sh 'echo `pwd`'
            }
        }
	
        //stage('git clone') {
        //    steps {
        //        sh 'rm -rf *;git clone https://github.com/abhpadhi/POC-Project.git'
        //    }
        //}
        
        //stage('Copy provider') {
        //    steps {
        //        sh 'cp -pr /project/provider.tf `pwd`/POC-Project'
        //    }
        //}
        
        stage('terraform init') {
            steps {
<<<<<<< HEAD
                sh '/app/terraform/terraform init -input=false `pwd`/POC-Project/'
                sh '/app/terraform/terraform plan -input=false -out `pwd`/POC-Project/terraformplan `pwd`/POC-Project' 
                sh '/app/terraform/terraform show -no-color `pwd`/POC-Project/terraformplan > `pwd`/POC-Project/terraformplan.txt'
=======
		//sh 'cp -pr /project/.terraform `pwd`/POC-Project'
                //sh '/mnt/dr-scripts/cwh-terraform-dr/terraform init -input=false `pwd`/POC-Project/'
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform plan -input=false -out `pwd`/POC-Project/terraformplan `pwd`/POC-Project' 
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform show -no-color `pwd`/POC-Project/terraformplan > `pwd`/POC-Project/terraformplan.txt'
>>>>>>> 124a0c346c8408680a77fb0a6564343db924965e
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
                sh '/app/terraform/terraform apply -input=false `pwd`/POC-Project/terraformplan'
            }
        }
    }
}
