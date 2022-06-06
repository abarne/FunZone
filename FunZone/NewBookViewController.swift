//
//  NewBookViewController.swift
//  FunZone
//
//  Created by admin on 6/6/22.
//

import UIKit

class NewBookViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    var bookData = [Book]()
    var tempArr : [Book] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addData()
        tempArr = bookData
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookCollectionViewCell
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1.0
        cell.bookCellLabel.text = bookData[indexPath.row].dataText
        cell.bookCellImage.image = UIImage(named: bookData[indexPath.row].imgData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        return searchView
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            bookData = tempArr
        }else {
            bookData = tempArr.filter({
                $0.dataText.contains(searchBar.text!)
            })
        }
        
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
      didSelectItemAt indexPath: IndexPath) {
      
        let vc = storyboard?.instantiateViewController(withIdentifier: "book") as! SingleBookViewController
        vc.pdfFile = bookData[indexPath.row].pdfData
        present(vc, animated: true)
      }
    
    func addData(){
        bookData.append(Book(pdfData: "sample", dataText: "Deathly Hallows", imgData: "deathly"))
        bookData.append(Book(pdfData: "lorem-ipsum", dataText: "Chamber of Secrets", imgData: "chamber"))
        bookData.append(Book(pdfData: "pdf", dataText: "HalfBlood Prince", imgData: "halfblood"))
        bookData.append(Book(pdfData: "c4611_sample_explain", dataText: "Phoenix", imgData: "phoenix"))
        bookData.append(Book(pdfData: "pdf-sample", dataText: "Sorcerer's Stone", imgData: "sorcerer"))
    }
}

struct Book {
    let pdfData : String
    let dataText : String
    let imgData : String
}

extension NewBookViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.33, height: self.view.frame.width * 0.37)
    }
}
