# Workstation setup - the Tools

## 1. Git
Install [git](https://git-scm.com/about) from (https://git-scm.com/download/win). `Git` is a [source code repository](https://en.wikipedia.org/wiki/Version_control) which helps to manage code versions and collaborate with other developers. Althought it is not strictly required to write your first 'hello world' application, it will make the learning easier. As you save your progress regularily, if something goes wrong you will be able to go back to the last working version and start again from that point. Install using default settings. 

After installation you should be able to find `Git Bash` in your start menu. When started it looks like the command prompt.
Type in `git --version` followed by enter to see if git is installed. The result should be something like this:

```
$ git --version
git version 2.19.0.windows.1
```

## 2. .NET Core SDK 
Install [.NET Core SDK] from (https://www.microsoft.com/net/download?initial-os=windows). Click on `Download .NET Core SDK` and follow the instructions. [.NET Core](https://en.wikipedia.org/wiki/.NET_Core) is a [software framework](https://en.wikipedia.org/wiki/Software_framework) on which we will be building our software. [SDK](https://en.wikipedia.org/wiki/Software_development_kit) stands for Software Development Kit and is a set of tools used to help development of software. After installing the .NET Core SDK among many other things you will have the `dotnet` command which we will use a lot to create projects, to build, test and run the applications we are about to write. 

Aftetr installation you should be able to open `Git Bash` again and type `dotnet --version` followed by enter. If everything went as expected you will see the current dotnet version. The output should be something like this:

```
$ dotnet --version
2.1.402
```

## 3. NUnit Templates
[NUnit](https://en.wikipedia.org/wiki/NUnit) is a [unit testing](https://en.wikipedia.org/wiki/Unit_testing) framework we will use to make sure the code we are about to write does exactly what it is supposed to do. Unit testing is a very important part of software development which is often overlooked, definately at the beginning, it is often claimed that it is difficult and takes too much time. That can be true, especially when tests are added after the code has been written without following necessary patterns and practicies but when one starts with a test, in a [TDD](https://en.wikipedia.org/wiki/Test-driven_development) fashion, it soon becomes a second nature and allows to write better code fast. 

Install NUnit templates by executing the following command in the Git Bash

```
dotnet new -i NUnit3.DotNetNew.Template
```

## 4. Visual Studio Code
Install [VS Code](https://en.wikipedia.org/wiki/Visual_Studio_Code) which is the source code editor we will use to start developing simple applications.
Follow the instructions on (https://code.visualstudio.com/) to download and install VS Code. 

After installation you will find `Visual Studio Code` in your start menu. 

## 5. Visual Studio Code Extensions
Although Visual Studio Code (VS Code) is useful on its own, it can use extensions which are developed and distributed independently. To make life easier through this lengthy hello world example install `C# (ms-vscode.csharp)` and `Gitlens (eamodio.gitlens)` extensions using the following commands: 

(If you had Git Bash open when you installed Visual Studio Code you will have to close and open it again for the `code` command to become available)

```
code --install-extension ms-vscode.csharp
code --install-extension eamodio.gitlens
```

The C# extension will help you with [syntax highlighting](https://en.wikipedia.org/wiki/Syntax_highlighting) and [intellisense](https://en.wikipedia.org/wiki/Intelligent_code_completion) while Gitlens will help to use git repository. 

## 6. Getting to know VS Code 
From now on most of the work you will do in VS Code so it is worth learning more about it. There is a good introductory [video](https://code.visualstudio.com/docs/introvideos/basics) on the official project website. There you will learn about the basic features but also where to find more information. VS Code will be your main tool for writing code for a while, so it is worth learning it well, but not necessarily all up-front. 

[![VS Code Basics Video](https://img.youtube.com/vi/Sdg0ef2PpBw/0.jpg)](https://www.youtube.com/watch?v=Sdg0ef2PpBw)
