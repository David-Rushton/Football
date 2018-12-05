<#
    .SYNOPSIS
    Update config.

    .DESCRIPTION
    OVerrides default settings with user defined values.

    .PARAMETER Options
    Hashtable containing new values.

    .EXAMPLE
    # To set your API key.
    PS C:\> Set-FootballOption @{
        ApiKey = "abcdefghijklmnopqrstuvwxyz"
    }
#>
function Set-FootballOption {
    [CmdletBinding()]

    param(

        [parameter(
            Mandatory,
            Position=0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage='Provide settings to update as key-value pairs.'
        )]
        [hashtable]$Option
    )


    Set-StrictMode -Version 'Latest'

    [int]$changes = 0
    $current = Get-FootballOption

    foreach ($key in $Option.Keys) {
        if ($current.ContainsKey($key)) {

            $changes ++
            $current[$key] = $Option[$key]
        }
        else {

            Write-Warning -Message "Option not recognised: $key."
        }
    }


    if ($changes -gt 0) {

        $path = Get-FootballOptionPath -OptionSet 'user'
        $json = $current | ConvertTo-Json

        Set-Content -Path $path -Value $json -Encoding 'UTF8'
    }
}
