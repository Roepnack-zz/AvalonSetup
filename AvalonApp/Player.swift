//
//  Player.swift
//  AvalonApp
//
//  Created by Scott Roepnack on 1/16/16.
//  Copyright © 2016 Scott Roepnack. All rights reserved.
//

import Foundation


class Player: CustomStringConvertible {
    var name: String
    var email: String
    
    init(name: String, email: String){
        self.name = name
        self.email = email
    }
    
    var description: String {
        return "\(name): \(email)"
    }
}