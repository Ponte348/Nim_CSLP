# Nim Presentation
### Group 6 Students: Pedro Ponte 98059; André Cardoso XXXXXX; Bruno Páscoa XXXXXX;

## Installation guide

This guide is aimed at Users users, if you have another OS refer to the Nim official website (https://nim-lang.org/install.html)

For this presentation you will need three things:
1. Nim Compiler
2. C Compiler
3. Text Editor


### 1. Nim Compiler
The easiest way of installing **Nim** is using _choosenim_, simply run the following commands:
```bash
$ sudo apt update
$ sudo apt install curl
$ curl https://nim-lang.org/choosenim/init.sh -sSf | sh
```
And follow the onscreen instructions\
**Don't forget to add _export PATH=/home/<your-user>/.nimble/bin:$PATH_ to PATH** (switch "<your-user>" with your actual user)
```bash
$ nano ~/.bashrc

...
  fi
fi

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
# What you need to add
export PATH=/home/<your-user>/.nimble/bin:$PATH
```


### 2. C Compiler

If you're using Unix you should have a C compiler like **gcc**, but others are usable as well.


### 3. Text Editor

Use whatever you prefer, we will be using VSCode.



### Conclusion

After adding **Nim** to PATH confirm it's working (don't forget you need to restart you terminal after updating the ~/.bashrc).

Type:
```
$ nim --version
Nim Compiler Version 2.0.0 [Linux: amd64]
Compiled at 2023-08-01
Copyright (c) 2006-2023 by Andreas Rumpf
```


### Troubleshooting

If you find any errors, follow these steps:
1. https://nim-lang.org/install.html
2. https://www.ibm.com/docs/en/aix/7.2?topic=management-troubleshooting-nim
3. Search online
4. Contact us:
    - Email: ponte@ua.pt
    - Whatsapp: +351 968772323
 


# Next Part
TODO: maybe o VSCode tem alguma extensão útil?



