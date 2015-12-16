//
//  ViewController.swift
//  GiggleMerge
//
//  Created by Saqib Omer on 12/14/15.
//  Copyright © 2015 KaboomLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var panGestureOne: UIPanGestureRecognizer!
    @IBOutlet var panGestureTwo: UIPanGestureRecognizer!
    
    @IBOutlet weak var imageViewOne: UIImageView!
    @IBOutlet weak var imageViewTwo: UIImageView!
    
    
    
    @IBOutlet weak var resultImageView: UIImageView!
    
    var locationOfImageOne : CGPoint!
    var locationOfImageTwo : CGPoint!
    
//    var rectOfImageViewOne : CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewOne.userInteractionEnabled = true
        imageViewTwo.userInteractionEnabled = true
        
        
        
        imageViewOne.addGestureRecognizer(panGestureOne)
        imageViewTwo.addGestureRecognizer(panGestureTwo)
        
        locationOfImageOne = imageViewOne.frame.origin
        locationOfImageTwo = imageViewTwo.frame.origin
        
//        rectOfImageViewOne = imageViewOne.frame
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Merger images
    
    func mergeImages (forgroundImage : UIImage, backgroundImage : UIImage) {
        
        let bottomImage = forgroundImage
        let topImage = backgroundImage
        
        let size = backgroundImage.size
        UIGraphicsBeginImageContext(size)
        
        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        bottomImage.drawInRect(areaSize)
        
        topImage.drawInRect(areaSize, blendMode: .Normal, alpha: 1.0)
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        resultImageView.image = newImage
        
        UIGraphicsEndImageContext()
    }
    
    @IBAction func panGestureActionOne(sender: UIPanGestureRecognizer) {
        
        
        
        
        
        if sender.state == UIGestureRecognizerState.Began { // When dragging started
            imageViewOne.alpha = 0.5 // Reduce opacity of image view
            
        }
        if sender.state == UIGestureRecognizerState.Ended { // When dragging finished
            imageViewOne.alpha = 1.0 // Restore opacity of image view to full
            imageViewOne.frame.origin = self.locationOfImageOne
        }
        
        if sender.state == UIGestureRecognizerState.Changed {
            imageViewOne.center = CGPointMake(sender.locationInView(self.view).x, sender.locationInView(self.view).y ) // Set ImageView to original position

            if CGRectContainsPoint(self.imageViewOne.frame, self.imageViewTwo.frame.origin) { // This checks if imageViewOne enters in origin of imageView two. 
                //You can change this logic accordingly
                imageViewOne.frame.origin = locationOfImageOne // Reset ImageView Frame
                mergeImages(imageViewOne.image!, backgroundImage: imageViewTwo.image!) // Call to mege images
            }

        }
        
    }
    
    @IBAction func panGestureActionTwo(sender: UIPanGestureRecognizer) {
        
        print("PannedGesture Two")
        
        if sender.state == UIGestureRecognizerState.Began { // When dragging started
            imageViewTwo.alpha = 0.5 // Reduce opacity of image view
        }
        if sender.state == UIGestureRecognizerState.Ended { // When dragging finished
            imageViewTwo.alpha = 1.0 // Restore opacity of image view to full
            imageViewTwo.frame.origin = self.locationOfImageTwo
        }
        
        if sender.state == UIGestureRecognizerState.Changed {
            
            
            imageViewTwo.center = CGPointMake(sender.locationInView(self.view).x - self.imageViewTwo.frame.width, sender.locationInView(self.view).y)// Set ImageView to original position
            
            if CGRectContainsPoint(self.imageViewTwo.frame, self.imageViewOne.frame.origin) { // This checks if imageViewOne enters in origin of imageView two.
                //You can change this logic accordingly
                imageViewTwo.frame.origin = locationOfImageTwo // Reset ImageView Frame
                mergeImages(imageViewOne.image!, backgroundImage: imageViewTwo.image!) // Call to mege images
            }
        }
        
    }


}

