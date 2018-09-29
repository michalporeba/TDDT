Clear-Host

$script:check = 0
$project = "HelloWorld"
$path = "C:\TDDT\$project"

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
        [parameter(Position=1, Mandatory=$false)][string[]]$Command
    )
    process{
        Write-Host ""
        Write-Host "Next Step: " -ForegroundColor DarkBlue
        Write-Host "$Message" -ForegroundColor DarkGray
        Write-Host ""
        if ($null -ne $Command) {
            Write-Host "Execute:" -ForegroundColor DarkBlue

            @($Command).ForEach{
                Write-Host "> " -ForegroundColor DarkBlue -NoNewLine 
                Write-Host "$psitem" -ForegroundColor Blue
            }
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
if ($null -eq $git) {
    Write-Error "git is missing"
    Write-NextStep "Install git from (https://git-scm.com/downloads)"
    return
} else {
    Write-Success "git version $($git.Version) is installed"
}


$dotnet = (Get-Command "dotnet.exe" -ErrorAction SilentlyContinue)
if ($null -eq $dotnet) {
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
if ($null -eq $vscode) {
    Write-Error "Visual Studio Code is not installed"
    Write-NextStep "Install Visual Studio Code from (https://code.visualstudio.com/)"
    return 
} else {
    $vscodeversion = (& code --version) | Select-Object -First 1
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

if (-Not (Test-Path -Path "$path\.git" -PathType Container)) {
    Write-NextStep "Initialize git repository in $path" -Command "cd `"$path`"","git init"
    return
} else {
    Write-Success "There is a git repo in $path"
}

if (-Not (Test-Path -Path "$path\$project.sln")) {
    Write-NextStep "Create solution in $path" -Command "dotnet new sln"
    return
} else {
    Write-Success "The solution file `"$path\$project.sln`" exists"
}

if (-Not (Test-Path -Path "$path\$project.Tests\$project.Tests.csproj")) {
    Write-NextStep "Create unit test project $project.Tests" -Command "dotnet new nunit -n $project.Tests"
    return
} else {
    Write-Success "The unit test project `"$path\$project.Tests\$project.Tests.csproj`" exists"
}

if (-Not (Test-Path -Path "$path\$project\$project.csproj")) {
    Write-NextStep "Create library project $project" -Command "dotnet new classlib -n $project"
    return
} else {
    Write-Success "The library project `"$path\$project\$project.csproj`" exists"
}

if (-Not((Get-Content "$path\$project.Tests\$project.Tests.csproj") -like "*ProjectReference Include=`"..\HelloWorld\HelloWorld.csproj`"*")) {
    Write-NextStep "Add reference in the unit test project to the library project" -Command "dotnet add $project.Tests reference $project"
    return
} else {
    Write-Success "Test project has reference to the library project"
}

if (-Not((& dotnet sln $path list) -like "*HelloWorld.csproj*")) {
    Write-NextStep "Add project HelloWorld to the solution" -Command "dotnet sln add HelloWorld"
    return
} else {
    Write-Success "HelloWorld project is in the Solution"
}

if (-Not((& dotnet sln $path list) -like "*HelloWorld.Tests.csproj*")) {
    Write-NextStep "Add project HelloWorld.Tests to the solution" -Command "dotnet sln add HelloWorld.Tests"
    return
} else {
    Write-Success "HelloWorld.Tests project is in the Solution"
}

#dotnet new nunit -n HelloWorld.Tests

Write-Host ""
