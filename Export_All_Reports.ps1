# Connect-PowerBIServiceAccount

cls
 $tentantWorkspaces = Get-PowerBIWorkspace -Scope Organization -Filter ("tolower(type) eq 'group'")

Write-Host "There are --" $tentantWorkspaces.Count "-- workspaces in this Power BI tenant."

# List out all workspace and group workspace(My Workspace)
$workspaces = Get-PowerBIWorkspace -Scope Organization -Filter ("tolower(type) eq 'workspace' and tolower(state) ne 'deleted'")
foreach ($workspace in $workspaces)
{
    write-host $workspace.Id "|" $workspace.Name "|" $workspace.Type "|" $workspace.State "|" $workspace.IsOnDedicatedCapacity "|" $workspace.CapacityId
} 

$myworkspaces = Get-PowerBIWorkspace -Scope Organization -Filter ("tolower(type) eq 'group' and tolower(state) ne 'deleted'")
foreach ($myworkspace in $myworkspaces)
{
    write-host $myworkspace.Id "|" $myworkspace.Name "|" $myworkspace.Type "|" $myworkspace.State "|" $myworkspace.IsOnDedicatedCapacity "|" $myworkspace.CapacityId
} 

# List out all reports
foreach ($workspace in $workspaces)

{

#    write-host $space.Id "|" $space.Name "|" $space.Type "|" $space.State "|" $space.IsOnDedicatedCapacity "|" $space.CapacityId
    try{
        $reports = Get-PowerBIReport -WorkspaceId $workspace.Id -ErrorAction Ignore
    }
    catch {
        Write-Host "An error occurred:"
        Write-Host $_.Exception
        
    }
        $outputFolder = "D:\github\PBI_Projects\workspaceFolder\" + $workspace.Name
        md $outputFolder
        foreach ($report in $reports)
        {
            Write-Host "|"$report.Id "|" $report.name "|" $report.DatasetId "|" $report.WebUrl
            $reportFullpath = $outputFolder + "\" + $report.Name + ".pbix"

            Export-PowerBIReport -Id $report.Id -OutFile $reportFullpath -WorkspaceId $workspace.Id
        } 
 } 


