# next-rails-nginx-chat-app

# Development

## SSL証明書

サイト要件としてHTTPS化しますが、開発環境には自己証明としておきます。  
本番公開時には、SSL証明書を適用する必要があります。

```bash
# openssl のインストール
sudo yum install openssl

# 秘密鍵の作成
sudo mkdir /etc/nginx/ssl
sudo openssl genrsa -out /etc/nginx/ssl/server.key 2048

# CSR（証明書署名要求）の作成
sudo openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr

# CRT（SSLサーバ証明書）の作成
sudo openssl x509 -days 3650 -req -signkey /etc/nginx/ssl/server.key -in /etc/nginx/ssl/server.csr -out /etc/nginx/ssl/server.crt

# nginx を再起動
sudo systemctl restart nginx
```