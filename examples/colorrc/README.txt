# how to have better colors with a light background

-> use a bettet ```LS_COLORS``` variable !

colors are difined in the file : [dircolors][1]
you can load the color definition with 

# for more colors check [dircolors-solarized][3]

```
curl https://gateway.ipfs.io/ipfs/QmamDLXELgfHvPxGuM1mwn2XfaUhiv6ZbqrCc6ZRRzotvP/dircolors > /tmp/dircolors
eval $(dircolors -b /tmp/dircolors)
```

and you can place the following [commands][2] in your startup file ($HOME/.bashrc)
```
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
```


## INSTALLATION
```
sudo apt-get dircolors
# you must have an ipms daemon running locally
# ipms daemon &
ipms get -o ~/.dircolors /ipfs/QmamDLXELgfHvPxGuM1mwn2XfaUhiv6ZbqrCc6ZRRzotvP/dircolors
ipms cat /ipfs/QmamDLXELgfHvPxGuM1mwn2XfaUhiv6ZbqrCc6ZRRzotvP/dircolorrc >> ~/.profiles
```

--&nbsp;<br>
$tic: 0$


[1]: dircolors
[2]: dircolorrc
[3]: https://github.com/seebi/dircolors-solarized
[4]: https://github.com/trapd00r/LS_COLORS
