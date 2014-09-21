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
    
    func applyFilters(userDefinedFilters: [UserDefinedFilter], callbackFunction : ((FilteredImages) -> (Void)) )
    {
        self.callbackFunction = callbackFunction
        
        for userDefinedFilter in userDefinedFilters
        {
            if let img = userDefinedFilter.inputImage
            {
               filteredImages = FilteredImages(selectedImage: img, finalImage: img)
            }
        }
        
        callbackFunction(filteredImages)
    }
}
