//
//  SearchViewController.swift
//  FunZone
//
//  Created by admin on 5/27/22.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        let searchString = searchField.text
        let newSearchString = searchString!.replacingOccurrences(of: " ", with: "+")
        if let url = URL(string: "https://www.google.com/search?q=\(newSearchString)"){
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
    }
}
