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
    var filtersRuning: Bool = false;
    var changePending: Bool = false;
    var backgroundBlock : Async?
    
    private var callbackFunction: ((FilteredImages) -> (Void))!
    
    init(controller: UIViewController)
    {
        self.controller = controller
    }

    func killBackgroundFiltering()
    {
        backgroundBlock?.cancel()
        backgroundBlock = nil
        
        filtersRuning = false
    }

    func applyFilters(userDefinedFilters: [UserDefinedFilter], selectedUserDefinedFilter: UserDefinedFilter, callbackFunction : ((FilteredImages) -> (Void)) )
    {
        if !self.filtersRuning
        {
            backgroundBlock = Async.background
            {
                self.filtersRuning = true
                self.callbackFunction = callbackFunction
                self.filteredImages = FilteringDelegate.applyFilterAsync(userDefinedFilters, selectedUserDefinedFilter: selectedUserDefinedFilter, context: self.ciContext)
                
            }
            .main
            {
                self.filtersRuning = false
                self.callbackFunction(self.filteredImages)
                
                if self.changePending
                {
                    self.changePending = false
                    self.applyFilters(userDefinedFilters, selectedUserDefinedFilter: selectedUserDefinedFilter, callbackFunction: callbackFunction)
                }
            }
        }
        else
        {
            changePending = true
        }
    }
    
    class func applyFilterAsync(userDefinedFilters: [UserDefinedFilter], selectedUserDefinedFilter: UserDefinedFilter, context : CIContext) -> FilteredImages
    {
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
                    
                    finalImage = img
                    selectedImage = img
                }
                else if let userDefinedFilterFilter = userDefinedFilter.filter
                {
                    let ciFilter = userDefinedFilterFilter.ciFilter
                    
                    ciFilter.setValue(inputImage, forKey: kCIInputImageKey)
                    
                    for (parameterIndex : Int, parameter : FilterParameter) in enumerate(userDefinedFilterFilter.filterParameters)
                    {
                        let paramValue = userDefinedFilter.values![parameterIndex] * Double(parameter.multiplier)
                        
                        if let valueFunction = userDefinedFilter.filter?.getValue
                        {
                            ciFilter.setValue(valueFunction(parameterIndex, paramValue), forKey: parameter.ciParameterName)
                            
                            println("get value \(valueFunction(parameterIndex, paramValue)) -- \(parameter.ciParameterName)")
                        }
                        else
                        {
                            ciFilter.setValue(paramValue, forKey: parameter.ciParameterName)
                        }
                    }
                    
                    let filteredImageData = ciFilter.valueForKey(kCIOutputImageKey) as! CIImage
                    
                    inputImage = filteredImageData

                    if userDefinedFilter == selectedUserDefinedFilter || index == userDefinedFilters.count - 2
                    {
                        let filteredImageRef = context.createCGImage(filteredImageData, fromRect: filteredImageData.extent())
                        let filteredImage = UIImage(CGImage: filteredImageRef)
                        
                        if userDefinedFilter == selectedUserDefinedFilter
                        {
                            selectedImage = filteredImage
                        }
                        
                        if (index == userDefinedFilters.count - 2)
                        {
                            finalImage = filteredImage
                        }
                    }
                }
            }
        }
        else
        {
            selectedImage = UIImage()
            finalImage = UIImage()
        }
        
        return FilteredImages(selectedImage: selectedImage, finalImage: finalImage)
    }
    
}
