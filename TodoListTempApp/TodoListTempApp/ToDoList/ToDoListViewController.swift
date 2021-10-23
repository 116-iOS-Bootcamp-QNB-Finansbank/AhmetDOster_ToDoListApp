//
//  ViewController.swift
//  TodoListTempApp
//
//  Created by T.A on 16.10.2021.
//

import UIKit
import CoreData

class ToDoListViewController: UIViewController, ToDoListViewProtocol {
    
    //MARK: - UI View Controller
    @IBOutlet weak var toDoTableView: UITableView!
    
    //MARK: - Properties
    var toDoList: [ToDoListPresentation] = []
    var filterToDoList: [ToDoListPresentation] = []
    var model : ToDoListViewModel!
    var presenter: ToDoListPresenterProtocol!
    var toDos: [ToDoListPresentation] = []
    
    //MARK: - func (UIViewController)
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        addNotificationRefreshToDoList()
        
        addAddUIBarButtonItem()
        sortAddUIBarButtonItem()
    }
    
    //MARK: - func (private)
    func addAddUIBarButtonItem() {
        let addButton = createUIBarButtonItem(imageSystemName: "plus.app", action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    func createUIBarButtonItem(imageSystemName: String, action: Selector) -> UIBarButtonItem
    {
        let imageDelete = UIImage(systemName: imageSystemName)
        let button = UIBarButtonItem(image: imageDelete, style: .plain, target: self, action: action)
        
        return button
    }
    
    func sortAddUIBarButtonItem() {
        let sortButton = UIBarButtonItem(title: "Sırala", style: .plain, target: self, action: #selector(sortButtonTapped))
        navigationItem.leftBarButtonItems = [sortButton]
    }
    
    func addNotificationRefreshToDoList() {
        self.presenter.addNotification(any: self, name: .refreshToDoList, selector: #selector(refreshToDoList))
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
    
    //MARK: - func (objC)
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
    
    @objc func refreshToDoList() {
        presenter.viewDidLoad()
    }
}


//MARK: - UITableViewDelegate (extension)
extension ToDoListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reelIndexPath : IndexPath = getReelIndexPath(todo:filterToDoList[indexPath.row], indexPath: indexPath)
        presenter.didSelectRow(at: reelIndexPath)
    }
    
    func getReelIndexPath(todo: ToDoListPresentation, indexPath: IndexPath) -> IndexPath
    {
        var indexPath = indexPath
        
        for i in 0...toDos.count {
            if toDos[i].id == todo.id {
                indexPath.row = i
                break
            }
        }
        
        return indexPath
    }
}

//MARK: - UISearchBarDelegate (extension)
extension ToDoListViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterToDoList = searchText.isEmpty ? toDos : toDos.filter { (toDo) in
            return toDo.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        toDoTableView.reloadData()
    }
}


//MARK: - UITableViewDataSource (extension)
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
