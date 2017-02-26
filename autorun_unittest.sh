# ls -lR . | shasum 

PROJECT_PATH=""
UNIT_TEST_DIRECTORY=""


update_sha(){
    sha=`ls -lR $PROJECT_PATH | shasum`
}

build () {
    OUTPUT="$($PROJECT_PATH/.virtualenv/bin/nosetests -w $PROJECT_PATH/$UNIT_TEST_DIRECTORY/)"
}

changed () {
    echo "=========================="
    build
    previous_sha=$sha
}

compare () {
    update_sha
    if [[ $sha != $previous_sha ]] ; then changed; fi
}

run () {
    while true; do
        sleep 1
        compare
    done
}

run