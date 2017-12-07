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
    var quoteView: QuoteView?
    var snapImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    func add(newQuote: Quote) {
        quotesArray.append(newQuote)
        let newIndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddQuote") {
            let navController = segue.destination as? UINavigationController
            let qbvc = navController?.viewControllers.first as? QuoteBuilderViewController
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
    
    // MARK: - Snapshot
    func snapshot(view: UIView) -> (UIImage) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates:true)
        snapImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return snapImage!
    }
    
    // MARK: Activity View Controller
    func share(image: UIImage) {
        let objectsToShare = [image]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objects = Bundle.main.loadNibNamed("QuoteView", owner: nil, options: [:]){
            quoteView = objects.first as? QuoteView
            snapshot(view: quoteView!)
        }
        share(image: snapImage!)
    }
}

