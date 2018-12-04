$ModuleManifestName = 'Football-cli'
$ModuleManifestPath = "$PSScriptRoot\..\..\Source\$ModuleManifestName\$ModuleManifestName.psd1"

Describe 'Get-FootballOption Tests' {

    Import-Module $ModuleManifestPath -Force

    InModuleScope $ModuleManifestName {

        Mock Test-Path { $true } -ModuleName 'Football-cli'
        Mock Get-Content { '{ "one": 1, "two": "two" }' } -ParameterFilter { $Path -And $Path.EndsWith("config.default.json")} -ModuleName 'Football-cli'
        Mock Get-Content { '{ "one": "one"           }' } -ParameterFilter { $Path -And $Path.EndsWith("config.current.json")} -ModuleName 'Football-cli'


        $actual = Get-FootballOption


        It 'Should return all settings' {

            $actual.Count | Should Be 2
        }


        It 'Should return mix of default and current settings' {

            # Current values should override default.
            $expected = [hashtable]@{
                one = "one"
                two = "two"
            }
            $actual['one'] | Should Be 'one'
            $actual['two'] | Should Be 'two'

        }
    }
}
