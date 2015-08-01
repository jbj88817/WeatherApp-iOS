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
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string:"http://www.weather-forecast.com/locations/San-Francisco/forecasts/latest")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                print(webContent)
            }
        }
        
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

