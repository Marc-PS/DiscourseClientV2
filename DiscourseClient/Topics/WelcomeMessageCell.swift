//
//  WelcomeMessageCell.swift
//  DiscourseClient
//
//  Created by Marc Perelló Sapiña on 15/3/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

class WelcomeMessageCell: UITableViewCell {
    
    @IBOutlet weak var viewTangerine: UIView!
    
    var viewModel: WelcomeMessageCellViewModel? {
        didSet {
            viewTangerine.layer.cornerRadius = 8
        }
    }
}
