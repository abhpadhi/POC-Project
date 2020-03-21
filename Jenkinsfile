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
        
        stage('terraform init') {
            steps {
		sh script:'''
		#!/bin/bash
		cd "${WORKSPACE}/POC-Project"
		mkdir -p ~/.aws
		sudo cp -pr /root/.aws/credentials ~/.aws
		sudo cp -pr /root/.aws/config ~/.aws
		sudo chown -R  jenkins. ~/.aws
               	sudo /mnt/dr-scripts/cwh-terraform-dr/terraform init
                sudo /mnt/dr-scripts/cwh-terraform-dr/terraform plan -input=false -out terraformplan
                sudo /mnt/dr-scripts/cwh-terraform-dr/terraform show -no-color terraformplan > terraformplan.txt
		'''
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
                        def plan = readFile 'POC-Project/terraformplan.txt'
                        input message: "Do you want to apply the plan?",
                            parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }

        stage('Apply') {
            steps {
		sh 'sudo chown -R jenkins. /var/lib/jenkins/workspace/Pipeline-Terraform'
		sh 'cd POC-Project/;/mnt/dr-scripts/cwh-terraform-dr/terraform apply -auto-approve'
            }
        }
   }
		post { 
          		always { 
             			cleanWs()
        		}
      		}
}
