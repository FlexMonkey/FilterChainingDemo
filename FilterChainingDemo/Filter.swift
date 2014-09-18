//
//  Filter.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 18/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation

class Filter
{
    // var ciFilter : CIFilter!
    
    var filterName: String!
    var parameterCount : Int!
    
    init(filterName: String, parameterCount: Int)
    {
        self.filterName = filterName
        self.parameterCount = parameterCount
    }
}