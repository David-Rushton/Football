<#
    .SYNOPSIS
    Query football-data.org.

    .DESCRIPTION
    Builds, executes and returns a football-data.org api call.

    .PARAMETER Uri
    All calls are made to http://api.football-data.org/v2.  Uri is appended to
    end to return required data set.

    .EXAMPLE
    # Returns json describing current Premier League table.
    PS C:\> Get-ApiContent -Uri 'competitions/PL/standings'
#>
function Get-ApiContent {
    [CmdletBinding()]
    [OutputType([PSCustomObject])]

    param(

        [parameter(
            Mandatory,
            Position=0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage='Provide required resource:'
        )]
        [string[]]
        $Uri
    )


    begin {

        Set-StrictMode -Version 'Latest'

        # Root Uri.
        $root = 'https://api.football-data.org/v2/'

        # Current config.
        $options = Get-FootballOption

        # Splatting object for making API calls.
        $params = @{
            Uri = ''
        }


        # Add API key to params, if set.
        if ($options['apiKey'] -ne '') {
            $params += @{ Headers = @{'X-Auth-Token' = $options['apiKey']} }
        }

        # Add proxy server, if set.
        if ($options['proxy'] -ne '') {
            $params += @{ Proxy = $options['proxy'] }
        }
    }


    process {

        foreach ($currentUri in $Uri) {
            try {

                $params.Uri = "$root$currentUri"
                Write-Verbose "Calling API: $($params.Uri)."
                $html = Invoke-WebRequest @params

                if ($html.statusCode -ne 200) {
                    throw 'API call failed: $html.statusDescription.'
                }

                Write-Output ($html.Content | ConvertFrom-Json)
            }
            catch{

                Write-Error "Cannot make API call: $_."
            }
        }
    }


    end {

    }
}
