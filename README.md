# Docker Typecho
| key | value |
| --- | --- |
| typecho | 1.0.14.10.10.-release |
| nginx | 1.13 |
| php | 7.1.7 |

## Config
edit docker-config.env

## Build
```
docker-compose build
```

## Run
```
docker-compose up
```

## Install
open [localhost:8080](http://localhost:8080)


orther settings look up `docker-config.env`

## Typecho 迁移到 Hexo

1. 将原来的数据通过数据转储（如:mysql_dump)复制到本地的数据库；

2. 配置 Typecho 使之可以访问备份的数据；

3. 访问`your-host/utils/2hexo.php`;

4. `data/hexo`生成数据。