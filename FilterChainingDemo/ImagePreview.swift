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
        
        imagePreviewSelected.layer.borderColor = UIColor.blueColor().CGColor
        imagePreviewSelected.layer.borderWidth = 2
        imagePreviewSelected.layer.cornerRadius = 10
        
        imagePreviewFinal.layer.borderColor = UIColor.blackColor().CGColor
        imagePreviewFinal.layer.borderWidth = 2
        imagePreviewFinal.layer.cornerRadius = 10
        
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
            
            imagePreviewFinal.frame = CGRect(x: 0, y: 0, width: widgetWidth, height: widgetHeight - 5)
            imagePreviewSelected.frame = CGRect(x: 0, y: widgetHeight + 5, width: widgetWidth, height: widgetHeight - 5)
        }
        else
        {
            let widgetWidth = Int(frame.size.width) / 2
            let widgetHeight = Int(frame.size.height)
            
            imagePreviewFinal.frame = CGRect(x: widgetWidth + 5, y: 0, width: widgetWidth - 5, height: widgetHeight)
            imagePreviewSelected.frame = CGRect(x: 0, y: 0, width: widgetWidth - 5, height: widgetHeight)
        }
    }

}
