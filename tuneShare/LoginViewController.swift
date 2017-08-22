//
//  LoginViewController.swift
//  tuneShare
//
//  Created by Raj Patel on 8/3/17.
//  Copyright © 2017 vrknights. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var rememberSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        rememberSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToHomeScreenWithSegue(){
        
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
