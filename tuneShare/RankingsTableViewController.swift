//
//  RankingsTableViewController.swift
//  tuneShare
//
//  Created by Raj Patel on 7/11/17.
//  Copyright © 2017 vrknights. All rights reserved.
//

import UIKit
import CoreData

class RankingsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var lists:[RankingsListMO] = []
    var fetchResultsController: NSFetchedResultsController<RankingsListMO>!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tuneShareBackground")!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Fetch data from store
        let fetchRequest: NSFetchRequest<RankingsListMO> = RankingsListMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "genre", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultsController = NSFetchedResultsController(fetchRequest:
                fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil,
                              cacheName: nil)
            fetchResultsController.delegate = self
            do {
                try fetchResultsController.performFetch()
                if let fetchedObjects = fetchResultsController.fetchedObjects {
                    lists = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "rankingsCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RankingsTableViewCell
        
        if let genreImage = lists[indexPath.row].listImage {
            cell.genreImageView.image = UIImage(data: genreImage as Data)
            cell.genreLabel.text = lists[indexPath.row].genre
            cell.firstLabel.text = "1) \(lists[indexPath.row].first!)"
            cell.secondLabel.text = "2) \(lists[indexPath.row].second!)"
            cell.thirdLabel.text = "3) \(lists[indexPath.row].third!)"
            cell.fourthLabel.text = "4) \(lists[indexPath.row].fourth!)"
            cell.fifthLabel.text = "5) \(lists[indexPath.row].fifth!)"
        }

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Share", handler: { (action, indexPath) -> Void in
            
            let defaultText = "My favorite \(self.lists[indexPath.row].genre!) artists are \(self.lists[indexPath.row].first!) , \(self.lists[indexPath.row].second!) , \(self.lists[indexPath.row].third!) , \(self.lists[indexPath.row].fourth!) , and \(self.lists[indexPath.row].fifth!) in that order. What do you think?"
            
            if let genreImage = self.lists[indexPath.row].listImage,
                let imageToShare = UIImage(data: genreImage as Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText,imageToShare], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        })
        
        // Delete button
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete",handler: { (action, indexPath) -> Void in
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let albumToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(albumToDelete)
                
                appDelegate.saveContext()
            }
            
        })
        
        shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]

    
    }
    

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
