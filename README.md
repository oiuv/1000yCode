# 千年·炎黄新章源码

`1000yCode` 收录经第三方修改的《千年·炎黄新章》Delphi 源码，包含 Windows 客户端和五个服务端工程。仓库自带编译所用的公共单元、控件和静态游戏资料。

本项目仅供学习与研究。

Login 账号服务为第三方修改版，内置单个新增和批量注册玩家账号的功能。TGS 也包含定制改动，例如随身物品栏及部分武功栏由 30 格扩至 50 格。本仓库的一层武功、二层武功和掌法栏各有 50 格，TGS 与客户端使用相同的栏位定义。[栏位定义](1000ydef/deftype.pas)

## 编译

编译需要 Windows、Delphi 7 和 Windows PowerShell。以下命令在仓库根目录执行。

```powershell
.\build_all.bat
```

脚本会从 `PATH` 或 Delphi 7 的默认安装目录查找 `DCC32.EXE`。编译输出和各工程的 `build.log` 位于 `build-output/<本次构建>/<工程>/`。

已使用 Delphi 7 验证 Balance、Gate、Login、DB、TGS 和 Client 六个工程均可编译。本次验证仅覆盖源码编译，游戏功能的正确性以实际运行测试为准。

```powershell
.\build_all.bat -Project client
.\build_all.bat -Project tgs
.\build_all.bat -CompilerPath 'D:\Delphi7\Bin\DCC32.EXE'
.\build_all.bat -Help
```

## 创建测试账号

启动 Login 服务并打开「账号信息」窗口，在顶部「账号」栏输入 `demo`，点击「增加」。程序会直接把测试账号写入 Login 工作目录下的 `Login.DB`，初始密码与账号同名。随后在游戏客户端用账号 `demo`、密码 `demo` 登录。[账号创建代码](login/frmLogin.pas)

「注册100个」会以输入的内容为前缀批量创建账号。输入 `demo` 会创建 `demo0` 至 `demo99`，各账号的初始密码与各自的账号名相同。

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

- [原版服务端核心源码（TGS1000）](https://github.com/oiuv/TGS1000.git)
- [原版客户端核心源码（CL1000）](https://github.com/oiuv/CL1000.git)
- [完整客户端程序（1000yClient）](https://github.com/oiuv/1000yClient.git)
- [千年开发者文档（1000yDocs）](https://github.com/oiuv/1000yDocs.git)
