pipeline {
    agent {
		label "Agent-1"
	}
     environment { 
        appVersion = ''
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
    }
  /*   parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')

        text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')

        booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')

        choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')

        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')

    } */

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