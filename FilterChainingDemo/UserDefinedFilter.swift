//
//  UserDefinedFilter.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 18/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation

class UserDefinedFilter
{
    var filter: Filter!
    
    var values: [Double]!
    
    init(filter: Filter)
    {
        self.filter = filter
        
        values = [Double](count: filter.parameterCount, repeatedValue: 0.0)
    }
}
