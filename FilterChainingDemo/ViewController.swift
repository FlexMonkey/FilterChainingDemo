//
//  ViewController.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 16/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIToolbarDelegate
{
    var userDefinedFilters: [UserDefinedFilter]!
    
    let filtersCollectionView = FiltersCollectionView(frame: CGRectZero)
    let filterParameterEditor = FilterParameterEditor(frame: CGRectZero)
    let imagePreview = ImagePreview(frame: CGRectZero)
 
    let toolbar = UIToolbar(frame: CGRectZero)
    
    let addNewFilterButton: UIBarButtonItem!
    let deleteFilterButton: UIBarButtonItem!
    
    let filteringDelegate: FilteringDelegate!
    
    override init()
    {
        super.init()
        
        addNewFilterButton = UIBarButtonItem(title: "Add New Filter", style: UIBarButtonItemStyle.Bordered, target: self, action: "addNewFilter:")
        deleteFilterButton = UIBarButtonItem(title: "Delete Selected Filter", style: UIBarButtonItemStyle.Bordered, target: self, action: "deleteSelectedFilter:")
        filteringDelegate = FilteringDelegate(controller: self)
        
        filterParameterEditor.viewController = self
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        addNewFilterButton = UIBarButtonItem(title: "Add New Filter", style: UIBarButtonItemStyle.Bordered, target: self, action: "addNewFilter:")
        deleteFilterButton = UIBarButtonItem(title: "Delete Selected Filter", style: UIBarButtonItemStyle.Bordered, target: self, action: "deleteSelectedFilter:")
        filteringDelegate = FilteringDelegate(controller: self)
        
        filterParameterEditor.viewController = self
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        userDefinedFilters = [
            UserDefinedFilter(isImageInputNode: true, isImageOutputNode: false),
            UserDefinedFilter(filter: Filters.filters[0]),
            UserDefinedFilter(filter: Filters.filters[1]),
            UserDefinedFilter(isImageInputNode: false, isImageOutputNode: true)]
        
        filtersCollectionView.userDefinedFilters = userDefinedFilters
        filtersCollectionView.addTarget(self, action: "filtersCollectionViewChangeHandler:", forControlEvents: .ValueChanged)
        
        filterParameterEditor.addTarget(self, action: "filterParameterEditorChangeHandler:", forControlEvents: .ValueChanged)

        toolbar.setItems([addNewFilterButton!, deleteFilterButton!], animated: true)
        deleteFilterButton.enabled = false
        
        view.addSubview(filtersCollectionView)
        view.addSubview(filterParameterEditor)
        view.addSubview(imagePreview)
        
        view.addSubview(toolbar)
    }

    var selectedFilter: UserDefinedFilter?
    {
        didSet
        {
            filterParameterEditor.userDefinedFilter = selectedFilter
   
            if let userDefinedFilterConst = selectedFilter
            {
                deleteFilterButton.enabled = !userDefinedFilterConst.isImageInputNode && !userDefinedFilterConst.isImageOutputNode
            }
            else
            {
                deleteFilterButton.enabled = false
            }
        }
    }
    
    func deleteSelectedFilter(value: UIBarButtonItem)
    {
        println("deleteSelectedFilter")
    }
    
    func addNewFilter(value: UIBarButtonItem)
    {
        println("addNewFilter")
    }
    
    func imagesDidChange(images: FilteredImages)
    {
        imagePreview.filteredImages = images
    }
    
    func filterParameterEditorChangeHandler(value : FilterParameterEditor)
    {
        filtersCollectionView.refresh()
        
        filteringDelegate.applyFilters(userDefinedFilters, selectedUserDefinedFilter: selectedFilter!, imagesDidChange)
    }
    
    func filtersCollectionViewChangeHandler(value: FiltersCollectionView)
    {
        selectedFilter = value.selectedFilter
    }
    
    override func viewDidLayoutSubviews()
    {
        let widgetWidth = Int(view.frame.width) - 20
        
        filtersCollectionView.frame = CGRect(x: 10, y: Int(view.frame.height - 160 - 10 - 40), width: widgetWidth, height: 160)
        filterParameterEditor.frame = CGRect(x: 10, y: Int(view.frame.height - 330 - 10 - 40), width: widgetWidth, height: 160)
        
        let imagePreviewHeight = Int(view.frame.height) - Int(topLayoutGuide.length) - 350 - 10 - 40
        let imagePreviewY = Int(topLayoutGuide.length) + 10
        
        imagePreview.frame = CGRect(x: 10, y: imagePreviewY, width: widgetWidth, height: imagePreviewHeight)
        
        toolbar.frame = CGRect(x: 0, y: view.frame.height - 40, width: view.frame.width, height: 40)
    }
  
}

