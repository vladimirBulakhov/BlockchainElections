//
//  Blockchain.swift
//  Elections
//
//  Created by Vladimir Bulakhov on 02/05/2020.
//  Copyright © 2020 Vladimir Bulakhov. All rights reserved.
//

import Foundation
import Firebase

class Blockchain: Decodable {
    
    var chain = [Block]()
    var length = 0
    
}
