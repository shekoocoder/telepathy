//
//  AppDelegate.swift
//
//  Copyright © 2017 Tokbox, Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private(set) var session: OTAcceleratorSession?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        session = OTAcceleratorSession.init(openTokApiKey: "46188422", sessionId: "2_MX40NjE4ODQyMn5-MTUzNjk3MTc3OTQxNH5wL3QvOU5Qc1hRUXV6aUJQamFaZ0ZLQnV-fg", token: "T1==cGFydG5lcl9pZD00NjE4ODQyMiZzaWc9NDU3OGM5MDA1Yzc2OTM1MDk1NmIyYjEzZDQxYWExODBmYWI4YjlhMjpzZXNzaW9uX2lkPTJfTVg0ME5qRTRPRFF5TW41LU1UVXpOamszTVRjM09UUXhOSDV3TDNRdk9VNVFjMWhSVVhWNmFVSlFhbUZhWjBaTFFuVi1mZyZjcmVhdGVfdGltZT0xNTM2OTcxODAxJm5vbmNlPTAuMDUyNDMyNTk1MTQxMzkwMjA0JnJvbGU9cHVibGlzaGVyJmV4cGlyZV90aW1lPTE1Mzc1NzY2MDAmaW5pdGlhbF9sYXlvdXRfY2xhc3NfbGlzdD0=")
        return true
    }
}

