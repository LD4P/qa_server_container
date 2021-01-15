# Deployment Templates for AWS

This deployment has three basic pieces:
* The application, running within a container that is hosted in Amazon Elastic Container Service (ECS)
* An environment file, residing in a S3 bucket that the container has permission to access
* A filesystem containing two volumes that the container can mount. This filesystem can be implemented either as an Elastic Block Store (EBS) volume or an Elastic File System (EFS).

Two templates are provided, a CloudFormation template and a standalone ECS task definition. Both require customization to your environment by populating various values; in the CloudFormation version these values can be passed in as parameters when the stack is created or updated.