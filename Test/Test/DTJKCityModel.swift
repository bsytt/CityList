//
//  DTJKCityModel.swift
//  Test
//
//  Created by gaof on 2019/4/17.
//  Copyright © 2019 bsy. All rights reserved.
//

import UIKit

class DTJKCityModel: NSObject {
    var state : String!
    var cities : NSArray!
    
    init(dic:NSDictionary) {
        state = (dic["state"] as! String)
        cities = (dic["cities"] as! NSArray) 
    }
}
class DTJKModel: NSObject {
    var city : String!
    var areas : NSArray!
    
    init(dic:NSDictionary) {
        city = (dic["city"] as! String)
        areas = (dic["areas"] as! NSArray)
    }
}
