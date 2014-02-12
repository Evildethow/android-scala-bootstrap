#!/bin/sh

BASE_DIR=$(pwd)
PLUGIN=android-plugin
SBT=sbt-extras
PLUGIN_DIR=${BASE_DIR}/${PLUGIN}
SBT_DIR=${BASE_DIR}/${SBT}
SBT_FILE=sbt

remove_plugin_projects() {
    [ -d ${PLUGIN_DIR} ] && rm -rf ${PLUGIN_DIR}
    [ -d ${SBT_DIR} ] && rm -rf ${SBT_DIR}
}

clone_plugin_projects() {
    git clone --depth 1 https://github.com/jberkel/${PLUGIN}.git ${PLUGIN_DIR}
    git clone --depth 1 https://github.com/paulp/${SBT}.git ${SBT_DIR}
}

make_sbt_executable() {
    chmod a+x ${SBT_DIR}/${SBT_FILE}
}

copy_sbt_runner_to_projects() {
    cp ${SBT_DIR}/${SBT_FILE} ${PLUGIN_DIR}
    cp ${SBT_DIR}/${SBT_FILE} ${BASE_DIR}
}

publish_plugin_locally() {
    cd ${PLUGIN_DIR} && ./${SBT_FILE} publish-local && cd ${BASE_DIR}
}

remove_plugin_projects
clone_plugin_projects
make_sbt_executable
copy_sbt_runner_to_projects
publish_plugin_locally
remove_plugin_projects

