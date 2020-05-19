# Connect-PowerBIServiceAccount

# List out all workspace and group workspace(My Workspace)
$workspaces = Get-PowerBIWorkspace -Scope Organization -Filter ("tolower(type) eq 'workspace' and tolower(state) ne 'deleted'")

$hash = @{}
foreach ($workspace in $workspaces)
{
#    write-host $workspace.Id "|" $workspace.Name "|" $workspace.Type "|" $workspace.State "|" $workspace.IsOnDedicatedCapacity "|" $workspace.CapacityId
    $hash = $hash + @{$workspace.Name = $workspace.Id;}
} 

$parentPath = "D:\github\PBI_Projects\workspaceFolder"
$paths = Get-ChildItem -Path $parentPath

foreach ($path in $paths) {
    $childPath = $parentPath+"\"+$path
    $reports = Get-ChildItem -Path $childPath
    foreach ( $report in $reports) {
        $currentFullPath = $childPath+"\"+$report.Name
        $name = $report.Name.Substring(0, $report.Name.Length-5)
        $wsid = $hash[$path.Name]

        New-PowerBIReport -Path $currentFullPath -Name $name -WorkspaceId $wsid
    }
}

