## 一键登录服务器
预安装:  
expect
ssh

1. 申请好跳板机权限，然后设置在jump.sh文件中  
```
# 223.252.216.168 为跳板机，wangkun3就生成public key的用户名
ssh -p 1046 wangkun3@223.252.216.168 -A
```
2. 在list.txt中配置添加编号以及其对应的IP地址，形式如下  
```
52      10.200.134.199
53      10.200.178.200
```
3. 执行login.sh,并传入配置的编号，然后就可以登录到对应的服务器，前提是要有跳板机权限和所登录机器的权限  
```
 ./login.sh 52
```


```
#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: input a digit index or -l"
    exit
fi

# check parameters
if grep '^[[:digit:]]*$' <<< "$1";then
        echo "finding and logining ..."
elif [ "$1" == "-l" ] ;then
        cat /etc/host-list.txt
        exit 0
else
        echo "wrong parameter!"
        exit 1
fi

# index and ip can be sperate with multiple spaces or tabs
read index ip password < <(cat /etc/host-list.txt | grep -E  "^$1[[[:space:]]|\t]?([0-9]{1,3}[\.]){3}[0-9]{1,3}" | awk '{print $1,$2,$3}')
if [ ! "$ip" ]
then
    echo "Failed to get IP with given index : "$1
    exit 1
fi

sshpass -p $password ssh root@$ip
```
