
デプロイ
-------------

## 環境変数をセット

    $ vim ~/.bashrc

    export TECHBLOG_DEPLOY_USER=<user_name>
    export TECHBLOG_DEPLOY_SERVER=<server_addr>

    $ source ~/.bashrc

## capistranoでデプロイ

    $ bundle exec cap production deploy


別のブログサービスのデータをインポートする
----------

## Lokkaからインポート

    $ LOKKA_DB=/path/to/lokka.sqlite3 rake import:from_lokka
