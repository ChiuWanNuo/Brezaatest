//
//  User.swift
//  Brezaatest
//
//  Created by ChiuWanNuo on 26/06/2020.
//  Copyright © 2020 ChiuWanNuo. All rights reserved.
//

import Foundation

struct users: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: addressInfo
    
    struct addressInfo: Codable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: geoInfo
        
        struct geoInfo: Codable{
            let lat: String
            let lng: String
        }
    }
    
    let phone: String
    let website: String
    let company: companyInfo
    
    struct companyInfo: Codable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}
