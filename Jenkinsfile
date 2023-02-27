pipeline{
    agent any

    tools {
        maven "maven-3.8.7"
    }
stages {
        stage('Initialize') {
                    steps {
                      bat '''
                      echo "starting"
                      echo JAVA_HOME=%JAVA_HOME%
                      '''
                         }
                    }
        stage('Build') {
            steps {
                git 'https://github.com/AnkitJ0107/ServiceDiscovery.git'

                // To run Maven on a Windows agent, use
                 bat 'mvn  clean install'
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.jar'
                }
            }
            stage('Build Docker Image') {
                                steps {
                                  bat '''
                                  docker build -t service_discovery .
                                  docker run -p 8761:8761 -d service_discovery
                                  '''
                                     }
                                }
        }
    }
}


}





node{
    def WORKSPACE = "/var/lib/jenkins/workspace/service-registry"
    def dockerImageTag = "service-registry${env.BUILD_NUMBER}"

    try{
        stage ('Clone Repository') {

                        bat '''
                        echo "cloning repository"

                        git 'https://github.com/AnkitJ0107/ServiceDiscovery.git',
                        branch: 'master'
                        '''

        }
        stage('Build'){
            bat 'mvn clean install'
        }
        stage('Build Docker Image'){
            dockerImage=docker.build("service-registry:${env.BUILD_NUMBER}")
        }
        stage('Deploy Docker'){
            bat '''
            echo "Docker Image Tag Name: ${dockerImageTag}"
            docker stop service-registry || true && docker rm service-registry || true
            docker run --name service-registry -d -p 8761:8761 service-registry:${env.BUILD_NUMBER}
            '''
        }

    }catch(e){
        throw e
    }
}