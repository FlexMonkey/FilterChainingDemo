//
//  FiltersCollectionViewCell.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 16/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit

class FiltersCollectionViewCell: UICollectionViewCell
{
    private var label : UILabel = UILabel(frame: CGRectZero)
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
            
        
        label = UILabel(frame: CGRectZero)
        label.numberOfLines = 0
        label.frame = bounds.rectByInsetting(dx: 0, dy: 0)
        label.textAlignment = NSTextAlignment.Center
        
        contentView.addSubview(label)
        
        updateUI()
    }
    
    override var selected: Bool
    {
        didSet
        {
            updateUI()
        }
    }

    func updateUI()
    {
        label.textColor = selected ? UIColor.blueColor() : UIColor.lightGrayColor()
        
        backgroundColor = UIColor.whiteColor() 
        
        if let userDefinedFilterConst = userDefinedFilter
        {
            layer.borderWidth = 2
            layer.cornerRadius = (userDefinedFilterConst.isImageInputNode || userDefinedFilterConst.isImageOutputNode) ? frame.width / 2 : 10
            layer.borderColor = userDefinedFilterConst.isImageOutputNode ? UIColor.blackColor().CGColor : selected ? UIColor.blueColor().CGColor : UIColor.lightGrayColor().CGColor
        }
    }
    
    var userDefinedFilter : UserDefinedFilter!
    {
        didSet
        {
            if let filter = userDefinedFilter.filter
            {
                label.text = filter.filterName
            }
            else
            {
                label.text = userDefinedFilter.isImageInputNode ? "Image Input" : "Image Output"
            }
            
            updateUI()
        }
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}
