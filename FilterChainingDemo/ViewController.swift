//
//  ViewController.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 16/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let filters = [Filter(filterName: "Blur", parameterCount: 1), Filter(filterName: "Brightness & Contrast", parameterCount: 2)]
    
    var userDefinedFilters: [UserDefinedFilter]!
    
    let filtersCollectionView = FiltersCollectionView(frame: CGRectZero)
    let filterParameterEditor = FilterParameterEditor(frame: CGRectZero)
    let imagePreview = ImagePreview(frame: CGRectZero)
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        userDefinedFilters = [UserDefinedFilter(filter: filters[0]), UserDefinedFilter(filter: filters[1])]
        filtersCollectionView.userDefinedFilters = userDefinedFilters
        filtersCollectionView.addTarget(self, action: "filtersCollectionViewChangeHandler:", forControlEvents: .ValueChanged)
        
        filterParameterEditor.backgroundColor = UIColor.lightGrayColor()
        imagePreview.backgroundColor = UIColor.blackColor()
        
        view.addSubview(filtersCollectionView)
        view.addSubview(filterParameterEditor)
        view.addSubview(imagePreview)
        
        filterParameterEditor.numDials = 3; 
    }

    func filtersCollectionViewChangeHandler(value: FiltersCollectionView)
    {
        println("--- \(value.selectedFilter.filter.filterName)")
        
        filterParameterEditor.numDials = value.selectedFilter.filter.parameterCount
    }
    
    override func viewDidLayoutSubviews()
    {
        let widgetWidth = Int(view.frame.width) - 20
        
        filtersCollectionView.frame = CGRect(x: 10, y: Int(view.frame.height - 160), width: widgetWidth, height: 160)
        filterParameterEditor.frame = CGRect(x: 10, y: Int(view.frame.height - 330), width: widgetWidth, height: 160)
        
        let imagePreviewHeight = Int(view.frame.height) - Int(topLayoutGuide.length) - 350
        let imagePreviewY = Int(topLayoutGuide.length) + 10
        
        imagePreview.frame = CGRect(x: 10, y: imagePreviewY, width: widgetWidth, height: imagePreviewHeight)
    }

}

