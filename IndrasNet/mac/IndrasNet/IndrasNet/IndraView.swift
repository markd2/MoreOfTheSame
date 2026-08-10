// IndraView.swift - NSView with the thing that draws

import AppKit

class IntraView: NSView {
    
    override func draw (_ rect: CGRect) {
        NSColor.white.set()
        bounds.fill()

        NSColor.black.set()
        bounds.frame()
    }
}

