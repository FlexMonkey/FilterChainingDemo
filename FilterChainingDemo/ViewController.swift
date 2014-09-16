//
//  ViewController.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 16/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{

    var collectionView : UICollectionView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: 150, height: 150)
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
        collectionView!.registerClass(FiltersCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView?.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(collectionView!)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as FiltersCollectionViewCell
        
        cell.backgroundColor = UIColor.whiteColor()
        cell.setLabel("\(indexPath.item)")
 
        return cell
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews()
    {
        collectionView?.frame = CGRect(x: 10, y: view.frame.height - 160, width: view.frame.width - 20, height: 160)
    }

}

