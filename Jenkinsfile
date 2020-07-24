pipeline
{
    agent any
    tools
    {
        maven 'maven'
    }
    stages {
	    stage("Code Checkout") {
                	steps {
                		git branch: 'master',
                		url: 'https://github.com/pylagg/maven_demo.git'
                  	}
              }
	      stage('Build Stage') {
			steps{
				bat 'mvn package'
			}
		}
		stage('Compile Stage')
		{
			steps{
				 bat 'mvn compile'
			}
		}
		stage('Testing Stage')
		{
			steps{
				 bat 'mvn test'
			}
		}    
	    stage('SonarQube analysis') 
		{
            		steps {
                		withSonarQubeEnv('sonar') {
                                     		bat 'mvn sonar:sonar'
                		}
            		}
        	}    
		stage('Artifactory')
		{
			steps{
				bat 'mvn deploy'
			}
		}
    }
}
