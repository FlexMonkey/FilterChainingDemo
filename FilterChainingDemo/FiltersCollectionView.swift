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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as FiltersCollectionViewCell
        
        cell.backgroundColor = UIColor.whiteColor()
        cell.setLabel("yo \(indexPath.item)")
        
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
