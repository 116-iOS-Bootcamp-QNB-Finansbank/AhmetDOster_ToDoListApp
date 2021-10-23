//
//  ToDoDetailViewController.swift
//  ToDoDetailViewController
//
//  Created by T.A on 16.10.2021.
//

import UIKit

class ToDoDetailViewController: UIViewController {

    //MARK: - UI Control
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var completionDatePicker: UIDatePicker!
    @IBOutlet weak var infoLabel: UILabel!
    
    //MARK: - Properties
    var toDoDetail: ToDoDetailPresentation!
    var viewModel: ToDoDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    var isChange: Bool!
    
    //MARK: - Func ( override)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        
        addNavigationBarLeftButtons()
        addNavigationBarRightButtons()
        
        isChange = false
        setInfoLabelHidden(isHidden: true)
        
    }
    
    func setInfoLabelHidden(isHidden: Bool)
    {
        infoLabel.isHidden = isHidden
    }
    
    func addNavigationBarRightButtons(){
        
        let deleteButton = createUIBarButtonItem(imageSystemName: "trash", action: #selector(deleteButtonTapped))
        let save = createUIBarButtonItem(imageSystemName: "square.and.arrow.up", action: #selector(saveButtonTapped))

        navigationItem.rightBarButtonItems = [deleteButton, save]
    }
    
    func createUIBarButtonItem(imageSystemName: String, action: Selector) -> UIBarButtonItem
    {
        let imageDelete = UIImage(systemName: imageSystemName)
        let button = UIBarButtonItem(image: imageDelete, style: .plain, target: self, action: action)
        
        return button
    }
    
    
    func addNavigationBarLeftButtons(){
        
        self.navigationItem.hidesBackButton = true
        
        let back = createUIBarButtonItem(imageSystemName: "chevron.left", action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItems = [back]
    }
    
    func setCompletionDatePickerMinDate() -> Void
    {
        completionDatePicker.minimumDate = Date()
    }
    
    func setDetail(toDoDetail: ToDoDetailPresentation)
    {
        titleTextField?.text = toDoDetail.title
        detailTextField?.text = toDoDetail.detail
        completionDatePicker.date = toDoDetail.completionDate
    }
    
    func setInfoLabel(text: String, color: UIColor)
    {
        infoLabel.text = text
        infoLabel.textColor = color
        setInfoLabelHidden(isHidden: false)
    }
    
    func isTitleValidation(titleText: String) -> Bool
    {
        return titleText != ""
    }
    
    func isDeleteValidation() -> Bool
    {
        if toDoDetail != nil && toDoDetail.id != ""
        {
            return true
        }
            
        return false
    }
    
    //MARK: - ObjC Func
    @objc func deleteButtonTapped(){
        
        if isDeleteValidation()
        {
            viewModel.deleteToDo(toDoId: toDoDetail!.id)
            setInfoLabel(text: "Silindi.", color: UIColor.red)
            isChange = true
            toDoDetail = nil
            setDetail(toDoDetail: ToDoDetailPresentation())
            
        }
        else
        {
            setInfoLabel(text: "To-do bulunamadı!", color: UIColor.red)
        }
    }
    
    @objc func saveButtonTapped(){
        
        let title = titleTextField.text ?? ""
        let detail = detailTextField.text ?? ""
        
        if isTitleValidation(titleText: title)
        {
            let completionDate = completionDatePicker.date
            
            isChange = true
            if toDoDetail != nil && toDoDetail.id != ""
            {
                let toDoObj = ToDoDetailPresentation(id: toDoDetail.id, title: title, detail: detail , completionDate: completionDate)
                viewModel.updateToDo(toDoDetail: toDoObj)
                setInfoLabel(text: "Güncellendi.", color: UIColor.green)
            }
            else
            {
            
                let toDoObj = ToDoDetailPresentation( title: title, detail: detail, completionDate: completionDate)
                viewModel.addToDo(toDoDetail: toDoObj)
                setInfoLabel(text: "Eklendi", color: UIColor.green)
                toDoDetail = toDoObj
            }
        }
        else
        {
            setInfoLabel(text: "Başlık alanı dolu olmalıdır!", color: UIColor.red)
        }
    }
    
    @objc func backButtonTapped(){
        
        if isChange
        {
            viewModel.postNotification(name: .refreshToDoList)
        }
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extension: ToDoDetailViewModelDelegate
extension ToDoDetailViewController: ToDoDetailViewModelDelegate {
    func showMovieDetail(_ toDo: ToDoDetailPresentation) {
        
        toDoDetail = toDo
        setDetail(toDoDetail: toDo)
    }
}
