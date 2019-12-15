//
//  NearByAirportsController.swift
//  NearestAirports
//
//  Created by ramesh on 15/12/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class NearByAirportsController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var nearByAirports = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearByAirports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        let airport = nearByAirports[indexPath.row]
        
        cell.textLabel?.text = airport["name"] as? String
        cell.detailTextLabel?.numberOfLines = 0

        let runwaylength = airport["runway_length"] as! Int
        let country = airport["country"] as! String

        if runwaylength == 0 {
            cell.detailTextLabel?.text = "Runway Length : " + "Data is not available" + "\n" + "Country : " + country
        } else {
            cell.detailTextLabel?.text = "Runway Length : " + String(runwaylength) + "\n" + "Country : " + country
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
