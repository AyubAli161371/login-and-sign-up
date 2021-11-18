//
//  SignupViewController.swift
//  ayub
//
//  Created by - on 06/11/2021.
//

import UIKit

class SignupViewController: UITableViewController, UITextFieldDelegate {
   
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtComPassword: UITextField!
    @IBOutlet weak var txtDateOfBirth: UITextField!
    
    var activeField: UITextField! = nil
    private var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsername.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtComPassword.delegate = self
        
           let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        initializeHideKeyboard()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        txtDateOfBirth.inputView = datePicker
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       activeField = textField
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    txtDateOfBirth.text = dateFormatter.string(from: datePicker.date)
    view.endEditing(true)

    }


    @objc func keyboardShow(notification:Notification){
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardsize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.height - keyboardsize.height
        let editingTextFieldY = activeField.convert(activeField.bounds, to: self.view).minY;
        if self.view.frame.minY >= 0{
            if editingTextFieldY > keyboardY - 70 {
                UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY-(keyboardY-50)), width:self.view.bounds.width , height: self.view.bounds.height)

                },completion: nil)
            }

        }
    }

    @objc func keyboardHidden(notification:Notification){
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width:self.view.bounds.width , height: self.view.bounds.height)

        },completion: nil)
    }
    
    
    
    func initializeHideKeyboard() {

    let Tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(dismissMyKeyboard))
view.addGestureRecognizer(Tap)

    }
    //obj func for Dismiss keyboard
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    

    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
}
    @IBAction func btnSignupClicked(_ sender: UIButton) {
        let imgSystem = UIImage(systemName: "person.crop.circle.badge.plus")
               
               if imgProfile.image?.pngData() != imgSystem?.pngData(){
                   // profile image selected
                   if let email = txtEmail.text, let password = txtPassword.text, let username = txtUsername.text, let conPassword = txtComPassword.text{
                       if username == ""{
                           print("Please enter username")
                       }else if !email.validateEmailId(){
                           openAlert(title: "Alert", message: "Please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                           print("email is not valid")
                       }else if !password.validatePassword(){
                           print("Password is not valid")
                       } else{
                           if conPassword == ""{
                               print("Please confirm password")
                           }else{
                               if password == conPassword{
                                   // navigation code
                                   print("Navigation code Yeah!")
                               }else{
                                   print("password does not match")
                               }
                           }
                       }
                   }else{
                       print("Please check your details")
                   }
              }//else{
//                   print("Please select profile picture")
//                   openAlert(title: "Alert", message: "Please select profile picture", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
//               }
           }
    
        }

//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        activeTextField = textField
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }




