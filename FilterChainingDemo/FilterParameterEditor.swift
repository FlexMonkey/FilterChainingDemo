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

    var userDefinedFilter : UserDefinedFilter!
    {
        didSet
        {
            numDials = userDefinedFilter.filter.parameterCount
        }
    }
    
    private var numDials : Int = 0
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
            dial.removeTarget(self, action: "dialChangeHandler:", forControlEvents: .ValueChanged)
            
            dial.removeFromSuperview()
        }
        
        numericDials = [NumericDial]()
        
        
        for i in 0 ..< numDials
        {
            let dial = NumericDial(frame: CGRectZero)
            
            dial.currentValue = userDefinedFilter.values[i]
            dial.title = userDefinedFilter.filter.parameterNames[i]
            
            dial.addTarget(self, action: "dialChangeHandler:", forControlEvents: .ValueChanged)
            
            numericDials.append(dial)
            
            addSubview(dial)
        }
        
        setNeedsLayout()
    }
    
    func dialChangeHandler(numericDial : NumericDial)
    {
        for (i : Int, dial : NumericDial) in enumerate(numericDials)
        {
            if dial == numericDial
            {                
                userDefinedFilter.values[i] = dial.currentValue
            }
        }
        
        sendActionsForControlEvents(.ValueChanged)
    }
    
    override func layoutSubviews()
    {
        backgroundColor = UIColor.blueColor()
        
        for (index : Int, dial : NumericDial) in enumerate(numericDials)
        {
            dial.frame = CGRect(x: index * 160, y: 10, width: 150, height: 150)
        }
    }

}
