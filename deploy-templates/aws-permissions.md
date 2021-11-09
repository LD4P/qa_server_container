# Permissions for Amazon Web Services (AWS)

The CloudFormation templates provided here will run perfectly when launched by a user with full admin access. However, it is not a security best practice to allow an admin user to run CloudFormation templates, because of the potential damage that a poorly written or malicious template can do to your account. The proper way to run CloudFormation templates is to launch them with a user that has access to the CloudFormation service, and the privilege to pass the operations through a role that CloudFormation assumes on their behalf. This role then carries the least amount of privileges necessary to create and/or destroy the resources in the template. The following IAM policies are intended to provide this permissions scheme.

# 1. Create User and Add Permissions

Use the web console to create an IAM user that will be used to manage the stacks for the QA server. Click the "Add user" button and name the user. You can name this user whatever you like, but for this example we will be naming the user `qa-user`. This user can be a web console user, but it is highly recommended that you create a programmatic access user, for use with the AWS CLI. Click on "Next:Permissions" to continue.

Select "Attach existing policies directly" and then click "Create policy". Click the JSON tab and paste in the following policy document:

```
{
     "Version": "2012-10-17",
     "Statement": [
         {
             "Effect": "Allow",
             "Action": [
                 "cloudformation:CreateStack",
                 "cloudformation:DescribeStacks", 
                 "cloudformation:DeleteStack",  
                 "cloudformation:DescribeStackEvents", 
                 "cloudformation:UpdateStack",
                 "iam:PassRole"
             ],
             "Resource": "*"
         }
     ]
 }
```
This policy will allow the user to launch, update, and delete the CloudFormation stacks that are defined by the templates in this repository. Click "Next:Tags" and then "Next:Review" to create the policy, giving the policy an appropriate name. Return to your IAM user screen and find the policy you have just created, and select it to assign the policy to your user. Then click "Next:Tags", then "Next:Review", and finally "Create user".

Be sure to download your *access key ID* and *secret access key* and install them in your AWS CLI tool credentials file, creating a named profile if necessary. 

Once the user `qa-user` is installed in your AWS CLI tool, you should be able to launch the template with a command resembling: 

`aws cloudformation create-stack --stack-name qa-server --profile qa-user`

However, the template will immediately fail with a permissions error, because the user does not have permissions to create any of the resources within the stacks. That is accomplished by creating a role that has all of those permissions, and the user will pass that role to the service.

# 2. Create CloudFormation Role and Add Permissions

Use the web console to create an IAM role that the service will assume. First, click on the "Create role" button and select "AWS Service", and from the list of services select CloudFormation. Click "Next: Permissions" and then click "Create policy". Click on the JSON tab and paste in the following policy:
```
{
     "Version": "2012-10-17",
     "Statement": [
         {
             "Effect": "Allow",
             "Action": [
                 "ec2:DescribeSubnets",
                 "ec2:DescribeSecurityGroups",
                 "ec2:CreateSecurityGroup",
                 "ec2:RevokeSecurityGroupEgress",
                 "ec2:RevokeSecurityGroupIngress",
                 "ec2:DeleteSecurityGroup",
                 "ec2:AuthorizeSecurityGroupEgress",
                 "ec2:AuthorizeSecurityGroupIngress",
                 "ec2:DescribeInstances",
                 "ec2:CreateNetworkInterface",
                 "ec2:CreateNetworkInterfacePermission",
                 "ec2:DeleteNetworkInterface",
                 "ec2:DeleteNetworkInterfacePermission",
                 "ec2:DescribeNetworkInterfaces",
                 "ec2:DescribeNetworkInterfacePermissions",
                 "ec2:DescribeNetworkInterfaceAttribute",
                 "ec2:DetachNetworkInterface",
                 "ecs:DescribeClusters",
                 "ecs:CreateCluster",
                 "ecs:DeleteCluster",
                 "ecs:RegisterTaskDefinition",
                 "ecs:DeregisterTaskDefinition",
                 "ecs:DescribeServices",
                 "ecs:CreateService",
                 "ecs:DeleteService",
                 "elasticfilesystem:CreateFileSystem",
                 "elasticfilesystem:ModifyMountTargetSecurityGroups",
                 "elasticfilesystem:DeleteFileSystem",
                 "elasticfilesystem:DescribeFileSystems",
                 "elasticfilesystem:CreateMountTarget",
                 "elasticfilesystem:DeleteMountTarget",
                 "elasticfilesystem:CreateAccessPoint",
                 "elasticfilesystem:DeleteAccessPoint",
                 "elasticfilesystem:DescribeMountTargets",
                 "elasticfilesystem:DescribeMountTargetSecurityGroups",
                 "elasticfilesystem:DescribeAccessPoints",
                 "elasticloadbalancing:DescribeLoadBalancers",
                 "elasticloadbalancing:CreateLoadBalancer",
                 "elasticloadbalancing:DeleteLoadBalancer",
                 "elasticloadbalancing:DescribeTargetGroups",
                 "elasticloadbalancing:CreateTargetGroup",
                 "elasticloadbalancing:DeleteTargetGroup",
                 "elasticloadbalancing:DescribeListeners",
                 "elasticloadbalancing:CreateListener",
                 "elasticloadbalancing:DeleteListener",
                 "autoscaling:CreateLaunchConfiguration",
                 "autoscaling:DeleteLaunchConfiguration",
                 "autoscaling:CreateAutoScalingGroup",
                 "autoscaling:DeleteAutoScalingGroup",
                 "autoscaling:DescribeAutoScalingGroups",
                 "autoscaling:UpdateAutoScalingGroup",
                 "autoscaling:DescribeScalingActivities",
                 "autoscaling:DescribeLaunchConfigurations",
                 "autoscaling:DescribeAutoScalingInstances",
                 "acm:RequestCertificate",
                 "acm:DescribeCertificate",
                 "acm:DeleteCertificate",
                 "iam:CreateRole",
                 "iam:ListRoleTags",
                 "iam:getRolePolicy",
                 "iam:PutRolePolicy",
                 "iam:DeleteRolePolicy",
                 "iam:DeleteRole",
                 "iam:GetRole",
                 "iam:PassRole",
                 "iam:CreateInstanceProfile",
                 "iam:DeleteInstanceProfile",
                 "iam:RemoveRoleFromInstanceProfile",
                 "iam:AddRoleToInstanceProfile",
                 "logs:CreateLogGroup",
                 "logs:PutRetentionPolicy",
                 "logs:DeleteLogGroup",
                 "s3:CreateBucket",
                 "s3:DeleteBucket",
                 "s3:GetBucketLocation",
                 "s3:ListBucket",
                 "s3:PutBucketPublicAccessBlock",
                 "datasync:CreateLocationEfs",
                 "datasync:CreateLocationS3",
                 "datasync:CreateTask",
                 "datasync:DeleteLocation",
                 "datasync:DescribeLocationS3",
                 "datasync:DescribeLocationEfs",
                 "datasync:DescribeTask",
                 "datasync:ListTagsForResource",
                 "datasync:DeleteTask"
             ],
             "Resource": "*"
         }
     ]
 }
```
Click on "Next:Tags" and then "Next:Review" to create the policy, giving the policy an appropriate name. 

Return to the IAM role screen and find the policy you have just created, and select it to assign the policy to your role. Then click "Next:Tags", then "Next:Review", and finally "Create role". You can name this role whatever you like, but for this example we will be naming the role `qa-role`.

Once your role has been created, click on it to view the role summary page, and the first item will be the "Role ARN", copy it. You should now be able to pass the arn of this role from `qa-user` to CloudFormation using the command line, like this:

`aws cloudformation create-stack --stack-name qa-server --profile qa-user --role-arn arn:aws:iam::<your_account_id>:role/qa-role`

You should also use this user and role to make any updates to the stack, or to delete the stack.



