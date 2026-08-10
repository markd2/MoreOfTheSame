// IndraView.swift - NSView with the thing that draws

import AppKit
import CoreGraphics

private let π = CGFloat.pi

class IndraView: NSView {
    var angularDivisions: Int = 5 {
        didSet {
            needsDisplay = true
        }
    }

    override var isFlipped : Bool{
        return true
    }
    
    func drawGuidelines() {
        let context = currentContext
        context.saveGState()
        defer { context.restoreGState() }

        NSColor.lightGray.set()

        let center = bounds.center

        let anglePerDivision = 2 * π / CGFloat(angularDivisions)

        for i in 0 ..< angularDivisions {
            // move the world around
            let identity = CGAffineTransform.identity
            let shiftingCenter = identity.translatedBy(x: center.x,
                                                       y: center.y)
            let angle = CGFloat(i) * anglePerDivision
            let rotating = shiftingCenter.rotated(by: angle)
            
            context.saveGState()
            
            context.concatenate(rotating)

            // now draw a line along the X axis
            let path = CGMutablePath()
            path.move(to: CGPoint.zero)
            path.addLine(to: CGPoint(x: 0.0, y: 5000.0))
            
            context.addPath(path)
            context.strokePath()
            
            context.restoreGState()
        }
        
    }
    
    override func draw (_ rect: CGRect) {
        NSColor.white.set()
        bounds.fill()

        drawGuidelines()

        NSColor.black.set()
        bounds.frame()
    }
}

