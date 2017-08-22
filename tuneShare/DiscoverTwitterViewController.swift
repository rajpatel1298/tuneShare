//
//  DiscoverTwitterViewController.swift
//  tuneShare
//
//  Created by Raj Patel on 7/13/17.
//  Copyright © 2017 vrknights. All rights reserved.
//

import UIKit
import TwitterKit

class DiscoverTwitterViewController: TWTRTimelineViewController {
    
    var artist: Artist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(artist.twitterHandle)
        
        let client = TWTRAPIClient()
        
        
        let searchSource = TWTRSearchTimelineDataSource(searchQuery: "\(artist.name)", apiClient: client)
        searchSource.resultType = "popular"
//        let travisDataSource = TWTRUserTimelineDataSource(screenName: artist.twitterHandle, apiClient: client)
        
        self.dataSource = searchSource
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
