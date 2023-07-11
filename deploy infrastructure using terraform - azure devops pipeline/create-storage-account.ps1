# Use this command to get the list of all the locations
Get-AzLocation | select Location

# Input Parameters
$resourceGroupName = "tfrg"
$storageAccName = "tfstorage"
$storageContainerName = "tfcontainer"
$location = "australiacentral"

# Connect to Azure Account
# If you are already connected you don't need this command else you will need to connect and also select the propriate subscription
Connect-AzAccount

# Function to create the storage container
Function CreateStorageContainer
{  

     Write-Host -ForegroundColor Green "Creating resource group..."
     New-AzResourceGroup -Name $resourceGroupName -Location $location
    
     Write-Host -ForegroundColor Green "Creating storage account..."
     New-AzStorageAccount -ResourceGroupName $resourceGroupName  -Name $storageAccName -Location $location -SkuName Standard_LRS
    
    Write-Host -ForegroundColor Green "Creating storage container..."
    # Get the storage account in which container has to be created
    $storageAcc = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccName
    # Get the storage account context
    $ctx = $storageAcc.Context
    
    # Check if the storage container exists
    if(Get-AzStorageContainer -Name $storageContainerName -Context $ctx -ErrorAction SilentlyContinue)
    {
        Write-Host -ForegroundColor Magenta $storageContainerName "- container already exists."
    }
    else
    {
        Write-Host -ForegroundColor Magenta $storageContainerName "- container does not exist."
        # Create a new Azure Storage Account
        New-AzStorageContainer -Name $storageContainerName -Context $ctx -Permission Container
    }
}

CreateStorageContainer

# Disconnect from Azure Account
Disconnect-AzAccount