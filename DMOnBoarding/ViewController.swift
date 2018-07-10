//
//  ViewController.swift
//  DMOnBoarding
//
//  Created by Venkatesh on 07/07/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ONBoardingViewDelegate {
    
    var onBoardingView : ONBoardingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.onBoardingView = ONBoardingView(targetView: self.view)
        self.onBoardingView.delegate = self
    }
    
    @objc func onbViewbuttonAction(_ sender: UIButton!) {
        print("buttonAction")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func buttonClicked() {
        print("delegate called")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

