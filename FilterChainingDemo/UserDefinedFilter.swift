//
//  UserDefinedFilter.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 18/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation
import UIKit

class UserDefinedFilter
{
    var values: [Double]?
    
    var isImageInputNode: Bool = false
    var isImageOutputNode: Bool = false
    
    var inputImage: UIImage?
    
    init(isImageInputNode: Bool, isImageOutputNode: Bool)
    {
        self.isImageInputNode = isImageInputNode
        self.isImageOutputNode = isImageOutputNode
    }
    
    init(filter: Filter)
    {
        self.filter = filter
        
        values = [Double](count: filter.parameterCount, repeatedValue: 0.0)
    }
    
    var filter: Filter?
    {
        didSet
        {
            values = [Double](count: filter!.parameterCount, repeatedValue: 0.0) // should be defaults
        }
    }
}
