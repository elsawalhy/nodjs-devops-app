pipeline {

    agent any

    stages{
        stage('dockerlogin'){
            steps{
               
               withCredentials([
                  usernamePassword(credentialsId:'dockerhub',usernameVariable: 'DOCKER_USER',passwordVariable:'DOCKER_PASS')
               ]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
               }
            }
        } 

        stage('docker build & push image'){
            steps{

             sh"""
                docker rmi elsawalhy133/nodejs-app || true
                docker build -t elsawalhy133/nodejs-app .
                docker push elsawalhy133/nodejs-app
                """
            }
        }
        stage('create namespace nodejs-ns & deploy application on minikube') {
            steps{
            sh """
            kubectl create ns nodejs-ns || true
            cd k8s/

            kubectl apply -f pv-pvc.yml -n nodejs-ns
            kubectl apply -f db.yml -n nodejs-ns
            kubectl apply -f app.yml -n nodejs-ns

            kubectl get svc -n nodejs-ns
            """
            }
        }  

    }
}
