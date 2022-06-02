//
//  SingleBookViewController.swift
//  FunZone
//
//  Created by admin on 5/27/22.
//

import UIKit
import PDFKit

class SingleBookViewController: UIViewController {

    
    @IBOutlet weak var myView: UIView!
    var pdfFile : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pdfView = PDFView(frame: myView.bounds)
        myView.addSubview(pdfView)
        pdfView.autoScales = true
        let filePath = Bundle.main.url(forResource: pdfFile, withExtension: "pdf")
        pdfView.document = PDFDocument(url: filePath!)
    }
}
