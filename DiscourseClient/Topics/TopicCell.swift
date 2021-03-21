//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class TopicCell: UITableViewCell {
    
    
    @IBOutlet weak var topicTitle: UILabel!
    @IBOutlet weak var postsCount: UILabel!
    @IBOutlet weak var postersCount: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lastPostedAt: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.delegate = self
            
            topicTitle.text = viewModel.topicTitle
            postsCount.text = String(viewModel.postsCount!)
            postersCount.text = String(viewModel.postersCount!)
            lastPostedAt.text = viewModel.dateFormatter(date: viewModel.lastPostedAt!).firstUppercased
            userImage.image = viewModel.topicImage
            userImage.layer.cornerRadius = 32
        }
    }
    
   
    
}

extension TopicCell: TopicCellViewModelDelegate {
    func imageFetched() {
        guard let viewModel = viewModel else { return }
        viewModel.delegate = self
        userImage.image = viewModel.topicImage
        userImage.layer.cornerRadius = 32
        setNeedsLayout()
        
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
