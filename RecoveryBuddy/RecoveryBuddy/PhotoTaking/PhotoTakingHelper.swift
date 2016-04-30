//
//  PhotoTakingHelper.swift
//  Makestagram
//
//  Created by Benjamin Encz on 5/21/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

typealias PhotoTakingHelperCallback = UIImage? -> Void

class PhotoTakingHelper : NSObject {
    
    weak var viewController: UIViewController!
    var successCallback: PhotoTakingHelperCallback
    var imagePickerController: UIImagePickerController?
    
    var presentedViewControllerStack: [UIViewController] = []
    
    init(viewController: UIViewController, successCallback: PhotoTakingHelperCallback) {
        self.viewController = viewController
        self.successCallback = successCallback
        
        super.init()
        
        showPhotoSourceSelection()
      
    }
    
    func pushModalViewController(newViewController: UIViewController) {
        presentedViewControllerStack.last?.presentViewController(newViewController, animated: true, completion: nil)
        presentedViewControllerStack.append(newViewController)
    }
    
    func popModalViewController() {
        presentedViewControllerStack.last?.dismissViewControllerAnimated(true, completion: nil)
        presentedViewControllerStack.removeLast()
    }
    
    func showPhotoSourceSelection() {
        // Allow user to choose between photo library and camera
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let photoLibraryAction = UIAlertAction(title: "Photo from Library", style: .Default) { (action) in
              self.showImagePickerController(.PhotoLibrary)
          
        }
        
        alertController.addAction(photoLibraryAction)
        
        // Only show camera option if rear camera is available
        if (UIImagePickerController.isCameraDeviceAvailable(.Rear)) {
            let cameraAction = UIAlertAction(title: "Photo from Camera", style: .Default) { (action) in
               
                 self.showImagePickerController(.Camera)
            }
            
            alertController.addAction(cameraAction)
        }
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
  
        imagePickerController!.delegate = self
        
        self.viewController.presentViewController(imagePickerController!, animated: true, completion: nil)

    }
    
}

extension PhotoTakingHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        viewController.dismissViewControllerAnimated(false, completion: nil)
        
      successCallback(image)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}

