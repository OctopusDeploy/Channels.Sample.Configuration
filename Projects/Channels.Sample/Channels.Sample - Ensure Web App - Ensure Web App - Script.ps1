$projectName = $OctopusParameters["Octopus.Project.Name"].Replace(".", "-")
$appInstanceName = $OctopusParameters["Octopus.Action[Determine App Instance Name].Output.AppInstanceName"]
$azureLocation = $OctopusParameters["AzureLocation"]

$webAppName = "$projectName-$appInstanceName"
Write-Output "WebAppName: $webAppName"

$existingWebApp = Get-AzureWebSite -Name $webAppName
if ($existingWebApp) {
    Write-Host "Web App named $webAppName already exists, no need to provision it."
} else {
    Write-Host "Creating new Web App named $webAppName in $azureLocation..."
    New-AzureWebSite -Name $webAppName -Location $azureLocation
}

Set-OctopusVariable -name "WebAppName" -value $webAppName
Set-OctopusVariable -Name "WebAppUrl" -Value ("https://{0}.azurewebsites.net" -f $webAppName.ToLowerInvariant())