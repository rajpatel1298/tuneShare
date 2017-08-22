//
//  Artist.swift
//  XML-CSVReader
//
//  Created by Vineeth Puli on 7/21/17.
//  Copyright © 2017 ToadTech. All rights reserved.
//

import Foundation
import UIKit

class Artist {
    
    var name = ""
    var twitterHandle = ""
    var twitterAVI: UIImage!
    
    init(name: String, twitterHandle: String){
        self.name = name
        self.twitterHandle = twitterHandle
    }
    
}
