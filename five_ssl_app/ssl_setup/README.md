# Create new Privat key

## In side `ssl_setup`

```sh
openssl req  -nodes -new -x509  -keyout ca.key -out ca.crt -subj '/CN=cert.kurtis.io/O=Kurtis'
```

# Create the server pub/priv key and self sign with server cert.
```sh
openssl genrsa -out server.key 2048
openssl genrsa -out client.key 2048
```

```sh
openssl req -new -key server.key -out server.csr -subj "/CN=server.kurtis.io/O=server"
openssl req -new -key client.key -out client.csr -subj "/CN=client.kurtis.io/O=client"
```

## Sign the new key

```ssh
openssl x509 -req -in ./server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 45
openssl x509 -req -in ./client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 45
```

```sh
go run server.go 
```
Test
```ssh
curl --cert client.crt --key client.key --cacert ca.crt -H'Host: server.kurtis.io' https://server.kurtis.io:8443/hello
```

Test
Use gemnerated Certs
```

GODEBUG=x509ignoreCN=0 go run client.go
```

