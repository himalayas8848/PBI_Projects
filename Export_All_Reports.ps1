cls

 $tentantWorkspaces = Get-PowerBIWorkspace -Scope Organization -Filter ("tolower(type) eq 'group'")

Write-Host "There are --" $tentantWorkspaces.Count "-- workspaces in this Power BI tenant."

# List out all workspace not deleted
$spaces = Get-PowerBIWorkspace -Scope Organization -Filter "tolower(state) ne 'deleted'" -Filter "tolower(type) ne 'personalgroup'"

foreach ($space in $spaces)

{

    write-host $space.Id "|" $space.Name "|" $space.Type "|" $space.State "|" $space.IsOnDedicatedCapacity "|" $space.CapacityId

} 

# List out all reports
foreach ($space in $spaces)

{

#    write-host $space.Id "|" $space.Name "|" $space.Type "|" $space.State "|" $space.IsOnDedicatedCapacity "|" $space.CapacityId

    $reports = Get-PowerBIReport -WorkspaceId $space.Id

    foreach ($report in $reports)

    {

        Write-Host "|"$report.Id "|" $report.name "|" $report.DatasetId

    } 
 } 