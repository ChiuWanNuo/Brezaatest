//
//  Comments.swift
//  Brezaatest
//
//  Created by ChiuWanNuo on 26/06/2020.
//  Copyright © 2020 ChiuWanNuo. All rights reserved.
//

import Foundation


struct comments: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
