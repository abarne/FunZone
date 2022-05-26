//
//  BookViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class BookViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var bookSearchBar: UISearchBar!
    let dataText = ["Book1","Book2","Book3","Book4","Book5","Book6","Book7","Book8","Book9","Book10","Book11","Book12","Book13","Book14","Book15","Book16","Book17","Book18","Book19"]
    let imgData = ["book.fill"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1.0
        cell.bookCellLabel.text = dataText[indexPath.row]
        cell.bookCellImage.image = UIImage(systemName: imgData[0])
        
        return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension BookViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.33, height: self.view.frame.width * 0.37)
    }
}
