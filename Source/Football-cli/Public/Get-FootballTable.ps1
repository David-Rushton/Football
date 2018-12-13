<#
    .SYNOPSIS
    Returns current league table.

    .DESCRIPTION
    Returns the current league table for any of the supported competitions.

    .PARAMETER Competition
    Supported competitions are:
      - The Premier League.
      - The EFL Championship
      - The UEFA Champions League.

    A number of values are accepted for each league:
        - 'The Premier League', 'Premier League', 'Premier', 'Prem', 'PL',
        - 'The ELF Championship', 'The Championship', 'ELF Championship', 'Championship', 'ELC',
        - 'The UEFA Champions League', 'The Champions League', 'Champions League', 'Champions' , 'CL'

    .EXAMPLE
    # Returns premier league table.
    PS C:\> Get-FootballTable -Competition 'The Premier League'

    .EXAMPLE
    # Also returns premier league table.
    PS C:\> Get-FootballTable -Competition 'The Premier League'

    .EXAMPLE
    # View the Champions League tables.
    PS C:\> Get-FootballTable -Competition 'CL'
#>
function Get-FootballTable {
    [CmdletBinding()]
    [OutputType([string])]

    param(

        [parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateSet(
            'The Premier League', 'Premier League', 'Premier', 'Prem', 'PL',
            'The ELF Championship', 'The Championship', 'ELF Championship', 'Championship', 'ELC',
            'The UEFA Champions League', 'The Champions League', 'Champions League', 'Champions' , 'CL'
        )]
        [string]
        $Competition
    )


    Set-StrictMode -Version 'Latest'


    # Convert competition name to API short code, if required.
    if (@('PL', 'ELC', 'CL') -notcontains $Competition) {

        switch -Wildcard ($Competition) {
            '*prem*'            { $Competition = 'PL'  ; break }
            '*Championship*'    { $Competition = 'ELC' ; break }
            '*Champions*'       { $Competition = 'CL'  ; break }
            default             { Write-Error "Competition not supported: $Competition." }
        }
    }


    # API requires upper-case competition name.
    $Competition = $Competition.ToUpper()


    # Get diving line posistions.
    switch ($Competition) {
        'PL'    { $breakers = @(1, 5, 18)    ; break }
        'ELC'   { $breakers = @(1, 3, 7, 22) ; break }
        'CL'    { $breakers = @(1, 3)        ; break }
        default { Write-Error "Competition not supported: $Competition." }
    }


    $tableObj = Get-ApiContent -Uri "competitions/$Competition/standings?standingType=TOTAL"
    $tableObj.standings.table.foreach({

        # Format output to fixed widths.
        $fixedWidth = @(
            $_.position.ToString().PadLeft(3),
            $_.team.name.PadRight(30),
            $_.playedGames.ToString().PadLeft(2),
            $_.won.ToString().PadLeft(2),
            $_.draw.ToString().PadLeft(2),
            $_.lost.ToString().PadLeft(2),
            $_.goalsFor.ToString().PadLeft(3),
            $_.goalsAgainst.ToString().PadLeft(3),
            $_.goalDifference.ToString().PadLeft(3),
            $_.points.ToString().PadLeft(3)
        )


        if ($_.position -eq 1) {
            Write-Output "`n  | Pos | Team                           | Pl | W  | D  | L  | F   | A   | D   | Pts |"
        }

        if ($breakers -contains $_.position) {
            Write-Output "  | --- | ------------------------------ | -- | -- | -- | -- | --- | --- | --- | --- |"
        }


        Write-Output ("  | {0} | {1} | {2} | {3} | {4} | {5} | {6} | {7} | {8} | {9} |" -f $fixedWidth)
    })
}
