# ImmortalWrt x86_64 自动编译

基于 [ImmortalWrt](https://github.com/immortalwrt/immortalwrt) `openwrt-24.10` 分支，使用 GitHub Actions 在云端自动编译的 x86_64 精简固件。

定位为**旁路网关（单臂路由）**：单网卡桥接，静态 IP 旁挂在主路由下，只负责代理分流与 DNS，不承担拨号、DHCP 等职责。

## 固件特点

- **精简优先**：只保留实际在用的功能，无冗余插件
- **云端自动编译**：GitHub Actions 每日定时构建，固件自动发布到 Release，无需本地环境
- **刷入即用**：网络、主题、各应用参数均已按目标环境预配置（仅代理订阅需自行填写）

## 已集成功能

| 功能 | 说明 |
|---|---|
| OpenClash | Clash Meta 核心，fake-ip 模式，规则分流，订阅/规则数据自动更新 |
| mosdns | DNS 分流（:5335），dnsmasq 全部转发，国内/国外域名智能解析 |
| UnblockNeteaseMusic | 网易云音乐灰歌单解锁 |
| vlmcsd | KMS 服务器（端口 1688） |
| miniupnpd | UPnP / NAT-PMP |
| LuCI (nginx) + Argon | 现代化 Web 管理界面与主题 |
| zram | 内存压缩交换分区 |

另内置 DNS 劫持（TCP 53 → mosdns）与 MSS Clamp（1380）nftables 规则。

## 默认参数

| 项目 | 值 |
|---|---|
| 管理 IP | `http://10.220.78.2` |
| 用户名 | `root` |
| 密码 | `password` |
| 上游网关 | `10.220.78.1` |
| 根分区大小 | 1 GB |

> ⚠️ OpenClash 的订阅链接属私密信息，**不包含在固件中**。刷机后请在「OpenClash → 配置文件订阅」中手动添加订阅并启动。

## 下载

进入 [Releases](https://github.com/wzyqlxp/immortalwrt/releases) 页面下载最新固件，镜像格式包含：

- `*.img.gz` — 通用磁盘镜像（dd / 写盘工具刷入）
- `*.vmdk` — VMware 虚拟机直接使用

## 编译方式

本项目所有编译均在 GitHub Actions 云端完成：

1. Fork 本仓库
2. 进入 **Actions** 标签页，选择 `ImmortalWrt x86_64`
3. 点击 **Run workflow** 手动触发，或等待每日定时自动构建
4. 构建完成后在 Release / Artifacts 中下载固件

## 目录结构

```
├── .github/workflows/immortalwrt.yml   # Actions 编译流程
├── immortalwrt/
│   ├── x86_64/defconfig                # 软件包配置
│   ├── diy-part1.sh                    # 三方插件源（OpenClash/mosdns/Argon）
│   └── diy-part2.sh                    # 默认 IP 等修改
└── files/                              # 直接覆盖进固件的文件（UCI 配置等）
```

## 致谢

- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt)
- [vernesong/OpenClash](https://github.com/vernesong/OpenClash)
- [sbwml/luci-app-mosdns](https://github.com/sbwml/luci-app-mosdns)
- [jerrykuku/luci-theme-argon](https://github.com/jerrykuku/luci-theme-argon)
- [DHDAXCW/OpenWRT_x86_x64](https://github.com/DHDAXCW/OpenWRT_x86_x64)（自动编译流程参考）
