# Remove-Item alias:curl
# Set-Alias wcurl Invoke-WebRequest

#PoshGit
Import-Module posh-git

#Terminal Icons
Import-Module -Name Terminal-Icons

#Z
Import-Module -Name z

#PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource HistoryAndPlugin 
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

#PowerType
Enable-PowerType

#PsFzf
Import-Module PSFzf
Set-PsFzfOption -PSReadLineChordProvider "Ctrl+f" -PSReadLineChordReverseHistory "Ctrl+r"

function which ($command) { 
    Get-Command -Name $command -ErrorAction SilentlyContinue | 
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue 
}

function touch ($filename) {
    # TODO: Check for actual path
    New-Item -Path . -Name $filename -ItemType "file"
}
