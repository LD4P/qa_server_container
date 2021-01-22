# Deployment Templates for AWS

This deployment has three basic pieces:
* The application, running within a container that is hosted in Amazon Elastic Container Service (ECS)
* An environment file, residing in a S3 bucket that the container has permission to access
* A filesystem containing two volumes that the container can mount. This filesystem can be implemented either as an Elastic Block Store (EBS) volume or an Elastic File System (EFS).

Two templates are provided, a CloudFormation template and a standalone ECS task definition. Both require customization to your environment by populating various values; in the CloudFormation version these values can be passed in as parameters when the stack is created or updated.

# Prerequisites

To use this deployment, you will need the following pieces of infrastructure in place in your AWS account before you begin:
1. A repo containing a successfully built Docker image. This can be an Elastic Container Registry (ECR) repository or a public or private repo hosted elsewhere. Building the application image and pushing it to the repo should already be done, and you will need the full path to the image, including the repository URL and image tag (usually :latest).
2. A Simple Storage Service (S3) bucket containing an environment file that has been populated with valid values. The file contains secrets and other parameters necessary for the application to run, an .env.example file has been provided as a template. The S3 bucket must contain this file, and the bucket permissions must be configured to allow access from the Amazon ECS task execution IAM role. Full documentation on setup is available at https://docs.aws.amazon.com/AmazonECS/latest/developerguide/taskdef-envfiles.html.
3. A filesystem that the containers can mount. At this point, only EFS volumes are supported, EBS will be supported in the future. This deployment assumes one EFS filesystem with two separate access points. The first access point contains the authority files, and it should be pre-populated with the files you want to use. The second will contain the database storage files, and this should provision itself on the first run.