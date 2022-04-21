Release v2.0.0.alpha-01 (2022-04-21)

* update to ruby 2.7.6
* use .dockerignore to not include files that aren't required for the image to run
* remove deploy templates (moved to LD4P/qa_server_aws_deploy)
* update dependencies
* log version in entry script

Release v1.0.2 (2022-04-15)

* add ability to manually build and push images to ECR

* Release v1.0.1 (2022-04-15)

* add GitHub actions to auto-build and deploy images to ECR
* Release of base qa_server as a Docker container image.
