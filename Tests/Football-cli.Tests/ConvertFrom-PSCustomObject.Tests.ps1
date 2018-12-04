$ModuleManifestName = 'Football-cli'
$ModuleManifestPath = "$PSScriptRoot\..\..\Source\$ModuleManifestName\$ModuleManifestName.psd1"

Describe 'ConvertFrom-PSCustomObject Tests' {

    Import-Module $ModuleManifestPath -Force

    InModuleScope $ModuleManifestName {

        $convertThis = [PSCustomObject]@{
            PSTypeName = "Name.Will.Be.Ignored"
            one = 1
            two = 2
            three = 3
            first = "a"
            next = "b"
            last = "z"
        }
        $expected = [hashtable]@{
            one = 1
            two = 2
            three = 3
            first = "a"
            next = "b"
            last = "z"
        }
        $actual = ConvertFrom-PSCustomObject $convertThis


        It 'Should convert a PSCustomObject to a Hashtable' {

            $actual | Should BeOfType [hashtable]
        }


        It 'Should return contain all keys' {

            $actual.keys | Should Contain 'one'
            $actual.keys | Should Contain 'two'
            $actual.keys | Should Contain 'three'
            $actual.keys | Should Contain 'first'
            $actual.keys | Should Contain 'next'
            $actual.keys | Should Contain 'last'
        }


        It 'Should return correct values.' {

            $actual['one']      | Should Be $expected['one']
            $actual['two']      | Should Be $expected['two']
            $actual['three']    | Should Be $expected['three']
            $actual['first']    | Should Be $expected['first']
            $actual['next']     | Should Be $expected['next']
            $actual['last']     | Should Be $expected['last']
        }

    }
}
