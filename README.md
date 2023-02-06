A small refresher infrastructure excercise ...

Technologies that will explored in this project:
- [Hashicorp's Vault](https://www.vaultproject.io/)
- [Hashicorp's Packer](https://www.packer.io/)
- [Hashicorp's Terraform](https://www.terraform.io/)
- [Cloudflare Zero-Trust tunnels](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/)
- GitHub SSO
- VMWare Virtual Machines
- [Azure Cloud Instances](https://azure.microsoft.com/en-us/products/container-instances)
- [Azure DevOps](https://azure.microsoft.com/en-us/products/devops)
    - [Azure pipelines](https://azure.microsoft.com/en-us/products/devops/pipelines)
- [Docker](https://www.docker.com/)
- [NodeJs](https://nodejs.org/en/)

In this repo, the plan is to accomplish the following as a personal learning training starting from scratch:
- Templating an Ubuntu-based Vault VM in **Packer**
- Setting up a local hashicorp **Vault** VM locally using **VMWare** to store our secrets for this project, and expose the HTTP endpoint behind a **Cloudflare Zero Trust** tunnel
    - The cloudflared tunnel will have the following rules to only allow needed resources to interact with vault publically on the internet:
        - Only my **Github SSO** user will be able to access the HTTP API and gui of vault
            - This ensures that I'm a) authorized b) authenticated through SSO
        - Allow the IPs of **Azure DevOps** to interact with vault's HTTP API
            - This ensures that only azure can retrieve secrets. We can't trust anyone to hit it.
- Create the following **Azure CI/CD Pipelines** for a **NodeJs** app:
    - Lint: Check if the code is linted based on linter properties
    - Test: run & validate the test suite
    - Build: build a **Docker** container for that app
    - Deploy: deploy the app as **Azure Container Instance**
        - Might leverage **Terraform** to define and configure IaaC resources for that test app, which will change the deploy pipeline a bit.

