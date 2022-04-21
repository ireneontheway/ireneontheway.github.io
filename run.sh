#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

copy_resource(){
    cp ${CURRENT_DIR}/CONTRIBUTING.md ${CURRENT_DIR}/src
    cp ${CURRENT_DIR}/LICENSE ${CURRENT_DIR}/src
}

build(){
    copy_resource
    case "$(uname -s)" in
        Linux*)
            runner="${CURRENT_DIR}/bin/linux/mdbook"
        ;;
        Darwin*)
            runner="${CURRENT_DIR}/bin/mac/mdbook"
        ;;
        MINGW*)
            runner="${CURRENT_DIR}/bin/win/mdbook.exe"
        ;;
        *)
        echo "Unknown OS"
        ;;
    esac

    ${runner} -V
    chmod +x ${runner} & ${runner} build ${CURRENT_DIR}
}

run(){
    copy_resource
    runner=""
    case "$(uname -s)" in
        Linux*)
            runner="${CURRENT_DIR}/bin/linux/mdbook"
        ;;
        Darwin*)
            runner="${CURRENT_DIR}/bin/mac/mdbook"
        ;;
        MINGW*)
            runner="${CURRENT_DIR}/bin/win/mdbook.exe"
        ;;
        *)
            echo "Unknown OS, Please run command `bin/{OS}/mdbook`"
        ;;
    esac

    if [[-z ${runner} ]]; then
        echo "Unknown runner"
    else
        ${runner} -V
        chmod +x ${runner} & ${runner} serve ${CURRENT_DIR} 
    fi
}

#run
case "$1" in
    build)
       build
    ;;
    *)
        run
    ;;
esac