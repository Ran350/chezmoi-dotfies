# gitconfig テンプレートについて

## 概要

このリポジトリの `.gitconfig` は chezmoi のテンプレート機能を使用して管理されています。

## ファイル構成

### 1. `home/dot_gitconfig.tmpl`
Git の設定ファイル本体です。chezmoi により `~/.gitconfig` として展開されます。

### 2. `home/.chezmoi.toml.tmpl`
テンプレート変数の定義ファイルです。初回実行時にユーザー情報を入力することで、設定がカスタマイズされます。

## 動作の仕組み

### 初回セットアップ時

1. `chezmoi init` を実行すると、`.chezmoi.toml.tmpl` が処理されます
2. `promptStringOnce` 関数により、以下の情報の入力を求められます：
   - **GitHub username**: GitHub のユーザー名
   - **GitHub email address**: GitHub のメールアドレス
3. 入力された情報は `~/.config/chezmoi/chezmoi.toml` に保存されます
4. `dot_gitconfig.tmpl` 内の変数 `{{ .github_username }}` と `{{ .github_email }}` が、入力した値に置き換えられます

### テンプレート変数

`dot_gitconfig.tmpl` で使用される変数：

- `{{ .github_username | quote }}` → GitHub ユーザー名（引用符で囲まれる）
- `{{ .github_email | quote }}` → GitHub メールアドレス（引用符で囲まれる）

### 設定内容

`.gitconfig` には以下の設定が含まれています：

#### ユーザー設定（動的）
```toml
[user]
name = <入力したGitHubユーザー名>
email = <入力したGitHubメールアドレス>
```

#### Git LFS 設定
Git Large File Storage の設定が含まれています。

#### カラー設定
UI、diff、status、branch でカラー表示を有効化しています。

#### Core 設定
- `quotepath = false`: 日本語ファイル名を正しく表示
- `commentChar = ";"`: コメント文字をセミコロンに設定
- `autocrlf = input`: 改行コードを自動変換（Windowsとの互換性）
- `excludesFile = ~/.config/git/ignore`: グローバル gitignore の場所

#### エイリアス
- `graph`: グラフ表示付きのログ出力
- `push-f`: `--force-with-lease` オプション付きの安全な force push

#### その他
- デフォルトブランチ名を `main` に設定
- grep に行番号と関数名表示を有効化

## カスタマイズ方法

### 設定を変更する場合

1. テンプレートを編集：
   ```bash
   chezmoi edit ~/.gitconfig
   ```

2. 変更を確認：
   ```bash
   chezmoi diff
   ```

3. 変更を適用：
   ```bash
   chezmoi apply
   ```

### ユーザー情報を変更する場合

`~/.config/chezmoi/chezmoi.toml` を直接編集するか、以下のコマンドで編集：

```bash
chezmoi edit-config
```

その後、以下で変更を適用：

```bash
chezmoi apply ~/.gitconfig
```

## メリット

- **バージョン管理**: gitconfig をリポジトリで管理できる
- **複数マシン対応**: マシンごとに異なるユーザー情報を自動設定
- **セキュリティ**: 個人情報をリポジトリにコミットせず、ローカルで管理
- **再現性**: 新しいマシンでも同じ設定を簡単に適用可能
