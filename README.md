## Camel K Workshop 

---

### デプロイ方法

1. OpenShift にログインする　（RHPDS の OpenShift 4.11 Workshop で動作確認）
1. Guides をデプロイするためのプロジェクトを作る
1. 本リポジトリ内の guides-deploy.sh を、プロジェクト名を引数に入れて実行する
   （mac なら以下のコマンドを実行）

```
sh ./guide-deploy.sh <project name>
```

OpenShift Developer Sandbox では、PostgreSQLに外部アクセスするための Load Balancer が設定できない時があるため、お勧めしません。

---

### 更新

2023/1/16: 作成

2023/1/18: Kafka/PostgreSQL連携 のページを追加