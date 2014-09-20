//
//  Filters.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 20/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation

struct Filters
{
    static let filters = [
        Filter(filterName: "Gaussian Blur", ciFilterName: "CIGaussianBlur", parameterCount: 1, parameterNames : ["Amount"]),
        Filter(filterName: "Color Controls", ciFilterName:"CIColorControls", parameterCount: 3, parameterNames : ["Saturation", "Brightness", "Contrast"])
    ]
}