<#
    .SYNOPSIS
    Converts a PSCustomObject to Hashtable.

    .DESCRIPTION
    Reads and converts a PSCustomObject into a hashtable.

    .PARAMETER InputObject
    PSCustomObject to convert.

    .EXAMPLE
    # CovertFrom-Json returns a PSCustomObject.
    PS C:\> ConvertFrom-Json $input | ConvertFrom-PSCustomObject
#>
function ConvertFrom-PSCustomObject {
    [CmdletBinding()]
    [OutputType([hashtable])]

    param(

        [parameter(
            Mandatory,
            Position=0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage='Supply a PSCustomObject to convert to a hashtable.'
        )]
        [PSCustomObject[]]$InputObject
    )


    begin {

        Set-StrictMode -Version 'Latest'
    }


    process {
        foreach ($object in $InputObject) {

            [hashtable]$result = @{}
            $object.PSObject.Properties | ForEach-Object { $result[$_.Name] = $_.Value }
            Write-Output $result
        }
    }


    end {

    }
}
