//
//  ONBoardingView.swift
//  DMOnBoarding
//
//  Created by Venkatesh on 07/07/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

protocol ONBoardingViewDelegate {
    func buttonClicked()
}

class ONBoardingView: UIView {
    
    var delegate : ONBoardingViewDelegate?
    var targetView : UIView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    var viewModel: ONBoardingViewModel = {
        return ONBoardingViewModel()
    }()
    
    var scrollView : UIScrollView! = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func initialViewSetup(_ numberOfPages: Int) {
        scrollView?.leftAnchor.constraint(equalTo: targetView.leftAnchor, constant: 30).isActive = true
        scrollView?.rightAnchor.constraint(equalTo: targetView.rightAnchor, constant: -30).isActive = true
        scrollView?.topAnchor.constraint(equalTo: targetView.topAnchor, constant: 60).isActive = true
        scrollView?.bottomAnchor.constraint(equalTo: targetView.bottomAnchor, constant: -60).isActive = true
        scrollView?.setNeedsLayout()
        scrollView?.layoutIfNeeded()
        scrollView?.contentSize = CGSize(width: (scrollView?.frame.width)! * CGFloat(numberOfPages), height: (scrollView?.frame.height)!)
        
        for i in 0...numberOfPages-1 {
            layoutViews(numberOfPages , i)
        }
    }
    
    required init(targetView : UIView) {
        super.init(frame: UIScreen.main.bounds)
        self.targetView = targetView
        self.targetView.backgroundColor = .red
        self.targetView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageview : UIImageView? = UIImageView(image: #imageLiteral(resourceName: "Bg_image"))
        self.targetView.addSubview(imageview!)
        imageview?.translatesAutoresizingMaskIntoConstraints = false
        imageview?.leftAnchor.constraint(equalTo: targetView.leftAnchor, constant: 0).isActive = true
        imageview?.rightAnchor.constraint(equalTo: targetView.rightAnchor, constant: 0).isActive = true
        imageview?.topAnchor.constraint(equalTo: targetView.topAnchor, constant: 0).isActive = true
        imageview?.bottomAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 0).isActive = true
        
        scrollView.frame = CGRect(x: 0, y: 0, width: targetView.frame.width, height: targetView.frame.height)
        self.targetView.addSubview(scrollView)
        
        initVM()
    }
    
    func initVM() {
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        //  self?.initialViewSetup(targetView, numberOfPages)
                    })
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.initialViewSetup((self?.viewModel.onBoardingModel.pages.count)!)
                print("called back")
            }
        }
        
        self.viewModel.initFetch()
    }
    
    //MARK: - UI Custom Methods
    
    fileprivate func createPageCtrl(_ numberOfPages: Int, _ i: Int) -> UIPageControl {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        pageControl.numberOfPages = numberOfPages
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .green
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPage = i
        return pageControl
    }
    
    
    fileprivate func createCircleImageView(_ numberOfPages: Int, _ i: Int) -> UIImageView {
        let circleView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        if i  == 0 {
            circleView.image = #imageLiteral(resourceName: "Sparkling_Cheese")
        }
        else if i  == 1 {
            circleView.image = #imageLiteral(resourceName: "Offers_out")
        }
        else  {
            circleView.image = #imageLiteral(resourceName: "Badge_In_store")
        }
        circleView.backgroundColor = .white
        circleView.translatesAutoresizingMaskIntoConstraints = false
        return circleView
    }
    
    
    fileprivate func createContainerView(_ numberOfPages: Int, _ i: Int) -> UIView {
        var frame : CGRect = CGRect()
        frame.origin.x = scrollView!.frame.width * CGFloat(i)
        frame.origin.y = 0
        frame.size = scrollView!.frame.size
        let containerView = UIView(frame: frame)
        containerView.backgroundColor = .white
        return containerView
    }
    
    
    fileprivate func createTitleLabel(_ numberOfPages: Int, _ i: Int) -> UILabel {
        
        let lbl = UILabel()
        lbl.backgroundColor = .clear
        lbl.textColor = .black
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = viewModel.onBoardingModel.pages[i].title
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    
    fileprivate func createDescriptionLabel(_ numberOfPages: Int, _ i: Int) -> UILabel {
        
        let lbl = UILabel()
        lbl.backgroundColor = .clear
        lbl.textColor = .black
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.text = viewModel.onBoardingModel.pages[i].desc
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    
    
    fileprivate func createButton(_ numberOfPages: Int, _ i: Int) -> UIButton {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        if i == numberOfPages - 1 {
            //    button.setTitle(ONBoardingAttributes.lastPageBtnTitle, for: .normal)
            button.setTitle(viewModel.onBoardingModel.lastPageBtnTitle, for: .normal)
            button.backgroundColor = .green
            button.setTitleColor(.white, for: .normal)
        }
        else {
            //   button.setTitle(ONBoardingAttributes.btnTitle, for: .normal)
            button.setTitle(viewModel.onBoardingModel.btnTitle, for: .normal)
            button.backgroundColor = .clear
            button.setTitleColor(.green, for: .normal)
        }
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(onbViewbuttonAction(_:)), for: .touchUpInside)
        return button
    }
    
    fileprivate func layoutViews(_ numberOfPages: Int, _ i: Int) {
        
        let pageControl = createPageCtrl(numberOfPages, i)
        let circleView = createCircleImageView(numberOfPages, i)
        let containerView = createContainerView(numberOfPages, i)
        let button = createButton(numberOfPages, i)
        let titleLbl = createTitleLabel(numberOfPages, i)
        let descLbl = createDescriptionLabel(numberOfPages, i)
        
        scrollView?.addSubview(containerView)
        containerView.addSubview(circleView)
        containerView.addSubview(titleLbl)
        containerView.addSubview(descLbl)
        containerView.addSubview(pageControl)
        containerView.addSubview(button)
        
        circleView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120).isActive = true
        circleView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        titleLbl.topAnchor.constraint(equalTo: circleView.bottomAnchor , constant: 40).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        titleLbl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10).isActive = true
        descLbl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        descLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        descLbl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        pageControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -60).isActive = true
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true
        button.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive = true
        button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    }
    
    
    @objc func onbViewbuttonAction(_ sender: UIButton!) {
        delegate?.buttonClicked()
    }
    
}
