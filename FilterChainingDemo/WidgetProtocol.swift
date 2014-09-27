//
//  WidgetProtocol.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 27/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation
import UIKit

class WidgetLayer: CALayer
{
    var selectedFilter : UserDefinedFilter?
    {
        didSet
        {
            needsDisplay()
        }
    }
}


