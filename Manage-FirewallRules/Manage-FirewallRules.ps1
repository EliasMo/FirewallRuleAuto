# Define the function to list firewall rules 
function List-FirewallRules {
    Get-NetFirewallRule | Format-Table -AutoSize
}

# function to create a new firewall rule 
function New-FirewallRule {
    param(
        [string]$DisplayName,
        [string]$Direction,
        [string]$Action,
        [string]$Protocol,
        [int]$LocalPort,
        [string]$RemoteAddress
)
    $Rule = New-NetFirewallRule 
            -DisplayName $DisplayName
            -Direction $Direction
            -Action $Action
            -Protocol $Protocol
            -LocalPort $LocalPort
            -RemoteAddress $RemoteAddress

    Write-Output "Firewall rule '$DisplayName' created successfully."

}

# function to modify an existing firewall rule 
function Set-FirewallRule {
    param(
        [string]$DisplayName,
        [string]$Action,
        [int]$LocalPort
    )

    $Rule = Get-NetFirewallRule -DisplayName $DisplayName

    if ($Rule) {
        Set-NetFirewallRule 
        -DisplayName $DisplayName
        -Action $Action
        -LocalPort $LocalPort
        Write-Output "Firewall rule '$DisplayName' modified successfully."
    } else {
        Write-Error "Firewall rule '$DisplayName' not found."
    }


}


# Function to remove a firewall rule 
function Remove-FirewallRule {
    param(
        [string]$DisplayName
    )

    $Rule = Get-NetFirewallRule - DisplayName $DisplayName

    if($Rule) {
        Remove-NetFirewallRule -DisplayName $DisplayName
        Write-Output "Firewall rule '$DisplayName' removed successfully."
    } else {
        Write-Error "Firewall rule '$DisplayName' not found."
    } 
}


# Main 
Write-Host "Firewall Rule Management Script"
Write-Host "--------------------------------"

# Choice
$action = Read-Host "Choose an action (List, New, Modify, Remove):"

# Select 
switch ($action.ToLower()) {
    "list"   {List-FirewallRules}
    "new"    {New-FirewallRule}
    "modify" {Set-FirewallRule}
    "remove" {Remove-FirewallRule}
    default  {Write-Error "Invalid action. Please choose List, New, Modify or Remove."}

} 