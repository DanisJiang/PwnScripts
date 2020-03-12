if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "pwn.sh [filename] ([ip]) ([port]) ([libcname])"
    exit
elif [ $# -gt 0 ]; then
    chmod +x $1
    filename="pwn"$1".py"
    touch $filename
    echo "from PwnContext import *
from libnum import *

try:
    from IPython import embed as ipy
except ImportError:
    print ('IPython not installed.')

if __name__ == '__main__':        
    # context.terminal = ['tmux', 'splitw', '-h'] # uncomment this if you use tmux
    context.log_level = 'debug'
    # functions for quick script
    s       = lambda data               :ctx.send(str(data))        #in case that data is an int
    sa      = lambda delim,data         :ctx.sendafter(str(delim), str(data)) 
    sl      = lambda data               :ctx.sendline(str(data)) 
    sla     = lambda delim,data         :ctx.sendlineafter(str(delim), str(data)) 
    r       = lambda numb=4096          :ctx.recv(numb)
    ru      = lambda delims, drop=True  :ctx.recvuntil(delims, drop)
    irt     = lambda                    :ctx.interactive()
    rs      = lambda *args, **kwargs    :ctx.start(*args, **kwargs)
    dbg     = lambda gs='', **kwargs    :ctx.debug(gdbscript=gs, **kwargs)
    # misc functions
    " > $filename
    
    echo "    ctx.binary = './"$1"'" >> $filename
    if [ $# -gt 2 ]; then
        echo "    ctx.remote = ('"$2"'," $3")" >> $filename
    else
        echo "    ctx.remote = ('0.0.0.0', 9999)"  >> $filename
    fi
    if [ $# -eq 4 ]; then
        if [ "$4" != "libc.so.6" ]; then
            mv $4 libc.so.6
        fi
        echo "    ctx.remote_libc = './libc.so.6'
    ctx.debug_remote_libc = True"  >> $filename
    fi
    echo "    rs()
    # rs('remote')
    # print(ctx.libc.path)" >> $filename
    echo ""  >> $filename
    echo ""  >> $filename
    echo "    irt()" >> $filename
fi
    echo "[*] created $filename successfully!"
    echo ""
    echo "[*] file "$1"------------------------------------"
    echo ""
    file $1
    echo ""
    echo "[*] checksec "$1"------------------------------------"
    echo ""
    checksec $1
    code $filename --user-data-dir