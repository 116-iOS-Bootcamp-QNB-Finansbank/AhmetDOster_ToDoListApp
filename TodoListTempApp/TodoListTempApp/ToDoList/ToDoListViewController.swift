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
    var sortState: String = ""
    
    //MARK: - func (UIViewController)
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        addNotificationRefreshToDoList()
        
        addAddUIBarButtonItem()
        sortAddUIBarButtonItem(imageSystemName: "", tag: 0)
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
    
    func sortAddUIBarButtonItem(imageSystemName: String, tag: Int) {
        
        let sortButton = UIButton(type: .system)
        sortButton.setTitle("Sırala", for: .normal)
        sortButton.setImage(UIImage(systemName: imageSystemName), for: .normal)
        sortButton.addTarget( self, action: #selector(sortButtonTapped(_sender:)), for: .touchUpInside)
        sortButton.tag = tag
        let sortBarButton = UIBarButtonItem(customView: sortButton)
        
        navigationItem.leftBarButtonItems = [sortBarButton]
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
    
    @objc func sortButtonTapped(_sender: UIButton){
        
        let tag = _sender.tag
        
        if tag == 0 || tag==2
        {
            filterToDoList = filterToDoList.sorted(by: {
                $0.completionDate.compare($1.completionDate) == .orderedDescending
            })
            sortAddUIBarButtonItem(imageSystemName: "chevron.down", tag: 1)
        }
        else
        {
            filterToDoList = filterToDoList.sorted(by: {
                $0.completionDate.compare($1.completionDate) == .orderedAscending
            })
            sortAddUIBarButtonItem(imageSystemName: "chevron.up", tag: 2)
        }
        
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
