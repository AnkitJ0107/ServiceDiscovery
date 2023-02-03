node{
    def WORKSPACE = "/var/lib/jenkins/workspace/service-registry"
    def dockerImageTag = "service-registry${env.BUILD_NUMBER}"

    try{
        stage ('Clone Repository') {

                        bat '''
                        echo "cloning repository"
                        '''
                        git url: 'https://github.com/AnkitJ0107/ServiceDiscovery.git',
                        branch: 'master'

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