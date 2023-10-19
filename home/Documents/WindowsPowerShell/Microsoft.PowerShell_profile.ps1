Remove-Item alias:curl
Set-Alias wcurl Invoke-WebRequest

Import-Module posh-git
Import-Module -Name Terminal-Icons
Import-Module -Name z
Import-Module -Name PSReadLine

Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

function which ($command) { 
    Get-Command -Name $command -ErrorAction SilentlyContinue | 
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue 
}

function touch ($filename) {
    # TODO: Check for actual path
    New-Item -Path . -Name $filename -ItemType "file"
}
