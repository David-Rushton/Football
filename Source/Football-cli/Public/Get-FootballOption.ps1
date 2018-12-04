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

    [string]$defaultPath = "$PSScriptRoot\..\Resources\config.default.json"
    [string]$currentPath = "$PSScriptRoot\..\Resources\config.current.json"

    [hashtable]$default = Get-Content -Path $defaultPath -Raw | ConvertFrom-Json | ConvertFrom-PSCustomObject
    [hashtable]$current = @{}


    # File only exists after first option is changed from default.
    if (Test-Path -Path $currentPath) {

        [hashtable]$current = Get-Content -Path $currentPath -Raw | ConvertFrom-Json | ConvertFrom-PSCustomObject
    }


    # Add missing options to user set.
    foreach ($key in $default.Keys) {

        if ( -not ($current.containsKey($key)) ) {

            $current[$key] = $default[$key]
        }
    }


    Write-Output $current
}
