## Kafka との連携
---

### 1. 目的

Kamelet の Kafka Sink, Kafka Source を使用して、Camel K と Kafka との連携の方法について理解していただきます。

* [Kafka Sink](https://camel.apache.org/camel-kamelets/0.9.x/kafka-sink.html)
* [Kafka Source](https://camel.apache.org/camel-kamelets/0.9.x/kafka-source.html)

### 2. Red Hat OpenShift Streams for Apache Kafka　(RHOSAK) の準備

このワークショップでは、Red Hat が提供するマネージド kafka の　サービスである、Red Hat OpenShift Streams for Apache Kafka (略してRHOSAK) を使用していきます。
RHOSAK を使用すると、Kafkaの環境を自分で構築・運用することなく、ストリーム処理のアプリケーションの開発やリリースを簡単に行うことができるようになります。
なお、2023年1月現在、RHOSAKは48時間有効の、無料のトライアル版を使用することができます。

#### 2.1 RHOSAK で Kafka インスタンスをプロビジョニングする

[console.redhat.com](https://console.redhat.com/) にアクセスし、Red Hat アカウントでログインします。

もし Red Hat アカウントを持っていない場合は、Register for a Red Hat accountリンクをクリックして、Red Hat アカウントを作成してください。
その際は、`Account Type: Personal` を選択してください。

![](images/07-kafka-001.png)
![karavan]({% image_path 07-kafka-001.png %}){:width="800px"}

ログインすると、左のメニューから、`Application and Data Services` -> `Streams for Apache Kafka` -> `Kafka Instance` を選択します。

![](images/07-kafka-002.png)
![karavan]({% image_path 07-kafka-002.png %}){:width="800px"}

Kafka Instances のページで、`[Create Kafka instance]` をクリックします。

![](images/07-kafka-003.png)

Create a Kafka instance のページに移動するので、`Name` に任意のクラスターの名前を入力してください。

他の項目はこのままで、一番下にスクロールして `[Create instance]` をクリックします。

![](images/07-kafka-004.png)

作成した Kafka インスタンスがリストに表示されます。しばらくすると、インスタンスの Status が `Ready` になるので待ちましょう。

インスタンスの Status が `Ready` になったら、右側の３点のアイコンから、`Detail` を選択してください。

![](images/07-kafka-005.png)

作成したインスタンスの詳細が表示されますので、`Connection` タブをクリックして、`Bootstrap server` の内容をメモしておきます。

![](images/07-kafka-006.png)

#### 2.2 RHOSAK で Kafka インスタンスに接続するための Service Account を作成する

アプリケーションまたはサービスを RHOSAK の Kafka インスタンスに接続するには、Service Account を作成する必要があります。

先ほどの Kafka インスタンス詳細ページの、Bootstrap server の下に、`[Create service account]` があるので、クリックして選択してください。

任意のアカウント名を入力して、`[Create]` を選択します。

![](images/07-kafka-007.png)

作成した Service Account の ID と Secret が表示されますので、メモをしてから閉じてください。

![](images/07-kafka-008.png)

#### 2.3 RHOSAK で Service Account の権限を変更する

Kafka インスタンスに接続するための Service Account を作成した後、Kafka インスタンスのアクセス制御リスト (ACL) で、その Service Account に適切なアクセスレベルを設定する必要があります。

左側メニューから `Kafka Instances` を選択し、先ほど作成したインスタンスの名前をクリックします。

![](images/07-kafka-009.png)

`Access` タブを選択し、`[Manage Access]` を選択します。

![](images/07-kafka-010.png)

ポップアップ画面が開いたら、ドロップダウンのメニューから `All accounts` をクリックします。

![](images/07-kafka-011.png)

次に、`Add permissions` のドロップダウンのメニューから、`Consume from a topic` を選択してください。

![](images/07-kafka-012.png)

`Topic` と `Consumer group` の権限について、左の欄は `is`、 右の欄に `* (アスタリスク)` を入力します。 

![](images/07-kafka-013.png)

さらに、`Add permissions` のドロップダウンのメニューから、今度は `Produce to a topic` を選択します。

![](images/07-kafka-014.png)

`Topic` の権限について、左の欄は `is`、 右の欄に `* (アスタリスク)` を入力します。 

最後に、`[Save]` を選択してください。

![](images/07-kafka-015.png)

これで、アプリケーションやサービスからトピックにアクセスする準備ができました。

![](images/07-kafka-016.png)

#### 2.4 RHOSAK で Kafka トピック を作成する

Kafka インスタンスと Service Account を作成したら、Kafka トピックを作成して、アプリケーションやサービスで Kafka メッセージの取得や送信ができます。

作成した kafka インスタンス の `Topic` タブを選択し、`[Create topic]` を選択します。

![](images/07-kafka-017.png)

ガイドの手順に従って、トピックの詳細を定義していきます。
任意のトピック名を入力し、`Next` を選択してください。

![](images/07-kafka-018.png)

他の項目は一旦そのままで良いので、`Next` を選択し、最後に `Finish` を選択してください。
トピックの設定が完了すると、新しい Kafka トピックが一覧に表示されます。

![](images/07-kafka-019.png)


