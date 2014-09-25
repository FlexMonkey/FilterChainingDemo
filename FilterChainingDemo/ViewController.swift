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
    let filtersCollectionView = FiltersCollectionView(frame: CGRectZero)
    let filterParameterEditor = FilterParameterEditor(frame: CGRectZero)
    let imagePreview = ImagePreview(frame: CGRectZero)
 
    let toolbar = UIToolbar(frame: CGRectZero)
    
    let addNewFilterButton: UIBarButtonItem!
    let deleteFilterButton: UIBarButtonItem!
    
    let filteringDelegate: FilteringDelegate!
    
    let startNode = UserDefinedFilter(isImageInputNode: true, isImageOutputNode: false)
    let endNode = UserDefinedFilter(isImageInputNode: false, isImageOutputNode: true)
    
    override init()
    {
        selectedFilter = startNode
        
        super.init()
        
        addNewFilterButton = UIBarButtonItem(title: "Add New Filter", style: UIBarButtonItemStyle.Bordered, target: self, action: "addNewFilter:")
        deleteFilterButton = UIBarButtonItem(title: "Delete Selected Filter", style: UIBarButtonItemStyle.Bordered, target: self, action: "deleteSelectedFilter:")
        filteringDelegate = FilteringDelegate(controller: self)
        
        filterParameterEditor.viewController = self

    }

    required init(coder aDecoder: NSCoder)
    {
        selectedFilter = startNode
        
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
            startNode,
            UserDefinedFilter(filter: Filters.filters[0]),
            UserDefinedFilter(filter: Filters.filters[1]),
            endNode]
        
        userDefinedFilters[0].inputImage = UIImage(named: "grand_canyon.jpg")
        
        filtersCollectionView.userDefinedFilters = userDefinedFilters
        
        addControlEventActions()
        filtersCollectionView.addTarget(self, action: "filtersCollectionViewSelectedFilterChange:", forControlEvents: .SelectedFilterChanged)

        toolbar.setItems([addNewFilterButton!, deleteFilterButton!], animated: true)
        deleteFilterButton.enabled = false
        
        view.addSubview(filtersCollectionView)
        view.addSubview(filterParameterEditor)
        view.addSubview(imagePreview)
        
        view.addSubview(toolbar)
        
        selectedFilter = userDefinedFilters[0]
        
        filteringDelegate.applyFilters(userDefinedFilters, selectedUserDefinedFilter: selectedFilter, imagesDidChange)
    }

    func addControlEventActions()
    {
        filtersCollectionView.addTarget(self, action: "filtersCollectionViewChangeHandler:", forControlEvents: .ValueChanged)
        filterParameterEditor.addTarget(self, action: "filterParameterEditorChangeHandler:", forControlEvents: .ValueChanged)
    }
    
    func removeControlEventActions()
    {
        filtersCollectionView.removeTarget(self, action: "filtersCollectionViewChangeHandler:", forControlEvents: .ValueChanged)
        filterParameterEditor.removeTarget(self, action: "filterParameterEditorChangeHandler:", forControlEvents: .ValueChanged)
    }
    
    var userDefinedFilters: [UserDefinedFilter] = [UserDefinedFilter(isImageInputNode: true, isImageOutputNode: false)]
    {
        didSet
        {
            removeControlEventActions()
            
            filtersCollectionView.userDefinedFilters = userDefinedFilters
            
            addControlEventActions()
            
            filteringDelegate.killBackgroundFiltering()
      
            filteringDelegate.applyFilters(userDefinedFilters, selectedUserDefinedFilter: selectedFilter, imagesDidChange)
        }
    }
    
    var selectedFilter: UserDefinedFilter
    {
        didSet
        {
            removeControlEventActions()
            
            filterParameterEditor.selectedFilter = selectedFilter
            filtersCollectionView.selectedFilter = selectedFilter
            
            addControlEventActions()
            
            deleteFilterButton.enabled = !selectedFilter.isImageInputNode && !selectedFilter.isImageOutputNode
            
            filteringDelegate.killBackgroundFiltering()
            filteringDelegate.applyFilters(userDefinedFilters, selectedUserDefinedFilter: selectedFilter, imagesDidChange)
        }
    }
    
    func deleteSelectedFilter(value: UIBarButtonItem)
    {
        let previousFilter = selectedFilter

        userDefinedFilters = userDefinedFilters.filter({!($0 == previousFilter)})
    }
    
    func addNewFilter(value: UIBarButtonItem)
    {
        let newFilter = UserDefinedFilter(filter: Filters.filters[0])
        
        userDefinedFilters.insert(newFilter, atIndex: userDefinedFilters.count - 1)
        
        filtersCollectionView.userDefinedFilters = userDefinedFilters
    }
    
    func filtersCollectionViewSelectedFilterChange(value: FiltersCollectionView)
    {
        selectedFilter = value.selectedFilter!
    }
    
    func imagesDidChange(images: FilteredImages)
    {
        imagePreview.filteredImages = images
    }
    
    func filterParameterEditorChangeHandler(value : FilterParameterEditor)
    {
        filtersCollectionView.refresh()

        filteringDelegate.applyFilters(userDefinedFilters, selectedUserDefinedFilter: selectedFilter, imagesDidChange)
    }
    
    func filtersCollectionViewChangeHandler(value: FiltersCollectionView)
    {
        println("\(value.selectedFilter?.uuid)  -- \(selectedFilter.uuid)")
        
        selectedFilter = value.selectedFilter!
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

