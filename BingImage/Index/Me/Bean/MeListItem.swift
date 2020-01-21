//
//  MeListItem.swift
//  BingImage
//
//  Created by creepersan on 2020/1/20.
//  Copyright © 2020 creepersan. All rights reserved.
//

import UIKit

class MeListItem: Any {
    static let NAV_NONE         : Int8 = 0
    static let NAV_ARROW        : Int8 = 1
    static let NAV_EXTERNAL     : Int8 = 2
    
    var id      : MeTableViewHeaderID = MeTableViewHeaderID.Undefine
    var name    : String    = ""
    var icon    : String    = ""
    var nav     : Int8      = 0
    
    init(id:MeTableViewHeaderID, name:String, icon:String, nav:Int8) {
        self.id = id
        self.name = name
        self.icon = icon
        self.nav = nav
    }
    
}
