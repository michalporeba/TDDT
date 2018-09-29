cls
$script:check = 0

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
}

Write-Host ""
