//
//  AnimationsController.swift
//  vk
//
//  Created by Rafael Khanov on 17.11.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit

class AnimationsController: UIViewController {
    
    @IBOutlet var indigoView: UIView!
    @IBOutlet var redView: UIView!
    @IBOutlet var greenView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        indigoView.layer.cornerRadius = indigoView.bounds.height / 2
        redView.layer.cornerRadius = indigoView.bounds.height / 2
        greenView.layer.cornerRadius = indigoView.bounds.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
     
        
        UIView.animate(withDuration: 0.2, delay: 0,
                       options: [.repeat, .autoreverse],
                       animations:   {
            self.indigoView.alpha = 0
        })
        UIView.animate(withDuration: 0.2, delay: 0.1,
                       options: [.repeat, .autoreverse],
                              animations:   {
                   self.redView.alpha = 0
               })
        UIView.animate(withDuration: 0.2, delay: 0.2,
                       options: [.repeat, .autoreverse],
                       animations:   {
            self.greenView.alpha = 0
        })
        
        
        

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.performSegue(withIdentifier: "End of animation", sender: nil)

        })

        
    }
  

}
