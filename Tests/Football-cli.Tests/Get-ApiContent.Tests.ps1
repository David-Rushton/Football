$ModuleManifestName = 'Football-cli'
$ModuleManifestPath = "$PSScriptRoot\..\..\Source\$ModuleManifestName\$ModuleManifestName.psd1"

Describe 'Get-ApiContent Tests' {

    Import-Module $ModuleManifestPath -Force

    InModuleScope $ModuleManifestName {

        Mock Get-FootballOption { @{ apiKey = ''; proxy = '' } } -ModuleName 'Football-Cli' -Verifiable
        Mock Invoke-WebRequest { [PSCustomObject]@{ statusCode = 200; content = '{ "match":"", "competition": "" }' } } -Verifiable

        It 'Should return api data as PSCustomObject.' {

            $expected = [PSCustomObject]@{ match = ''; competition = '' }
            $actual = Get-ApiContent -Uri 'matches/250703'

            $actual.match       | Should Be $expected.match
            $actual.competition | Should Be $expected.competition
            $actual             | Should BeOfType [PSCustomObject]

            Assert-VerifiableMock
        }
    }
}
