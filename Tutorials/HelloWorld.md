# Hello World

It is a long standing tradition to start learning of a new programming langauge with a `Hello World` application. The objectie is to write an application that will display a 'Hello World' message to the user. With modern tools like Visual Studio (not Code) it is possible to write such application with exactly 3 mouse clicks and no typing at all. But this doesn't teach much, it shows how to generate code that does something trivial without explaining why and how things work. It doesn't explain how to test a code either, a skill which is as important as coding itself. We will do it differently. It will take much longer, that's for sure, but hopefully it will allow you to understand what is happening, a good start to learning to write computer programs. To make most of the learning process don't be lazy, don't copy and past but instead type all the commands and code yourself. If you find any errors, try to solve the problem or ask for help online. 

## 1. Create a folder for the solution
Now that all the tools are ready we need to have a folder where the code will be written. 
Create a folder `C:\TDDT\HelloWorld` 

## 2. Initialize the repository

Open the `C:\TDDT\HelloWorld` folder in Code. You can find it in the start menu and then choose 'Open Folder' option. You can press `[Ctrl+K]`+`[Ctrl+O]` when in Code too. My favourite option is to type `code C:\TDDT\HelloWorld` in the command prompt.

Once the folder has been opened, close the welcome message and press `[Ctrl+']` to toggle the terminal. Your Code should look more or less like so:
![Hello World in VSCode](./Images/HelloWorld.EmptyFolderInVsCode.png)

From now on you can type the commands directly in VSCode, in the terminal instead of Git Bash, but Git Bash will still work. 

Next step is to create a git repository in the folder to let git know that we want it to version contents of that folder. To do so, make sure you are in the `C:\TDDT\HellowWorld` folder (the terminal prompt should be `PS C:\TDDT\HelloWorld>`). If you are not navigate to it by executing `cd C:\TDDT\HelloWorld` in the terminal. 

Now initiate the repository using 

```
git init
```

and check if it worked using 

```
git status
```

## 3. Create solution and projects

Next we will need to create a solution for the projects. Solution is a logical grouping of projects defined in a *.sln file and a project is a collection of files with code and other assets that get compiled into an executable or a library. It is an important part of the initial setup as we will be developing multiple projects at the same time. The easiest way to do so is using `dotnet` command. 

Navigate to C:\Dev\TDDT in the terminal and execute

```
dotnet new sln
```

which creates HelloWorld.sln file, which is now visible in VS Code Explorer

![HelloWorld.sln](./Images/HelloWorld.SolutionFile.png)

The 1 in the blue cricle on top of Source Control icon indicates that there are uncommitted changes in the git repo. Let's ignore it for now and carry on creating the projects. 

```
dotnet new nunit -n HelloWorld.Tests
```

```
dotnet new classlib -n HelloWorld
dotnet add HelloWorld.Tests reference HelloWorld
dotnet sln add HelloWorld
dotnet sln add HelloWorld.Tests
```

This is how the solution structure looks before the first build

![HelloWorld.sln](./Images/HelloWorld.SolutionBeforeFirstBuild.png)

Build solution 
```
dotnet build
```

![HelloWorld.sln](./Images/HelloWorld.SolutionAfterFirstBuild.png)

There are 21 changed files. Most of them autogenerated and in most case of no interest to a developer. They are there to allo the build tools do their job (the obj folders) or an output of the build (the bin folders). There is no need to see those folder in the VS Code file explorer and in the case of the bin folder we shouldn't commit them either. The next step is to fix this. 

## 4. Add .gitignore file

Create the `.gitignore` file in the `C:\TDDT\HelloWorld` folder and add two lines in it:

```
bin/
obj/
```

to exclude `obj` and `bin` folders from being tracked by git

![.gitignore](./Images/HelloWorld.GitIgnore.png)

Create `.vscode\settings.json` file with the following content

```
{ 
    "files.exclude": { 
        "**/bin/": true, 
        "**/obj/": true,
        ".vscode/": true
    }
}
```

![Solution after cleanup](./Images/HelloWorld.SolutionAfterCleanup.png)