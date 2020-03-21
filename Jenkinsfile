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
                sh '/mnt/dr-scripts/cwh-terraform-dr/terraform apply POC-Project/terraformplan'
            }
        }
   }
		post { 
          		always { 
             			cleanWs()
        		}
      		}
}
