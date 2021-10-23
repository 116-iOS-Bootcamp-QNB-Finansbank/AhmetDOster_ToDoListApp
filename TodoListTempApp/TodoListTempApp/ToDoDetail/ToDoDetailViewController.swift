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
    
    //MARK: - Func( override)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        addNavigationBarSaveButton()
        addNavigationBarBackButton()
        isChange = false
        setInfoLabelHidden(isHidden: true)
        
    }
    
    func setInfoLabelHidden(isHidden: Bool)
    {
        infoLabel.isHidden = isHidden
    }
    
    func addNavigationBarSaveButton(){
        let save = UIBarButtonItem(title: "Kaydet", style: .plain, target: self, action: #selector(saveButtonTapped))

        navigationItem.rightBarButtonItems = [save]
    }
    
    func addNavigationBarBackButton(){
        
        self.navigationItem.hidesBackButton = true
        
        let image = UIImage(systemName: "chevron.left")
        let back = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        
        
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
    
    //MARK: - ObjC Func
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
