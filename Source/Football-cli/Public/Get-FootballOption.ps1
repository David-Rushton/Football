<#
    .SYNOPSIS
    Get config.

    .DESCRIPTION
    Returns the current configuration, as a collection of key-value pairs.

    .EXAMPLE
    # Returns settings.
    PS C:\> Get-FootballOptions
#>
function Get-FootballOption {
    [CmdletBinding()]
    [OutputType([hashtable])]

    param(
    )


    Set-StrictMode -Version 'Latest'


    # Config is a mix of default and user settings.
    # User settings, when present, override default.

    [string]$defaultPath = Get-FootballOptionPath -OptionSet 'default'
    [string]$userPath = Get-FootballOptionPath -OptionSet 'user'

    [hashtable]$default = Get-Content -Path $defaultPath -Raw | ConvertFrom-Json | ConvertFrom-PSCustomObject
    [hashtable]$user = @{}


    # File only exists after first option is changed from default.
    if (Test-Path -Path $userPath) {

        [hashtable]$user = Get-Content -Path $userPath -Raw | ConvertFrom-Json | ConvertFrom-PSCustomObject
    }


    # Add missing options to user set.
    foreach ($key in $default.Keys) {

        if ( -not ($user.containsKey($key)) ) {

            $user[$key] = $default[$key]
        }
    }


    Write-Output $user
}
