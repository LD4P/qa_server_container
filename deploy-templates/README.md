# Deployment Templates for Amazon Web Services (AWS)

This deployment has three basic pieces:
* The application, running within a container that is hosted in Amazon Elastic Container Service (ECS)
* An environment file, residing in a S3 bucket that the container has permission to access
* A filesystem containing two volumes that the container can mount. This filesystem can be implemented either as an Elastic Block Store (EBS) volume or an Elastic File System (EFS).

Two templates are provided, a CloudFormation template and a standalone ECS task definition. Both require customization to your environment by populating various values; in the CloudFormation version these values can be passed in as parameters when the stack is created or updated.

# Prerequisites

This deployment assumes that you have an AWS account, and an Identity and Access Management (IAM) account within your AWS account that allows enough access to create, update, and destroy all the necessary resources. If your IAM user lacks sufficient privileges, your deployment will stop with an error message telling you so.

To use this deployment, you will need the following pieces of infrastructure in place in your AWS account before you begin:
1. A repo containing a successfully built Docker image. This can be an Elastic Container Registry (ECR) repository or a public or private repo hosted elsewhere. Building the application image and pushing it to the repo should already be done, and you will need the full path to the image, including the repository URL and image tag (usually :latest). Full documentation on this process is available at .
2. A Simple Storage Service (S3) bucket containing an environment file that has been populated with valid values. The file contains secrets and other parameters necessary for the application to run, an .env.example file has been provided as a template. The S3 bucket must contain this file, and the bucket permissions must be configured to allow access from the Amazon ECS task execution IAM role, but it should not be open to the public. Full documentation on setup is available at https://docs.aws.amazon.com/AmazonECS/latest/developerguide/taskdef-envfiles.html.
3. A filesystem that the containers can mount. At this point, only EFS volumes are supported, EBS will be supported in the future. This deployment assumes one EFS filesystem with two separate access points. The first access point contains the authority files, and it should be pre-populated with the files you want to use. The second will contain the database storage files, and this should provision itself on the first run.
While it's not strictly required, you should also have control over a domain space where you are able to create and update DNS records. 

# Files and Templates

This folder contains several files you can use to deploy the qa-server container into ECS after the above prerequisites have been met. The most complete solution can be found in the aws-cloudformation.yaml file, which will create all the necessary resources including an EC2 cluster, an ECS task definition, and an ECS service with a public-facing load balancer. To use this template, you will need to make a copy of parameters.env.example and rename it to parameters.env, then populate it with the values appropriate to your environment. CloudFormation will read those values from the file if you pass it on the command line when you create or update the stack. Instructions on the individual parameters can be found in the CloudFormation template. 

For those who may not want to create all of the resources from scratch, you can simply edit the CloudFormation template to exclude the unwanted resources; if you have an existing infrastructure and you only want the ECS task definition, that is provided in the form of the task-definition.json file. The task definition file also requires you to fill in values appropriate to your environment, however, as a simple JSON document it does not allow for variable substitution (or even comments). The variables have been indicated with angle brackets, and they have been named consistent with the variables in the CloudFormation template, so you can use the instructions in the latter to help with filling them in. Once the values are in place, the JSON file can be used to create an ECS task definition capable of running the QA server container.

Please note that the prerequisites listed above are required for both the task definition and the CloudFormation template. The container will not run properly without those pieces, and CloudFormation will not create them for you.