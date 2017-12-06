//
//  ViewController.swift
//  QuotePro
//
//  Created by Daniel Grosman on 2017-12-06.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddQuoteProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var quotesArray = [Quote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func add(newQuote: Quote) {
        quotesArray.append(newQuote)
        let newIndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddQuote") {
//            segue.destination.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
            let qbvc = segue.destination as? QuoteBuilderViewController
            qbvc?.delegate = self
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HomeScreenTableViewCell  else {
            fatalError("The dequeued cell is not an instance of HomeScreenTableViewCell.")
        }
        let currentQuote = quotesArray[indexPath.row]
        cell.quoteLabel.text=currentQuote.quoteText
        cell.authorLabel.text=currentQuote.quoteAuthor
        cell.newPhotoImage.image=currentQuote.photoImage
        return cell
    }
    
    
}

