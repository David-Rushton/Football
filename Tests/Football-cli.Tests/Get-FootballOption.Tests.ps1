$ModuleManifestName = 'Football-cli'
$ModuleManifestPath = "$PSScriptRoot\..\..\Source\$ModuleManifestName\$ModuleManifestName.psd1"

Describe 'Get-FootballOption Tests' {

    Import-Module $ModuleManifestPath -Force

    InModuleScope $ModuleManifestName {

        context 'Default and users settings defined' {

            Mock Test-Path { $true } -ModuleName 'Football-cli'
            Mock Get-Content { '{ "one": 1, "two": "two" }' } -ParameterFilter { $Path -And $Path.EndsWith("config.default.json")} -ModuleName 'Football-cli'
            Mock Get-Content { '{ "one": "one"           }' } -ParameterFilter { $Path -And $Path.EndsWith("config.user.json")} -ModuleName 'Football-cli'


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
                $actual['one'] | Should Be $expected['one']
                $actual['two'] | Should Be $expected['two']

            }
        }


        context 'Default settings only' {

            Mock Test-Path { $false } -ModuleName 'Football-cli'
            Mock Get-Content { '{ "one": 1, "two": "two" }' } -ParameterFilter { $Path -And $Path.EndsWith("config.default.json")} -ModuleName 'Football-cli'

            It 'Should return default settings, when user not defined' {

                $actual = Get-FootballOption

                $actual.Count  | Should Be 2
                $actual['one'] | Should Be 1
                $actual['two'] | Should Be "two"
            }
        }


        context 'Default settings and values' {

            Mock Test-Path { $false } -ModuleName 'Football-cli'

            It 'Should return default settings and values' {

                $actual = Get-FootballOption

                $actual.Count     | Should Be 2
                $actual['apiKey'] | Should Be ''
                $actual['proxy']  | Should Be ''
            }
        }

    }
}
