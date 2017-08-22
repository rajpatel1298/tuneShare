//
//  DiscoverTableViewController.swift
//  tuneShare
//
//  Created by Raj Patel on 7/15/17.
//  Copyright © 2017 vrknights. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UITableViewController {
    
    var artists:[Artist] = []
    var selectedArtist: Artist!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tuneShareBackground")!)
        
        let csvPath = Bundle.main.path(forResource: "top100", ofType: "csv")
        
        if csvPath == nil {
            return
        }
        
        var csvData: String? = nil
        
        do {
            csvData = try String(contentsOfFile: csvPath!, encoding: String.Encoding.utf8)
            var csv = csvData?.csvRows()
            csv?.remove(at: 0)
            for row in csv!{
                artists.append(Artist(name: row[2], twitterHandle: row[3]))
            }
            
        } catch{
            print(error)
        }
        
//        for artist in artists {
//            print(artist.name + " : " + artist.twitterHandle)
//        }

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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return artists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "discoverCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DiscoverTableViewCell
        
        
        let picUrl = "https://twitter.com/\(artists[indexPath.row].twitterHandle)/profile_image?size=original"
        
//        print(picUrl)
        
        if let url = NSURL(string: picUrl) {
            if let data = NSData(contentsOf: url as URL){
                cell.discoverImageView.image = UIImage(data: data as Data)
            }
        }
            
        cell.discoverImageView.layer.cornerRadius = 50
        cell.discoverImageView.clipsToBounds = true
        cell.discoverArtistLabel.text = artists[indexPath.row].name

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       selectedArtist = artists[indexPath.row]
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "discoverTwitterView" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let twitterViewController = segue.destination as! DiscoverTwitterViewController
                twitterViewController.artist = artists[indexPath.row]
            }
        }
        
        
    }
 

}
