//
//  ImagePreview.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 17/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit

class ImagePreview: UIControl
{
    let imagePreviewSelected = UIControl(frame: CGRectZero)
    let imagePreviewFinal = UIControl(frame: CGRectZero)
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        imagePreviewSelected.backgroundColor = UIColor.redColor()
        imagePreviewFinal.backgroundColor = UIColor.blueColor()
        
        addSubview(imagePreviewSelected)
        addSubview(imagePreviewFinal)
        
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews()
    {
        println("\(frame.size.width) x \(frame.size.height)")
        
        if frame.size.width < frame.size.height
        {
            // portrait mode
            let widgetWidth = Int(frame.size.width)
            let widgetHeight = Int(frame.size.height) / 2
            
            imagePreviewSelected.frame = CGRect(x: 5, y: 0, width: widgetWidth - 10, height: widgetHeight)
            imagePreviewFinal.frame = CGRect(x: 0, y: widgetHeight, width: widgetWidth, height: widgetHeight)
        }
        else
        {
            // landscape mode
            let widgetWidth = Int(frame.size.width) / 2
            let widgetHeight = Int(frame.size.height)
            
            imagePreviewSelected.frame = CGRect(x: widgetWidth, y: 0, width: widgetWidth - 5, height: widgetHeight)
            imagePreviewFinal.frame = CGRect(x: 0, y: 0, width: widgetWidth, height: widgetHeight - 50)
        }
    }

}
