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
    
    var quoteView: QuoteView?
    weak var delegate: AddQuoteProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isToolbarHidden = false
        
        if let objects = Bundle.main.loadNibNamed("QuoteView", owner: nil, options: [:]){
            quoteView = objects.first as? QuoteView
            self.view.addSubview(quoteView!)
        }
        quoteView?.translatesAutoresizingMaskIntoConstraints = false
        
        quoteView?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        quoteView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        quoteView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        quoteView?.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0).isActive = true
        
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                .font : UIFont(name: "HelveticaNeue-Light", size: 12)!,
                .foregroundColor : UIColor.blue,
                ], for: .normal)
        
        let randomImageButton = UIBarButtonItem(title: "Randomize Image", style: UIBarButtonItemStyle.plain, target: self, action: #selector(generatePhoto))
        let randomQuoteButton = UIBarButtonItem(title: "Randomize Quote", style: UIBarButtonItemStyle.plain, target: self, action: #selector(generateQuote))
        let saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(didSave))
        self.toolbarItems = [randomImageButton, randomQuoteButton, saveButton]
    }
    
    
    @objc func generateQuote(sender: UIBarButtonItem) {
        let quoteAPI = QuoteAPI ()
        quoteAPI.generateQuote { (quote, author) in
            DispatchQueue.main.async{
                self.quoteView?.quoteLabel.text = quote
                self.quoteView?.authorLabel.text = author
            }
        }
    }
    
    @objc func generatePhoto(sender: UIBarButtonItem) {
        let photoAPI = PhotoAPI ()
        photoAPI.generatePhoto { (image) in
            DispatchQueue.main.async{
                self.quoteView?.photoImageView.image = image
            }
        }
    }
    
    @objc func didSave(sender: UIBarButtonItem) {
        let saveQuote = Quote(quoteText:(self.quoteView?.quoteLabel.text!)!, quoteAuthor:(self.quoteView?.authorLabel.text!)!, photoImage:(self.quoteView?.photoImageView.image!)!)
        delegate?.add(newQuote: saveQuote)
        self.dismiss(animated: true, completion: nil)
    }
    
}
