//
//  FilteringDelegate.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 21/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation
import UIKit

class FilteringDelegate
{
    let ciContext = CIContext(options: nil)
    let controller: UIViewController
    var filteredImages: FilteredImages!
    
    private var callbackFunction: ((FilteredImages) -> (Void))!
    
    init(controller: UIViewController)
    {
        self.controller = controller
    }
    
    func applyFilters(userDefinedFilters: [UserDefinedFilter], selectedUserDefinedFilter: UserDefinedFilter, callbackFunction : ((FilteredImages) -> (Void)) )
    {
        self.callbackFunction = callbackFunction
        
        var selectedImage:UIImage!
        var finalImage:UIImage!
        
        if let img = userDefinedFilters[0].inputImage
        {
            var inputImage: CIImage!

            for (index: Int, userDefinedFilter: UserDefinedFilter) in enumerate(userDefinedFilters)
            {
                if(index == 0)
                {
                    inputImage = CIImage(image: img)
                    
                    selectedImage = img
                }
                else if let userDefinedFilterFilter = userDefinedFilter.filter
                {
                    let ciFilter = userDefinedFilterFilter.ciFilter
                    
                    ciFilter.setValue(inputImage, forKey: kCIInputImageKey)
                    
                    for (parameterIndex : Int, parameter : FilterParameter) in enumerate(userDefinedFilterFilter.filterParameters)
                    {
                        let paramValue = userDefinedFilter.values![parameterIndex] * Double(parameter.multiplier)
                        
                        ciFilter.setValue(paramValue, forKey: parameter.ciParameterName)
                    }
                    
                    let filteredImageData = ciFilter.valueForKey(kCIOutputImageKey) as CIImage
                    let filteredImageRef = ciContext.createCGImage(filteredImageData, fromRect: filteredImageData.extent())
                    
                    inputImage = filteredImageData
                    
                    let filteredImage = UIImage(CGImage: filteredImageRef)
                    
                    if userDefinedFilter == selectedUserDefinedFilter
                    {
                        selectedImage = filteredImage
                    }
                    
                    finalImage = filteredImage
                }
            }
        }
        
        filteredImages = FilteredImages(selectedImage: selectedImage, finalImage: finalImage)
        callbackFunction(filteredImages)
    }
    
}
