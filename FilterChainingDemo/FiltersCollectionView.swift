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
    var collectionView : UICollectionView
    
    override init(frame: CGRect)
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: 150, height: 150)
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.registerClass(FiltersCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.lightGrayColor()
        
        super.init(frame: frame)

        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(collectionView)
    }
    
    var userDefinedFilters: [UserDefinedFilter] = [UserDefinedFilter]()
    {
        didSet
        {
            
        }
    }
    
    var indexPath : NSIndexPath?
    {
        didSet
        {
            var foo = [NSIndexPath]()
            
            if let tmp = oldValue
            {
                foo.append(tmp)
            }
            
            if let tmp = indexPath
            {
                foo.append(tmp)
            }
            
            collectionView.reloadItemsAtIndexPaths(foo)
            
            sendActionsForControlEvents(.ValueChanged)
        }
    }
    
    var selectedFilter : UserDefinedFilter!
    {
        get
        {
            return userDefinedFilters[indexPath!.item]
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return userDefinedFilters.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        self.indexPath = indexPath
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as FiltersCollectionViewCell
        
        cell.backgroundColor = (self.indexPath == indexPath) ? UIColor.blueColor() : UIColor.whiteColor()
        
        cell.userDefinedFilter = userDefinedFilters[indexPath.item]
        
        return cell
    }
    
    override func layoutSubviews()
    {
        
        collectionView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        collectionView = UICollectionView(frame: CGRectZero)
        super.init(coder: aDecoder)
    }

}
