//
//  ToDoDetailViewController.swift
//  ToDoDetailViewController
//
//  Created by T.A on 16.10.2021.
//

import UIKit

class ToDoDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var detailTextField: UITextField!
    
    @IBOutlet weak var completionDatePicker: UIDatePicker!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var viewModel: ToDoDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
        addNavigationBarSaveButton()
        addNavigationBarBackButton()
        
        /*
        model = ToDoDetailViewModel()
        setCompletionDatePickerMinDate()
     
        setInfoLabelHidden(isHidden : false)
        setDetail()
         */
        
        //setDetail()
        //self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
       // let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        //let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(playTapped))
        
        
        //navigationItem.title = "Detay"
       
       }

    @objc func backButtonTapped(){
        
        self.navigationController?.popToRootViewController(animated: true)
        ///[self.navigationController popViewControllerAnimated:true]
    }
    
    //var model: ToDoDetailViewModel! = nil
    
    func setInfoLabelHidden(isHidden: Bool)
    {
        infoLabel.isHidden = isHidden
    }
    
    func addNavigationBarSaveButton(){
        let save = UIBarButtonItem(title: "Kaydet", style: .plain, target: self, action: #selector(saveButtonTapped))

        navigationItem.rightBarButtonItems = [save]
    }
    
    func addNavigationBarBackButton(){
        self.navigationItem.hidesBackButton = true;
        
        
        let image = UIImage(systemName: "chevron.left")
        let back = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        back.accessibilityLabel = "Geri"
        
        
        navigationItem.leftBarButtonItems = [back]
    }
    
    func setCompletionDatePickerMinDate() -> Void
    {
        completionDatePicker.minimumDate = Date()
    }
    
    var toDo: ToDoListPresentation!
    var toDoDetail: ToDoDetailPresentation!
    
    func setDetail(toDoDetail: ToDoDetailPresentation)
    {
        titleTextField?.text = toDoDetail.title
        detailTextField?.text = toDoDetail.detail
        completionDatePicker.date = toDoDetail.completionDate
    }
    
    @objc func saveButtonTapped(){
        
        
        if let title = titleTextField.text,
            let detail = detailTextField.text
        {
            let completionDate = completionDatePicker.date
            
            if toDo != nil
            {
                let toDoObj = ToDoDetailPresentation(id: toDo.id, title: title, detail: detail, completionDate: completionDate)
                viewModel.updateToDo(toDoDetail: toDoObj)
                setInfoLabel(text: "Güncellendi.", color: UIColor.green)
            }
            else
            {
            
                let toDoObj = ToDoDetailPresentation(id: "", title: title, detail: detail, completionDate: completionDate)
                viewModel.addToDo(toDoDetail: toDoObj)
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

extension ToDoDetailViewController: ToDoDetailViewModelDelegate {
    func showMovieDetail(_ toDo: ToDoDetailPresentation) {
        
        setDetail(toDoDetail: toDo)
    }
}
