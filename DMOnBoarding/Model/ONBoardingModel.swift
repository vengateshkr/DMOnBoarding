//
//  Event.swift
//  MVVMPlayground
//
//  Created by Neo on 01/10/2017.
//  Copyright © 2017 ST.Huang. All rights reserved.
//

import Foundation

struct ONBoardingModel: Codable {
    let pages : [PageModel]
    let btnTitle : String
    let lastPageBtnTitle : String
    
}

struct PageModel: Codable {
    let title : String
    let desc : String
}
