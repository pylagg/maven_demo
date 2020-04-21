pipeline{
	agent any
	tools{
	maven 'MAVEN_HOME'
	}

	      stage('Build Stage')
		{
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
    }
@Library("my-shared-library@part2") _

// Entry point into microservice-pipelines
jenkinsJob.call()
