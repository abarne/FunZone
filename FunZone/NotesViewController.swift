//
//  NotesViewController.swift
//  FunZone
//
//  Created by admin on 5/31/22.
//

import UIKit
import CoreData

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let userDefault = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var newNoteLabel: UILabel!
    private var models = [NoteItem]()
    private var user = [User]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as! NotesTableViewCell
        cell.cellText?.text = model.name
        cell.cellDate?.text = "created on: \(dateFormatter.string(from: model.createdAt!))"
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        return cell
        
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        
        let sheet = UIAlertController(title: "Edit your note", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: {_ in
            let alert = UIAlertController(title: "Edit", message: "Edit your note", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: {[weak self] _ in
                guard let field = alert.textFields?.first, let newText = field.text, !newText.isEmpty else {
                    return
                }
                self?.updateItem(item: item, newName: newText)
            }))
            self.present(alert, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {[weak self] _ in
            self?.deleteItem(item: item)
        }))
        
        present(sheet, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        self.setUser()
        self.getAllItems()

    }
    
    
    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "New Note", message: "Enter your note", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: {[weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.createItem(name: text)
        }))
        present(alert, animated: true)
    }
    
    
    //Core Data CRUD functions
    
    func setUser(){
        let userName = userDefault.string(forKey: "currentLoggedIn")
        do{
            let request = User.fetchRequest() as NSFetchRequest<User>
            let pred = NSPredicate(format: "name == %@", userName!)
            request.predicate = pred
            let userArr = try context.fetch(request)
            user = userArr
        }catch{
            print("error getting items")
        }
    }
    
    func getAllItems(){
        models = user.first?.notes?.allObjects as! [NoteItem]
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func createItem(name: String){
        do{
            let newItem = NoteItem(context: context)
            newItem.name = name
            newItem.createdAt = Date()
            user.first?.addToNotes(newItem)
            try context.save()
            self.getAllItems()
        }catch{
            print("error creating item")
        }
    }
    
    func deleteItem(item: NoteItem){
        context.delete(item)
        do{
            try context.save()
            self.getAllItems()
        }catch{
            print("error deleting NoteItem")
        }
    }
    
    func updateItem(item: NoteItem, newName: String){
        item.name = newName
        do{
            try context.save()
            self.getAllItems()
        }catch{
            print("error saving NoteItem")
        }
    }
}
