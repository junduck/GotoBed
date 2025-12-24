//
//  GotoBedApp.swift
//  GotoBed
//
//  Created by Junda Li on 24/12/2025.
//

import SwiftUI

@main
struct GotoBedApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popover: NSPopover?
    var powerMonitor = PowerMonitor()
    
    static let showPopoverNotification = "com.gotobed.showPopover"
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Check for existing instances
        let runningApps = NSWorkspace.shared.runningApplications
        let currentPID = ProcessInfo.processInfo.processIdentifier
        
        for app in runningApps {
            if app.bundleIdentifier == Bundle.main.bundleIdentifier && app.processIdentifier != currentPID {
                // Another instance is already running, send notification to show popover
                DistributedNotificationCenter.default().postNotificationName(
                    NSNotification.Name(AppDelegate.showPopoverNotification),
                    object: nil,
                    userInfo: nil,
                    deliverImmediately: true
                )
                NSApp.terminate(nil)
                return
            }
        }
        
        // Listen for show popover notifications
        DistributedNotificationCenter.default().addObserver(
            self,
            selector: #selector(showPopoverFromNotification),
            name: NSNotification.Name(AppDelegate.showPopoverNotification),
            object: nil
        )
        
        // Create the status item in the menu bar
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "moon.zzz.fill", accessibilityDescription: "GotoBed")
            button.action = #selector(togglePopover)
            button.target = self
        }
        
        // Create the popover
        popover = NSPopover()
        popover?.behavior = .transient
        popover?.contentViewController = NSHostingController(rootView: MenuBarView(powerMonitor: powerMonitor))
        
        // Hide dock icon and main window
        NSApplication.shared.setActivationPolicy(.accessory)
    }
    
    @objc func togglePopover() {
        guard let button = statusItem?.button else { return }
        
        if let popover = popover {
            if popover.isShown {
                popover.performClose(nil)
            } else {
                // Refresh data before showing
                powerMonitor.fetchAssertions()
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
    
    @objc func showPopoverFromNotification() {
        guard let button = statusItem?.button else { return }
        guard let popover = popover, !popover.isShown else { return }
        
        // Refresh data before showing
        powerMonitor.fetchAssertions()
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
    }
}
