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
    
    var pdfData = ["sample","sample","sample","sample","sample","sample","sample","sample","sample","sample"]
    var dataText = ["Book1","Book2","Book3","Book4","Book5","Book6","Book7","Book8","Book9","Book10"]
    let imgData = ["book.fill"]
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookCollectionViewCell
        
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
      
        let vc = storyboard?.instantiateViewController(withIdentifier: "book") as! SingleBookViewController
        vc.pdfFile = pdfData[indexPath.row]
        present(vc, animated: true)
        
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
