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

        let size = size / 2.0

        path.move(to: CGPoint(x: anchor * unitScale,
                              y: 0.0))
        path.addLine(to: CGPoint(x: (anchor + size) * unitScale,
                                 y: size * unitScale))
        path.addLine(to: CGPoint(x: (anchor + size * 2) * unitScale,
                                 y: 0.0))
        path.addLine(to: CGPoint(x: (anchor + size) * unitScale,
                                 y: -size * unitScale))
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
        let openingOffset = centerOpening

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
            let xFudgeFactor = i.isMultiple(of: 2) ? 0 : 0.5 * diamondSize
            
            // now draw a guide line along the X axis
            let path = CGMutablePath()
            path.move(to: CGPoint(x: (openingOffset - xFudgeFactor) * unitScale,
                                  y: 0.0 * unitScale))
            path.addLine(to: CGPoint(x: 5000.0 * unitScale,
                                     y: 0.0 * unitScale))
                  
            context.addPath(path)
            context.strokePath()

            var anchor: CGFloat = openingOffset - xFudgeFactor
            var scaledDiamondSize = diamondSize
            var scaledDiamondSpace = diamondSpace

            for d in 0 ..< 2 {
                drawDiamond(size: scaledDiamondSize, anchor: anchor)

                scaledDiamondSize *= diamondGrowth
                scaledDiamondSpace *= diamondGrowth

                anchor += scaledDiamondSize + scaledDiamondSpace
            }
        }

        let circleRect = CGRect(x: center.x - openingOffset * unitScale,
                                y: center.y - openingOffset * unitScale,
                                width: openingOffset * unitScale * 2,
                                height: openingOffset * unitScale * 2)
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

