Clear-Host

$script:check = 0
$path = "C:\TDDT\HelloWorld"

function Write-Error {
    [CmdletBinding()]
    param([parameter(Position=0, Mandatory=$true)][string]$Message)
    process{
        $script:check += 1
        $checkText = $script:check.ToString().PadLeft(3,' ')
        Write-Host "  $checkText [x] $Message" -ForegroundColor DarkRed 
    }
}

function Write-Success {
    [CmdletBinding()]
    param([parameter(Position=0, Mandatory=$true)][string]$Message)
    process{
        $script:check += 1
        $checkText = $script:check.ToString().PadLeft(3,' ')
        Write-Host "  $checkText [$([Char]8730)] $Message" -ForegroundColor Green 
    }
}

function Write-NextStep {
    [CmdletBinding()]
    param(
        [parameter(Position=0, Mandatory=$true)][string]$Message,
        [parameter(Position=1, Mandatory=$false)][string]$Command
    )
    process{
        Write-Host ""
        Write-Host "Next Step: " -ForegroundColor DarkBlue
        Write-Host "$Message" -ForegroundColor DarkGray
        Write-Host ""
        if ($Command -ne $null) {
            Write-Host "Execute:" -ForegroundColor DarkBlue
            Write-Host "> " -ForegroundColor DarkBlue -NoNewLine 
            Write-Host "$Command" -ForegroundColor Blue
            Write-Host ""
        }
    }
}

function Write-Step {
    [CmdletBinding()]
    param([parameter(Position=0, Mandatory=$true)][string]$Step)
    process{
        Write-Host ""
        Write-Host "[$Step]" -ForegroundColor DarkGray
    }
}


Write-Step "Setup the Environment"


$git = (Get-Command "git.exe" -ErrorAction SilentlyContinue)
if ($git -eq $null) {
    Write-Error "git is missing"
    Write-NextStep "Install git from (https://git-scm.com/downloads)"
    return
} else {
    Write-Success "git version $($git.Version) is installed"
}


$dotnet = (Get-Command "dotnet.exe" -ErrorAction SilentlyContinue)
if ($dotnet -eq $null) {
    Write-Error ".NET Core SDK is missing"
    Write-NextStep "Install .NET Core SDK from (https://www.microsoft.com/net/download)"
    return 
} else {
    Write-Success ".NET Core SDK version $($dotnet.Version) is installed"
}


$templates = (& dotnet new --list)
if (($templates -like "*NUnit 3 Test Project*").Count -ne 1) {
    Write-Error "NUnit templates are not installed"
    Write-NextStep "Install NUnit templates" -Command "dotnet new -i NUnit3.DotNetNew.Template"
} else {
    Write-Success "NUnit 3 templates are installed"
}


$vscode = (Get-Command "code" -ErrorAction SilentlyContinue)
if ($vscode -eq $null) {
    Write-Error "Visual Studio Code is not installed"
    Write-NextStep "Install Visual Studio Code from (https://code.visualstudio.com/)"
    return 
} else {
    $vscodeversion = (& code --version) | Select -First 1
    Write-Success "Visual Studio Code version $vscodeversion is isntalled"
}


$extensions = (& code --list-extensions)
if (-Not ($extensions -like "*ms-vscode.csharp*")) {
    Write-Error "Visual Studio Code C# extension is missing"
    Write-NextStep "Install C# extension for Visual Studio Code" -Command "code --install-extension ms-vscode.csharp"
    return 
} else {
    Write-Success "C# extension for Visual Studio Code is installed"
}

if (-Not ($extensions -like "*eamodio.gitlens*")) {
    Write-Error "Visual Studio Code Gitlens extension is missing"
    Write-NextStep "Install Gitlens extension for Visual Studio Code" -Command "code --install-extension eamodio.gitlens"
    return 
} else {
    Write-Success "Gitlens extension for Visual Studio Code is installed"
}

Write-Step "Prepare the Workspace"


if (-Not (Test-Path -Path $path -PathType Container)) {
    Write-NextStep "Create folder $path" -Command "mkdir `"$path`""
    return
} else {
    Write-Success "Folder $path exists"
}

Write-Host ""
