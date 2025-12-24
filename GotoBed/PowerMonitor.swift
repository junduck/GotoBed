//
//  PowerMonitor.swift
//  GotoBed
//
//  Created by Junda Li on 24/12/2025.
//

import Foundation
import Combine
import IOKit.pwr_mgt

struct PowerAssertion: Identifiable {
    let id = UUID()
    let processName: String
    let pid: Int
    let assertName: String
    let assertType: String
    let startTime: Date?
}

class PowerMonitor: ObservableObject {
    @Published var assertions: [PowerAssertion] = []
    
    func fetchAssertions() {
        var assertionsDict: Unmanaged<CFDictionary>?
        let result = IOPMCopyAssertionsByProcess(&assertionsDict)
        
        guard result == kIOReturnSuccess,
              let dict = assertionsDict?.takeRetainedValue() as? [Int: [[String: Any]]] else {
            print("Failed to get power assertions")
            self.assertions = []
            return
        }
        
        var newAssertions: [PowerAssertion] = []
        
        for (pid, assertionsList) in dict {
            for assertion in assertionsList {
                guard let processName = assertion["Process Name"] as? String,
                      let assertName = assertion["AssertName"] as? String,
                      let assertType = assertion["AssertType"] as? String else {
                    continue
                }
                
                // Filter out system processes that are not interesting
                if processName == "WindowServer" || 
                   processName == "powerd" ||
                   assertType == "UserIsActive" ||
                   assertType == "ExternalMedia" {
                    continue
                }
                
                let startTime = assertion["AssertStartWhen"] as? Date
                
                let powerAssertion = PowerAssertion(
                    processName: processName,
                    pid: pid,
                    assertName: assertName,
                    assertType: assertType,
                    startTime: startTime
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
}
