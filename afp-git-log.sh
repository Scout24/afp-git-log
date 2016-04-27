#!/bin/bash

# Simple script to fetch all logs related to the AFP project.

quiet='false'

function get_base(){
    local base
    base=$(basename $1)
    echo ${base%.git}
}

function clone_pull_and_log(){
    local base url
    url=$1
    base=$(get_base $1)
    if ! [[ -d $base ]] ; then
        if ! $quiet ; then
            echo "Will clone " $base
        fi

        git clone $url
        cd $base
    else
        if [[ $quiet = 'false' ]] ; then
            echo "Will update " $base
        fi
        cd $base
        if [[ $quiet = 'false' ]] ; then
            git pull
        else
            git pull > /dev/null
        fi
    fi
    if [[ $quiet = 'false' ]] ; then
        echo "Log for "  $base
    fi
    git --no-pager shortlog -sn
    if ! $quiet ; then
        cd -
    else
        cd - > /dev/null
    fi
}

repos=("https://github.com/ImmobilienScout24/afp-core.git"
       "https://github.com/ImmobilienScout24/afp-cli.git"
       "https://github.com/ImmobilienScout24/afp-alppaca.git"
       "https://github.com/ImmobilienScout24/afp-web.git"
       "https://github.com/ImmobilienScout24/afp-resource-maker.git"
       "https://github.com/ImmobilienScout24/afp-talk.git"
       )
if [[ $1 = '-q' ]] ; then
    quiet='true'
fi

for i in 0 1 2 3 4 5
do
    clone_pull_and_log ${repos[$i]}
done
