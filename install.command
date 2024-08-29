#!/bin/bash
function check_installed(){
    # 指定したコマンドがインストールされているかを確認
    # インストール済み：10, 未インストール：20
    command="$1 --version &> /dev/null"
    eval $command
    if [ $? -ne 0 ] ; then
        return 20
    else
        return 10
    fi
}
function check_fileExists(){
    # 指定したファイルが存在するかを確認
    # 存在：10, 存在しない：20
    if [ -e $1 ]; then
        return 10
    else
        return 20
    fi
}

function install_python(){
    pyenv install $1
    source ~/.zprofile
    check_installed python
    if [ $? -eq 10 ]; then
        pip install --upgrade pip setuptools
        cd "$(dirname "$0")"
        check_fileExists requirements.txt
        if [ $? -eq 10 ]; then
            pip install -r requirements.txt
            git clone https://github.com/aais-lab/IntroductionPrograming-library.git --depth 1
            pip install IntroductionPrograming-library/.
        fi
    fi
}

# zprofileの存在チェック
check_fileExists ~/.zprofile
if [ $? -eq 20 ]; then
    touch ~/.zprofile
fi

dir="$(dirname "$0")"
xattr -d com.apple.quarantine "$dir/check.command"
xattr -d com.apple.quarantine "$dir/uninstall.command"

# homebrewのインストールと設定
check_installed brew
if [ $? -eq 20 ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    echo 'export PATH="$PATH:/opt/homebrew/bin"' >> ~/.zprofile
    source ~/.zprofile

    check_installed brew
    if [ $? -eq 10 ]; then
        echo "Homebrew install Complete!"
    else
        echo "Not Completed Homebrew install process"
    fi
else
    echo "Homebrew already installed!"
    echo "Starting Update process ..."
    brew update
    brew cleanup
    echo "Complete Update !"
fi

# pyenvのインストールと設定
check_installed pyenv
if [ $? -eq 20 ]; then
    brew install pyenv
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zprofile
    echo 'export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"' >> ~/.zprofile
    echo 'eval "$(pyenv init -)"' >> ~/.zprofile
    source ~/.zprofile

    check_installed brew
    if [ $? -eq 10 ]; then
        echo "pyenv install Complete!"
        brew install xz python-tk@3.12 python-tk@3.11
        cd $dir
        source setting.conf
        for version in ${versions}; do
            echo "$version をインストールします"
            install_python $version
        done
        pyenv global $version
        echo "Python $1 がグローバルに設定されました"
    else
        echo "Not Completed pyenv install process"
    fi
else
    echo "pyenv already installed!"
    echo "Starting Update process ..."
    brew upgrade pyenv
    pyenv rehash
    echo "Complete Update !"
    source ~/.zprofile
    cd $dir
    source setting.conf
    for version in ${versions}; do
        echo "$version をインストールします"
        install_python $version
    done
    pyenv global $version
    echo "Python $1 がグローバルに設定されました"
fi

echo "インストールプロセスが終了しました"
