//
//  Citizen.swift
//  Elections
//
//  Created by Vladimir Bulakhov on 02/05/2020.
//  Copyright © 2020 Vladimir Bulakhov. All rights reserved.
//

import Foundation
import Firebase

struct Citizen{
    
    var name : String
    var surname : String
    var numberOfPassport : String
    var isCitizenVoted = false
    var ref : DatabaseReference?
    
    func convertToDictionary() -> Any {
        return ["name": name , "surname": surname, "numberOfPassport" : numberOfPassport, "isCitizenVoted": isCitizenVoted]
    }
    
}
