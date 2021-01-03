<p align="center">
  <img alt="Terraform" title="Terraform logo" src="./assets/logo-terraform.png" width="200px" />
</p>

<h3 align="center">
  Serverless booking software
</h3>

<p align="center">Cloud-Native Serverless application developed with Hashicorp Terraform and Serverless Framework.</p>

## Introduction

The main purpose of this small event-driven project is to show how to use <a href="https://www.terraform.io/">Terraform</a> to provision immutable Cloud-Native infrastructure, along with the <a href="https://www.serverless.com/">Serverless Framework</a>.

## Infrastructure as Code (IaC) 👷🏻

Terraform is an open-source Infrastructure as Code tool to manage cloud resources. It was mainly used to provision the core infrastructure at AWS, which was the chosen cloud provider. <br />

### Resources

These are the main infrastructure resources provisioned by Terraform to create a fully event-driven serverless architecture:

- <b>DynamoDB</b>
  - Tables
  - Indexes
  - Streams
- <b>IAM</b>
  - Roles
  - Policies
- <b>SNS topics</b>
- <b>SQS</b>
  - Queues
  - DQLs
- <b>Systems Manager</b>
  - Parameter Store: this service is the key-point to make it possible to Serverless and Terraform communicate to each other. All the resources names and ARNs (IAM roles, policies, queues, tables, etc.) are exported to the Parameter Store as key-values by Terraform. Then, it is possible to access these keys via Serverless Framework and referecence IAM role statements or create environment variables for each Lambda function.

## Serverless ☁️

It is also possible to provision the resources mentioned previously with the Serverless Framework, however, in this project, I chose to separate responsabilities and only Terraform is used to manage infrastructure. <br />

Therefore, the main usage of Serverless in this project is to create the API gateway endpoints and Lambda functions triggered by API Gateway's events.

### Endpoints

The API is really simple and has only four endpoints:

- <b>POST/</b>users: register a new user.
- <b>POST/</b>login: user authentication (returns a JWT token).
- <b>POST/</b>bookings: register a new booking.
- <b>GET/</b>bookings: list all the bookings (<i>restricted to ADMIN users</i>).

Click on the button below and import the Insomnia workspace to do the API requests after the deployment step:

[![Run in Insomnia}](https://insomnia.rest/images/run.svg)](https://insomnia.rest/run/?label=Terraform%20Serverless&uri=https%3A%2F%2Fgist.github.com%2Feduardo3g%2F0bc07cdc507e62b90c620b3eab50c1f2)

## Deploy

### Prerequisites

First of all, you need an AWS account and create a user with programmatic admin access. Then, <a href="https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html">configure the AWS CLI</a> on your workstation.
<br/>

Once you're done, clone this repository and move yourself to the root directory.

### Environment variables

The API depends on two external services to send e-mails and SMSs when a new booking is registed in the DynamoDB table. Create accounts on each of them:
  - <a href="https://www.zoho.com/pt-br/">Zoho</a>
  - <a href="https://messagebird.com/en/">Messagebird</a>

<br />

The last thing before the deployment is to define your environment variables of the `dev` stage.

```bash
# Move to the Terraform development directory
cd terraform/environments/dev

# Open the file that contains the environment variables and update the values
nano secrets.auto.tfvars
```

In order to keep things simple, I recommend only changing the following keys:
  - <b>email_from</b>: use the e-mail you created at <a href="https://www.zoho.com/pt-br/">Zoho</a> (the one containing the domain <b>@zohomail.com</b>)
  - <b>email_from_password</b>: your password from Zoho
  - <b>email_to</b>: create a temporary e-mail box at <a href="https://temp-mail.org/pt/">TempMail</a> (leave the window opened while you're testing)
  - <b>message_bird_api_key</b>: your test API Key from <a href="https://messagebird.com/en/">Messagebird</a> (No SMSs will be sent with this key. Use the production one if you want to receive them.)
  - <b>sms_phone_from</b>: your cellphone number (e.g: "+55119...")
  - <b>sms_phone_to</b>: your cellphone number (e.g: "+55119...")

### Deploy

Luckly, now you just need to run a single command and Terraform will do the magic for you 😛
```bash
# Run the command bellow to avoid lack of permission to run the deploy shell script
chmod u=rwx,g=r,o=r deploy.sh

# Deploy everything to a development stage at AWS
./deploy.sh dev
```

You're supposed to see 53 resources created by Terraform, that is, all the resources I mentioned in previous sections (IAM roles, tables, queues, etc).

<br />

In the other hand, the Serverless Framework will create the `dev-api` and 8 Lambda functions.

### Destroy

Now that you've tested everything, feel free to delete all the resources at AWS. It's as simple as the deployment script:
```bash
# Run the command bellow to avoid lack of permission to run the destroy shell script
chmod u=rwx,g=r,o=r deploy.sh

# Remove everything from the development stage at AWS
./destroy.sh dev
```
