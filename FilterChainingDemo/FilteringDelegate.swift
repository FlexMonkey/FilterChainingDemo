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
    
    var filtersRuning : Bool = false;
    var changePending : Bool = false;
    
    func applyFilters(userDefinedFilters: [UserDefinedFilter], selectedUserDefinedFilter: UserDefinedFilter, callbackFunction : ((FilteredImages) -> (Void)) )
    {
        if !self.filtersRuning
        {
            Async.background
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
                        println("changePending!")
                        
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
                    let filteredImageRef = context.createCGImage(filteredImageData, fromRect: filteredImageData.extent())
                    
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
        
        return FilteredImages(selectedImage: selectedImage, finalImage: finalImage)
    }
    
}
