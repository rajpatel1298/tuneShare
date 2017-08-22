//
//  AddRankingsTableViewController.swift
//  tuneShare
//
//  Created by Raj Patel on 7/12/17.
//  Copyright © 2017 vrknights. All rights reserved.
//

import UIKit

class AddRankingsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var genreImageView: UIImageView!
    @IBOutlet var genreTextField: UITextField!
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var thirdTextField: UITextField!
    @IBOutlet var fourthTextField: UITextField!
    @IBOutlet var fifthTextField: UITextField!
    
    var list: RankingsListMO!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                
                imagePicker.delegate = self
                
                present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Image Picker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            genreImageView.image = selectedImage
            genreImageView.contentMode = .scaleAspectFill
            genreImageView.clipsToBounds = true
        }
        
        let leadingConstraint = NSLayoutConstraint(item: genreImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: genreImageView.superview, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: genreImageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: genreImageView.superview, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: genreImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: genreImageView.superview, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: genreImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: genreImageView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(sender: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(sender: AnyObject){
        if genreTextField.text == "" || firstTextField.text == "" || secondTextField.text == "" || thirdTextField.text == "" || fourthTextField.text == "" || fifthTextField.text == ""{
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
        
        print("Genre: \(String(describing: genreTextField.text))")
        print("First: \(String(describing: firstTextField.text))")
        print("Second: \(String(describing: secondTextField.text))")
        print("Third: \(String(describing: thirdTextField.text))")
        print("Fourth: \(String(describing: fourthTextField.text))")
         print("Fifth: \(String(describing: fifthTextField.text))")
        
        // Save album in database
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            list = RankingsListMO(context: appDelegate.persistentContainer.viewContext)
            list.genre = genreTextField.text
            list.first = firstTextField.text
            list.second = secondTextField.text
            list.third = thirdTextField.text
            list.fourth = fourthTextField.text
            list.fifth = fifthTextField.text
            
            if let genreImage = genreImageView.image {
                if let imageData = UIImagePNGRepresentation(genreImage){
                    list.listImage = NSData(data: imageData)
                }
            }
            
            print("Saving data to context...")
            appDelegate.saveContext()
        }
        
        dismiss(animated: true, completion: nil)
    }

    
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
