//
//  Block.swift
//  Elections
//
//  Created by Vladimir Bulakhov on 01/05/2020.
//  Copyright © 2020 Vladimir Bulakhov. All rights reserved.
//

import Foundation
import Firebase


struct Block: Decodable {
    
    var index: Int64
    var timestamp: Date
    var transactions: [Transaction]
    var proof: Int64
    var previous_hash: String
    
}

