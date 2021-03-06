//
//  ItemViewController.swift
//  MyTodo
//
//  Created by aaaabang on 2021/10/26.
//

import UIKit

protocol AddItemDelegate{
    func addItem(item:TodoItem)
}

protocol EditItemDelegate{
    func editItem(newItem:TodoItem,itemIndex: Int)
}

class ItemViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var isChecked: UISwitch!
    @IBOutlet weak var titleInput: UITextField!
    
    var addItemDelegate:AddItemDelegate?
    var editItemDelegate: EditItemDelegate?
    var itemToEdit:TodoItem?
    var itemIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.isEnabled = false
        // Do any additional setup after loading the view.
        if itemToEdit != nil{
            doneButton.isEnabled = true
            self.titleInput.text! = itemToEdit!.title
            self.isChecked.isOn = itemToEdit!.isChecked
        }
    }
    
    @IBAction func cancle(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        if itemToEdit == nil{
            self.addItemDelegate?.addItem(item: TodoItem(title: titleInput.text!, isChecked: isChecked.isOn))
        }
        else{
            self.editItemDelegate?.editItem(newItem: TodoItem(title: titleInput.text!, isChecked: isChecked.isOn),itemIndex:self.itemIndex)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ItemViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField,shouldChangeCharactersIn range:NSRange,replacementString string:String)->Bool{
        let oldText = textField.text!
        let stringRange = Range(range,in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneButton.isEnabled = !newText.isEmpty
        return true
    }
}
