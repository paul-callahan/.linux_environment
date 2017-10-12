setpowerline() {
    unamestr=`uname`
    if [[ "$unamestr" == 'Linux' ]]; then
	if [[ -f /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh ]]; then
	    . /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
	else
	    echo "powerline not installed"
	fi
	
    else
	. /Users/paul/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh
    fi
    PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
}

cpath() {
    greadlink -nf $1 | tee >(pbcopy)
    echo
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


gitup(){	
	RED='\033[33;31m'
	YELLO='\033[33;33m'
	GREEN='\033[33;32m'
	NC='\033[0m' # No Color

	if ! [ -d .git ]; then
		echo "${RED}This is not a git repo"
		return 1
	fi
	
	HEAD=$(git rev-parse HEAD)
	CHANGED=$(git status --porcelain | wc -l)
	CUR_BRANCH=$(git rev-parse --abbrev-ref HEAD)

	echo "Fetching..."
	git fetch --all --prune &>/dev/null
	if [ $? -ne 0 ]; then
		echo "Fetch Failed!"
		return 1
	fi

	for branch in `git for-each-ref --format='%(refname:short)' refs/heads`; do

		LOCAL=$(git rev-parse --quiet --verify $branch)
		if [ "$branch" = "$CUR_BRANCH" ] && [ $CHANGED -gt 0 ]; then
			echo -e "${YELLO}WORKING${NC}\t\t$branch"
		elif git rev-parse --verify --quiet $branch@{u}&>/dev/null; then
			REMOTE=$(git rev-parse --quiet --verify $branch@{u})
			BASE=$(git merge-base $branch $branch@{u})
			
			if [ "$LOCAL" = "$REMOTE" ]; then
			   echo -e "${GREEN}OK${NC}\t\t$branch" 
			elif [ "$LOCAL" = "$BASE" ]; then
				if [ "$branch" = "$CUR_BRANCH" ]; then
					git merge $REMOTE&>/dev/null
				else
					git branch -f $branch $REMOTE
				fi
				echo -e "${GREEN}UPDATED${NC}\t\t$branch"
			elif [ "$REMOTE" = "$BASE" ]; then
				echo -e "${RED}AHEAD${NC}\t\t$branch"
			else
				echo -e "${RED}DIVERGED${NC}\t\t$branch"
			fi
		else
			echo -e "${RED}NO REMOTE${NC}\t$branch"
		fi
	done
}
