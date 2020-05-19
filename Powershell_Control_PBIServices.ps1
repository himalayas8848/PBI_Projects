# Connect to Power BI Services account
Connect-PowerBIServiceAccount

# List all workspace  as a user
$myWorkspaces = Get-PowerBIWorkspace
Write-Host "The current user has "$myWorkspaces.Count" workspaces"

# Get all workspace  as a PBI Admin
$tentantWorkspaces = Get-PowerBIWorkspace -Scope Organization
Write-Host "There are "$tentantWorkspaces.Count" workspaces in this Power BI tenant"

# Get the list of workspaces by making a direct REST API call against the user API.
$myRestResult = Invoke-PowerBIRestMethod -Url 'Groups' -Method Get | ConvertFrom-Json
$myRestResult

# Get the list of workspaces by making a direct REST API call against the admin API
$tenantRestResult = Invoke-PowerBIRestMethod -Url 'admin/Groups' -Method Get | ConvertFrom-Json
$tenantRestResult

# Get additional troubleshooting information
Resolve-PowerBIError -Last



