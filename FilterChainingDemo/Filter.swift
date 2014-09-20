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
    
    var filterName: String
    var parameterCount : Int
    var parameterNames : [String]
    var ciFilterName: String
    
    init(filterName: String, ciFilterName: String, parameterCount: Int, parameterNames : [String])
    {
        self.filterName = filterName
        self.ciFilterName = ciFilterName
        self.parameterCount = parameterCount
        self.parameterNames = parameterNames
    }
}