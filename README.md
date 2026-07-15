# Douyin Space Pause

一个适用于 Windows 的 AutoHotkey v2 小脚本：运行后，只有当前台窗口是抖音客户端、抖音直播网页，或全屏的抖音/抖音直播窗口时，才把空格键作为播放/暂停快捷键发送给当前窗口。当前台是其他应用时，脚本不会接管空格键，因此不会干扰输入、视频播放或其他软件快捷键。

## 使用方法

1. 安装 [AutoHotkey v2](https://www.autohotkey.com/)。
2. 双击运行 `douyin_space_pause.ahk`。
3. 打开抖音直播间，并确保抖音窗口或包含抖音直播间的浏览器窗口处于前台。
4. 按空格键暂停或继续播放。

## 作用范围

脚本通过 AutoHotkey 的条件热键 `#HotIf` 限制空格键只在 `IsDouyinWindow()` 返回真时生效：

- 当前前台进程是抖音/TikTok 桌面客户端时生效。
- 当前前台进程是常见浏览器，且窗口标题包含 `抖音`、`Douyin`、`douyin.com`、`live.douyin.com` 或 `TikTok LIVE` 时生效。
- 其他窗口、其他应用和其他浏览器标签页不生效，空格键保持系统/应用原有行为。

如果你的抖音客户端或浏览器使用了不同的进程名，可以在 `douyin_space_pause.ahk` 顶部的 `DouyinAppProcesses` 或 `BrowserProcesses` 中补充。
