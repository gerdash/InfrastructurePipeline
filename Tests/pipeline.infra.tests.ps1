param(
[Parameter(Mandatory)]
[string] $resourceGroup
)

BeforeAll {
    
}

Describe "Resource Group tests" -tag "AzureInfrastructure" {
    
    Context "Resource Groups" {
        It "Check Main Resource Group $resourceGroup Exists" {
            Get-AzResourceGroup -Name $resourceGroup -ErrorAction SilentlyContinue | Should -Not -be $null
        }
   
    }
}

Describe "Storage Tests" -tag "AzureInfrastructure" {
    Context "Storage" {
        
        

        it "Check Storage Account Exists" {
            $sa = Get-AzStorageAccount -Name "scpipelinedemo" -ResourceGroupName $resourceGroup -ErrorAction SilentlyContinue
            $sa | Should -Not -be $null
        }
         
    }
}

