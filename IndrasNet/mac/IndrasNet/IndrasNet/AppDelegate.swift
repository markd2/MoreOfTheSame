//
//  AppDelegate.swift
//  IndrasNet
//
//  Created by markd on 8/10/26.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!
    @IBOutlet var indraView: IndraView!
    @IBOutlet var angularDivisionSlider: NSSlider!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        indraView.angularDivisions = angularDivisionSlider.integerValue
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

// UI Nonsense
extension AppDelegate {
    @IBAction func handleAngularDivisionSlider(_ sender: NSSlider) {
        indraView.angularDivisions = sender.integerValue
        print("\(sender.intValue)")
    }
}

