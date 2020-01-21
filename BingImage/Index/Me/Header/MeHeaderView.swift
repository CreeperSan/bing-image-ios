//
//  MeHeaderView.swift
//  BingImage
//
//  Created by creepersan on 2020/1/20.
//  Copyright © 2020 creepersan. All rights reserved.
//

import UIKit

class MeHeaderView: UIView {
    
    class func headerView() -> MeHeaderView {
        guard let view = Bundle.main.loadNibNamed("MeHeaderView", owner: nil, options: nil)?.first as? MeHeaderView else {
            return MeHeaderView()
        }
        return view
    }

}
