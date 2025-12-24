Raw CFDictionary from IOPMCopyAssertionsByProcess pid -> obj

```text
{
    54166 =     (
                  {
            AllowsDeviceRestart = 1;
            AssertLevel = 255;
            AssertName = "BaiduNetdisk Transfering File";
            AssertPID = 54166;
            AssertStartWhen = "2025-12-24 00:20:57 +0000";
            AssertType = NoIdleSleepAssertion;
            AssertionId = 33513;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1066672307929833;
            "Process Name" = "BaiduNetdisk_mac";
        }
    );
    486 =     (
                {
            AllowsDeviceRestart = 1;
            AssertLevel = 255;
            AssertName = "com.apple.audio.RMEUSBDevice-130-24078167.context.preventuseridlesleep";
            AssertPID = 486;
            AssertStartWhen = "2025-12-24 01:11:17 +0000";
            AssertType = PreventUserIdleSystemSleep;
            AssertionId = 33737;
            AssertionOnBehalfOfPID = 1177;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1079643109163977;
            "Process Name" = coreaudiod;
            ResourcesUsed =             (
                "audio-in",
                "audio-out",
                "RMEUSBDevice-130-24078167"
            );
        }
    );
    1042 =     (
                {
            AllowsDeviceRestart = 1;
            AssertLevel = 255;
            AssertName = "Playing audio";
            AssertPID = 1042;
            AssertStartWhen = "2025-12-24 01:11:18 +0000";
            AssertType = NoIdleSleepAssertion;
            AssertionId = 34655;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1079647404132191;
            "Process Name" = "Google Chrome";
        },
                {
            AssertLevel = 255;
            AssertName = "Video Wake Lock";
            AssertPID = 1042;
            AssertStartWhen = "2025-12-24 01:11:19 +0000";
            AssertType = NoDisplaySleepAssertion;
            AssertionId = 34656;
            AssertionTrueType = PreventUserIdleDisplaySleep;
            GlobalUniqueID = 1079651699361632;
            "Process Name" = "Google Chrome";
        }
    );
    464 =     (
                {
            AllowsDeviceRestart = 1;
            AssertLevel = 255;
            AssertName = "com.apple.BTStack";
            AssertPID = 464;
            AssertStartWhen = "2025-12-24 01:37:06 +0000";
            AssertType = PreventUserIdleSystemSleep;
            AssertionId = 34847;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1086296013506591;
            "Process Name" = bluetoothd;
        }
    );
    415 =     (
                {
            AssertLevel = 255;
            AssertName = "Powerd - Prevent sleep while display is on";
            AssertPID = 415;
            AssertStartWhen = "2025-12-23 23:38:37 +0000";
            AssertType = PreventUserIdleSystemSleep;
            AssertionId = 33036;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1055763090997516;
            "Process Name" = powerd;
        },
                {
            AssertLevel = 255;
            AssertName = "com.apple.powermanagement.externalmediamounted";
            AssertPID = 415;
            AssertStartWhen = "2025-12-19 22:45:53 +0000";
            AssertType = ExternalMedia;
            AssertionId = 32772;
            AssertionTrueType = ExternalMedia;
            GlobalUniqueID = 1348620288004;
            HumanReadableReason = "An external media device is attached.";
            "Process Name" = powerd;
        }
    );
    472 =     (
                {
            AssertLevel = 255;
            AssertName = "com.apple.iohideventsystem.queue.tickle serviceID:100011f18 service:AppleUserHIDEventService product:MX Master 3 eventType:17";
            AssertPID = 472;
            AssertStartWhen = "2025-12-24 01:37:23 +0000";
            AssertTimeoutTimeLeft = 600;
            AssertTimeoutUpdateTime = "2025-12-24 01:37:23 +0000";
            AssertType = UserIsActive;
            AssertionId = 33385;
            AssertionTrueType = UserIsActive;
            GlobalUniqueID = 1063781795463785;
            "Process Name" = WindowServer;
            TimeoutAction = TimeoutActionRelease;
            TimeoutSeconds = 600;
        }
    );
}
Failed to cast to [String: Any]
=== PowerMonitor Debug ===
IOPMCopyAssertionsByProcess result: 0
Raw CFDictionary: {
    54166 =     (
                {
            AllowsDeviceRestart = 1;
            AssertLevel = 255;
            AssertName = "BaiduNetdisk Transfering File";
            AssertPID = 54166;
            AssertStartWhen = "2025-12-24 00:20:57 +0000";
            AssertType = NoIdleSleepAssertion;
            AssertionId = 33513;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1066672307929833;
            "Process Name" = "BaiduNetdisk_mac";
        }
    );
    486 =     (
                {
            AllowsDeviceRestart = 1;
            AssertLevel = 255;
            AssertName = "com.apple.audio.RMEUSBDevice-130-24078167.context.preventuseridlesleep";
            AssertPID = 486;
            AssertStartWhen = "2025-12-24 01:11:17 +0000";
            AssertType = PreventUserIdleSystemSleep;
            AssertionId = 33737;
            AssertionOnBehalfOfPID = 1177;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1079643109163977;
            "Process Name" = coreaudiod;
            ResourcesUsed =             (
                "audio-in",
                "audio-out",
                "RMEUSBDevice-130-24078167"
            );
        }
    );
    1042 =     (
                {
            AllowsDeviceRestart = 1;
            AssertLevel = 255;
            AssertName = "Playing audio";
            AssertPID = 1042;
            AssertStartWhen = "2025-12-24 01:11:18 +0000";
            AssertType = NoIdleSleepAssertion;
            AssertionId = 34655;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1079647404132191;
            "Process Name" = "Google Chrome";
        },
                {
            AssertLevel = 255;
            AssertName = "Video Wake Lock";
            AssertPID = 1042;
            AssertStartWhen = "2025-12-24 01:11:19 +0000";
            AssertType = NoDisplaySleepAssertion;
            AssertionId = 34656;
            AssertionTrueType = PreventUserIdleDisplaySleep;
            GlobalUniqueID = 1079651699361632;
            "Process Name" = "Google Chrome";
        }
    );
    464 =     (
                {
            AllowsDeviceRestart = 1;
            AssertLevel = 255;
            AssertName = "com.apple.BTStack";
            AssertPID = 464;
            AssertStartWhen = "2025-12-24 01:37:06 +0000";
            AssertType = PreventUserIdleSystemSleep;
            AssertionId = 34847;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1086296013506591;
            "Process Name" = bluetoothd;
        }
    );
    415 =     (
                {
            AssertLevel = 255;
            AssertName = "Powerd - Prevent sleep while display is on";
            AssertPID = 415;
            AssertStartWhen = "2025-12-23 23:38:37 +0000";
            AssertType = PreventUserIdleSystemSleep;
            AssertionId = 33036;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1055763090997516;
            "Process Name" = powerd;
        },
                {
            AssertLevel = 255;
            AssertName = "com.apple.powermanagement.externalmediamounted";
            AssertPID = 415;
            AssertStartWhen = "2025-12-19 22:45:53 +0000";
            AssertType = ExternalMedia;
            AssertionId = 32772;
            AssertionTrueType = ExternalMedia;
            GlobalUniqueID = 1348620288004;
            HumanReadableReason = "An external media device is attached.";
            "Process Name" = powerd;
        }
    );
    472 =     (
                {
            AssertLevel = 255;
            AssertName = "com.apple.iohideventsystem.queue.tickle serviceID:100011f18 service:AppleUserHIDEventService product:MX Master 3 eventType:17";
            AssertPID = 472;
            AssertStartWhen = "2025-12-24 01:37:24 +0000";
            AssertTimeoutTimeLeft = 600;
            AssertTimeoutUpdateTime = "2025-12-24 01:37:24 +0000";
            AssertType = UserIsActive;
            AssertionId = 33385;
            AssertionTrueType = UserIsActive;
            GlobalUniqueID = 1063781795463785;
            "Process Name" = WindowServer;
            TimeoutAction = TimeoutActionRelease;
            TimeoutSeconds = 600;
        }
    );
}
Failed to cast to [String: Any]
=== PowerMonitor Debug ===
IOPMCopyAssertionsByProcess result: 0
Raw CFDictionary: {
    54166 =     (
                {
            AllowsDeviceRestart = 1;
            AssertLevel = 255;
            AssertName = "BaiduNetdisk Transfering File";
            AssertPID = 54166;
            AssertStartWhen = "2025-12-24 00:20:57 +0000";
            AssertType = NoIdleSleepAssertion;
            AssertionId = 33513;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1066672307929833;
            "Process Name" = "BaiduNetdisk_mac";
        }
    );
    486 =     (
                {
            AllowsDeviceRestart = 1;
            AssertLevel = 255;
            AssertName = "com.apple.audio.RMEUSBDevice-130-24078167.context.preventuseridlesleep";
            AssertPID = 486;
            AssertStartWhen = "2025-12-24 01:11:17 +0000";
            AssertType = PreventUserIdleSystemSleep;
            AssertionId = 33737;
            AssertionOnBehalfOfPID = 1177;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1079643109163977;
            "Process Name" = coreaudiod;
            ResourcesUsed =             (
                "audio-in",
                "audio-out",
                "RMEUSBDevice-130-24078167"
            );
        }
    );
    1042 =     (
                {
            AllowsDeviceRestart = 1;
            AssertLevel = 255;
            AssertName = "Playing audio";
            AssertPID = 1042;
            AssertStartWhen = "2025-12-24 01:11:18 +0000";
            AssertType = NoIdleSleepAssertion;
            AssertionId = 34655;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1079647404132191;
            "Process Name" = "Google Chrome";
        },
                {
            AssertLevel = 255;
            AssertName = "Video Wake Lock";
            AssertPID = 1042;
            AssertStartWhen = "2025-12-24 01:11:19 +0000";
            AssertType = NoDisplaySleepAssertion;
            AssertionId = 34656;
            AssertionTrueType = PreventUserIdleDisplaySleep;
            GlobalUniqueID = 1079651699361632;
            "Process Name" = "Google Chrome";
        }
    );
    464 =     (
                {
            AllowsDeviceRestart = 1;
            AssertLevel = 255;
            AssertName = "com.apple.BTStack";
            AssertPID = 464;
            AssertStartWhen = "2025-12-24 01:37:06 +0000";
            AssertType = PreventUserIdleSystemSleep;
            AssertionId = 34847;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1086296013506591;
            "Process Name" = bluetoothd;
        }
    );
    415 =     (
                {
            AssertLevel = 255;
            AssertName = "Powerd - Prevent sleep while display is on";
            AssertPID = 415;
            AssertStartWhen = "2025-12-23 23:38:37 +0000";
            AssertType = PreventUserIdleSystemSleep;
            AssertionId = 33036;
            AssertionTrueType = PreventUserIdleSystemSleep;
            GlobalUniqueID = 1055763090997516;
            "Process Name" = powerd;
        },
                {
            AssertLevel = 255;
            AssertName = "com.apple.powermanagement.externalmediamounted";
            AssertPID = 415;
            AssertStartWhen = "2025-12-19 22:45:53 +0000";
            AssertType = ExternalMedia;
            AssertionId = 32772;
            AssertionTrueType = ExternalMedia;
            GlobalUniqueID = 1348620288004;
            HumanReadableReason = "An external media device is attached.";
            "Process Name" = powerd;
        }
    );
    472 =     (
                {
            AssertLevel = 255;
            AssertName = "com.apple.iohideventsystem.queue.tickle serviceID:100011f18 service:AppleUserHIDEventService product:MX Master 3 eventType:17";
            AssertPID = 472;
            AssertStartWhen = "2025-12-24 01:37:27 +0000";
            AssertTimeoutTimeLeft = 600;
            AssertTimeoutUpdateTime = "2025-12-24 01:37:27 +0000";
            AssertType = UserIsActive;
            AssertionId = 33385;
            AssertionTrueType = UserIsActive;
            GlobalUniqueID = 1063781795463785;
            "Process Name" = WindowServer;
            TimeoutAction = TimeoutActionRelease;
            TimeoutSeconds = 600;
        }
    );
}
```
