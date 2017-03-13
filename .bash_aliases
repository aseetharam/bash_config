alias grep='grep --color=auto'
alias pwd='pwd -P'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto -v'
alias du='du -kh'          # Makes a more readable output.
alias df='df -kTh'
alias dd='du -sch *'
alias lh='ls -lh'          # sort in readable way
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias ld='ls -d */'        # list directories only
alias ll='ls -l'
alias lsr='tree -Csu'      # nice alternative to 'recursive ls'
alias l1='ls -1'
alias l11='ls -1 | nl'
alias scp-resume="rsync --partial -h --progress --rsh=ssh"
alias git-commit-count="git log --pretty=format:'' | wc -l"
alias pep8="pep8 --ignore=E501 -r"
alias qr="qstat -r"
alias qs="qstat -a"
alias ss="squeue -a"
alias ssa="squeue -u arnstrm"
alias qra=" qstat -a |grep "arnstrm" |grep -w "R" |nl"
alias qsa=" qstat -a |grep "arnstrm" |grep -w "[QRH]" |nl"
alias dirtree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
#alias qs512="qsub -I -l mem=512Gb,nodes=1:ppn=32:ib32,walltime=48:00:00 -N test"
#alias qs256="qsub -I -l mem=256Gb,nodes=1:ppn=32:ib32,walltime=48:00:00 -N test"
#alias ql64="qsub -I -q testq -l mem=512Gb,nodes=1:ppn=64:ib64,walltime=120:00:00 -N test"
#alias ql32="qsub -I -q testq -l mem=512Gb,nodes=1:ppn=32:ib32,walltime=120:00:00 -N test"
