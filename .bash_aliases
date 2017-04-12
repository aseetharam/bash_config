# location
alias pwd='pwd -P'

#grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# listing
alias ls='ls --color=auto -v'
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

# transfer 
alias scp-resume="rsync --partial -h --progress --rsh=ssh"
alias git-commit-count="git log --pretty=format:'' | wc -l"
alias pep8="pep8 --ignore=E501 -r"

# slurm
alias interactive='srun -N 1 -n 16 -t 04:00:00 --pty bash'
alias qs="squeue -a"
alias qsa="squeue -u arnstrm"
alias qn='sinfo --format="%25N %.3D %9P %11T %.4c %14C %.8z %.8m %.4d %.8w %10f %20E"'
alias ql='sinfo --states=down,drain,fail,no_respond,maint,unk --format="%12n %20f %20H %12u %32E"'
alias qj='sacct -o user,jobid,jobname,state,node,start'

# pbs
#alias qra=" qstat -a |grep "arnstrm" |grep -w "R" |nl"
#alias qsa=" qstat -a |grep "arnstrm" |grep -w "[QRH]" |nl"

# dir
alias dirtree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
alias cdg="cd /work/GIF/arnstrm/gitdirs"
alias du='du -kh'          # Makes a more readable output.
alias df='df -kTh'
alias dd='du -sch *'
