# Ambiente de Desenvolvimento Docker para Projetos PHP

## Primeiros passos

Clone o repositório renomeando-o com o nome do sistema a ser desenvolvido:
```shell
git clone git@github.com:alexjesustech/docker-develop-php.git app-exemplo
```

Entre na pasta criada:
```shell
cd app-exemplo
```

Exclua a pasta ```.git```:
```shell
rm -rf .git
```

Criar e iniciar contêineres configurados no arquivo ```docker-compose.yml``` com o comando a seguir: 
```shell
docker-compose up -d
```
Em seguida acesse o endereço http://localhost:

Saiba como instalar: 
* [CodeIgniter 4](etc/codeigniter.md)
