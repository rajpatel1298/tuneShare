//
//  RegisterViewController.swift
//  tuneShare
//
//  Created by Raj Patel on 8/5/17.
//  Copyright © 2017 vrknights. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    
    func registerUser(){
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is incomplete")
            return
        }
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil {
                print(error!)
                return
            }
            guard let uid = user?.uid else {
                return
            }
            // Successfully authenticated user
            let imageName = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                        let values = ["name": name, "email": email, "profileImageURL": profileImageURL]
                        self.registerUserInDatabaseWithUID(uid: uid,values: values as [String : AnyObject])
                    }
                })
            }
        })
        print(123)
    }
    
    private func registerUserInDatabaseWithUID(uid: String, values: [String: AnyObject]){
        let ref = FIRDatabase.database().reference(fromURL: "https://tuneshare-39fcf.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        usersReference.updateChildValues(values, withCompletionBlock: { (err,ref) in
            if err != nil {
                print(err!)
                return
            }
            print("Saved user successfully into Firebase db")
            self.performSegue(withIdentifier: "login", sender: nil)
        })
    }

    func handleSelectProfileImageView(){
    
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            
            selectedImageFromPicker = editedImage
            
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.layer.cornerRadius = 75
            profileImageView.clipsToBounds = true
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
