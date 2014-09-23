//
//  FiltersCollectionView.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 16/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit

class FiltersCollectionView: UIControl, UICollectionViewDataSource, UICollectionViewDelegate
{
    var uiCollectionView : UICollectionView
    
    override init(frame: CGRect)
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: 150, height: 150)
        
        uiCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        uiCollectionView.registerClass(FiltersCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        uiCollectionView.allowsSelection = true
        
        super.init(frame: frame)

        uiCollectionView.dataSource = self
        uiCollectionView.delegate = self
        
        addSubview(uiCollectionView)
        
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        
        uiCollectionView.backgroundColor = UIColor.clearColor()
    }
    
    func refresh()
    {
        if uiCollectionView.indexPathsForSelectedItems().count > 0
        {
            let indexPathsForSelectedItem = uiCollectionView.indexPathsForSelectedItems()[0] as NSIndexPath
        
            uiCollectionView.reloadData()
        
            uiCollectionView.selectItemAtIndexPath(indexPathsForSelectedItem, animated: true, scrollPosition: UICollectionViewScrollPosition.None)
        }
        else
        {
            uiCollectionView.reloadData()
        }
    }
    
    var userDefinedFilters: [UserDefinedFilter] = [UserDefinedFilter]()
    {
        didSet
        {
            if oldValue.count < userDefinedFilters.count && oldValue.count != 0
            {
                println("** INSERTING OBJECT")
                
                let insertIndexPath = NSIndexPath(forItem: oldValue.count - 1, inSection: 0)
              
                uiCollectionView.insertItemsAtIndexPaths([insertIndexPath])
                
                let scrollToIndexPath = NSIndexPath(forItem: userDefinedFilters.count - 1, inSection: 0)
                
                uiCollectionView.selectItemAtIndexPath(scrollToIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.CenteredHorizontally)
            }
            else if oldValue.count > userDefinedFilters.count
            {
                println("** Deleting object")
                
                let deleteIndexPath = uiCollectionView.indexPathsForSelectedItems()[0] as NSIndexPath // NSIndexPath(forItem: 1, inSection: 0)
                
                uiCollectionView.deleteItemsAtIndexPaths([deleteIndexPath])
                
                let scrollToIndexPath = NSIndexPath(forItem: 0, inSection: 0)
                
                uiCollectionView.selectItemAtIndexPath(scrollToIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.Left)
            }
            else
            {
                //refresh()
            }
        }
    }
    
    var selectedFilter : UserDefinedFilter?
    {
        didSet
        {
            // uiCollectionView.selectItemAtIndexPath for selected item!!!
            
            var selectedIndex : Int = -1
            
            for (i: Int, filter: UserDefinedFilter) in enumerate(userDefinedFilters)
            {
                if filter == selectedFilter!
                {
                    selectedIndex = i
                }
            }
            
            if selectedIndex != -1
            {
                let scrollToIndexPath = NSIndexPath(forItem: selectedIndex, inSection: 0)
                uiCollectionView.selectItemAtIndexPath(scrollToIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.CenteredHorizontally)
            }
            
            sendActionsForControlEvents(.ValueChanged)
            refresh()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return userDefinedFilters.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        selectedFilter = userDefinedFilters[indexPath.item]
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as FiltersCollectionViewCell
    
        cell.userDefinedFilter = userDefinedFilters[indexPath.item]
        
        if let foo = selectedFilter
        {
            cell.selected = cell.userDefinedFilter == foo
        }
        else
        {
            cell.selected = false
        }
        
        return cell
    }
    
    override func layoutSubviews()
    {
        
        uiCollectionView.frame = CGRect(x: 4, y: 0, width: frame.width - 8, height: frame.height)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        uiCollectionView = UICollectionView(frame: CGRectZero)
        super.init(coder: aDecoder)
    }

}
