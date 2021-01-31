# InfrastructurePipeline

## Build
A sample infrastructure test and build pipeline using VSTS to:
* Checkout ARM Templates from Git
* Run Pester tests against template code
* Deploy a sample infrastrucutre
* Run Pester Infrastrcuture validation against deployed infrastructure
* Tear down infrastructure
* Package and publish files

## Release
A sample release pipeline demonstrating:
* Releasing ARM templates using a pipeline
* Multiple stages for dev/test/prod etc.
* Release gates using environments
