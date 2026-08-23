
### README.ja.md

```markdown
# Steam Depot Version Downloader

SteamCMDを使用して、指定したSteam DepotのManifestを取得し、
既存のSteamインストールとは別の場所にゲームファイルを構築する
ためのツールです。

既存のSteamインストールは変更しません。

## Features

- SteamCMDの自動検出
- SteamCMDの自動ダウンロード
- Steam Guard対応
- 複数Depot対応
- 固定Manifestによるダウンロード
- 独立した作業ディレクトリ
- 独立した出力ディレクトリ
- 日本語 / 英語UI
- 基本的なファイル検証

## Requirements

- Windows 10 / 11
- インターネット接続
- 対象ゲームを所有しているSteamアカウント
- SteamCMD

SteamCMDが見つからない場合は自動的にダウンロードします。

## Quick Start

1. `SteamDepotVersionDownloader.bat` を開きます。
2. `USER CONFIGURATION` セクションを編集します。
3. AppIDを設定します。
4. 必要なDepot IDを設定します。
5. 対応するManifest IDを設定します。
6. `DEPOT_COUNT` を設定します。
7. ファイルを保存します。
8. BATファイルを実行します。
9. SteamCMDが起動したらSteamへログインします。

## Configuration

基本的に編集するのは、

`USER CONFIGURATION`

のセクションだけです。

例:

```bat
set "GAME_NAME=Skyrim Special Edition"
set "VERSION_NAME=1.6.1170"

set "APPID=489830"

set "DEPOT_COUNT=3"

set "DEPOT1_ID=489831"
set "DEPOT1_MANIFEST=8442952117333549665"

set "DEPOT2_ID=489832"
set "DEPOT2_MANIFEST=8042843504692938467"

set "DEPOT3_ID=489833"
set "DEPOT3_MANIFEST=1914580699073641964"
```
## License

このプロジェクトはMIT Licenseの下で公開されています。
詳細は [LICENSE](LICENSE) を参照してください。

このライセンスは、このリポジトリに含まれるソースコードと
ドキュメントにのみ適用されます。

このツールによってダウンロードされるゲームファイルや
その他の第三者コンテンツの再配布権を与えるものではありません。
