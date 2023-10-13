#!/usr/bin/env bash

zero_app_nsh="./`basename $0`"

zero_app_msg_usage="
usage: ${zero_app_nsh} [command] [option]
command:
    version -- output cli version
    help -- output usage

options:
    -p,--preset [value] -- use some preset
    -t,--topic <value> -- set hub url list. ps: ge or gh,ge,gl
    -e,--email <value> -- set email list. ps: x@163.com or x@163.com,x@126.com
    --today [value] -- set day of date . ps: 20230724
    -i,--input [value] -- input dir
    -o,--output [value] -- output dir
    --dryrun -- with dry run mode
    -h,--help -- info help usage
    -v,--version -- info version
"
zero_app_msg_version="${zero_app_nsh} version 1.0.0"

zero_app_sarg=""
zero_app_larg=""


#zero:task:s:get space md5
zero_const_space_md5=`echo -n " " | md5sum | cut -b -32`
zero_const_comma_md5=`echo -n "," | md5sum | cut -b -32`
zero_const_eol_md5=`echo -n "\n" | md5sum | cut -b -32`
#zero:task:e:get space md5
# echo $zero_const_eol_md5
# echo $zero_const_space_md5


function zero_str_join(){
    # echo "$@"

    # a b c
    c=""
    a=$1
    b=$2
    d=""
    [ -n "$3" ] && c=$3
    [ -n "$4" ] && d=$4

    [ $b ] && {
        if [ $a ] ; then
            echo ${a}${c}${b}${d}
        else
            echo ${b}${d}
        fi 
        return 0
    }
    echo $a
}


function zero_app_getopt_opts_def(){
    o=$(echo $1 | sed -E "s/ -- +.*//g")
    o=$(echo $o | sed -E "s/^ +//g")
    o=$(echo $o | sed -E "s/-+//g")
    o=$(echo $o | sed -E "s/,+/ /g")
    # echo $o
    oa=(${o// / })
    # echo $o
    # echo ${oa[0]}
    # echo ${oa[1]}
    # echo ${oa[2]}

    # zero_app_sarg=$(zero_str_join "$zero_app_sarg" ${oa[0]} "" ":")
    # zero_app_larg=$(zero_str_join "$zero_app_larg" ${oa[1]} ", ":")


    os=${oa[0]}
    ol=${oa[1]}
    ot=${oa[2]}
    # eg. nc,<value>
    [ -z $ot ] && {
        ot=$ol
    }

    # eg. os is --eml
    [ $os ] && {
        [ ${#os} -ne 1 ] && { ol=$os; os=""; }
    }

    
    # echo $os,$ol,$ot

    if [[ $ot =~ "]" ]];then
        #  echo ${oa[0]}
        zero_app_sarg=$(zero_str_join "$zero_app_sarg" $os "" ":")
        zero_app_larg=$(zero_str_join "$zero_app_larg" $ol "," ":")
    elif [[ $ot =~ ">" ]];then
        # echo ${oa[0]}
        zero_app_sarg=$(zero_str_join "$zero_app_sarg" $os "" "::")
        zero_app_larg=$(zero_str_join "$zero_app_larg" $ol "," "::")
    else
        # echo ${oa[0]}
        zero_app_sarg=$(zero_str_join "$zero_app_sarg" $os "")
        zero_app_larg=$(zero_str_join "$zero_app_larg" $ol ",")
    fi

}
# zero_app_getopt_opts_def "-h,--help -- info help usage"
# zero_app_getopt_opts_def '-v,--version -- info version'
# zero_app_getopt_opts_def "-p,--preset [value] -- use some preset"
# zero_app_getopt_opts_def "--hubs <value> -- set hub url list. multi one will split with , char"
# zero_app_getopt_opts_def "--eml <value> -- set email list. multi one will split with , char"


function zero_app_getopt_opts_use(){

# zero_const_space_md5=$2

opts="$1"
space_md5=$2
space=$3

opts=`echo "$opts" | sed "s/$space/$space_md5/g" `
# echo "$options"
array=(`echo "$opts"` )

id=0
for line in ${array[@]}
do
if [ "$line" ]; then
    vline=`echo "$line" | sed "s/$space_md5/$space/g" `
    zero_app_getopt_opts_def "$vline"

    #  echo "$ld:$vline"
    # # echo "$ld:$line"
    # ld=$(($ld + 1))
fi
done 

# echo $ld
# echo "args:"
# echo $zero_app_sarg
# echo $zero_app_larg

}

# options="
# -h,--help -- info help usage
# -v,--version -- info version
# -p,--preset [value] -- use some preset
# --hubs <value> -- set hub url list. multi one will split with , char
# --eml <value> -- set email list. multi one will split with , char
# "

# zero_app_getopt_opts_use "$options" "$zero_const_space_md5" " "



function zero_app_getopt_opts_get(){

# zero_const_space_md5=$2

opts="$1"
space_md5=$2
space=$3

opts=`echo "$opts" | sed "s/$space/$space_md5/g" `
opts=`echo "$opts" |sed '/^$/d' `

# echo "$options"
array=(`echo "$opts"` )

idf=`echo "$opts" | grep -n 'options' | cut -d ':' -f1`
idf=$(($idf + 0))
# echo $idf
id=0


# for line in ${array[@]}
for id in "${!array[@]}"
do
line=${array[$id]}
# echo "$id$line" | sed "s/$space_md5/$space/g"
if [ "$line" ]; then
    # echo $id
    if [ $id -ge $idf ] ; then
        # echo $id
        echo "$line" | sed "s/$space_md5/$space/g"
    fi 
    # id=$(($id + 1))
fi
done 
}
# options=`zero_app_getopt_opts_get "$zero_app_msg_usage" "$zero_const_space_md5" " "`

function zero_app_getopt_opts_out(){
    echo "args:(getopt)"
    # echo $zero_app_sarg
    # echo $zero_app_larg
    echo "-o $zero_app_sarg --long $zero_app_larg"
    # exit 0
}

function zero_app_dbg_getopts()
{
    local opt_ab
    while getopts "ab" opt_ab; do
        # funname,index,key
        echo $FUNCNAME: $OPTIND: $opt_ab
    done
}

# zero_app_dbg_getopts "-a" "-b"
# OPTIND=1
# $OPTARG

#zero:task:s:define-cli-option
options=`zero_app_getopt_opts_get "$zero_app_msg_usage" "$zero_const_space_md5" " "`
# echo "$options"
#zero:task:e:define-cli-option

#zero:task:s:gen-getopt-option
zero_app_getopt_opts_use "$options" "$zero_const_space_md5" " "
# zero_app_getopt_opts_out
# exit 0
#zero:task:e:gen-getopt-option


#zero:task:s:out-cli-version
# out version when the arg1 is -v or --version
# if you do not like it, skip.
if [ $1"_" = "version_" ];then
    echo "$zero_app_msg_usage";
    exit 0
fi
#zero:task:e:out-cli-version

#zero:task:s:out-usage
# out usage when the args length ne 1
# if you do not like it, skip.
# if [ $# -ne 1 ];then
#     echo "$zero_app_msg_usage";
#     exit 1
# fi

# out usage when the arg1 is -h or --help
# if you do not like it, skip.
if [[ $1"_" = "help_" ]] || [[ $1"_" = "-h_" ]];then
    echo "$zero_app_msg_usage";
    exit 0
fi
#zero:task:e:out-usage

# [getopt-and-getopts](https://zhuanlan.zhihu.com/p/113837365)


#zero:task:s:out-usage-uc3

# https://unix.stackexchange.com/questions/628942/bash-script-with-optional-input-arguments-using-getopt


function zero_app_fix_val(){
    if [[ $1 =~ "--" ]] ;then
        #  "--name"
        echo ${2}
    else
        # "-n"
        echo ${2:1}
    fi
}

vars=$(getopt -o $zero_app_sarg --long $zero_app_larg -- "$@")
eval set -- "$vars"

#zero:task:s:set-default-value
inputdir=~/.ssh
outputdir=~/.ssh
email=$(git config --global user.email)
password=""
topic="github"
today=`date +'%Y%m%d'`
dryrun=1

email="yemiancheng1993@126.com,hualei03042013@163.com,hualei03042013@126.com,ymc.github@gmail.com"
topic="gh,ge,gl"
#zero:task:e:set-default-value

#zero:task:s:bind-scr-level-args-value
# extract options and their arguments into variables.
for opt; do
    case "$opt" in
      -i|--input)
        inputdir=`zero_app_fix_val "$opt" "$2"`
        shift 2
        ;;
      -o|--output)
        outputdir=`zero_app_fix_val "$opt" "$2"`
        shift 2
        ;;
      -t|--topic)
        topic=`zero_app_fix_val "$opt" "$2"`
        shift 2
        ;;
      -e|--email)
        email=`zero_app_fix_val "$opt" "$2"`
        shift 2
        ;;
      --dryrun)
        dryrun=0
        shift 1
        ;;
      --)
        shift
        ;;
    esac
done
echo "input: $inputdir"
echo "out: $outputdir"
echo "email: $email"
echo "topic: $topic"
echo "today: $today"
echo "dryrun: $dryrun"
echo  "$@"

# [ -n "$1" ] && email=$1
# [ -n "$2" ] && topic=$2
# [ -n "$3" ] && today=$3
# exit 0
#zero:task:e:bind-scr-level-args-value


# function oneof(){

# }


# done
# ssh-keygen -m PEM -t rsa -b 4096 -C "$email" -f ~/.ssh/230724 -N "" -y

# https://www.zhihu.com/question/21402411


# zero:task:s:design-key-dirs
# mkdir -p ~/.ssh/{gh,ge,gl}
# zero:task:e:design-key-dirs

# ssh-keygen -P "$password" -t rsa -f ~/.ssh/gh/230724 -C "$email" 
# ssh-keygen -P "$password" -t rsa -f ~/.ssh/ge/230724 -C "$email" 
# ssh-keygen -P "$password" -t rsa -f ~/.ssh/gl/230724 -C "$email"

ts=(${topic//,/ })
es=(${email//,/ })


function render_tpl(){
    tpl=topic/today/email
    [ -n "$1" ] && tpl=$1
    [ -n "$2" ] && key=$2
    [ -n "$3" ] && val=$3
    if [ $key ] ; then
        echo "$tpl" | sed "s/$key/$val/g"
    else
        echo "$tpl"
    fi
}

function gen_ssh_key(){
p_tpl=today/email/topic
p_tpl=email/today/topic
# p_tpl=today/topic
p_txt=""

for t in ${ts[@]}
do
    for e in ${es[@]}
    do
        p_txt=`render_tpl "$p_tpl" "today" "$today"`
        p_txt=`render_tpl "$p_txt" "email" "$e"`
         mkdir -p ${outputdir}/${p_txt}
        p_txt=`render_tpl "$p_txt" "topic" "$t"`
        # echo $p_txt

        file=${outputdir}/${p_txt}
        filed=${file%/*}
        comment=$e

        if [ $dryrun -eq 0 ] ; then
            cmdcode="ssh-keygen -P "$password" -t rsa -f $file -C "$comment""
            echo "$cmdcode"
        else
            mkdir -p $filed
            # only gen key file when does not exsits.
            [ ! -e $file ] && ssh-keygen -P "$password" -t rsa -f $file -C "$comment" 
        fi
        
        
    done
done
}


gen_ssh_key

# topics
# ./ssh.keygen.sh -h
# ./ssh.keygen.sh -v
# ./ssh.keygen.sh -t "gh,ge,gl" -e "yemiancheng1993@126.com,hualei03042013@163.com,hualei03042013@126.com,ymc.github@gmail.com"
# ./ssh.keygen.sh  -i /c/  -o /f/
