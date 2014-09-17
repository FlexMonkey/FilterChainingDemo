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
    let filtersCollectionView = FiltersCollectionView(frame: CGRectZero)
    let filterParameterEditor = FilterParameterEditor(frame: CGRectZero)
    let imagePreview = ImagePreview(frame: CGRectZero)
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        filterParameterEditor.backgroundColor = UIColor.lightGrayColor()
        imagePreview.backgroundColor = UIColor.blackColor()
        
        view.addSubview(filtersCollectionView)
        view.addSubview(filterParameterEditor)
        view.addSubview(imagePreview)
        
        filterParameterEditor.numDials = 3; 
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

