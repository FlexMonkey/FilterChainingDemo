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
        
        imagePreviewSelected.backgroundColor = UIColor.blueColor()
        imagePreviewFinal.backgroundColor = UIColor.blackColor()
        
        addSubview(imagePreviewSelected)
        addSubview(imagePreviewFinal)
        
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews()
    {
        if UIApplication.sharedApplication().statusBarOrientation.isPortrait
        {
            let widgetWidth = Int(frame.size.width)
            let widgetHeight = Int(frame.size.height) / 2
            
            imagePreviewFinal.frame = CGRect(x: 0, y: 0, width: widgetWidth, height: widgetHeight)
            imagePreviewSelected.frame = CGRect(x: 0, y: widgetHeight, width: widgetWidth, height: widgetHeight)
        }
        else
        {
            let widgetWidth = Int(frame.size.width) / 2
            let widgetHeight = Int(frame.size.height)
            
            imagePreviewFinal.frame = CGRect(x: widgetWidth, y: 0, width: widgetWidth, height: widgetHeight)
            imagePreviewSelected.frame = CGRect(x: 0, y: 0, width: widgetWidth, height: widgetHeight)
        }
    }

}
