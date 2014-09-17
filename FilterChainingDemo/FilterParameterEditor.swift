//
//  FilterParameterEditor.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 17/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit

class FilterParameterEditor: UIControl
{
    var numericDials = [NumericDial]()

    var numDials : Int = 0
    {
        didSet
        {
            createDials()
        }
    }
    
    func createDials()
    {
        for dial in numericDials
        {
            dial.removeFromSuperview()
        }
        numericDials = [NumericDial]()
        
        
        for i in 0 ..< numDials
        {
            let dial = NumericDial(frame: CGRectZero)
            
            // dial.addTarget(self, action: "sliderChangeHandler:", forControlEvents: .ValueChanged)
            
            numericDials.append(dial)
            
            addSubview(dial)
        }
        
        setNeedsLayout()
    }
    
    override func layoutSubviews()
    {
        for (index : Int, dial : NumericDial) in enumerate(numericDials)
        {
            dial.frame = CGRect(x: index * 160, y: 10, width: 150, height: 150)
        }
    }

}
