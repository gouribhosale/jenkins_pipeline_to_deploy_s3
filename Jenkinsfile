#!/usr/bin/env groovy

// Define the Jenkins pipeline
pipeline {
    agent any // Run this pipeline on any available agent

    // Define environment variables for AWS credentials and region
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID') // Access Key ID from Jenkins credentials
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY') // Secret Access Key from Jenkins credentials
        AWS_DEFAULT_REGION = "eu-west-1" // AWS region to use
    }

    // Define stages for the pipeline
    stages {
        // Stage for deploying files to S3 bucket
        stage('Deploy to S3') {
            steps {
                // Execute shell commands to copy HTML files to S3 bucket
                script {
                    sh "aws s3 cp public/index.html s3://jenkinstf-ec2-static-bucket/"
                }
            }
        }

        // Stage for setting bucket policy
        stage('Set Bucket Policy') {
            steps {
                // Execute shell command to set bucket policy using policy.json file
                script {
                    sh "aws s3api put-bucket-policy --bucket jenkinstf-ec2-static-bucket --policy file://policy.json"
                }
            }
        }
    }
}