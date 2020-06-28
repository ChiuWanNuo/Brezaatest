//
//  Posts.swift
//  Brezaatest
//
//  Created by ChiuWanNuo on 26/06/2020.
//  Copyright © 2020 ChiuWanNuo. All rights reserved.
//

import Foundation

class posts: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    var commentsCount: Int? = 0
}

