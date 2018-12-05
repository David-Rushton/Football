$ModuleManifestName = 'Football-cli'
$ModuleManifestPath = "$PSScriptRoot\..\..\Source\$ModuleManifestName\$ModuleManifestName.psd1"

Describe 'Set-FootballOption Tests' {

    Import-Module $ModuleManifestPath -Force

    InModuleScope $ModuleManifestName {

        Mock Get-FootballOption { @{ One = 1; Two = 2 } } -ModuleName 'Football-cli'

        Context 'Warning with write' {

            It 'Should warn on unsupported options' {

                Mock Set-Content {} -Verifiable -ModuleName 'Football-cli'
                $option = @{ UnsupportedOption = "test-value" }

                Set-FootballOption -Option $option 3>&1 | Should Match "Option not recognised: UnsupportedOption"
                Assert-MockCalled -CommandName Set-Content -Times 0
            }
        }


        It 'Should update user config file' {

            $path = "TestDrive:\config.user.json"
            $option = @{ one = 'one' }
            Mock Get-FootballOptionPath { $path } -ParameterFilter { $OptionSet -eq 'user' } -ModuleName 'Football-cli'

            Set-FootballOption -Option $option

            $path | Should Exist

        }
    }
}
