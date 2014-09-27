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
    let imagePreviewSelected = UIImageView(frame: CGRectZero)
    let imagePreviewFinal = UIImageView(frame: CGRectZero)
    var overlayWidget : WidgetLayer?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        imagePreviewSelected.layer.borderColor = UIColor.blueColor().CGColor
        imagePreviewSelected.layer.borderWidth = 2
        imagePreviewSelected.layer.cornerRadius = 10
        imagePreviewSelected.contentMode = UIViewContentMode.ScaleAspectFit
        
        imagePreviewFinal.layer.borderColor = UIColor.blackColor().CGColor
        imagePreviewFinal.layer.borderWidth = 2
        imagePreviewFinal.layer.cornerRadius = 10
        imagePreviewFinal.contentMode = UIViewContentMode.ScaleAspectFit
        
        addSubview(imagePreviewSelected)
        addSubview(imagePreviewFinal)
        
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    var selectedFilter : UserDefinedFilter! // if this filter has an overlay widget, add it above current image
    {
        didSet
        {
            if let widget = selectedFilter.filter?.overlayWidget
            {
                if overlayWidget != widget
                {
                    overlayWidget = widget
                    layer.addSublayer(widget)
                }
                    
                overlayWidget?.selectedFilter = selectedFilter
                widget.setNeedsDisplay()
            }
            else if let widget = overlayWidget
            {
                overlayWidget?.removeFromSuperlayer()
                overlayWidget = nil
            }
        }
    }
    
    var filteredImages: FilteredImages!
    {
        didSet
        {
            imagePreviewSelected.image = filteredImages.selectedImage
            imagePreviewFinal.image = filteredImages.finalImage
        }
        
    }
    
    override func layoutSubviews()
    {
        if let widget = overlayWidget
        {
            let widgetSide = min(Int(frame.size.width), Int(frame.size.height))
            let halfWidgetSide = widgetSide / 2
            
            widget.frame = CGRect(x: Int(frame.size.width) / 4 - halfWidgetSide, y: Int(frame.size.height) / 2 - halfWidgetSide, width: widgetSide, height: widgetSide)
        }
        
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
