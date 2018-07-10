//
//  Constants.swift
//  DMOnBoarding
//
//  Created by Venkatesh on 08/07/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import Foundation

class ONBoardingViewModel {
    
    let apiService: APIServiceProtocol
    
     var onBoardingModel : ONBoardingModel! {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    
    var isAllowSegue: Bool = false
    

    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?

    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.fetchPopularPhoto { [weak self] (success, onBoardingModel, error) in
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self?.fetchedData(onBoardingModel)
                print("sucesss")
            }
        }
    }
    
    func fetchedData (_ obj : ONBoardingModel) {
        self.onBoardingModel = obj
    }
    
    deinit {
        print("deinit view model")
    }
}

