//
//  Filter.swift
//  YooHoo
//
//  Created by Yonathan Handoyo on 07/04/25.
//


import SwiftUI

enum FriendFilter: String {
    case AZ = "A-Z"
    case ZA = "Z-A"
    case latest = "Latest"
    case oldest = "Oldest"
    
    static var allFilter: [FriendFilter] {
        return [.AZ, .ZA, .latest, .oldest]
    }
}
