$version = $OctopusParameters["Octopus.Release.Number"]
$environment = $OctopusParameters["Octopus.Environment.Name"]
$subscriptionId = $OctopusParameters["Octopus.Action.Azure.SubscriptionId"]
$uniquifier = $subscriptionId.Split("-")[0]

Write-Host "Package Version: $version"

$name = "### UNKNOWN ###"
$isPreRelease = $version -match "-(?<name>\p{L}*)"
if ($isPreRelease) {
    $name = $matches['name']
} else {
    $name = $environment
}

$appInstanceName = "$name-$uniquifier"
$webAppName = "$projectName-$appInstanceName"

Set-OctopusVariable -name "AppInstanceName" -value $appInstanceName
Write-Output "AppInstanceName: $appInstanceName"