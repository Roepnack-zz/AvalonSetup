//
//  MessageSender.swift
//  AvalonApp
//
//  Created by M. Paul Weeks on 1/16/16.
//  Copyright © 2016 Scott Roepnack. All rights reserved.
//

import Foundation

class MessageSender {

    func sendMessages(players: [PlayerMeta], firstPlayer: String){
        for p in players {
            
            var body = ""
            body += p.secretMessage()
            body += "\n\n"
            body += firstPlayer
            
            sendEmail(p.email, body: body)
        }
    }
    
    var urlPath: String = ""
    var fromEmail: String = ""
    
    func sendEmail(email: String, body: String){
        let formatter = NSDateFormatter()
        formatter.timeStyle = .MediumStyle
        let dateString = formatter.stringFromDate(NSDate())

        
        var myDict: NSDictionary?
        if let path = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDict {
            urlPath = String(dict.valueForKey("MailGunUrl")!)
            fromEmail = String(dict.valueForKey("MailGunFromEmail")!)
        }
        
        let subject = "AVALON - " + dateString
        let form = ("from=\(fromEmail)&to=" + email + "&subject=" + subject + "&text=" + body).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        print ("form: ", form)
        
        let request = NSMutableURLRequest(URL: NSURL(string: "\(urlPath)")!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        request.HTTPBody = form!.dataUsingEncoding(NSUTF8StringEncoding)
        
        print("Request: \(request)")
        print(request.HTTPBody)
        let task = session.dataTaskWithRequest(request, completionHandler: {ret_data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: ret_data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
        })
        task.resume()
    }
}