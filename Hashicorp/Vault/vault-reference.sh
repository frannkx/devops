
#ver status de vault
vault status

#Inicializar, vauver keys y Root token
vault operator init

# desellar la boveda
vault operator unseal

#Inicializar server dev
vault server -dev

#Configuraciones en dev
export VAULT_ADDR='http://127.0.0.1:8200'
echo "CR3XSzqQbMw15hbbqkQOoqAMxXwB8h9FSgcYdQELhZk=" > unseal.key
export VAULT_DEV_ROOT_TOKEN_ID=hvs.cY52AWryZSr8iWuqak11HO6W


vault kv put -mount=secret foo bar=baz

vault kv get -mount=secret foo

vault kv metadata get -mount=secret foo

vault kv get -mount=secret -version=1 foo

vault kv put -mount=secret hello foo=world excited=yes

vault kv get -mount=secret hello

vault kv get -mount=secret -field=excited hello


Unseal Key: DrgW7zm4lR/2pRzNaBkTEvIF9dbHAiaVryk94lo45R4=
Root Token: hvs.IPd8FgA8tz64hKH04a4sKDBB

API

V-TOKEN=hvs.CAESIDUyQhTsZQGv9VqbKnqmNi-cA8SF0ltnl1Eb0VlfFlj6Gh4KHGh2cy45N2J1c29XeVlMZ1ppWk9tajJreVdZMVc

curl -X 'GET' \
  'http://localhost:8200/v1/sys/host-info' \
  -H 'accept: application/json' \
  -H 'X-Vault-Token: '${V_TOKEN}'' | jq .

  curl -X 'GET' \
  'http://localhost:8200/v1/sys/mounts' \
  -H 'accept: application/json' \
  -H 'X-Vault-Token: '${V_TOKEN}'' | jq -r '.data | keys'


#Reference: 
# K8s https://developer.hashicorp.com/vault/docs/platform/k8s
# Vault Helm chart https://github.com/hashicorp/vault-helm
# Integrate K8s vault https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-external-vault
# CSI on AKS https://learn.microsoft.com/en-us/azure/aks/csi-storage-drivers
# Vault CSI provider https://developer.hashicorp.com/vault/tutorials
# Kubernetes https://developer.hashicorp.com/vault/docs/secrets/kubernetes

