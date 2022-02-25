#!/bin/bash

setpowerline() {
    unamestr=`uname`
    if [[ "$unamestr" == 'Linux' ]]; then
      if [[ -f /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh ]]; then
          . /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
      else
          echo "powerline not installed"
      fi
    else
        export PATH=~/Library/Python/3.7/bin:$PATH
        local pl_base=$(pip3 show powerline-status | grep Location | awk '{print $2}')
        . ${pl_base}/powerline/bindings/bash/powerline.sh
    fi
    #PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }
    #PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
}

cpath() {
    greadlink -nf $1 | tee >(pbcopy)
    echo
}

findx() {
    find "$1" -name "$2" 2>&1 >files_and_folders | grep -v 'Permission denied' >&2
}

nukenoneimages() {
    docker rmi -f $(docker images | grep '<none>' | awk '{print $3}' | grep -v CONTAINER)
}

nukematchingimages() {
    docker rmi -f $(docker images | grep "$1" | awk '{print $3}' | grep -v CONTAINER)
}

nukematchingcontainers() {
    docker rm -f $(docker ps -a | grep "$1" | awk '{print $1}' | grep -v CONTAINER)
}

nukevolumes() {
    docker volume rm $(docker volume ls -q)
}

nukeallimagesexceptlicenseserver() {
    docker rmi $(docker images | grep -v licenseserver | awk '{print $3}' | grep -v IMAGE)
}

nukeallcontainers() {
    docker rm $1 $(docker ps -a | grep -v licenseserver | awk '{print $1}' | grep -v CONTAINER)
}


bump_version() { local lib_path=$1;
   local curr=$(head -n 1 $lib_path/project.clj | sed 's/.*"\(.*\)"/\1/')
   printf "The current version number is '$curr'. What do you want to change it to? "
   read next
   echo "Bumping '$lib_path' version from '$curr' to '$next'..."
   sed -i '' "s/\(io.tcell\/$(basename $lib_path).*\)${curr}/\1${next}/" */project.clj */*/project.clj */*/*/project.clj
}

getpod() {
    local pattern=$1
    kubectl get pods | grep "$1" | head -1 | awk '{print $1}'
}

podforward() {
    local pattern=$1
    local localport=${2:-8080}
    local remoteport=${3:-8080}
    local pod=$(getpod $pattern)
    echo "forwarding localhost:${localport} to ${pod}:${remoteport}"
    nohup kubectl --namespace default port-forward $pod ${localport}:${remoteport} &
}

rebuild-service() {
  local service=$1
  docker-compose stop $service
  docker-compose rm -f $service
  make up-${service} DETACH=true
}
