# [AutoNas][this repo] NAS自动部署脚本

使用Docker容器来部署[NextCloud][nextcloud]或[Jellyfin][jellyfin]，使用[Caddy][caddy]当作网关进行转发，使用[Cloudflare][cloudflare] [Tunnel][cloudflare tunnel]作为内网穿透工具
使用到的工具全部都是免费的，除了购买一个域名

## 用法

* 准备一个域名，可以在万网上直接购买，假设为`example.com`

* 在Cloudflare上面添加站点，域名填写`example.com`，记录要配置的DNS解析服务器地址

* 在万网后台将`example.com`域名的DNS解析服务器设置为Cloudflare提供的DNS解析服务器

* 在Cloudflare上面建立Tunnel，记录TUNNEL_TOKEN，并配置TUNNEL使用的域名，需要哪个配置哪个，也可以都配置上

    * nextcloud.example.com -> `http://caddy:80`
    * jellyfin.example.com  -> `http://caddy:80`

* cd到要部署NextCloud或Jellyfin的目录

    ```
    cd /path_to_deploy
    ```

* 使用Git克隆或者直接下载本项目到想部署NextCloud或Jellyfin的目录里

    ```
    git clone https://github.com/indiefun/auto-nas.git
    cd auto-nas
    ```

* 安装docker和docker-compose依赖，如果已经安装了docker和docker-compose可以略过本步骤

    ```
    sudo ./setup.sh
    ```

* 执行config.sh配置docker-compose.yml等，根据提示输入

    ```
    ./config.sh
    # 首先输入 nextcloud.example.com，留空表示不启用nextcloud服务
    # 然后输入 jellyfin.example.com，留空表示不启用jellyfin服务
    # 二者不可都为空
    # 最后输入 TUNNEL_TOKEN，这个不能为空
    ```

* 启动服务

    ```
    ./start.sh
    ```

* 使用浏览器开始使用`https://nextcloud.example.com`或`https://jellyfin.example.com`吧

* 如果在内网想加快访问速度，可以在本机或者路由器上面设置HOST来加速内网访问

    * [内网IP] nextcloud.example.com
    * [内网IP] jellyfin.example.com

## 其他脚本

* `stop.sh`    停止Docker容器
* `status.sh`  查看Docker容器状态
* `clear.sh`   清理Docker容器的挂载点，会删除所有数据，**谨慎使用**
* `backup.sh`  备份所有文件，包括数据，备份前请先stop所有docker容器，备份生成backup.tar.gz压缩包，可以将backup.tar.gz转移到其他目录或者机器
* `recover.sh` 恢复所有文件，包括数据，备份前请先stop所有docker容器，并将backup.tar.gz放入当前目录

## 参考链接

* [NextCloud官网][nextcloud]
* [Jellyfin官网][jellyfin]
* [Caddy官网][caddy]
* [Cloudflare官网][cloudflare]
* [Cloudflare Tunnel文档][cloudflare tunnel]

[this repo]: https://github.com/indiefun/auto-nas
[nextcloud]: https://nextcloud.com/
[jellyfin]: https://jellyfin.org/
[caddy]: https://caddyserver.com/
[cloudflare]: https://www.cloudflare.com/zh-cn/
[cloudflare tunnel]: https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/
