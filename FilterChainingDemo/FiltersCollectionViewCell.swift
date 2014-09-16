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
    var label : UILabel = UILabel(frame: CGRectZero)
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        contentView.addSubview(label)
    }

    func setLabel(value : String)
    {
        label.text = value
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}
