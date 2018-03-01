# InfrastructurePipeline

A sample infrastructure test and build pipeline using VSTS to:
* Checkout ARM Templates from Git
* Run Pester tests against template code
* Deploy a sample infrastrucutre
* Run Pester Infrastrcuture validation against deployed infrastructure
* Tear down infrastructure
* Package and publish files
