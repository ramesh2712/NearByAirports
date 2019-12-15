//
//  ViewController.swift
//  NearestAirports
//
//  Created by ramesh on 14/12/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate ,UISearchBarDelegate {
    
    
    private var viewModel = NearByAirportsDetail()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var airportTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        viewModel.viewDidLoad()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
        self.view.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
      //  searchBar.text = ""
        searchBar.resignFirstResponder()
        self.view.endEditing(true)
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
           return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText == "" {
            viewModel.resetAirportList()
            airportTableView.reloadData()
            searchBar.endEditing(true)
        }
        else {
           if viewModel.airportList.count > 0
           {
               viewModel.searchedCity(searchText: searchText)
               airportTableView.reloadData()
              // tlbSearch.reloadData()
           }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchedAirportList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let airport = viewModel.searchedAirportList[indexPath.row]
        cell.textLabel?.text = airport.city
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.findTopFiveNearByAirports(selectedIndexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "NearByAirportsSegue", sender: self)
    }
    
       // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
           if (segue.identifier == "NearByAirportsSegue") {
            let viewController = segue.destination as! NearByAirportsController
            viewController.nearByAirports = viewModel.nearByAirports
           }
       }
}

