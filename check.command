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

echo "Checking installed applications..."
echo ""
echo "Env version:"
check_installed brew
if [ $? -eq 10 ]; then
    command="brew --version"
    eval $command | printf "  %s %s\n" `cat`
else
    echo "  Homebrew Not yet"
fi
check_installed pyenv
if [ $? -eq 10 ]; then
    command="pyenv --version"
    eval $command | printf "  %s %s\n" `cat`

    echo "Installed Python version:"
    pyenv versions
else
    echo "  pyenv Not yet"
fi
check_installed python
if [ $? -eq 10 ]; then
    command="python --version"
    echo "Used:"
    eval $command | printf "  %s %s\n" `cat`
else
    command="python3 --version"
    echo "Used:"
    eval $command | printf "  %s %s\n" `cat`
fi
