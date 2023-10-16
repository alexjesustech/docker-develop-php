# Guia de instalação do Codeigniter 4

Se o container estiver em execução, pare-o:
```shell
docker-compose stop
```

Exclua a pasta ```project```:
```shell
rm -rf project
```

Clone o Codeigniter (v4.4.1):
```shell
git clone -b v4.4.1 --single-branch git@github.com:codeigniter4/appstarter.git project
```

Agora execute o container novamente:
```shell
docker-compose start
```

Instale as dependencies do Codeigniter: 
```shell
chown -R $(id -un):www-data /home/$(id -un)/project
```

Instale as dependencies do Codeigniter: 
```shell
composer install
```

Em seguida acesse o endereço http://localhost:

Documentação do CodeIgniter4
https://codeigniter.com/user_guide/index.html
