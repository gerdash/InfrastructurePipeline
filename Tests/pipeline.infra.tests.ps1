$resourceGroup = "PipelineTest"

Describe "Resource Group tests" -tag "AzureInfrastructure" {
    
    Context "Resource Groups" {
        It "Check Main Resource Group $resourceGroup Exists" {
            Get-AzureRmResourceGroup -Name $resourceGroup -ErrorAction SilentlyContinue | Should Not be $null
        }
   
    }
}

Describe "Storage Tests" -tag "AzureInfrastructure" {
    Context "Storage" {
        
        $sa = Get-AzStorageAccount -Name "scpipelinedemo" -ResourceGroupName $resourceGroup -ErrorAction SilentlyContinue
        it "Check Storage Account Exists" {
            $sa | Should Not be $null
        }
         
    }
}

