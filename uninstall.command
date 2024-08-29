echo "インストールされているHomebrew, pyenv, Pythonが全てアンインストールされます"
read -p "よろしいですか？[y/N]：" ANSWER
if [ $ANSWER = "y" ]; then
    # pythonのアンインストール
    pyenv global system
    versions=`pyenv versions | grep -v "system"`
    for el in ${versions}; do
        echo "$el をアンインストールします"
        pyenv uninstall $el
        
    done
    # pyenvのアンインストール
    brew uninstall pyenv xz python-tk@3.12 python-tk@3.11

    # brewのアンインストール
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
    
    # zprofile内の記述削除
    sed -i.bak -e '/PYENV_ROOT/d' -e '/homebrew/d' -e '/pyenv init /d' ~/.zprofile

    echo "アンインストールが完了しました"
else
    echo "アンインストールプロセスを停止します"
fi

