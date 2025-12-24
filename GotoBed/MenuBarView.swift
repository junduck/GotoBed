//
//  MenuBarView.swift
//  GotoBed
//
//  Created by Junda Li on 24/12/2025.
//

import SwiftUI

struct MenuBarView: View {
    @ObservedObject var powerMonitor: PowerMonitor
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sleep Blockers")
                .font(.headline)
                .padding(.horizontal)
                .padding(.top, 8)
            
            Divider()
            
            if powerMonitor.assertions.isEmpty {
                Text("Nothing preventing sleep")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(powerMonitor.assertions) { assertion in
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(assertion.processName)
                                        .font(.system(.body, design: .rounded))
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text("PID: \(assertion.pid)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                HStack {
                                    Text(powerMonitor.getAssertionDescription(assertion.assertType))
                                        .font(.caption)
                                        .foregroundColor(.orange)
                                    Spacer()
                                    Text("⏱️ \(powerMonitor.getDuration(from: assertion.startTime))")
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                        .fontWeight(.medium)
                                }
                                
                                Text(assertion.assertName)
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            
                            if assertion.id != powerMonitor.assertions.last?.id {
                                Divider()
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
                .frame(maxHeight: 400)
            }
            
            Divider()
            
            HStack {
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
                .keyboardShortcut("q", modifiers: .command)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .frame(minHeight: 150, maxHeight: 500)
        .onAppear {
            powerMonitor.fetchAssertions()
        }
    }
}
