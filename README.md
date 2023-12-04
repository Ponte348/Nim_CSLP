# Nim tutorial
**Group 6 Students:**
- Pedro Ponte   | 98059
- André Cardoso | 108269
- Bruno Páscoa  | 107418;

## Navigating this repository

Further down this page you'll find the instructions to prepare everything you need for our presentation.  
Additionally, we encourage you to browse our *Learning* folder, if you want to read more about what we prepared.


## Installation guide

This guide is aimed at Unix users, if you have another OS refer to the Nim official website (https://nim-lang.org/install.html)

For this presentation you will need three things:
1. Nim Compiler
2. C Compiler
3. Text Editor


### 1. Nim Compiler
The easiest way of installing **Nim** is using the [_choosenim_](https://github.com/dom96/choosenim#choosenim) tool.

You can install it by running the following commands:

```bash
$ sudo apt update && sudo apt upgrade
$ sudo apt install curl
$ curl https://nim-lang.org/choosenim/init.sh -sSf | sh
```

After installing **choosenim**, you must add it to your PATH and source your shell profile again:

```bash
$ echo '#Nim\nPATH=$HOME/.nimble/bin:$PATH' >> ~/.bashrc
$ source ~/.bashrc
```


### 2. C Compiler

You will need a C compiler to compile the Nim code. We recommend using **gcc**, but any compiler should work. You can install it by running the following command:

```bash
$ sudo apt install gcc
```


### 3. Text Editor

Use whatever you prefer, we will be using VSCode with the [Nim](https://marketplace.visualstudio.com/items?itemName=nimsaem.nimvscode) plugin.



### Conclusion

After adding **Nim** to your PATH, confirm it's working. If you get an error, try restarting your terminal

To verify that **Nim** is installed, run the following command in your terminal
```bash
$ nim --version
Nim Compiler Version 2.0.0 [Linux: amd64]
Compiled at 2023-08-01
Copyright (c) 2006-2023 by Andreas Rumpf
```


### Troubleshooting

If you find any errors, you can file an issue on this repo or try the following:
1. Visiting https://nim-lang.org/install.html
2. Joining the [Nim discord server](https://discord.com/invite/nim)
3. Contact us:
    - Email: ponte@ua.pt
    - Whatsapp: +351 968772323
 


## Files Needed

Navigate to your work directory and clone our repository to get the files needed for this presentation.: 
```bash
$ git clone https://github.com/Ponte348/Nim_CSLP
```

The exercises will be in **Nim_Exercises.pdf** and the presentation slides are **Nim_Presentation**.


