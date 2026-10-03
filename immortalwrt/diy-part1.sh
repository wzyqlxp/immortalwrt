#!/bin/bash
# 在 feeds update/install 之后执行，添加三方插件源

# Argon 主题（替换 feed 中的旧版）
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
git clone --depth=1 -b master https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# mosdns v5 + 地理数据
rm -rf feeds/packages/net/v2ray-geodata
git clone --depth=1 -b v5 https://github.com/sbwml/luci-app-mosdns package/mosdns
git clone --depth=1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# OpenClash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash package/openclash-tmp
mv package/openclash-tmp/luci-app-openclash package/luci-app-openclash
rm -rf package/openclash-tmp

# autocore（LuCI 概览 CPU 信息，若源码树没有则从 sbwml 拉取）
if ! ls package/emortal/autocore* >/dev/null 2>&1; then
  git clone --depth=1 https://github.com/sbwml/autocore package/autocore
fi
