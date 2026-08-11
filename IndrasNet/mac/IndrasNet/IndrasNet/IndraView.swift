// IndraView.swift - NSView with the thing that draws

import AppKit
import CoreGraphics

private let π = CGFloat.pi
typealias Unit = CGFloat

class IndraView: NSView {
    var angularDivisions: Int = 5 {
        didSet { needsDisplay = true }
    }

    var centerOpening: Unit = 5 {
        didSet { needsDisplay = true }
    }

    var diamondSize: Unit = 1 {
        didSet { needsDisplay = true }
    }

    var diamondSpace: Unit = 0.5 {
        didSet { needsDisplay = true }
    }

    var diamondCount: Int = 5 {
        didSet { needsDisplay = true }
    }

    var diamondGrowth: Unit = 1.1 {
        didSet { needsDisplay = true }
    }

    // points per unit
    let unitScale: CGFloat = 10

    override var isFlipped : Bool{
        return true
    }

    func drawDiamond(size: Unit, anchor: Unit) {
        let context = currentContext

        context.saveGState()
        defer { context.restoreGState() }

        NSColor.orange.set()
        
        let path = CGMutablePath()

        let size = (size / 2.0) * unitScale

        path.move(to: CGPoint(x: anchor, y: 0.0))
        path.addLine(to: CGPoint(x: anchor + size, y: size))
        path.addLine(to: CGPoint(x: anchor + size * 2.0, y: 0.0))
        path.addLine(to: CGPoint(x: anchor + size, y: -size))
        path.closeSubpath()

        context.addPath(path)
        context.strokePath()
    }
    
    func drawNet() {
        let context = currentContext
        context.saveGState()
        defer { context.restoreGState() }

        NSColor.lightGray.set()

        let center = bounds.center
        let openingOffset = centerOpening * unitScale

        let anglePerDivision = 2 * π / CGFloat(angularDivisions)

        for i in 0 ..< angularDivisions {
            context.saveGState()
            defer { context.restoreGState() }

            // move the world around
            let identity = CGAffineTransform.identity
            let shiftingCenter = identity.translatedBy(x: center.x,
                                                       y: center.y)
            let angle = CGFloat(i) * anglePerDivision
            let rotating = shiftingCenter.rotated(by: angle)
            
            context.concatenate(rotating)
            let xfudgeFactor = i.isMultiple(of: 2) ? 0 : 0.5 * unitScale * diamondSize
            
            // now draw a line along the X axis
            let path = CGMutablePath()
            path.move(to: CGPoint(x: openingOffset - xfudgeFactor, y: 0.0))
            path.addLine(to: CGPoint(x: 5000.0, y: 0.0))
                  
            context.addPath(path)
            context.strokePath()

            for d in 0 ..< diamondCount {
                let floatD = CGFloat(d) // #ILYS
                
                var anchor = openingOffset + floatD * diamondSize * unitScale
                anchor += floatD * diamondSpace * unitScale * diamondGrowth

                anchor -= xfudgeFactor
                drawDiamond(size: diamondSize + floatD * diamondGrowth * unitScale,
                            anchor: anchor)
            }
        }

        let circleRect = CGRect(x: center.x - openingOffset,
                                y: center.y - openingOffset,
                                width: openingOffset * 2,
                                height: openingOffset * 2)
        context.strokeEllipse(in: circleRect)
    }
    
    override func draw (_ rect: CGRect) {
        NSColor.white.set()
        bounds.fill()

        drawNet()

        NSColor.black.set()
        bounds.frame()
    }
}

