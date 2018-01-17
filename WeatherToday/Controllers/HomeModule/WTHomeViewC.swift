//
//  WTHomeViewC.swift
//  WeatherToday
//
//  Created by Minakshi Bawa on 16/01/18.
//  Copyright © 2018 OrganisationName. All rights reserved.
//

import UIKit
import SVProgressHUD

class WTHomeViewC: WTBaseViewC
{
    @IBOutlet weak var imgViewWeather: UIImageView!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblDgrees: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!

    //    MARK: - Variable Declaration -
    var imgURL = ""
    var city = ""
    var temp = ""
    var isNoError: Bool = true

    //    MARK: - View LifeCycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar.delegate = self
        configView()
      //  self.getWeatherData()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBAction Methods -
    @IBAction func tapLogoutBtn(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    // MARK: - Private Mwthods -
    func configView()
    {
        lblCityName.text = "Search City..."
        lblDgrees.text = ""
        
    }
    func getWeatherData()
    {
        SVProgressHUD.show()
        let urlRequest = URLRequest(url: URL(string:"http://api.apixu.com/v1/current.json?key=640ef62ee7b4438cba6161914181601&q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error)  in
             SVProgressHUD.dismiss()
            if error == nil
            {
                
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                    if let current = json["current"] as? [String:AnyObject]
                   {
                    if let temp = current["temp_c"] as? Int
                    {
                        self.temp = String(describing:"\(temp)")
                    }
                    if let condition = current["condition"] as? [String : AnyObject] {
                        let icon = condition["icon"] as! String
                        self.imgURL = "http:\(icon)"
                    }
                    }
                    if let location = json["location"] as? [String : AnyObject] {
                        self.city = location["name"] as! String
                    }
                    if let _ = json["error"]
                    {
                         SVProgressHUD.dismiss()
                        self.isNoError = false
                    }
                    DispatchQueue.main.async {
                         SVProgressHUD.dismiss()
                        if self.isNoError
                        {
                            //print("hello")
                            self.lblDgrees.text = "Temperature: " +  "\(self.temp) °"
                            self.lblCityName.text = "City Name: " +  self.city
                            self.imgViewWeather.downloadImage(from: self.imgURL)
                        }
                        else
                        {
                            self.lblDgrees.text = "Temperature: "
                            self.lblCityName.text = "City Name: Not avaialble"
                            self.imgViewWeather.downloadImage(from: "")
                            self.isNoError = true
                        }
                        }
                }
                catch let jasonError
                {
                     SVProgressHUD.dismiss()
                    print(jasonError.localizedDescription)
                }
            }
            
        }
        task.resume()
    }

}
extension WTHomeViewC : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.getWeatherData()
    }
    
}
