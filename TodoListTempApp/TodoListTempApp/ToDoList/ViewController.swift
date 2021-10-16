//
//  ViewController.swift
//  TodoListTempApp
//
//  Created by T.A on 16.10.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = ToDoListViewModel()
        
        toDoList = model.getToDos()
        filterToDoList = toDoList
        
        let addButton = UIBarButtonItem(title: "Ekle", style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        myTableView.reloadData()
    }
    
    
    var toDoList: [ToDoListPresentation] = []
    var filterToDoList: [ToDoListPresentation] = []
    var model : ToDoListViewModel! = nil
    
    @objc func addButtonTapped(){
        
        let viewController = ToDoDetailBuilder.build(with: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}


extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let detailViewController = DetailViewController()
        //self.navigationController?.pushViewController(detailViewController, animated: true)
        
        //let viewController = DetailViewController()
        //viewController.toDo = filterToDoList[indexPath.row]
        //self.navigationController?.pushViewController(viewController, animated: true)
        
        //DetailViewController().toDo = filterToDoList[indexPath.row]
        
        let viewController = ToDoDetailBuilder.build(with: filterToDoList[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterToDoList = searchText.isEmpty ? toDoList : toDoList.filter { (toDo) in
            return toDo.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        myTableView.reloadData()
    }
}


extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterToDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        let toDo = filterToDoList[indexPath.row]
        cell.textLabel?.text = toDo.title
        return cell
    }
    
    
}
