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
        label.textColor = selected ? UIColor.whiteColor() : UIColor.darkGrayColor()
        
        backgroundColor = selected ? UIColor.blueColor() : UIColor.lightGrayColor()
        
        layer.borderWidth = 2
        layer.cornerRadius = frame.width / 2
        layer.borderColor = selected ? UIColor.blueColor().CGColor : UIColor.darkGrayColor().CGColor
    }
    
    var userDefinedFilter : UserDefinedFilter!
    {
        didSet
        {
            label.text = userDefinedFilter.filter.filterName
        }
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}
