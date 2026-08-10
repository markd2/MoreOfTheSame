// NSView+CGStuff.swift -- core graphics utilities on NSView

import Cocoa

extension NSView {
    var currentContext: CGContext {
        let context = NSGraphicsContext.current
        return context!.cgContext
    }
}
