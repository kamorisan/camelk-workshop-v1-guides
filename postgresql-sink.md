## PostgresSQL との連携
---

### 1. 目的

Kamelet の **PostgreSQL Sink** を使用して、Camel K と Kafka との連携の方法について理解していただきます。

* [PostgreSQL Sink](https://camel.apache.org/camel-kamelets/{{ KAMELETS_VERSION }}/postgresql-sink.html)

### 2. PostgreSQL Sink を使用してテーブルからデータを取得する

PostgreSQL は既に準備されているものを使うことができます。

PostgreSQL にアクセスするための情報は以下の通りです。

* **Server Name**: {{ POSTGRESQL_SERVER }}
* **Server Port**: 5432
* **User Name**: demo
* **Password**: demo
* **Database Name**: sampledb

また、データベースには products というテーブルが用意されており、以下のデータが格納されています。

|  id (integer) |  name (varchar) |
| :---: | :---: |
|  1  |  apple  |
|  2  |  orange  |
|  3  |  lemon  |

ターミナルから、下記のコマンドを実行すると、PostgreSQLにログインすることができます。

```
PGPASSWORD=demo psql -h {{ POSTGRESQL_SERVER }} -d sampledb -U demo 
```

`\d` と入力すると、テーブルの一覧が表示されます。

![](images/08-postgresql-001.png)
![karavan]({% image_path 08-postgresql-001.png %}){:width="300px"}

テーブル:products の 中身を確認してみましょう。`select * from products;` と入力してください。

![](images/08-postgresql-002.png)
![karavan]({% image_path 08-postgresql-002.png %}){:width="300px"}

それでは、左のエクスプローラー上で、右クリックをして、メニューから `Karavan: Create Integration` を選択し、任意のファイル名で空のインテグレーションを作成をしてください。
（ここでは、postgresql-sink というファイル名にしておきます。）

続いて、Karavan Designer のGUIが開いたら、上部の `Create new route` をクリックして、Route を作成しましょう。

`components` タブから `Timer` を探して選択をしてください。
右上のテキストボックスに `Timer` と入力をすると、絞り込みができます。

Route の source として、Timer コンポーネントが配置されます。
Route の Timer シンボルをクリックすると、右側にプロパティが表示されますので、確認してください。

Parameters は、以下のように設定をします。

* **Timer Name**: 任意の名称
* **Repeat Count**: 1

![](images/08-postgresql-003.png)
![karavan]({% image_path 08-postgresql-003.png %}){:width="800px"}