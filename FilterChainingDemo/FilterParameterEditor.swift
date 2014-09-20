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
            if let filter = userDefinedFilter.filter
            {
                numDials = filter.parameterCount
            }
            else
            {
                numDials = 0
            }
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
            if let udf = userDefinedFilter
            {
                if let udfFilter = udf.filter
                {
                    let dial = NumericDial(frame: CGRectZero)
                    
                    dial.currentValue = udf.values![i]
                    dial.title = udfFilter.parameterNames[i]
                    
                    dial.addTarget(self, action: "dialChangeHandler:", forControlEvents: .ValueChanged)
                    
                    numericDials.append(dial)
                    
                    addSubview(dial)
                }
            }
        }
        
        setNeedsLayout()
    }
    
    func dialChangeHandler(numericDial : NumericDial)
    {
        for (i : Int, dial : NumericDial) in enumerate(numericDials)
        {
            if dial == numericDial
            {                
                userDefinedFilter.values![i] = dial.currentValue
            }
        }
        
        sendActionsForControlEvents(.ValueChanged)
    }
    
    override func layoutSubviews()
    {
        layer.borderColor = UIColor.blueColor().CGColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        
        let startX = Int(frame.size.width) - numericDials.count * 160
        
        for (index : Int, dial : NumericDial) in enumerate(numericDials)
        {
            dial.frame = CGRect(x: startX + index * 160, y: 10, width: 150, height: 150)
        }
    }

}
