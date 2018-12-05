<#
    .SYNOPSIS
    Returns config file path.

    .DESCRIPTION
    Returns path to default and user config paths.

    .PARAMETER OptionSet
    Supported values: default, user.

    .EXAMPLE
    # Returns default path.
    PS C:\> Get-FootballOptionPath -OptionSet 'default'

    .EXAMPLE
    # Returns user path.
    PS C:\> Get-FootballOptionPath -OptionSet 'user'
#>
function Get-FootballOptionPath {
    [CmdletBinding()]
    [OutputType([string])]

    param(

        [parameter(
            Mandatory,
            Position=0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage='Support values: default and user.'
        )]
        [ValidateSet('default','user')]
        [string]$OptionSet
    )


    Set-StrictMode -Version 'Latest'
    Write-Output "$PSScriptRoot\..\Resources\config.$OptionSet.json"
}
