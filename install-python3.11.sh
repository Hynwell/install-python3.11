#!/bin/bash

read -p "Уставить pytnon3.11 (y/n?): " inpy
if [[ "$inpy" == "y" ]]; then

    echo "---Linux UPDATE---"    
    sudo apt update && sudo apt upgrade -y

    echo "---Install Python3.11---"

    # Установка необходимого софта, для сборки python
    softwares_list_for_python=(build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev pkg-config)
    for software_list_for_python in ${softwares_list_for_python[@]}
        do
            sudo apt install $software_list_for_python -y
        done
    
    # Скачиваем файлы python3.11
    mkdir -p ~/download
    curl -o ~/download/Python-3.11.1.tgz https://www.python.org/ftp/python/3.11.1/Python-3.11.1.tgz
    tar -xf ~/download/Python-3.11.1.tgz -C ~/download/

    # Сборка Python
    cd ~/download/Python-3.11.1
    ./configure --enable-optimizations
    make -j $(nproc)
    sudo make altinstall

    # Cделать Python3.11 по умолчанию
    sudo ln -s /usr/local/bin/python
    sudo ln -s /usr/local/bin/python3.11 /usr/local/bin/python

    # Удаление исходников
    cd ~/
    sudo rm -rf ~/download/Python-3.11.1.tgz ~/download/Python-3.11.1

    echo "---THE END---"
    python3.11 -V
    pip3.11 -V

elif [[ "$inpy" == "n" ]]; then
    echo "Отмена установки Python"
else
  echo "Выбранно не верное значение -> отмена установки Python"
fi