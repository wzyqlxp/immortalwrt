#!/bin/bash
# 修改出厂默认 IP 为 10.220.78.2
sed -i 's/192.168.1.1/10.220.78.2/g' package/base-files/files/bin/config_generate
