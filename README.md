# 千年·炎黄新章源码

`1000yCode` 是基于分享的炎黄新章 Delphi 源码整理的项目，包含 Windows 客户端和五个服务端工程。仓库自带编译所用的公共单元、控件和静态游戏资料。

## 编译

编译需要 Windows、Delphi 7 和 Windows PowerShell。以下命令在仓库根目录执行。

```powershell
.\build_all.bat
```

脚本会从 `PATH` 或 Delphi 7 的默认安装目录查找 `DCC32.EXE`。编译输出和各工程的 `build.log` 位于 `build-output/<本次构建>/<工程>/`。

```powershell
.\build_all.bat -Project client
.\build_all.bat -Project tgs
.\build_all.bat -CompilerPath 'D:\Delphi7\Bin\DCC32.EXE'
.\build_all.bat -Help
```

## 目录

| 目录 | 用途 |
| --- | --- |
| [client/](client/) | Windows 客户端，控件位于 `client/Lib/` |
| [balance/](balance/) | 登录接入和 Gate 调度 |
| [gate/](gate/) | 客户端与后端服务之间的通信网关 |
| [login/](login/) | 账号和登录服务 |
| [db/](db/) | 游戏数据服务 |
| [tgs1000/](tgs1000/) | 游戏服务端，静态配置和脚本位于 `tgs1000/bin/` |
| [Common/](Common/) 和 [1000ydef/](1000ydef/) | 公共通信单元、协议和数据结构 |
| [Lib/](Lib/) | FastNet 网络组件，供 Balance、Gate 和 TGS 编译使用 |

运行游戏时，请准备对应版本的客户端资源，并按部署环境配置服务地址、端口和数据库。运行日志、玩家数据和本机部署配置由 `.gitignore` 排除。

修改 Delphi 源码时保留原有 GBK/CP936 编码。Markdown 文档使用 UTF-8 和 LF。

## 相关项目

- [完整客户端程序](https://github.com/oiuv/1000yClient.git)
- [千年开发者文档](https://github.com/oiuv/1000yDocs.git)
