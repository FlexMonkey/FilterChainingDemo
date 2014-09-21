//
//  FilteredImages.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 21/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation
import UIKit

struct FilteredImages
{
    let selectedImage: UIImage
    let finalImage: UIImage
    
    init(selectedImage: UIImage, finalImage: UIImage)
    {
        self.selectedImage = selectedImage
        self.finalImage = finalImage
    }
}