//
//  ShowPhotosViewController.swift
//  vk
//
//  Created by Rafael Khanov on 23.11.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit

class ShowPhotosViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet private var friendsPhoto: UIImageView!
    var rootPhoto: UIImage!
    var images: [UIImage]!
    
    var changePhoto: UIImage!
    
    var keyRootPhoto: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGR()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.friendsPhoto.image = rootPhoto
    }
    
    func setupGR () {
        let swipeLeftGR = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        swipeLeftGR.direction = .left
        let swipeRightGR = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        swipeRightGR.direction = .right
        view.addGestureRecognizer(swipeLeftGR)
        view.addGestureRecognizer(swipeRightGR)
    }
    
    @objc private func swipe(_ recognizer: UISwipeGestureRecognizer) {
        
        switch recognizer.direction {
        case .left:
            print("left")
            
            
            UIView.animateKeyframes (
                withDuration: 1,
                delay: 0,
                options: .calculationModeCubicPaced,
                animations: {
                    UIView.addKeyframe (
                        withRelativeStartTime: 0,
                        relativeDuration: 0.5
                    ) {
                        self.friendsPhoto.transform = CGAffineTransform(translationX: 0, y: -40)
                        
                    }
                    UIView.addKeyframe (
                        withRelativeStartTime: 0.5,
                        relativeDuration: 0.5
                    ) {
                        self.friendsPhoto.alpha = 0
                    }
            },
                completion: { [unowned self] _ in
                    
                    UIView.animateKeyframes (
                        withDuration: 0.1,
                        delay: 0,
                        options: .calculationModeDiscrete,
                        animations: {
                            UIView.addKeyframe (
                                withRelativeStartTime: 0,
                                relativeDuration: 1
                            ) {
                                self.friendsPhoto.transform = CGAffineTransform(translationX: 400, y: 0)
                                
                                self.friendsPhoto.alpha = 0
                                
                            }
                    },
                        completion: { [unowned self] _ in
                            
                            if self.keyRootPhoto == 0  {
                                self.friendsPhoto.image = self.images[self.images.count - 1]
                                self.keyRootPhoto = self.images.count - 1
                                
                                UIImage.animatedImage(with: self.images, duration: 2)
                                
                            } else {
                                self.friendsPhoto.image = self.images[self.keyRootPhoto - 1]
                                self.keyRootPhoto -= 1
                            }
                            
                            UIView.animateKeyframes (
                                withDuration: 1,
                                delay: 0,
                                options: .calculationModeCubicPaced,
                                animations:
                                {
                                    UIView.addKeyframe (
                                        withRelativeStartTime: 0,
                                        relativeDuration: 1) {
                                            self.friendsPhoto.transform = CGAffineTransform(translationX: 0, y: 0)
                                            self.friendsPhoto.alpha = 1
                                    }
                            },
                                completion: nil)
                        }
                    )
            })

            
        case .right:
            print("right")
 
            UIView.animateKeyframes (
                withDuration: 1,
                delay: 0,
                options: .calculationModeCubicPaced,
                animations: {
                    UIView.addKeyframe (
                        withRelativeStartTime: 0,
                        relativeDuration: 0.5
                    ) {
                        self.friendsPhoto.transform = CGAffineTransform(translationX: 0, y: -40)
                        
                    }
                    UIView.addKeyframe (
                        withRelativeStartTime: 0.5,
                        relativeDuration: 0.5
                    ) {
                        self.friendsPhoto.alpha = 0
                    }
            },
                completion: { [unowned self] _ in
                    
                    UIView.animateKeyframes (
                        withDuration: 0.1,
                        delay: 0,
                        options: .calculationModeDiscrete,
                        animations: {
                            UIView.addKeyframe (
                                withRelativeStartTime: 0,
                                relativeDuration: 1
                            ) {
                                self.friendsPhoto.transform = CGAffineTransform(translationX: -400, y: 0)
                                
                                self.friendsPhoto.alpha = 0
                                
                            }
                    },
                        completion: { [unowned self] _ in
                            
                            if self.keyRootPhoto == self.images.count - 1  {
                                self.friendsPhoto.image = self.images[0]
                                self.keyRootPhoto = 0
                            } else {
                                
                                
                                self.friendsPhoto.image = self.images[self.keyRootPhoto + 1]
                                self.keyRootPhoto += 1
                            }
                            
                            UIView.animateKeyframes (
                                withDuration: 1,
                                delay: 0,
                                options: .calculationModeCubicPaced,
                                animations:
                                {
                                    UIView.addKeyframe (
                                        withRelativeStartTime: 0,
                                        relativeDuration: 1) {
                                            self.friendsPhoto.transform = CGAffineTransform(translationX: 0, y: 0)
                                            self.friendsPhoto.alpha = 1
                                    }
                            },
                                completion: nil)
                        }
                    )
            })
            
            
            
        default:
            print("break")
            break
        }
        
        
        
    }
   
    
    
}
