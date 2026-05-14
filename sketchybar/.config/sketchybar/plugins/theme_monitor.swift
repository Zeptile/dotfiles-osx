#!/usr/bin/env swift

import Cocoa
import Foundation

let configDir = ProcessInfo.processInfo.environment["HOME"]! + "/.config/sketchybar"

func getCurrentSystemAppearance() -> String {
    let appearance = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")
    return appearance == "Dark" ? "dark" : "light"
}

func getThemeConfig() -> (darkTheme: String, lightTheme: String, autoEnabled: Bool) {
    let configPath = configDir + "/theme_config.sh"
    var darkTheme = "gruvbox"
    var lightTheme = "gruvbox-light"
    var autoEnabled = true
    
    if let content = try? String(contentsOfFile: configPath, encoding: .utf8) {
        for line in content.components(separatedBy: "\n") {
            if line.hasPrefix("DARK_THEME=") {
                darkTheme = line.replacingOccurrences(of: "DARK_THEME=", with: "")
                    .replacingOccurrences(of: "\"", with: "")
            } else if line.hasPrefix("LIGHT_THEME=") {
                lightTheme = line.replacingOccurrences(of: "LIGHT_THEME=", with: "")
                    .replacingOccurrences(of: "\"", with: "")
            } else if line.hasPrefix("AUTO_SWITCH_ENABLED=") {
                let value = line.replacingOccurrences(of: "AUTO_SWITCH_ENABLED=", with: "")
                    .replacingOccurrences(of: "\"", with: "")
                autoEnabled = value == "true"
            }
        }
    }
    return (darkTheme, lightTheme, autoEnabled)
}

func getCurrentTheme() -> String {
    let themePath = configDir + "/.theme"
    return (try? String(contentsOfFile: themePath, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)) ?? "default"
}

func setTheme(_ theme: String) {
    let themePath = configDir + "/.theme"
    try? theme.write(toFile: themePath, atomically: true, encoding: .utf8)
}

func syncTheme() {
    let config = getThemeConfig()
    guard config.autoEnabled else { return }
    
    let appearance = getCurrentSystemAppearance()
    let desiredTheme = appearance == "dark" ? config.darkTheme : config.lightTheme
    let currentTheme = getCurrentTheme()
    
    if currentTheme != desiredTheme {
        setTheme(desiredTheme)
        let task = Process()
        task.launchPath = "/usr/local/bin/sketchybar"
        if !FileManager.default.fileExists(atPath: task.launchPath!) {
            task.launchPath = "/opt/homebrew/bin/sketchybar"
        }
        task.arguments = ["--reload"]
        try? task.run()
    }
}

syncTheme()

DistributedNotificationCenter.default().addObserver(
    forName: NSNotification.Name("AppleInterfaceThemeChangedNotification"),
    object: nil,
    queue: .main
) { _ in
    syncTheme()
}

RunLoop.main.run()
