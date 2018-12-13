Describe 'Get-FootballTable Tests' {

    $ModuleManifestName = 'Football-cli'
    $ModuleManifestPath = "$PSScriptRoot\..\..\Source\$ModuleManifestName\$ModuleManifestName.psd1"

    Import-Module $ModuleManifestPath -Force


    InModuleScope $ModuleManifestName {

        $mockTableObj = [PSCustomObject]@{
            standings = [PSCustomObject]@{
                table = @(
                    [PSCustomObject]@{ position =  1; team = [PSCustomObject]@{name = 'team 01'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position =  2; team = [PSCustomObject]@{name = 'team 02'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position =  3; team = [PSCustomObject]@{name = 'team 03'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position =  4; team = [PSCustomObject]@{name = 'team 04'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position =  5; team = [PSCustomObject]@{name = 'team 05'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position =  6; team = [PSCustomObject]@{name = 'team 06'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position =  7; team = [PSCustomObject]@{name = 'team 07'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position =  8; team = [PSCustomObject]@{name = 'team 08'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position =  9; team = [PSCustomObject]@{name = 'team 09'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position = 10; team = [PSCustomObject]@{name = 'team 10'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position = 11; team = [PSCustomObject]@{name = 'team 11'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position = 12; team = [PSCustomObject]@{name = 'team 12'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position = 13; team = [PSCustomObject]@{name = 'team 13'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position = 14; team = [PSCustomObject]@{name = 'team 14'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position = 15; team = [PSCustomObject]@{name = 'team 15'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position = 16; team = [PSCustomObject]@{name = 'team 16'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position = 17; team = [PSCustomObject]@{name = 'team 17'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position = 18; team = [PSCustomObject]@{name = 'team 18'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position = 19; team = [PSCustomObject]@{name = 'team 19'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                    [PSCustomObject]@{ position = 20; team = [PSCustomObject]@{name = 'team 20'}; playedGames = 1; won = 1; draw = 1; lost = 1; goalsfor = 1; goalsAgainst = 1; goalDifference = 1;  points = 1}
                )
            }
        }
        # TODO: Find method for testing this is returned.
        $mockTableTxt = @(
            "`n  | Pos | Team                           | Pl | W  | D  | L  | F   | A   | D   | Pts |"
             '  | --- | ------------------------------ | -- | -- | -- | -- | --- | --- | --- | --- |'
             '  |   1 | team 01                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |   2 | team 02                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |   3 | team 03                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |   4 | team 04                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  | --- | ------------------------------ | -- | -- | -- | -- | --- | --- | --- | --- |'
             '  |   5 | team 05                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |   6 | team 06                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |   7 | team 07                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |   8 | team 08                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |   9 | team 09                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |  10 | team 10                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |  11 | team 11                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |  12 | team 12                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |  13 | team 13                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |  14 | team 14                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |  15 | team 15                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |  16 | team 16                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |  17 | team 17                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  | --- | ------------------------------ | -- | -- | -- | -- | --- | --- | --- | --- |'
             '  |  18 | team 18                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |  19 | team 19                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
             '  |  20 | team 20                        |  1 |  1 |  1 |  1 |   1 |   1 |   1 |   1 |'
        )
        Mock Get-ApiContent { $mockTableObj } -ModuleName 'Football-cli'


        It 'Should complete on all valid competition names' {

            $supportedCompetitionNames = @(
                'The Premier League', 'Premier League', 'Premier', 'Prem', 'PL',
                'The ELF Championship', 'The Championship', 'ELF Championship', 'Championship', 'ELC',
                'The UEFA Champions League', 'The Champions League', 'Champions League', 'Champions' , 'CL'
            )

            foreach ($name in $supportedCompetitionNames) {

                { Get-FootballTable -Competition $name } | Should Not Throw
            }
        }


        It 'Should support lowercase competition names' {

            # Underlying API requires uppercase competition name.
            # Ensure it is converted by cmdlet.
            { Get-FootballTable -Competition 'pl' } | Should Not Throw
        }

    }
}
