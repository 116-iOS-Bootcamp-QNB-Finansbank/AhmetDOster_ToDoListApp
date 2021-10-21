//
//  ViewController.swift
//  TodoListTempApp
//
//  Created by T.A on 16.10.2021.
//

import UIKit
import CoreData

class ToDoListViewController: UIViewController, ToDoListViewProtocol {
    
    @IBOutlet weak var toDoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        addNotificationRefreshToDoList()
        
        let addButton = UIBarButtonItem(title: "Ekle", style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItems = [addButton]
        
        let sortButton = UIBarButtonItem(title: "Sırala", style: .plain, target: self, action: #selector(sortButtonTapped))
        navigationItem.leftBarButtonItems = [sortButton]
      
    }
    
    var presenter: ToDoListPresenterProtocol!
    var toDos: [ToDoListPresentation] = []
    
    func addNotificationRefreshToDoList() {
        NotificationCenterManager().addNotification(any: self, name: .refreshToDoList, selector: #selector(refreshToDoList))
    }
    
    @objc func refreshToDoList() {
        presenter.viewDidLoad()
    }

    func handleOutput(_ output: ToDoListPresenterOutput) {
        switch output {
        case .showToDoList(let toDos):
            self.toDos = toDos
            self.filterToDoList = toDos
            
            DispatchQueue.main.async {
                self.toDoTableView.reloadData()
            }
        }
    }
    
    
    var toDoList: [ToDoListPresentation] = []
    var filterToDoList: [ToDoListPresentation] = []
    var model : ToDoListViewModel! = nil
    
    @objc func addButtonTapped(){
        
        let viewController = ToDoDetailBuilder.build(with: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func sortButtonTapped(){
        
        filterToDoList = filterToDoList.sorted(by: {
            $0.completionDate.compare($1.completionDate) == .orderedDescending
        })
        
        toDoTableView.reloadData()
    }
}


extension ToDoListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let detailViewController = DetailViewController()
        //self.navigationController?.pushViewController(detailViewController, animated: true)
        
        //let viewController = DetailViewController()
        //viewController.toDo = filterToDoList[indexPath.row]
        //self.navigationController?.pushViewController(viewController, animated: true)
        
        //DetailViewController().toDo = filterToDoList[indexPath.row]
        
        presenter.didSelectRow(at: indexPath)
        
        /*
        let viewController = ToDoDetailBuilder.build(with: filterToDoList[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
         */
    }
}

extension ToDoListViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterToDoList = searchText.isEmpty ? toDos : toDos.filter { (toDo) in
            return toDo.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        toDoTableView.reloadData()
    }
}


extension ToDoListViewController : UITableViewDataSource{
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
