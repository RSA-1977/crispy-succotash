#!/bin/bash

#Check is root
function isRoot() {
	if [ "$EUID" -ne 0 ]; then
		return 1
	fi
}

function initialCheck() {
	if ! isRoot; then
		echo "Sorry, you need to run this as root"
		exit 1
	fi
}

function downloadDependencies() {
    ## Install dependencies
    wget -nc https://dl.winehq.org/wine-builds/winehq.key
    sudo apt-key add winehq.key
    sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
    apt-get -y update
    apt-get install -y wine1.7

    ## This is needed if running 32-bit on a 64-bit server
    apt-get -y install lib32gcc1 libc6-amd64
}

function getServerInfo() {
    ##Get server Name
    read -p "What do you want your rust server to be called?: " HOSTNAME

    ##Other Variables
    IDENTITY=""
    POST=28015
    PLAYERS=100
}

function downloadSteamCMD() {
    ## Download and extract SteamCMD
    wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz
    tar -xvzf steamcmd_linux.tar.gz
}

function setupSteam() {
    ## Run SteamCMD and login
    cd $HOME/server/steam
    ./steamcmd.sh
    login anonymous

    ## Change install directory
    force_install_dir $RUST_PATH/server/rust

    ## Install Rust server
    app_update 258550 -beta experimental
    exit

    ## Copy the missing steamclient.so
    ln -s $HOME/server/steam/linux32/steamclient.so $RUST_PATH/RustDedicated_Data/Plugins/x86_64/steamclient.so
    ln -s $HOME/server/rust/libsteam_api.so $RUST_PATH/RustDedicated_Data/Plugins/x86_64/libsteam_api.so
}

function startRustServer() {
    ## Start Rust server
    #xvfb-run --auto-servernum --server-args='-screen 0 640x480x24:32' wine $RUST_PATH/rust_server.exe -batchmode -cfg server.cfg -maxplayers 10 -port 28015
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib64:$RUST_PATH/RustDedicated_Data/Plugins/x86_64
    $RUST_PATH/RustDedicated $ServerArgs +server.hostname "$HOSTNAME" +server.port $PORT +server.identity "$IDENTITY" -logFile $RUST_PATH/logs/server.log $RCON_ARGS &

    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib64:/home/moblgeek-game1/server/rust/RustDedicated_Data/Plugins/x86_64
    ./RustDedicated -batchmode -load +server.hostname "Test Server" +server.port 28015 +server.identity "Test Server" -logFile logs/server_log.txt
    client.connect 23.102.133.179:28015


    RCON_ARGS='+rcon.ip 0.0.0.0 +rcon.port 48000 +rcon.password "password"'
    CWD=`pwd`
    cd $RUST_PATH
    $RUST_PATH/RustDedicated $ServerArgs +server.hostname "$HOSTNAME" +server.port $PORT +server.identity "$IDENTITY" -logFile ServerLog.log $RCON_ARGS &
    cd $CWD
}
initialCheck
downloadDependencies
getServerInfo
downloadSteamCMD
setupSteam
startRustServer







