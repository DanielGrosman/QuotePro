//
//  Quote.swift
//  QuotePro
//
//  Created by Daniel Grosman on 2017-12-06.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

import UIKit

class Quote: NSObject {
    
    var quoteText: String
    var quoteAuthor: String
    var photoImage: UIImage?
    
    init(quoteText: String, quoteAuthor: String, photoImage: UIImage) {
        self.quoteText = quoteText
        self.quoteAuthor = quoteAuthor
        self.photoImage = photoImage
    }
}
