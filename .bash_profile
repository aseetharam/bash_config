# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

###############################
## FUNCTIONS
###############################

mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

up () {
        COUNTER=$1
        while [[ $COUNTER -gt 0 ]]
         do
          UP="${UP}../"
          COUNTER=$(( $COUNTER -1 ))
         done
        echo "cd $UP"
        cd $UP
        UP=''
}


# Version control current branch function
function get_curr_branch {
  local dir="$PWD"
  local vcs
  local nick
  while [[ "$dir" != "/" ]]; do
    for vcs in git hg svn bzr; do
      if [[ -d "$dir/.$vcs" ]] && hash "$vcs" &>/dev/null; then
        case "$vcs" in
          git) __git_ps1 "${1:- %s}"; return;;
          hg) nick=$(hg branch 2>/dev/null);;
          svn) nick=$(svn info 2>/dev/null\
                | grep -e '^Repository Root:'\
                | sed -e 's#.*/##');;
          bzr)
            local conf="${dir}/.bzr/branch/branch.conf" # normal branch
            [[ -f "$conf" ]] && nick=$(grep -E '^nickname =' "$conf" | cut -d' ' -f 3)
            conf="${dir}/.bzr/branch/location" # colo/lightweight branch
            [[ -z "$nick" ]] && [[ -f "$conf" ]] && nick="$(basename "$(< $conf)")"
            [[ -z "$nick" ]] && nick="$(basename "$(readlink -f "$dir")")";;
        esac
        [[ -n "$nick" ]] && printf "${1:- %s}" "$nick"
        return 0
      fi
    done
    dir="$(dirname "$dir")"
  done
}

function rdom() { local IFS=\> ; read -d \< E C ; }


# Find a file with a pattern in name:
function ff() { find $(pwd -P) -type f -iname '*'$*'*' -ls ; }
function fd() { find $(pwd -P) -type d -iname '*'$*'*' -ls ; }

function fp() { find $(pwd -P) -type f -name '*'$* ; }


# Find a file with pattern $1 in name and Execute $2 on it:
function fe()
{ find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ; }

# Find a pattern in a set of files and highlight them:
function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    find . -type f -name "${2:-*}" -print0 | \
    xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more

}

# cut last n lines in file, 10 by default
function cuttail()
{
    nlines=${2:-10}
    sed -n -e :a -e "1,${nlines}!{P;N;D;};N;ba" $1
}
change () {
        from=$1
        shift
        to=$1
        shift
        for file in $*
        do
                perl -i.bak -p -e "s{$from}{$to}g;" $file
                echo "Changing $from to $to in $file"
        done
}

# move filenames to lowercase
function lowercase()
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

# count files
function fcount()
{
echo "   files  path"
echo "   -----  ----"
find . -type f -printf '%h\n' | sort | uniq -c
echo ""
echo ""
echo -e "\tSummary"
echo "==========================="
find $DIR -exec stat -c '%F' {} \; | sort | uniq -c | sort -rn
echo "==========================="
}

# swap filenames
function swap()
{
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# getlimit function
function getLimit()
{
    local pairs=0 count=0 limit=$1 wantdiff=$2
    shift 2
    while [ "$1" ] ;do
        [abs $(( $2-$1 )) -ge $limit ] && : $((count++))
        : $((pairs++))
                shift 2
      done
    test $((pairs-count)) -eq $wantdiff
}
# extract compressed files
function extract()      # Handy Extract Program.
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *.tar.xz)    tar xJvf $1     ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
# svn completion
_svn ()
{
    local cur prev
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}
    if [ $COMP_CWORD -eq 1 ] || [ "${prev:0:1}" = "-" ]; then
        COMPREPLY=( $( compgen -W 'add blame cat checkout cleanup commit copy \
        delete diff export help import info list lock log merge mkdir move \
        propdel propedit propget proplist propset resolved revert status \
        switch unlock update' $cur ))
    else
        COMPREPLY=( $( compgen -f $cur ))
    fi
    return 0
}
complete -F _svn -o default -X '@(*/.svn|.svn)' svn

# repeat n times
function repeat()
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do
        eval "$@";
    done
}

# ask confirmation
function ask()          # See 'killps' for example of use.
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

# Get name of app that created a corefile
function corename()
{
    for file ; do
        echo -n $file : ; gdb --core=$file --batch | head -1
    done
}

# add line numbers to grep output

function grep() {
    if [[ -t 1 ]]; then
        command grep -n "$@"
    else
        command grep "$@"
    fi
}

#function save_last_command () {
#        # Only want to do this once per process
#        if [ -z "$SAVE_LAST" ]; then
#            EOS=" # end session $USER@${HOSTNAME}:`tty`"
#            export SAVE_LAST="done"
#            if type _loghistory >/dev/null 2>&1; then
#                _loghistory
#                _loghistory -c "$EOS"
#            else
#                history -a
#            fi
#            /bin/echo -e "#`date +%s`\n$EOS" >> ${HISTFILE}
#        fi
#    }
#    trap 'save_last_command' EXIT#
#
#  # END History manipulation section
#  ##################################
