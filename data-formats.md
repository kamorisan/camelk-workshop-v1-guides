## Data Formats パターン
---

### 1. 目的

[Marshal](https://camel.apache.org/components/{{ CAMEL_VERSION }}/eips/marshal-eip.html) と [Unmarshal](https://camel.apache.org/components/{{ CAMEL_VERSION }}/eips/unmarshal-eip.html#) を使用して、Camel K のデータ変換機能の使用方法を理解する事を目的とします。

* **Marshal** - Message の Body の Javaオブジェクトをバイナリやテキスト形式に変換します。
* **Unmarshal** - Message の Body の バイナリやテキスト形式のデータをJavaオブジェクトに変換します。

Apache Camel が提供する Data Format については[こちら](https://camel.apache.org/components/{{ CAMEL_VERSION }}/dataformats/index.html)を参照してください。

### 2. CSVファイルを Unmarshal でJavaオブジェクトに変換する

VSCODE 左のエクスプローラー上で、右クリックをして、メニューから `Karavan: Create Integration` を選択し、任意のファイル名で空のインテグレーションを作成をしてください。
（ここでは、dataformats というファイル名にしておきます。）

まず、CSVファイルを取得する処理を作成します。

`dataformats.yaml` の Karavan Designer のGUIを開き、上部の `Create new route` をクリックして、Route を作成しましょう。

`components` タブから `File` を探して選択をしてください。
右上のテキストボックスに `File` と入力をすると、絞り込みができます。

![](images/03-dataformat-001.png)
![karavan]({% image_path 03-dataformat-001.png %}){:width="600px"}

Route の source として、File コンポーネントが配置されます。
Route の File シンボルをクリックすると、右側にプロパティが表示されますので、確認してください。

Parameters は、以下を入力してください。

* **Directory Name**: data/input

> 前章の [Fileコンポーネント]({{ HOSTNAME_SUFFIX }}/workshop/camel-k/lab/file-component) で `data/input` フォルダを作成していない場合は、ワークスペースのルートフォルダ直下に、`data` フォルダを作成し、さらにdata フォルダの配下に、`input` フォルダを作成してください。

![](images/03-dataformat-002.png)
![karavan]({% image_path 03-dataformat-002.png %}){:width="800px"}

最後に、テスト用のCSVファイルを作成します。
左のエクスプローラー上で、右クリックをして、メニューから `新しいファイル` を選択し、`test.csv` を作成します。

ファイルの中身は、

<pre>
  id,name
  1,apple
  2,orange
  3,lemon
</pre>

としてください。

![](images/03-dataformat-003.png)
![karavan]({% image_path 03-dataformat-003.png %}){:width="600px"}

では、取得するファイルの中身を変換していきます。
まず、オブジェクトに変換するために、`Unmarshal` を使用します。

Route にマウスカーソルを持っていくと、File シンボルの下に小さな＋ボタンが現れますので、それをクリックし、`Transformation` のタブから `Unmarshal` を探して選択をしてください。

![](images/03-dataformat-004.png)
![karavan]({% image_path 03-dataformat-004.png %}){:width="600px"}

`Unmarshal` のシンボルが File に続いて配置されます。

Parameters は、以下のように設定をしてください。
他の項目は、デフォルトのままで構いません。

* **Data Format**: csv
* **Delimiter**: , (カンマ)
* **Use Maps**: True

![](images/03-dataformat-005.png)
![karavan]({% image_path 03-dataformat-005.png %}){:width="800px"}
![](images/03-dataformat-006.png)
![karavan]({% image_path 03-dataformat-006.png %}){:width="800px"}

データ変換後の Body を 確認するための `Log` を追加します。
Unmarshal シンボルの下の＋ボタンをクリックし、`Routing` のタブから `Log` を探して選択をしてください。

![](images/03-dataformat-007.png)
![karavan]({% image_path 03-dataformat-007.png %}){:width="600px"}

Unmarshalで変換した内容を表示するには、Log プロパティ の `Message` に `${body}` と入力をしてください。

それでは、実際に動かしてみます。

右上の **▷** の実行ボタンを押してください。
（もしくは、左のエクスプローラでファイル名を右クリックして、`Karavan: Run File` を選択してください）

ターミナルが開き、作成したインテグレーションが JBang を通して実行されます。
特にエラーなく実行されたら、先ほど作成した `test.csv` を `data/input` フォルダに移動して格納をしてください。

![](images/03-dataformat-008.png)
![karavan]({% image_path 03-dataformat-008.png %}){:width="800px"}

ファイルが所定のフォルダに格納されると、インテグレーションが実行されて、コンソールに Unmarshal で変換をした後の Log が表示されます。
（インプットのファイルは、`data/input` 配下に `.camel` フォルダが作成され、そちらに移動します）

CSV Data Format で Unmarshal したデータは、JavaのList型になります。

![](images/03-dataformat-009.png)
![karavan]({% image_path 03-dataformat-009.png %}){:width="800px"}

Log の確認ができたら、処理を停止してください。

### 3. Marshal でJSON形式のテキストに変換する

先ほど作成した `dataformat.yaml` に、JSON形式のテキストに変換する処理を追加します。

Log シンボルにマウスカーソルを持っていくと、左上に小さく `→` ボタンが表示されますので、クリックします。

![](images/03-dataformat-010.png)
![karavan]({% image_path 03-dataformat-010.png %}){:width="400px"}

続いて、`Transformation` タブから `Marshal` を探して選択をしてください。
右上のテキストボックスに `Marshal` と入力をすると、絞り込みができます。

![](images/03-dataformat-011.png)
![karavan]({% image_path 03-dataformat-011.png %}){:width="600px"}

これで、`Unmarshal` と `Log` の間に、`Marshal` が追加されました。

`Marshal` のシンボルをクリックすると、右側にプロパティが表示されますので、
Parameters 項目に、以下の内容を設定してください。
他の項目は、デフォルトのままで構いません。

* **Data Format**: json
* **Library**: jackson

![](images/03-dataformat-012.png)
![karavan]({% image_path 03-dataformat-012.png %}){:width="800px"}

それでは再び、右上の **▷** の実行ボタンを押してください。
（もしくは、左のエクスプローラでファイル名を右クリックして、`Karavan: Run File` を選択してください）

ターミナルが開き、作成したインテグレーションが JBang を通して実行されます。
特にエラーなく実行されたら、もう一度、 `test.csv` を `data/input` フォルダに移動して格納をしてください。

ファイルが所定のフォルダに格納されると、インテグレーションが実行されて、コンソールに Marshal で変換をした後の Log が表示されます。
（インプットのファイルは、`data/input` 配下に `.camel` フォルダが作成され、そちらに移動します）

JSON Data Format で Marshal したデータは、JSON形式のテキストになります。

![](images/03-dataformat-013.png)
![karavan]({% image_path 03-dataformat-013.png %}){:width="800px"}

Log の確認ができたら、処理を停止してください。