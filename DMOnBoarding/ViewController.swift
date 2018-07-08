//
//  ViewController.swift
//  DMOnBoarding
//
//  Created by Venkatesh on 07/07/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ONBoardingViewDelegate {
    
    var targetView : UIView!
    var scrollView : UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = ONBoardingView(targetView: self.view, numberOfPages: 3)
        view.delegate = self
        
    }
    
    @objc func onbViewbuttonAction(_ sender: UIButton!) {
        print("buttonAction")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print(scrollView?.frame.size.width,self.view.frame.size.width)
    }
    
    func buttonClicked() {
        print("delegate called")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

