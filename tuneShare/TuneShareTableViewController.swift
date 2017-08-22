//
//  TuneShareTableViewController.swift
//  tuneShare
//
//  Created by Raj Patel on 6/29/17.
//  Copyright © 2017 vrknights. All rights reserved.
//

import UIKit
import CoreData

class TuneShareTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
//    var albums:[Album] = []
    var albums:[AlbumMO] = []
    var fetchResultController: NSFetchedResultsController<AlbumMO>!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tuneShareBackground")!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Fetch data from store
        let fetchRequest: NSFetchRequest<AlbumMO> = AlbumMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "artist", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest:
                fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil,
                              cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    albums = fetchedObjects
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
        return albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cellIdentifier = "favoritesCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TuneShareTableViewCell

        // Configure the cell...
        if let albumImage = albums[indexPath.row].image {
            cell.albumImageView.image = UIImage(data: albumImage as Data)
            cell.albumImageView.contentMode = .scaleAspectFit
            cell.albumImageView.clipsToBounds = true
            
        }
        cell.albumLabel.text = albums[indexPath.row].name
        cell.artistLabel.text = albums[indexPath.row].artist
        cell.yearLabel.text = albums[indexPath.row].year

        return cell
    }
 
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Share", handler: { (action, indexPath) -> Void in
            
            let defaultText = self.albums[indexPath.row].name! + " by " + self.albums[indexPath.row].artist! + " is one of my favorite albums! What do you think?"
            
            if let restaurantImage = self.albums[indexPath.row].image,
                let imageToShare = UIImage(data: restaurantImage as Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText,imageToShare], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        })
        
        // Delete button
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete",handler: { (action, indexPath) -> Void in
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let albumToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(albumToDelete)
                
                appDelegate.saveContext()
            }
            
        })
        
        shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }

    
//    override func viewWillAppear(_ animated: Bool) {
//        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
//            let request: NSFetchRequest<AlbumMO> = AlbumMO.fetchRequest()
//            let context = appDelegate.persistentContainer.viewContext
//            
//            do {
//                albums = try context.fetch(request)
//            } catch {
//                print(error)
//            }
//        }
//    }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    
    func controllerWillChangeContent(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type:
        NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        if let fetchedObjects = controller.fetchedObjects {
            albums = fetchedObjects as! [AlbumMO]
        }
    }
    func controllerDidChangeContent(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    

}
