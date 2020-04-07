//
//  MenuModel.swift
//  pocSlideMenu
//
//  Created by Vanoshan  Ramdhani on 2020/04/06.
//  Copyright © 2020 Vanoshan  Ramdhani. All rights reserved.
//

import Foundation
import UIKit

enum MenuModel: Int, CustomStringConvertible{
    
    case Profile
    case Settings
    case Support
    
    var description: String{
        switch  self{
        case .Profile:
            return "Profile"
        case .Settings:
            return "Settings"
        case .Support:
        return "Support"
        }
    }
    var image: UIImage{
        switch self {
        case .Profile:
            return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .Settings:
            return UIImage(named: "ic_mail_outline_white_2x") ?? UIImage()
        case .Support:
            return UIImage(named: "ic_menu_white_3x") ?? UIImage()
        }
    }

    
    
}
