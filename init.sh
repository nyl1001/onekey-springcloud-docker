#!/bin/bash

ONEKEY_ENV_PATH=`(pwd)`
. $ONEKEY_ENV_PATH/sh/function.sh
. $ONEKEY_ENV_PATH/sh/color.sh

sysType=$(uname -s)
case $sysType in
    "Linux")
        isStringInFile "ONEKEY_ENV_PATH" "~/.profile"
        if [ $? = 0 ]; then
            echo export ONEKEY_ENV_PATH="$ONEKEY_ENV_PATH" >> ~/.profile && echo 'export PATH="$PATH:$ONEKEY_ENV_PATH/bin"' >> ~/.profile
        fi
        ;;
    "Darwin")
        shellType=`echo $SHELL`
        $OUTPUT "current shell type is $shellType..."
        if [[ $shellType =~ "bash" ]] || [[  $shellType =~ "-bash" ]]; then
            isStringInFile ONEKEY_ENV_PATH ~/.bashrc
            if [ $? = 0 ]; then
                echo export ONEKEY_ENV_PATH="$ONEKEY_ENV_PATH" >> ~/.bashrc && echo 'export PATH="$PATH:$ONEKEY_ENV_PATH/bin"' >> ~/.bashrc
            fi
            $OUTPUT "ONEKEY_ENV_PATH has been set to environment file ~/.bashrc..."
        elif [[ $shellType =~ "zsh" ]] || [[  $shellType =~ "-zsh" ]]; then
            if [ ! -f ~/.zshrc.pre-oh-my-zsh ]; then
                isStringInFile ONEKEY_ENV_PATH ~/.zshrc
                if [ $? = 0 ]; then
                    echo export ONEKEY_ENV_PATH="$ONEKEY_ENV_PATH" >> ~/.zshrc && echo 'export PATH="$PATH:$ONEKEY_ENV_PATH/bin"' >> ~/.zshrc
                fi
                $OUTPUT "ONEKEY_ENV_PATH has been set to environment file ~/.zshrc..."
            else
                isStringInFile ONEKEY_ENV_PATH ~/.zshrc.pre-oh-my-zsh
                if [ $? = 0 ]; then
                    echo export ONEKEY_ENV_PATH="$ONEKEY_ENV_PATH" >> ~/.zshrc.pre-oh-my-zsh && echo 'export PATH="$PATH:$ONEKEY_ENV_PATH/bin"' >> ~/.zshrc.pre-oh-my-zsh && zsh &&  ~/.zshrc
                fi
                $OUTPUT "ONEKEY_ENV_PATH has been set to environment file ~/.zshrc.pre-oh-my-zsh..."
            fi
        fi
        ;;
    *)
        $OUTPUT "system $sysType not supported!"
        exit -1
        ;;
esac

cp $ONEKEY_ENV_PATH/docker-compose.yml.bak $ONEKEY_ENV_PATH/docker-compose.yml

$OUTPUT "Seting Env ONEKEY_ENV_PATH $ONEKEY_ENV_PATH successfully..."