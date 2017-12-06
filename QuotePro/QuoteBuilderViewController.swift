//
//  QuoteBuilderViewController.swift
//  QuotePro
//
//  Created by Daniel Grosman on 2017-12-06.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

import UIKit

protocol AddQuoteProtocol:  class {
    func add (newQuote: Quote)
}

class QuoteBuilderViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var randomImage: UIImageView!
    weak var delegate: AddQuoteProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func generateQuote(_ sender: UIButton) {
        let quoteAPI = QuoteAPI ()
        quoteAPI.generateQuote { (quote, author) in
            DispatchQueue.main.async{
                self.quoteLabel.text = quote
                self.authorLabel.text = author
            }
        }
    }
    
    @IBAction func generatePhoto(_ sender: UIButton) {
        let photoAPI = PhotoAPI ()
        photoAPI.generatePhoto { (image) in
            DispatchQueue.main.async{
                self.randomImage.image = image
            }
        }
    }
    
    @IBAction func didSave(_ sender: UIButton) {
        let saveQuote = Quote(quoteText:quoteLabel.text!, quoteAuthor:authorLabel.text!, photoImage:randomImage.image!)
        delegate?.add(newQuote: saveQuote)
        self.dismiss(animated: true, completion: nil)
    }
    
}
