//
//  GameTable.swift
//  PaddockClubPad
//
//  Created by Zel Marko on 05/02/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import Foundation

var bets = [NSDictionary]()

func getBets() {
    
    let url = NSURL(string: "http://disobeythesystem.com/bets_download.php")
    let data = NSData(contentsOfURL: url!)! 
    
    var error: NSError?
    if let dict: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? NSArray {
        
        for (dick) in dict as NSArray {
            bets.append(dick as NSDictionary)
            println(bets)
        }
    }

}