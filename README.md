# 环境准备

## 1 qemu

官网下载最新的qemu：

```
https://www.qemu.org
```

解压后进行安装与编译。

```
tar xvf qemu-5.2.0.tar.xz
./configure --target-list=riscv64-softmmu
make
sudo make install
```

## 2 交叉编译工具链

- 2.1 在芯来科技官网上下载对应的交叉编译工具链

```
https://nucleisys.com/download.php
```

- 2.2准备交叉编译工具链

```
PATH=$PATH:$HOME/toolschain/gcc/bin:$HOME/toolschain/qemu/bin
```
