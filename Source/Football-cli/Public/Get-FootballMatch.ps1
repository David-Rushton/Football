<#
    .SYNOPSIS
    Details fixtures/results.

    .DESCRIPTION
    Lists fixtues or results for the current season of any supported
    competition.

    .PARAMETER Competition
    Choose from The Premier League (PL), The ELF Championship (ELC) or The UEFA
    Champtions League (CL).

    .PARAMETER MatchDay
    Supported values are Last, Current, Next or any match day number.

    .EXAMPLE
    # Return the current round.
    PS C:\> Get-FootballMatch -Competition 'pl' -MatchDay 'Current'

    .EXAMPLE
    # Review the first day of the season.
    PS C:\> Get-FootballMatch -Competition 'elc' -MatchDay 1

#>
function Get-FootballMatch {
    [CmdletBinding()]
    [OutputType([string])]

    param(

        [parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage='Which league do you want to view?'
        )]
        [ValidateSet(
            'The Premier League', 'Premier League', 'Premier', 'Prem', 'PL',
            'The ELF Championship', 'The Championship', 'ELF Championship', 'Championship', 'ELC',
            'The UEFA Champions League', 'The Champions League', 'Champions League', 'Champions' , 'CL'
        )]
        [string]
        $Competition,

        [parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage='Last, Current, Next or a number.'
        )]
        [ValidateScript({ ($_ -in @('Last', 'Current' , 'Next')) -or ($_ -match "^[\d]+$") })]
        [string]
        $MatchDay
    )


    Set-StrictMode -Version 'Latest'


    # We'll need the current match day if an relative has been provided.
    if ($MatchDay -isnot [int]) {

        $currentMatchDay = ( Get-ApiContent -Uri "competitions/$($Competition.ToUpper())" ).currentSeason.CurrentMatchDay
    }


    switch ($MatchDay) {
        'Last'      { $requiredMatchDay = ($currentMatchDay - 1) }
        'Current'   { $requiredMatchDay = ($currentMatchDay    ) }
        'Next'      { $requiredMatchDay = ($currentMatchDay + 1) }
        default     { $requiredMatchDay = $MatchDay }
    }


    $m = Get-ApiContent -Uri "competitions/$($Competition.ToUpper())/matches?matchday=$requiredMatchDay"
    $m.matches.foreach({

        $status = $_.status
        $kickoff = ([datetime]$_.utcDate).ToString('d/M H:mm')
        $homeTeam = $_.homeTeam.Name.PadLeft(30)
        $awayTeam = $_.awayTeam.Name.PadRight(30)
        $score = $_.score
        $winner = $_.score.winner


        if ($status -in @('LIVE', 'IN_PLAY', 'PAUSE', 'FINISHED')) {

            $homeTeam = "$homeTeam $($score.fullTime.homeTeam)"
            $awayTeam = "$($score.fullTime.awayTeam) $awayTeam"
            $homeCol  = if ($winner -eq 'HOME_TEAM') { 'Yellow' } else { 'Gray' }
            $awayCol  = if ($winner -eq 'AWAY_TEAM') { 'Yellow' } else { 'Gray' }

            Write-Host "  $status" -NoNewline
            Write-Host $homeTeam -ForegroundColor $homeCol -NoNewline
            Write-Host " - " -NoNewline
            Write-Host $awayTeam -ForegroundColor $awayCol
        }
        else {

            write-host "  $kickoff $homeTeam - $awayTeam"
        }
    })

}
