//
//  QuoteView.swift
//  QuotePro
//
//  Created by Daniel Grosman on 2017-12-06.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

import UIKit

class QuoteView: UIView {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    func setupWithQuote (quote: Quote) {
        photoImageView.image = quote.photoImage
        quoteLabel.text = quote.quoteText
        authorLabel.text = quote.quoteAuthor
    }
    

}
