//
//  FilterParameterEditor.swift
//  FilterChainingDemo
//
//  Created by Simon Gladman on 17/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//
//  TODO - implement using PHImageManager (http://nshipster.com/phimagemanager/)

import UIKit

class FilterParameterEditor: UIControl, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    let fadeAnimationDuration = 0.3
    
    var fadedOutDials = [NumericDial]()
    var numericDials = [NumericDial]()
    let filterPicker = UIPickerView(frame: CGRectZero)
    var loadImageButton: UIButton?
    weak var viewController : UIViewController?
    
    override func didMoveToWindow()
    {
        filterPicker.alpha = 0
        filterPicker.delegate = self
        filterPicker.dataSource = self
        
        addSubview(filterPicker)
    }

    var selectedFilter : UserDefinedFilter!
    {
        didSet
        {
            if let filterConst = selectedFilter.filter
            {
                numDials = filterConst.parameterCount
                
                if loadImageButton != nil
                {
                    loadImageButton?.removeFromSuperview()
                    loadImageButton = nil
                }
                
                UIView.animateWithDuration(fadeAnimationDuration, animations: {self.filterPicker.alpha = 1}, completion: setFilterPickerItem)
            }
            else
            {
                numDials = 0
                UIView.animateWithDuration(fadeAnimationDuration, animations: {self.filterPicker.alpha = 0})
                
                if selectedFilter.isImageInputNode
                {
                    loadImageButton = UIButton()
                    loadImageButton!.setTitle("LoadImage", forState: .Normal)
                    loadImageButton!.setTitleColor(UIColor.blueColor(), forState: .Normal)
                    loadImageButton!.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
                    loadImageButton!.addTarget(self, action: "loadImageClickedSelector:", forControlEvents: .TouchUpInside)
                    
                    addSubview(loadImageButton!)
                }
                else if selectedFilter.isImageOutputNode
                {
                    if loadImageButton != nil
                    {
                        loadImageButton?.removeFromSuperview()
                        loadImageButton = nil
                    }
                }
            }
        }
    }
    
    func setFilterPickerItem(value: Bool)
    {
        if let filterConst = selectedFilter.filter
        {
            for (index, filter) in enumerate(Filters.filters)
            {
                if filter.filterName == filterConst.filterName
                {
                    filterPicker.selectRow(index, inComponent: 0, animated: true)
                }
            }
        }
    }
    
    private var numDials : Int = 0
    {
        didSet
        {
            createDials()
        }
    }
    
    func applyFilters()
    {
        sendActionsForControlEvents(.ValueChanged)
    }
    
    func createDials()
    {
        fadedOutDials = [NumericDial]()
        
        for dial in numericDials
        {
            dial.removeTarget(self, action: "dialChangeHandler:", forControlEvents: .ValueChanged)
            
            fadedOutDials.append(dial)
            
            UIView.animateWithDuration(fadeAnimationDuration, animations: {dial.alpha = 0}, completion: dialFadeOutComplete)
        }
        
        numericDials = [NumericDial]()
        
        for i in 0 ..< numDials
        {
            if let udf = selectedFilter
            {
                if let udfFilter = udf.filter
                {
                    let dial = NumericDial(frame: CGRectZero)
                    
                    dial.currentValue = udf.values![i]
                    dial.title = udfFilter.filterParameters[i].parameterName
                    dial.alpha = 0;
                    
                    dial.addTarget(self, action: "dialChangeHandler:", forControlEvents: .ValueChanged)
                    
                    numericDials.append(dial)
                    
                    addSubview(dial)

                    UIView.animateWithDuration(fadeAnimationDuration, animations: {dial.alpha = 1})
                }
            }
        }
        
        setNeedsLayout()
    }
    
    func dialFadeOutComplete(value: Bool)
    {
        for dial in fadedOutDials
        {
            dial.removeFromSuperview()
        }
    }
    
    func loadImageClickedSelector(button: UIButton)
    {
        var imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.modalInPopover = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        
        viewController!.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        if let rawImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            selectedFilter.inputImage = rawImage.resizeToBoundingSquare(boundingSquareSideLength: 640)
            
            applyFilters()
        }
        
        viewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dialChangeHandler(numericDial: NumericDial)
    {
        for (i : Int, dial : NumericDial) in enumerate(numericDials)
        {
            if dial == numericDial
            {                
                selectedFilter.values![i] = dial.currentValue
            }
        }
        
        sendActionsForControlEvents(.ValueChanged)
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    {
        return NSAttributedString(string: Filters.filters[row].filterName, attributes: [NSForegroundColorAttributeName : UIColor.blueColor()])
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        selectedFilter.filter = Filters.filters[row]
        numDials = selectedFilter.filter!.parameterCount
        sendActionsForControlEvents(.ValueChanged)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return Filters.filters.count
    }
    
    override func didMoveToSuperview()
    {
        layer.borderColor = UIColor.blueColor().CGColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
    }
    
    override func layoutSubviews()
    {
        if (selectedFilter?.isImageInputNode != false)
        {
            loadImageButton?.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        }
        else
        {
            let startX = Int(frame.size.width) - numericDials.count * 160
            
            for (index : Int, dial : NumericDial) in enumerate(numericDials)
            {
                dial.frame = CGRect(x: startX + index * 160, y: 10, width: 150, height: 150)
            }
            
            filterPicker.frame = CGRect(x: 10, y: 10, width: 225, height: frame.size.height - 20)
        }
    }

}
