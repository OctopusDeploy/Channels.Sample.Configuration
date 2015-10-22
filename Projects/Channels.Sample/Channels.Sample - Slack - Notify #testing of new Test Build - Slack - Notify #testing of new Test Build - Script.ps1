function Slack-Rich-Notification ($notification)
{
    $payload = @{
        channel = $OctopusParameters['Channel']
        username = $OctopusParameters['Username'];
        icon_url = $OctopusParameters['IconUrl'];
        attachments = @(
            @{
            fallback = $notification["fallback"];
            color = $notification["color"];
            fields = @(
                @{
                title = $notification["title"];
                value = $notification["value"];
                });
            };
        );
    }

    Invoke-RestMethod -Method POST -Body ($payload | ConvertTo-Json -Depth 4) -Uri $OctopusParameters['HookUrl']
}

Slack-Rich-Notification @{
    title = "$Title";
    value = "$Value";
    fallback = "$Fallback";
    color = "$Color";
};
