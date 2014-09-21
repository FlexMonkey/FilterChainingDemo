//
//  UserDefinedFilter.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 18/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation
import UIKit

class UserDefinedFilter
{
    let uuid = NSUUID.UUID().UUIDString
    
    var values: [Double]?
    
    var isImageInputNode: Bool = false
    var isImageOutputNode: Bool = false
    
    var inputImage: UIImage?
    
    init(isImageInputNode: Bool, isImageOutputNode: Bool)
    {
        self.isImageInputNode = isImageInputNode
        self.isImageOutputNode = isImageOutputNode
    }
    
    init(filter: Filter)
    {
        self.filter = filter
        
        setValuesFromFilter()
    }
    
    var filter: Filter?
    {
        didSet
        {
            setValuesFromFilter()
        }
    }
    
    func setValuesFromFilter()
    {
        values = [Double]()
        
        for filterParameter in filter!.filterParameters
        {
            values?.append(filterParameter.defaultValue)
        }
    }
}

    func == (left: UserDefinedFilter, right: UserDefinedFilter) -> Bool
    {
        return left.uuid == right.uuid
    }
