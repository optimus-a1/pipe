#!/bin/bash

# 下载pop文件
echo "正在下载pop文件..."
curl -L -o pop 'https://dl.pipecdn.app/v0.2.8/pop'

# 给pop文件加执行权限
chmod +x pop

# 创建缓存目录
mkdir -p download_cache

# 提示用户输入推荐代码并执行
echo '请输入推荐代码 (回车使用默认代码 37ea19443c8fc101)：'
read referral_code
referral_code=${referral_code:-37ea19443c8fc101}  # 默认代码
echo "正在使用推荐代码: $referral_code"
./pop --signup-by-referral-route "$referral_code"

# 检查返回值（可能会失败，应该捕获错误）
if [ $? -ne 0 ]; then
  echo "推荐注册失败，请检查推荐代码是否有效！"
  exit 1
fi

# 提示用户输入内存、存储、钱包地址
echo '请输入内存大小 (单位 GB)：'
read ram_size
echo '请输入存储大小 (单位 GB)：'
read disk_size
echo '请输入钱包地址：'
read wallet_address

# 运行pop程序
echo "正在运行pop..."
./pop --ram "$ram_size" --max-disk "$disk_size" --cache-dir /data --pubKey "$wallet_address"

# 检查pop命令是否成功执行
if [ $? -ne 0 ]; then
  echo "pop程序执行失败！"
  exit 1
fi

echo '脚本执行完成。'
