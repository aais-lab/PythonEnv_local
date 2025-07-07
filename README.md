# PythonEnv_local
## Overview
千葉工業大学 先進工学部 知能メディア工学科の第2セメスター講義「プログラミング言語基礎」及び第3セメスター講義「知能メディアプロジェクト1」、第4セメスター講義「プログラミング言語応用」「知能メディアプロジェクト2」、第5セメスター講義「マルチエージェントシステム」を受講する学部生向けの、Python環境導入スクリプト群です。環境構築の際の手順飛ばしや、打ち間違い等によるミスが多いため、統一的な環境を簡便に作成できるようにすることを目的として作成されました。

## Requirement
### 必要環境
- MacOS
    - 学科指定のPCがMacのため、Windows及びLinuxでは動作しません
    - AppleシリコンであるM1搭載のPCでのみ動作確認を行なっています

### 導入 & 構築される環境
- Homebrew
    - Mac用パッケージ管理ソフトウェア
    - 実行時点の最新版
- pyenv
    - Pythonの環境管理ソフトウェア
    - 実行時点の最新版
- xz
    - ファイル圧縮・展開ライブラリ
- python-tk@3.11, @3.12
    - Python用GUIツールキット
- setting.confで設定したバージョンのPython
    - pip及びsetuptoolsは自動的にアップデートされます
    - requirements.txtに記載したライブラリが自動的に導入されます
    - 講義用の描画ライブラリIPが導入されます
        - [aais-lab IntroductionPrograming-library](https://github.com/aais-lab/IntroductionPrograming-library)
- zprofileへの記載
    - Homebrew及びpyenvへのパスを通すために必要な記述が自動で入力されます

## Usage
#### gitからクローン
```
git clone https://github.com/aais-lab/PythonEnv_local.git
```

#### インストール
以下のコマンドを実行し、実行権限を付与してください。
```
xattr -d com.apple.quarantine ./PythonEnv_local/install.command
```

install.commandをダブルクリックして実行。

パスワードを入力したりReturnキーを押下する必要があることがあるので、注意してください。

#### 環境チェック
install.command実行前の場合、以下のコマンドを実行してください。
```
xattr -d com.apple.quarantine ./PythonEnv_local/check.command
```

check.commandをダブルクリックして実行。

Homebrew、pyenv、インストール済みのPythonバージョンの一覧が表示されます。

e.g.)
```
Env version:
  Homebrew 4.3.18
  pyenv 2.3.36
Installed Python version:
* system (set by /Users/usrname/.pyenv/version)
  3.10.5
  3.11.5
  3.12.2
Used:
  Python 3.11.5
```

#### 全環境のアンインストール
uninstall.commandをダブルクリックして実行。

現在pyenvの管理下でインストールされているPythonバージョンが全てアンインストールされます。
また、install.commandでインストールされた pyenv、xz、python-tk@3.11、python-tk@3.12、Homebrew及びzprofileに入力された環境設定が全て削除されます。
削除前のzprofileは.zprofile.bakとしてHomeディレクトリへ残されます。

## Author
[Nao Yamanouchi](https://github.com/ClairdelunaEve)

## Licence
3-Clause BSD
