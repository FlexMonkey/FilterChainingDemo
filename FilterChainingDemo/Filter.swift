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
    var parameterNames : [String]!
    
    init(filterName: String, parameterCount: Int, parameterNames : [String])
    {
        self.filterName = filterName
        self.parameterCount = parameterCount
        self.parameterNames = parameterNames
    }
}