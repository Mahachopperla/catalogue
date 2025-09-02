pipeline {
    agent {
		label "Agent-1"
	}
     environment { 
        appVersion = ''
        REGION = 'us-east-1'
        ACC_ID = '582834785619'
        PROJECT = 'roboshop'
        COMPONENT = 'catalogue'
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
    }
    parameters {
        booleanParam(name: 'deploy', defaultValue: false, description: 'Toggle this value')
    }

    stages {
        stage('Read JSON File') {
            steps {
                script {
                    // Assuming 'package.json' exists in the workspace
                    def PackageJson = readJSON file: 'package.json' 

                    // Accessing data from the parsed JSON
                    appVersion = PackageJson.version

                    // printing the extracted value
                    echo "Package Version: ${appVersion}"
                }
            }
        }

         stage('Install dependencies') {
            steps {
                script {
                    sh """
                        npm install
                    """
                }
            }
        }

          stage('unit tests') {
            steps {
                script {
                    sh """
                        echo "unit tests" 
                    """
                }
            }
        }

        stage('Docker image build') {
            steps {
                script {
                    withAWS(credentials: 'AWS-auth', region: 'us-east-1') { // 'AWS-auth' is the ID of your AWS credentials in Jenkins
                        
                        sh """
                        aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.${REGION}.amazonaws.com
                        docker build -t ${ACC_ID}.dkr.ecr.${REGION}.amazonaws.com/${PROJECT}/${COMPONENT}:${appVersion} .
                        docker push ${ACC_ID}.dkr.ecr.${REGION}.amazonaws.com/${PROJECT}/${COMPONENT}:${appVersion}
                                               
                        """
                    }
                }
            }
        }

        stage('Trigger Deploy') {
            when{
                expression { params.deploy }
            }
            steps {
                script {
                    build job: 'catalogue-cd',
                    parameters: [
                        string(name: 'appVersion', value: "${appVersion}"),
                        string(name: 'deploy_to', value: 'dev')
                    ],
                    propagate: false,  // even deploy fails ci pipeline will not be effected
                    wait: false // ci pipeline will not wait for deploy pipeline completion
                }
            }
        }
       
        
    }

    post {
         always { 
            echo 'I will always say Hello again!'
            deleteDir()
        }

        success {
            echo "This build is completed successfully"
        }
        failure { 
            echo 'Hello Failure'
        }
    }
}