#!/bin/bash
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
        echo "Will clone " $base
        git clone $url
        cd $base
    else
        echo "Will update " $base
        cd $base
        git pull
    fi
    echo "Log for "  $base
    git --no-pager shortlog -sn
    cd -
}

repos=("https://github.com/ImmobilienScout24/afp-core.git"
       "https://github.com/ImmobilienScout24/afp-cli.git"
       "https://github.com/ImmobilienScout24/afp-alppaca.git"
       "https://github.com/ImmobilienScout24/afp-web.git"
       "https://github.com/ImmobilienScout24/afp-resource-maker.git"
       )

for i in 0 1 2 3 4
do
    clone_pull_and_log ${repos[$i]}
done
