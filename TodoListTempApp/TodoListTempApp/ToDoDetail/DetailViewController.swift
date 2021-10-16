//
//  DetailViewController.swift
//  DetailViewController
//
//  Created by T.A on 16.10.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var detailTextField: UITextField!
    
    @IBOutlet weak var completionDatePicker: UIDatePicker!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model = ToDoDetailViewModel()
        setCompletionDatePickerMinDate()
        //setDetail()
        //self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
       // let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        //let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(playTapped))
        
        addSaveButton()
        setInfoLabelHidden(isHidden : false)
        setDetail()
        //navigationItem.title = "Detay"
       

    }
    
    var model: ToDoDetailViewModel! = nil
    
    func setInfoLabelHidden(isHidden: Bool)
    {
        infoLabel.isHidden = isHidden
    }
    
    func addSaveButton(){
        let save = UIBarButtonItem(title: "Kaydet", style: .plain, target: self, action: #selector(saveButtonTapped))

        navigationItem.rightBarButtonItems = [save]
    }
    
    func setCompletionDatePickerMinDate() -> Void
    {
        completionDatePicker.minimumDate = Date()
    }
    
    var toDo: ToDoListPresentation!
    var toDoDetail: ToDoDetailPresentation!
    
    func setDetail()
    {
        if let toDo = toDo
        {
            toDoDetail=model.getToDo(id: toDo.id)
            titleTextField?.text = toDoDetail.title
            detailTextField?.text = toDoDetail.detail
            completionDatePicker.date = toDoDetail.completionDate
        }
        else
        {
            return
        }
    }
    
    @objc func saveButtonTapped(){
        
        if let title = titleTextField.text,
            let detail = detailTextField.text
        {
            let completionDate = completionDatePicker.date
            
            if toDo != nil
            {
                let toDoObj = ToDoDetailPresentation(id: toDo.id, title: title, detail: detail, completionDate: completionDate)
                model.updateToDo(toDo: toDoObj)
                setInfoLabel(text: "Güncellendi.", color: UIColor.green)
            }
            else
            {
            
                let toDoObj = ToDoDetailPresentation(id: "", title: title, detail: detail, completionDate: completionDate)
                model.addToDo(toDo: toDoObj)
                setInfoLabel(text: "Eklendi", color: UIColor.green)
            }
        }
        else
        {
            setInfoLabel(text: "Tüm alanlar dolu olmalıdır!", color: UIColor.red)
        }
        
    }
    
    func setInfoLabel(text: String, color: UIColor)
    {
        infoLabel.text = text
        infoLabel.textColor = color
        setInfoLabelHidden(isHidden: true)
    }

}
