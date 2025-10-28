pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-2'
        GIT_BRANCH = 'main'
        CLUSTER_IDENTIFIER       = credentials('CLUSTER_IDENTIFIER')
        MASTER_USERNAME          = credentials('MASTER_USERNAME')
        MASTER_PASSWORD          = credentials('MASTER_PASSWORD')
        DATABASE_NAME            = credentials('DATABASE_NAME')
        PROXY_NAME               = credentials('PROXY_NAME')
        CLUSTER_ID               = credentials('CLUSTER_ID')
        VPC_NAME                 = credentials('VPC_NAME')
        RDS_PROXY_SECRET_NAME    = credentials('RDS_PROXY_SECRET_NAME')
        AWS_ACCESS_KEY_ID        = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY    = credentials('AWS_SECRET_ACCESS_KEY')
        REGION                   = credentials('REGION')
        MQ_USERNAME              = credentials('MQ_USERNAME')
        MQ_PASSWORD              = credentials('MQ_PASSWORD')
        HOST_INSTANCE_TYPE       = credentials('HOST_INSTANCE_TYPE')
        ENGINE_VERSION           = credentials('ENGINE_VERSION')
        BROKER_NAME              = credentials('BROKER_NAME')
        ENVIRONMENT              = credentials('ENVIRONMENT')
        BROKER_NODES             = credentials('BROKER_NODES')
    }

    stages {
        stage('Init') {
            steps {
                script {
                    sh '''
                     echo "Starting build for stears infrastructure..."
                    '''
                }
            }
        }
        stage('Clone Repo') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'github-pat',
                    usernameVariable: 'GIT_USERNAME',
                    passwordVariable: 'GIT_PASSWORD'
                )]) {
                    script {
                        sh '''
                        rm -rf stears-devops
                        git clone --branch $GIT_BRANCH https://$GIT_USERNAME:$GIT_PASSWORD@github.com/karosi12/stears-devops.git
                        cd stears-devops
                        '''
                    }
                }
            }
        }

        stage('AWS Login') {
            steps {
                echo "Configuring AWS credentials..."
                sh '''
                aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
                aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
                aws configure set region "$AWS_REGION"

                echo "Verifying AWS identity..."
                aws sts get-caller-identity
                '''
            }
        }

        stage('Generate terraform.tfvars') {
            steps {
                dir('stears-devops/infra') {
                    sh 'chmod +x generate_tfvars.sh'
                    sh './generate_tfvars.sh'
                    sh 'echo "Generated terraform.tfvars:" && cat terraform.tfvars'
                }
            }
        }
        stage('Terraform Init') {
            steps {
                dir('stears-devops/infra') {
                    script {
                        sh '''
                        terraform init -reconfigure
                        '''
                    }
                }
            }
        }

        stage('Terraform plan') {
            steps {
                dir('stears-devops/infra') {
                    script {
                        sh '''
                        terraform plan -out "stears.tfplan"
                        '''
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('stears-devops/infra') {
                    script {
                        sh '''
                        terraform apply -auto-approve "stears.tfplan"
                        '''
                    }
                }
            }
        }
    }
}
