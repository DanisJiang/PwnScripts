# PwnScripts

The original intention that I build this Repository is a few days ago I saw the https://github.com/matrix1001/welpwn, which is designed to make pwnning an art. So I decided to write something to make my pwnning more artistic.

## pwn.sh

Usage:

move pwn.sh to the PATH

```
pwn.sh [filename] ([ip]) ([port]) ([libcname])
sample:
pwn.sh hacknote chall.pwnable.tw 10102 libc.so.6
```

When I start a new pwn, I always copy an old script and change the filename, libcname, ip and port one by one. This is so meaningless.

The framework of the pwn script is welpwn, which is so easy to 
specify libc for the program.