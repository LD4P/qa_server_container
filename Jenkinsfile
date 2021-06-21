pipeline {
    agent any

    options {
            buildDiscarder(logRotator(numToKeepStr: '10'))
            disableConcurrentBuilds()
            timeout(time: 1, unit: 'HOURS')
    }
environment {
        POM_VERSION = 26
        AWS_ECR_REGION = 'us-east-1'
        AWS_ECS_SERVICE = 'qa-server-service-2'
        AWS_ECS_TASK_DEFINITION = 'qa-server-woth-cluster'
        AWS_ECS_COMPATIBILITY = 'EC2'
        AWS_ECS_NETWORK_MODE = 'awsvpc'
        AWS_ECS_CPU = '256'
        AWS_ECS_MEMORY = '512'
        AWS_ECS_CLUSTER = 'qa-server-ld4p3-cluster'
        AWS_ECS_TASK_DEFINITION_PATH = './deploy-templates/task-definition.json'
        AWS_ECR_URL = '092831676293.dkr.ecr.us-east-1.amazonaws.com/qa-server/qa-server-app'
    }
    
    stages {
    
        
        stage('Build Docker Image') {
          steps {
            withCredentials([string(credentialsId: 'd30d02f9-809b-45dd-981a-dc015fb135be', variable: 'AWS_ECR_URL')]) {
              script {
                docker.build("${AWS_ECR_URL}:latest", " .")
              }
            }
          }
        }


        stage('Push Image to ECR') {
          steps {
            withCredentials([string(credentialsId: 'd30d02f9-809b-45dd-981a-dc015fb135be', variable: 'AWS_ECR_URL')]) {
              withAWS(region: "${AWS_ECR_REGION}", credentials: 'd30d02f9-809b-45dd-981a-dc015fb135be') {
                script {
                  def login = ecrLogin()
                  sh('#!/bin/sh -e\n' + "${login}") // hide logging
                  docker.image("${AWS_ECR_URL}:latest").push()
                }
              }
            }
          }
        }
        stage('Deploy in ECS') {
          steps {
            withCredentials([string(credentialsId: 'd30d02f9-809b-45dd-981a-dc015fb135be', variable: 'AWS_ECS_EXECUTION_ROL'),string(credentialsId: 'd30d02f9-809b-45dd-981a-dc015fb135be', variable: 'AWS_ECR_URL')]) {
              script {
                updateContainerDefinitionJsonWithImageVersion()
                sh("/usr/bin/aws ecs register-task-definition --region ${AWS_ECR_REGION} --family ${AWS_ECS_TASK_DEFINITION} --execution-role-arn ${AWS_ECS_EXECUTION_ROL} --requires-compatibilities ${AWS_ECS_COMPATIBILITY} --network-mode ${AWS_ECS_NETWORK_MODE} --cpu ${AWS_ECS_CPU} --memory ${AWS_ECS_MEMORY} --container-definitions file://${AWS_ECS_TASK_DEFINITION_PATH}")
                def taskRevision = sh(script: "/usr/bin/aws ecs describe-task-definition --task-definition ${AWS_ECS_TASK_DEFINITION} | egrep \"revision\" | tr \"/\" \" \" | awk '{print \$2}' | sed 's/\"\$//'", returnStdout: true)
                sh("/usr/bin/aws ecs update-service --cluster ${AWS_ECS_CLUSTER} --service ${AWS_ECS_SERVICE} --task-definition ${AWS_ECS_TASK_DEFINITION}:${taskRevision}")
              }
            }
          }
        }
    }
    
}