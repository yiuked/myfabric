# myfabric
本实实现一个单组织，一个 orderer 节点，一个 peer 节点来最小化启动 fabric 的示例。

## 运行环境
* go version go1.13
* docker 19.03.4
* fabric 1.4.3

## 快速开始
1. 下载
```
git clone https://github.com/yiuked/myfabric.git
cd myfabric/
```

2. 生成证书及配置文件
```
./generate.sh
```

3. 启动节点
```
./start.sh
```

4. 管道初始化
```
./channel.sh
```

5. 安装链码
```
./install.sh
```
