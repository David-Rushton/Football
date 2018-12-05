$ModuleManifestName = 'Football-cli'
$ModuleManifestPath = "$PSScriptRoot\..\..\Source\$ModuleManifestName\$ModuleManifestName.psd1"

Describe 'Get-FootballOptionPath Tests' {

    Import-Module $ModuleManifestPath -Force

    InModuleScope $ModuleManifestName {

        It 'Should return a valid default path' {

            $actual = Get-FootballOptionPath -OptionSet 'default'
            $actual | Should Exist
        }

        It 'Should return a user path' {

            $actual = Get-FootballOptionPath -OptionSet 'user'
            $actual | Should BeLike "*config.user.json"
        }

        # TODO: Devise test for user file, that may/may not exist.
    }
}
