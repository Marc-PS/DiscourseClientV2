//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

protocol TopicCellViewModelDelegate: class {
    func imageFetched()
}


class TopicCellViewModel: CellViewModel {
    weak var delegate: TopicCellViewModelDelegate?
    var topicTitle: String?
    var postsCount: Int?
    var postersCount: Int?
    var lastPostedAt: String?
    var dateFormatted: String?
    var topicImage: UIImage?
    
    
    
    init(topic: Topic, user: User) {
        super.init(topic: topic)
        
        
        topicTitle = topic.title
        postsCount = topic.postsCount
        postersCount = topic.posters.count
        lastPostedAt = topic.lastPostedAt
        insertImage(user: user)
        
    }
    
    func insertImage(user: User) {
        var imageStringURL = "https://mdiscourse.keepcoding.io"
        imageStringURL.append(user.avatarTemplate.replacingOccurrences(of: "{size}", with: "64"))
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: imageStringURL), let data = try? Data(contentsOf: url) {
                self?.topicImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.delegate?.imageFetched()
                }
            }
        }
        
    }
    
    func dateFormatter(date: String) -> String {
        let inputFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = inputFormat
        
        let dates = dateFormatter.date(from: date)

        let outputFormat = "MMM dd"
        dateFormatter.dateFormat = outputFormat
        let outputStringDate = dateFormatter.string(from: dates!)
        
        return outputStringDate
    }
    
    
    
}


