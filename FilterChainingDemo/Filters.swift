//
//  Filters.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 20/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation
import UIKit

struct Filters
{
    static let filters = [
        
        Filter(filterName: "Bloom",
            ciFilterName: "CIBloom",
            filterParameters: [
                FilterParameter(parameterName: "Radius", ciParameterName: "inputRadius", defaultValue: 0.5, multiplier: 20),
                FilterParameter(parameterName: "Intensity", ciParameterName: "inputIntensity", defaultValue: 0.5, multiplier: 2)]),
        
        Filter(filterName: "Color Controls",
            ciFilterName: "CIColorControls",
            filterParameters: [
                    FilterParameter(parameterName: "Saturation", ciParameterName: "inputSaturation", defaultValue: 0.75, multiplier: 2),
                    FilterParameter(parameterName: "Brightness", ciParameterName: "inputBrightness", defaultValue: 0, multiplier: 1),
                    FilterParameter(parameterName: "Contrast", ciParameterName: "inputContrast", defaultValue: 0.5, multiplier: 2)]),
        
        Filter(filterName: "Exposure Adjust",
            ciFilterName: "CIExposureAdjust",
            filterParameters: [FilterParameter(parameterName: "EV", ciParameterName: "inputEV", defaultValue: 0.5, multiplier: 2)]),
        
        Filter(filterName: "Gamma Adjust",
            ciFilterName: "CIGammaAdjust",
            filterParameters: [FilterParameter(parameterName: "Input Power", ciParameterName: "inputPower", defaultValue: 0.5, multiplier: 2)]),
        
        Filter(filterName: "Gaussian Blur",
            ciFilterName: "CIGaussianBlur",
            filterParameters: [FilterParameter(parameterName: "Amount", ciParameterName: "inputRadius", defaultValue: 0.5, multiplier: 10)]),
        
        Filter(filterName: "Gloom",
            ciFilterName: "CIGloom",
            filterParameters: [
                FilterParameter(parameterName: "Radius", ciParameterName: "inputRadius", defaultValue: 0.25, multiplier: 20),
                FilterParameter(parameterName: "Intensity", ciParameterName: "inputIntensity", defaultValue: 0.5, multiplier: 2)]),

        Filter(filterName: "Sharpen Luminance",
            ciFilterName: "CISharpenLuminance",
            filterParameters: [FilterParameter(parameterName: "Sharpness", ciParameterName: "inputSharpness", defaultValue: 0.5, multiplier: 2)]),
        
        Filter(filterName: "Tone Curve",
            ciFilterName: "CIToneCurve",
            filterParameters: [
                FilterParameter(parameterName: "One", ciParameterName: "inputPoint0", defaultValue: 0.0, multiplier: 1),
                FilterParameter(parameterName: "Two", ciParameterName: "inputPoint1", defaultValue: 0.25, multiplier: 1),
                FilterParameter(parameterName: "Three", ciParameterName: "inputPoint2", defaultValue: 0.5, multiplier: 1),
                FilterParameter(parameterName: "Four", ciParameterName: "inputPoint3", defaultValue: 0.75, multiplier: 1),
                FilterParameter(parameterName: "Five", ciParameterName: "inputPoint4", defaultValue: 1.0, multiplier: 1)],
            getValue:
            {
                (index: Int, paramValue: Double) -> AnyObject in
                
                let toneCurveX = [0.0, 0.25, 0.5, 0.75, 1.0][index]
                let toneCurvePoint = CIVector(x: CGFloat(toneCurveX), y: CGFloat(paramValue))
                
                return toneCurvePoint
            }
        ),
        

        
        Filter(filterName: "Unsharp Mask",
            ciFilterName: "CIUnsharpMask",
            filterParameters: [
                FilterParameter(parameterName: "Radius", ciParameterName: "inputRadius", defaultValue: 0.25, multiplier: 20),
                FilterParameter(parameterName: "Intensity", ciParameterName: "inputIntensity", defaultValue: 0.5, multiplier: 2)]),
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