//
//  BookViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

struct Book {
    let bookTitle: String
    let bookImage: UIImage
    let bookText: String
}

class BookViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    

    var dataText = ["Book1","Book2","Book3","Book4","Book5","Book6","Book7","Book8","Book9","Book10","Book11","Book12","Book13","Book14","Book15","Book16","Book17","Book18","Book19"]
    let imgData = ["book.fill"]
    var sampleText = ["This is some sample text to see if it works. Thanks"]
    
    
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

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        return searchView
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("You searched for \(searchBar.text!)")
    }
    
    func collectionView(_ collectionView: UICollectionView,
      didSelectItemAt indexPath: IndexPath) {
      
        print(dataText[indexPath.row])
        
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
