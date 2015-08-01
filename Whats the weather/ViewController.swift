//
//  ViewController.swift
//  Whats the weather
//
//  Created by Bojie Jiang on 7/31/15.
//  Copyright © 2015 Bojie Jiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    
    
    @IBOutlet weak var displayWeatherLabel: UILabel!
    
    @IBAction func getWeatherBtn(sender: AnyObject) {
        
        var wasSucessful = false
        
        
        let attemptedUrl = NSURL(string:"http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                if let urlContent = data {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let websiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    if websiteArray!.count > 1 {
                        
                        wasSucessful = true
                        
                        let weatherArray = websiteArray![1].componentsSeparatedByString("</span>")
                        
                        if weatherArray.count > 1 {
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.displayWeatherLabel.text = weatherSummary
                            })
                        }
                    }
                    
                }
                if wasSucessful == false {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                         self.displayWeatherLabel.text = "Couldn't find the weather for that city - please try again!"
                    })
                   
                }
            }
            
            task.resume()
        } else {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                 self.displayWeatherLabel.text = "Couldn't find the weather for that city - please try again!"
            })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        cityTextField.resignFirstResponder()
        return true
    }
    
    
    
}

