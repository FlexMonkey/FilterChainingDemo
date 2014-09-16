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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        view.addSubview(filtersCollectionView)
    }


    
    override func viewDidLayoutSubviews()
    {
       filtersCollectionView.frame = CGRect(x: 10, y: view.frame.height - 160, width: view.frame.width - 20, height: 160)
    }

}

