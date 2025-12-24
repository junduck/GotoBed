//
//  MenuBarView.swift
//  GotoBed
//
//  Created by Junda Li on 24/12/2025.
//

import SwiftUI

struct MenuBarView: View {
    @ObservedObject var powerMonitor: PowerMonitor
    @State private var showSystemDaemons = false

    var userApps: [PowerAssertion] {
        powerMonitor.assertions.filter { !$0.isSystemDaemon }
    }

    var systemDaemons: [PowerAssertion] {
        powerMonitor.assertions.filter { $0.isSystemDaemon }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            if powerMonitor.assertions.isEmpty {
                Text("Nothing preventing sleep")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        // User Apps Section
                        if !userApps.isEmpty {
                            ForEach(userApps) { assertion in
                                AssertionRow(assertion: assertion, powerMonitor: powerMonitor)

                                if assertion.id != userApps.last?.id || !systemDaemons.isEmpty {
                                    Divider()
                                }
                            }
                        }

                        // System Daemons Section (Collapsed by default)
                        if !systemDaemons.isEmpty {
                            Button(action: {
                                showSystemDaemons.toggle()
                            }) {
                                HStack {
                                    Image(
                                        systemName: showSystemDaemons
                                            ? "chevron.down" : "chevron.right"
                                    )
                                    .font(.caption)
                                    Text("System Daemons (\(systemDaemons.count))")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                            }
                            .buttonStyle(.plain)

                            if showSystemDaemons {
                                ForEach(systemDaemons) { assertion in
                                    AssertionRow(assertion: assertion, powerMonitor: powerMonitor)

                                    if assertion.id != systemDaemons.last?.id {
                                        Divider()
                                    }
                                }
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
                .buttonStyle(.borderedProminent)
                .tint(.red)
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

struct AssertionRow: View {
    let assertion: PowerAssertion
    let powerMonitor: PowerMonitor

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Process name header
            HStack {
                HStack(spacing: 4) {
                    if assertion.assertions.contains(where: { $0.blocksRestart }) {
                        Text("🔒")
                            .font(.caption)
                    }
                    if assertion.belongsToCurrentUser {
                        Text(assertion.processName)
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)

                        Button(action: {
                            print(
                                "Quit button tapped for PID: \(assertion.pid), app: \(assertion.processName)"
                            )
                            powerMonitor.quitApp(pid: assertion.pid)
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                                .imageScale(.medium)
                        }
                        .buttonStyle(.borderless)
                        .help("Quit \(assertion.processName)")
                    } else {
                        Text(assertion.processName)
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                    }
                }
                Spacer()
                Text("PID: \(assertion.pid)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            // Assertions list
            ForEach(assertion.assertions) { detail in
                HStack(alignment: .top, spacing: 8) {
                    Text("•")
                        .foregroundColor(.secondary)
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Text(powerMonitor.getAssertionDescription(detail.assertType))
                                .font(.caption)
                                .foregroundColor(.orange)
                            Spacer()
                            Text("⏱️ \(powerMonitor.getDuration(from: detail.startTime))")
                                .font(.caption)
                                .foregroundColor(.blue)
                                .fontWeight(.medium)
                        }
                        Text(detail.assertName)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                }
                .padding(.leading, 8)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .onTapGesture {
            if assertion.belongsToCurrentUser {
                powerMonitor.activateApp(pid: assertion.pid)
            }
        }
        .help(
            assertion.belongsToCurrentUser ? "Click to switch to \(assertion.processName)" : "")
    }
}
