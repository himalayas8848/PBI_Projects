cls

 $tentantWorkspaces = Get-PowerBIWorkspace -Scope Organization -Filter ("tolower(type) eq 'group'")

Write-Host "There are --" $tentantWorkspaces.Count "-- workspaces in this Power BI tenant."

# List out all workspace not deleted
$spaces = Get-PowerBIWorkspace -Scope Organization -Filter ("tolower(state) ne 'deleted'")

foreach ($space in $spaces)

{

    write-host $space.Id "|" $space.Name "|" $space.Type "|" $space.State "|" $space.IsOnDedicatedCapacity "|" $space.CapacityId

} 

# List out all dataset

$dss = Get-PowerBIDataset -Scope Organization

foreach ($ds in $dss)

{

    Write-Host "|"$ds.Id "|" $ds.name "|" $ds.ConfiguredBy "|" $ds.IsOnPremGatewayRequired

}

# List out all reports
 $reports = Get-PowerBIReport -Scope Organization

foreach ($report in $reports)

{

    Write-Host "|"$report.Id "|" $report.name "|" $report.DatasetId

} 