//
//  TweetFeed.swift
//  PaddockClubPad
//
//  Created by Zel Marko on 25/12/14.
//  Copyright (c) 2014 Zel Marko. All rights reserved.
//

import UIKit
import SwifteriOS
import ImageIO

var tweets: [JSONValue] = []
var tweetImages: [UIImage] = []

func fetchTweets() {
    
    var swifter: Swifter
    
    swifter = Swifter(consumerKey: "UzvjCl7rOuH6B9rvewRQidNnq", consumerSecret: "Oofp5X8IqRxAwS4aDfUd5ZjXmWo11CJVmx5Lg9mYeGSGFW7MCl")
    
    swifter.getSearchTweetsWithQuery("FormulaOne", geocode: nil, lang: nil, locale: nil, resultType: nil, count: 10, until: nil, sinceID: nil, maxID: nil, includeEntities: true, callback: nil, success: { (statuses, searchMetadata) -> Void in
        
        tweets = statuses!
        println(tweets.count)
        for var i = 0; i < tweets.count; ++i {
            if var imageURL = tweets[i]["entities"]["media"][0]["media_url"].string {
                
                let url = NSURL(string: imageURL)
                
                let image = CGImageSourceCreateWithURL(url, nil)
                let option: [String: AnyObject] = [
                    
                    kCGImageSourceCreateThumbnailFromImageAlways : true
                ]
                
                let preview = UIImage(CGImage: CGImageSourceCreateThumbnailAtIndex(image, 0, option))
                
                let coeficient = CGFloat(297.0 / preview!.size.width)
                let size = CGSizeApplyAffineTransform(preview!.size, CGAffineTransformMakeScale(coeficient, coeficient))
                let hasAlpha = false
                let scale: CGFloat = 0.0
                
                UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
                preview!.drawInRect(CGRect(origin: CGPointZero, size: size))
                
                let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                //println(scaledImage!.size)
                
                tweetImages.append(scaledImage!)
                
            } else {
                tweetImages.append(UIImage(named: "placeholder")!)
            }

        }
        
    }) { (error) -> Void in
        
    }
    
}

/*

class InternalHelper: NSObject {
    
    class func downloadImage(url: NSURL, handler: ((image: UIImage, NSError!) -> Void)) {
    
        var imageRequest: NSURLRequest = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(imageRequest,
                                                queue: NSOperationQueue.mainQueue(),
                                                completionHandler: {response, data, error in
        handler(image: UIImage(data: data)!, error)
        })
    }

}
*/
 