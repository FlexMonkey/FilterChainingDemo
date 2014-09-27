//
//  ToneCurveEditorCurveLayer.swift
//  ToneCurveEditor
//
//  Created by Simon Gladman on 13/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit
import CoreGraphics

class ToneCurveEditorCurveLayer: WidgetLayer
{
    override func drawInContext(ctx: CGContext!)
    {
        if let curveValues = selectedFilter?.values
        {
            var path = UIBezierPath()
    
            let margin = 20
            let thumbRadius = 15
            let widgetWidth = Int(frame.width)
            let widgetHeight = Int(frame.height) - margin - margin - thumbRadius - thumbRadius

            var interpolationPoints : [CGPoint] = [CGPoint]()
            
            for (i: Int, value: Double) in enumerate(curveValues)
            {
                let pathPointX = i * (widgetWidth / curveValues.count) + (widgetWidth / curveValues.count / 2)
                let pathPointY = thumbRadius + margin + widgetHeight - Int(Double(widgetHeight) * value)
                
                interpolationPoints.append(CGPoint(x: pathPointX,y: pathPointY))
            }
     
            path.interpolatePointsWithHermite(interpolationPoints)
       
            CGContextSetLineJoin(ctx, kCGLineJoinRound)
            
            CGContextAddPath(ctx, path.CGPath)
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextSetStrokeColorWithColor(ctx, UIColor.whiteColor().CGColor)
            CGContextSetLineWidth(ctx, 10)
            CGContextStrokePath(ctx)
            
            CGContextAddPath(ctx, path.CGPath)
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextSetStrokeColorWithColor(ctx, UIColor.blueColor().CGColor)
            CGContextSetLineWidth(ctx, 6)
            CGContextStrokePath(ctx)
        }
    }


    
}
