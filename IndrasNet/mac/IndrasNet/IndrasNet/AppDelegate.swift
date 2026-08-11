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
    @IBOutlet var angularDivisionLabel: NSTextField!

    @IBOutlet var centerOpeningSlider: NSSlider!
    @IBOutlet var centerOpeningLabel: NSTextField!

    @IBOutlet var diamondSizeSlider: NSSlider!
    @IBOutlet var diamondSizeLabel: NSTextField!

    @IBOutlet var diamondSpaceSlider: NSSlider!
    @IBOutlet var diamondSpaceLabel: NSTextField!

    @IBOutlet var diamondGrowthSlider: NSSlider!
    @IBOutlet var diamondGrowthLabel: NSTextField!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        indraView.angularDivisions = angularDivisionSlider.integerValue
        indraView.centerOpening = Unit(centerOpeningSlider.integerValue)
        indraView.diamondSize = Unit(diamondSizeSlider.doubleValue)
        indraView.diamondSpace = Unit(diamondSpaceSlider.doubleValue)
        indraView.diamondGrowth = Unit(diamondGrowthSlider.doubleValue)

        updateUI()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

// UI Nonsense
extension AppDelegate {
    func updateUI() {
        angularDivisionLabel.stringValue = "\(indraView.angularDivisions)"
        
        centerOpeningLabel.stringValue = "\(indraView.centerOpening)"
        diamondSizeLabel.stringValue = "\(indraView.diamondSize)"
        diamondSpaceLabel.stringValue = "\(indraView.diamondSpace)"
        diamondGrowthLabel.stringValue = "\(indraView.diamondGrowth)"
    }

    @IBAction func handleAngularDivisionSlider(_ sender: NSSlider) {
        indraView.angularDivisions = sender.integerValue
        updateUI()
    }

    @IBAction func handleCenterOpeningSlider(_ sender: NSSlider) {
        indraView.centerOpening = Unit(sender.integerValue)
        updateUI()
    }

    @IBAction func handleDiamondSizeSlider(_ sender: NSSlider) {
        indraView.diamondSize = Unit(sender.doubleValue)
        updateUI()
    }

    @IBAction func handleDiamondSpaceSlider(_ sender: NSSlider) {
        indraView.diamondSpace = Unit(sender.doubleValue)
        updateUI()
    }

    @IBAction func handleDiamondGrowthSlider(_ sender: NSSlider) {
        indraView.diamondGrowth = Unit(sender.doubleValue)
        updateUI()
    }
}

