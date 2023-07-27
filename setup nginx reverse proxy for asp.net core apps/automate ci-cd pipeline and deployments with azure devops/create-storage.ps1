# Set the Azure subscription you want to use if you have multiple subscriptions
Set-AzContext -SubscriptionId <SubscriptionId>

<----------------------------------------------------------------------------------------------------->
# Set the resource group properties name and location
$rgName = "terraform-2023"
$location = "australiacentral"

<----------------------------------------------------------------------------------------------------->
# Create the resource group
New-AzResourceGroup -Name $rgName -Location $location

<----------------------------------------------------------------------------------------------------->
#Create Storage account

$location = "australiacentral"
$rgName = "terraform-2023"
$accountName = "mystorageaccount2023"

$st = New-AzStorageAccount -ResourceGroupName $rgName -Name $accountName `
    -Location $location -SkuName Standard_GRS -AccessTier Hot `
    -Kind StorageV2 -AllowCrossTenantReplication $false `
    -AllowBlobPublicAccess $false -PublicNetworkAccess Disabled `
    -RequireInfrastructureEncryption -MinimumTlsVersion TLS1_2

# Enable containers soft delete :  retention of 60 days
Enable-AzStorageContainerDeleteRetentionPolicy -ResourceGroupName $rgName `
    -StorageAccountName $accountName `
    -RetentionDays 60

# Enable blob soft delete : retention of 60 days
Enable-AzStorageBlobDeleteRetentionPolicy -ResourceGroupName $rgName `
    -StorageAccountName $accountName `
    -RetentionDays 60

# Enable change feed and versioning
Update-AzStorageBlobServiceProperty -ResourceGroupName $rgName `
    -StorageAccountName $accountName `
    -EnableChangeFeed $true `
    -ChangeFeedRetentionInDays 60 `
    -IsVersioningEnabled $true

# Enable point-in-time restore with a retention period of 59 days
# The retention period for point-in-time restore must be at least one day less than that set for soft delete
Enable-AzStorageBlobRestorePolicy -ResourceGroupName $rgName `
    -StorageAccountName $accountName `
    -RestoreDays 59

# View the service settings
Get-AzStorageBlobServiceProperty -ResourceGroupName $rgName `
    -StorageAccountName $accountName