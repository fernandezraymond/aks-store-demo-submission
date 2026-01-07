# aks-store-demo-submission

## How to run the app locally
1. Go to the root directory and run `docker compose up` then after a while, navigate to `http://localhost:8080/`.

## How to configure and run the CI/CD pipeline.
1. To configure it, use the `.gitlab-ci.yml` file.
1. Create a tag on the repository and the pipeline will run.

## How to deploy the application to kubernetes.
1. On the pipeline there is a final `manual` job, once it is run it will deploy new tagged version of the app.