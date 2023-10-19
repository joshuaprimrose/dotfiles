# dotfiles
A repo containing any items needed for configuring a usable windows dev environment

# Additional Tools
- Chocolatey: https://chocolatey.org/
- Alacritty: https://github.com/alacritty/alacritty
- Git: https://git-scm.com/
- Posh Git: https://github.com/dahlbyk/posh-git
- MinGW: https://www.mingw-w64.org/
- Various tools (GNU & Others): awk, fd, fzf, ripgrep, sed, etc.
- Neovim: https://neovim.io/

# Install
1. Update any certs (or add http.sslVerify = false to your git config `git config --global http.sslVerify false`)
2. Install fzf binary: `choco install fzf -y`
3. Update Powershell `iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"`
4. Launch PowerShell. It should create a profile in Windows Terminal for you. I always run as admin.
5. Create your Powershell profile `New-Item -Path $profile -Type File -Force` (you can run `echo $profile` to find the location)
6. Install poshgit `choco install poshgit -y`
    Install the PS module: `Install-Module posh-git -Scope CurrentUser -Force` `
    Add: `Import-Module posh-git` to your powershell profile (see #5 above)
7. Install Terminal Icons module:`Install-Module -Name Terminal-Icons -Repository PSGallery`
    Add: `Import-Module -Name Terminal-Icons` to your powershell profile (see #5 above)
8. Add fzf module: `Install-Module -Name PSFzf -Scope CurrentUser -Force`
    Add: `Import-Module PSFzf` and `Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'` to your powershell profile (see #5 above)
9. Install the Z module: `Install-Module -Name z –Force`
    Add: `Import-module -Name z` to your powershell profile (see #5 above)
10. Install the PSReadLine module: `Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck`
    Add: `Import-Module -Name PSReadLine` to your powershell profile (see #5 above)
10. Install MinGw `choco install mingw -y`
11. Install cmake and make `choco install cmake make -y`
12. Install Lua `choco install lua -y`
13. Install Node JS `choco install nodejs -y`
14. Install Python 3 (optional) `choco install python2 -y`
15. Install Zig (optional) `choco install zig -y`
16. Install Go (optional) `choco install golang -y`
17. Install awk, curl, fd, gzip, jq, ripgrep, sed, unzip, wget `choco install awk curl fd gzip jq ripgrep sed unzip wget -y`
18. Install Neovim `choco install neovim -y`
19. Install lazygit `choco install lazygit`
20. Install JDK 20 to `C:\TrustedApps\Java`
21. Update M2_HOME to MVN_HOME and add JAVA_HOME env vars
22. Copy your <MVN_HOME>/conf/settings.xml to <user>/.m2/settings.xml
23. Modify 
