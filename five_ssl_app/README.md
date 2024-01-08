# Five Build SSL CA and test with servier client example app

Openssl PKI Examples with golang app as functional test

## Second test with-in `ssl_setup` directory

## Create CA
```sh
openssl req -new -config etc/root-ca.conf -out ca/root-ca.csr -keyout ca/root-ca/private/root-ca.key
openssl ca -selfsign -config etc/root-ca.conf -out ca/root-ca.crt -extensions root_ca_ext
```

# Create signing CA
```sh
openssl req -new -config etc/signing-ca.conf -out ca/signing-ca.csr -keyout ca/signing-ca/private/signing-ca.key
```

# Sign signingca CSR
```sh
openssl ca -config etc/root-ca.conf -in ca/signing-ca.csr -out ca/signing-ca.crt -extensions signing_ca_ext
```

# Create new Server cert
```sh
openssl req -new -config etc/www.kurtis.io.conf -out certs/www.kurtis.io.csr -keyout certs/www.kurtis.io.key
openssl ca -config etc/signing-ca.conf -in certs/www.kurtis.io.csr -out certs/www.kurtis.io.crt -extensions server_ext
```

# Create New Signing Cert
```sh
openssl req -new -config etc/client.kurtis.io -out certs/client.kurtis.io.csr -keyout certs/client.kurtis.io.key
openssl ca -config etc/signing-ca.conf -in certs/client.kurtis.io.csr -out certs/client.kurtis.io.crt -extensions server_ext
```

# Create cert chain
```sh
cat root-ca.pem signing-ca.pem > bundle.pem
```
# Edit /etc/hosts and test
```sh
curl --cacert bundle.pem -H'Host: client.kurtis.io' https://client.kurtis.io:8443/hello
```
