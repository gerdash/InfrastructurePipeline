#Requires -Modules Pester
<#
.SYNOPSIS
    Tests a specific ARM template
.EXAMPLE
    Invoke-Pester 
.NOTES
    This file has been created as an example of using Pester to evaluate ARM templates
    Source: https://github.com/Azure/azure-quickstart-templates/tree/master/201-vmss-automation-dsc
#>

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$template = Split-Path -Leaf $here

$templatesFolder="$here\..\templates"
$parametersFolder="$here\..\parameters"

$TempValidationRG = "Pester-Validation-RG"
$location = "West Europe"





Describe "Template: $template" -Tags Unit {
     BeforeAll {
         New-AzResourceGroup -Name $TempValidationRG -Location $Location
    }

    
    Context "Template Syntax" {
        
        It "Has a JSON template" {        
            "$templatesFolder\azuredeploy.json" | Should Exist
        }
        
        It "Has a parameters file" {        
            "$parametersFolder\azuredeploy.parameters.json" | Should Exist
        }
        
        It "Has a metadata file" {        
            "$templatesFolder\metadata.json" | Should Exist
        }

        It "Converts from JSON and has the expected properties" {
            $expectedProperties = '$schema',
            'contentVersion',
            'parameters',
            'variables',
            'resources',                                
            'outputs' | Sort-Object 
            $templateProperties = (get-content "$templatesFolder\azuredeploy.json" | ConvertFrom-Json -ErrorAction SilentlyContinue) | Get-Member -MemberType NoteProperty | % Name
            $templateProperties | Sort-Object | Should Be $expectedProperties
        }
        
        It "Creates the expected Azure resources" {
            $expectedResources = 'Microsoft.Storage/storageAccounts' | Sort-Object 

            $templateResources = (get-content "$templatesFolder\azuredeploy.json" | ConvertFrom-Json -ErrorAction SilentlyContinue).Resources.type
            $templateResources | Sort-Object | Should Be $expectedResources 
        }
       

    }
    
    Context "Template Validation" {
          
        It "Template $templatesFolder\azuredeploy.json and parameter file  passes validation" {
      
            # Complete mode - will deploy everything in the template from scratch. If the resource group already contains things (or even items that are not in the template) they will be deleted first.
            # If it passes validation no output is returned, hence we test for NullOrEmpty
            $ValidationResult = Test-AzResourceGroupDeployment -ResourceGroupName $TempValidationRG -Mode Complete -TemplateFile "$templatesFolder\azuredeploy.json" -TemplateParameterFile "$parametersFolder\azuredeploy.parameters.json"
            $ValidationResult | Should BeNullOrEmpty
        }
    }

     AfterAll {
         Remove-AzResourceGroup $TempValidationRG -Force
     }
}
