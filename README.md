# 構成
## playbook

エントリーポイント

```
ansible-sample/
  - playbook_app.yml
    インベントリの app ディレクティブのホストへのデプロイ
  - playbook_web.yml
    インベントリの web ディレクティブのホストへのデプロイ
  - playbook_common.yml
    インベントリの全ホストへのデプロイ
  - playbook_localhost.yml
    ローカルホストへのデプロイ(sshを使わないでデプロイできる)
```

## inventory

実行先ホストを定義する

```
ansible-sample/
  - inventory_dev
    dev 環境のインベントリファイル
  - inventory_prd
    prd 環境のインベントリファイル
  - inventory_stg
    stg 環境のインベントリファイル
```

## group\_vars

inventoryのディレクティブごとの変数を定義する

```
ansible-sample/
  - group_vars/
    - all.yml
      inventoryのすべてのディレクティブで参照される変数
    - app.yml
      inventoryの app ディレクティブで参照される変数
    - web.yml
      inventoryの web ディレクティブで参照される変数
```

## host\_vars

inventoryのホストごとの変数を定義する

```
ansible-sample/
  - host_vars/
    - all.yml
      inventoryのすべてのホストで参照される
    - ansible-app-dev.yml
      inventoryの ansible-app-dev ホストで参照される
    - ansible-app-prd.yml
    - ansible-app-stg.yml
    - ansible-web-dev.yml
    - ansible-web-prd.yml
    - ansible-web-stg.yml
    - localhost.yml
      playbookのhostsでlocalhostを指定しているときに参照される
```

## roles

実行する処理を定義

```
ansible-sample/
  - roles/
    - app/
      - files/
        静的ファイルを配置する
        - foo.conf
      - tasks/
        実行する処理を記述する
        - main.yml
      - templates/
        jinja2テンプレート形式ファイルを配置する
        - bar.conf.j2
      - vars/
        roleごとの変数ファイルを配置する
        - main.yml
    - common/
    - web/
```


# playbook 実行コマンド

## ローカルで実行

```bash
# ローカルホストに対して実行 (hosts: localhost となっているplaybookを指定)
ansible-playbook playbook_localhost.yml

# インベントリファイルを指定して実行 (-i オプションでinventoryを指定)
ansible-playbook -i inventory_prd playbook_common.yml
ansible-playbook -i inventory_prd playbook_app.yml
ansible-playbook -i inventory_prd playbook_web.yml

# 特定のロールのみ実行 (--tags オプションでロールに紐づくタグを指定)
ansible-playbook --tags app -i inventory_prd playbook_app.yml
ansible-playbook --tags common,web -i inventory_prd playbook_web.yml

# 特定のグループに対してのみ実行 (-l オプションでグループ名を指定)
ansible-playbook  -i inventory_prd -l web playbook_common.yml

# 特定のホストに対してのみ実行 (-l オプションでホスト名を指定)
ansible-playbook  -i inventory_prd -l  ansible-app-prd playbook_common.yml
```

## コンテナで実行

※ localhostに対してのデプロイはできないので注意

```
# imageのビルド
./bin/build.sh

```

```bash
# インベントリファイルを指定して実行 (-i オプションでinventoryを指定)
./bin/ansible-playbook.sh -i inventory_prd playbook_common.yml
./bin/ansible-playbook.sh -i inventory_prd playbook_app.yml
./bin/ansible-playbook.sh -i inventory_prd playbook_web.yml

# 特定のロールのみ実行 (--tags オプションでロールに紐づくタグを指定)
./bin/ansible-playbook.sh --tags app -i inventory_prd playbook_app.yml
./bin/ansible-playbook.sh --tags common,web -i inventory_prd playbook_web.yml

# 特定のグループに対してのみ実行 (-l オプションでグループ名を指定)
./bin/ansible-playbook.sh  -i inventory_prd -l web playbook_common.yml

# 特定のホストに対してのみ実行 (-l オプションでホスト名を指定)
./bin/ansible-playbook.sh  -i inventory_prd -l  ansible-app-prd playbook_common.yml
```

## オプション

```
-i <InventoryFile>: インベントリファイルを指定
--list-hosts: 実行対象のホストを表示
--list-tasks: 実行タスクを表示
--tags: 実行対象のタグを指定
-l <Subset>: グループ名やホスト名を指定
```

# 参考

- [Ansible Best Practices](https://docs.ansible.com/ansible/2.8/user_guide/playbooks_best_practices.html)
- [Ansible Roles](https://docs.ansible.com/ansible/2.8/user_guide/playbooks_reuse_roles.html)
- [【Ansible】メンテナンスしやすいPlaybookの書き方](https://densan-hoshigumi.com/server/playbook-maintainability)

