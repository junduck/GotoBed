//
//  PowerMonitor.swift
//  GotoBed
//
//  Created by Junda Li on 24/12/2025.
//

import AppKit
import Combine
import Foundation
import IOKit.pwr_mgt

struct AssertionDetail: Identifiable {
    let id = UUID()
    let assertName: String
    let assertType: String
    let startTime: Date?
    let blocksRestart: Bool
}

struct PowerAssertion: Identifiable {
    let id = UUID()
    let processName: String
    let pid: Int
    let belongsToCurrentUser: Bool
    let isSystemDaemon: Bool
    let assertions: [AssertionDetail]
}

class PowerMonitor: ObservableObject {
    @Published var assertions: [PowerAssertion] = []

    private func pidBelongsToCurrentUser(_ pid: Int) -> Bool {
        let currentUID = getuid()
        var info = proc_bsdinfo()
        let size = MemoryLayout<proc_bsdinfo>.size
        let result = proc_pidinfo(Int32(pid), PROC_PIDTBSDINFO, 0, &info, Int32(size))

        if result == size {
            return info.pbi_uid == currentUID
        }
        return false
    }

    private func isSystemDaemon(_ pid: Int, processName: String) -> Bool {
        // Check if it's a system daemon by bundle path
        let runningApps = NSWorkspace.shared.runningApplications
        if let app = runningApps.first(where: { $0.processIdentifier == pid_t(pid) }) {
            if let bundleURL = app.bundleURL {
                let path = bundleURL.path
                // System locations
                if path.hasPrefix("/System/") || path.hasPrefix("/usr/libexec/")
                    || path.hasPrefix("/usr/sbin/")
                {
                    return true
                }
            }
            // Check activation policy - daemons are usually UIElement or Prohibited
            if app.activationPolicy == .prohibited || app.activationPolicy == .accessory {
                return true
            }
        }

        // Fallback: common daemon naming pattern (ends with 'd')
        if processName.hasSuffix("d") && processName.count > 1 {
            return true
        }

        return false
    }

    func fetchAssertions() {
        var assertionsDict: Unmanaged<CFDictionary>?
        let result = IOPMCopyAssertionsByProcess(&assertionsDict)

        guard result == kIOReturnSuccess,
            let dict = assertionsDict?.takeRetainedValue() as? [Int: [[String: Any]]]
        else {
            print("Failed to get power assertions")
            self.assertions = []
            return
        }

        var newAssertions: [PowerAssertion] = []

        for (pid, assertionsList) in dict {
            var processName: String?
            var assertionDetails: [AssertionDetail] = []

            for assertion in assertionsList {
                guard let name = assertion["Process Name"] as? String,
                    let assertName = assertion["AssertName"] as? String,
                    let assertType = assertion["AssertType"] as? String
                else {
                    continue
                }

                // Set process name from first assertion
                if processName == nil {
                    processName = name
                }

                // Filter out system processes that are not interesting
                if name == "WindowServer" || name == "powerd" || assertType == "UserIsActive"
                    || assertType == "ExternalMedia"
                {
                    continue
                }

                let startTime = assertion["AssertStartWhen"] as? Date
                let allowsRestart = assertion["AllowsDeviceRestart"] as? Int ?? 1
                let blocksRestart = allowsRestart == 0

                let detail = AssertionDetail(
                    assertName: assertName,
                    assertType: assertType,
                    startTime: startTime,
                    blocksRestart: blocksRestart
                )

                assertionDetails.append(detail)
            }

            // Only add if we have assertions after filtering
            if !assertionDetails.isEmpty, let processName = processName {
                let powerAssertion = PowerAssertion(
                    processName: processName,
                    pid: pid,
                    belongsToCurrentUser: pidBelongsToCurrentUser(pid),
                    isSystemDaemon: isSystemDaemon(pid, processName: processName),
                    assertions: assertionDetails
                )
                newAssertions.append(powerAssertion)
            }
        }

        self.assertions = newAssertions.sorted { $0.processName < $1.processName }
    }

    func getAssertionDescription(_ type: String) -> String {
        switch type {
        case "NoIdleSleepAssertion":
            return "Preventing sleep"
        case "PreventUserIdleSystemSleep":
            return "Preventing idle sleep"
        case "NoDisplaySleepAssertion":
            return "Keeping display on"
        case "PreventUserIdleDisplaySleep":
            return "Preventing display sleep"
        default:
            return "Active assertion"
        }
    }

    func activateApp(pid: Int) {
        let runningApps = NSWorkspace.shared.runningApplications
        if let app = runningApps.first(where: { $0.processIdentifier == pid_t(pid) }) {
            app.activate(options: [])
        }
    }

    func getDuration(from startTime: Date?) -> String {
        guard let startDate = startTime else {
            return "Unknown"
        }

        let now = Date()
        let interval = now.timeIntervalSince(startDate)

        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60

        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else if minutes > 0 {
            return "\(minutes)m \(seconds)s"
        } else {
            return "\(seconds)s"
        }
    }

    func quitApp(pid: Int) {
        let runningApps = NSWorkspace.shared.runningApplications
        if let app = runningApps.first(where: { $0.processIdentifier == pid_t(pid) }) {
            app.terminate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.fetchAssertions()
            }
        }
    }

    func sleepNow() {
        let connection = IOPMFindPowerManagement(mach_port_t(MACH_PORT_NULL))
        if connection != 0 {
            IOPMSleepSystem(connection)
            IOServiceClose(connection)
        }
    }
}
