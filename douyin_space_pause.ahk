#Requires AutoHotkey v2.0
#SingleInstance Force

; Space-to-pause helper for Douyin live rooms.
; The Space hotkey is active only when the foreground window appears to be
; Douyin (desktop app) or a browser tab/window whose title contains Douyin.
; In every other application, Space keeps its normal behavior.

SetTitleMatchMode 2

; Add or remove process names here if your Douyin client/browser uses a
; different executable. Browser entries allow Douyin live rooms opened in a
; browser, while title checks below keep the hotkey scoped to Douyin pages.
global DouyinAppProcesses := Map(
    "Douyin.exe", true,
    "douyin.exe", true,
    "抖音.exe", true,
    "TikTok.exe", true,
    "tiktok.exe", true
)

global BrowserProcesses := Map(
    "chrome.exe", true,
    "msedge.exe", true,
    "firefox.exe", true,
    "brave.exe", true,
    "opera.exe", true,
    "vivaldi.exe", true,
    "iexplore.exe", true
)

global DouyinTitleKeywords := [
    "抖音",
    "Douyin",
    "douyin.com",
    "live.douyin.com",
    "TikTok LIVE"
]

IsDouyinWindow(*) {
    try {
        processName := WinGetProcessName("A")
        title := WinGetTitle("A")
    } catch Error {
        return false
    }

    if DouyinAppProcesses.Has(processName) {
        return true
    }

    if BrowserProcesses.Has(processName) {
        for keyword in DouyinTitleKeywords {
            if InStr(title, keyword, false) {
                return true
            }
        }
    }

    return false
}

PauseDouyinLive(*) {
    ; Avoid sending a plain Space from the Space hotkey: some Douyin live pages
    ; keep keyboard focus on the page chrome/chat and ignore it. Media_Play_Pause
    ; is handled by Chromium and the Douyin desktop player more consistently.
    Send "{Media_Play_Pause}"

    ; Give visible feedback so it is clear the scoped hotkey fired. This does
    ; not guarantee Douyin accepted the media key, but it distinguishes hotkey
    ; detection problems from player problems.
    ToolTip "已发送播放/暂停按键"
    SetTimer () => ToolTip(), -900
}

#HotIf IsDouyinWindow()
Space::PauseDouyinLive()
#HotIf
