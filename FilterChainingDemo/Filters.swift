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
        
        Filter(filterName: "Gaussian Blur",
            ciFilterName: "CIGaussianBlur",
            filterParameters: [FilterParameter(parameterName: "Amount", ciParameterName: "inputRadius", defaultValue: 0.5, multiplier: 10)]),
        
        Filter(filterName: "Color Controls",
            ciFilterName: "CIColorControls",
            filterParameters: [
                    FilterParameter(parameterName: "Saturation", ciParameterName: "inputSaturation", defaultValue: 0.75, multiplier: 1),
                    FilterParameter(parameterName: "Brightness", ciParameterName: "inputBrightness", defaultValue: 0.85, multiplier: 1),
                    FilterParameter(parameterName: "Contrast", ciParameterName: "inputContrast", defaultValue: 0.95, multiplier: 1)
            ])

        // Filter(filterName: "Color Invert", ciFilterName:"CIColorInvert", , parameterNames : [])
    ]
}

struct FilterParameter
{
    var parameterName: String
    var ciParameterName: String
    var multiplier: Int
    var defaultValue: Double
    
    init(parameterName: String, ciParameterName: String, defaultValue: Double, multiplier: Int)
    {
        self.parameterName = parameterName
        self.ciParameterName = ciParameterName
        self.defaultValue = defaultValue
        self.multiplier = multiplier
    }
}