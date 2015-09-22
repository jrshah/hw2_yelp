//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Jay Shah on 9/18/15.
//  Copyright (c) 2015 Jay Shah. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate {

    var businesses: [Business]!
    var searchBar: UISearchBar!
    var searchSettings = YelpSearchSettings()

    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        
        if (indexPath.row ==  businesses.count - 1)
        {
            //searchSettings.offset = searchSettings.offset! + 1
        }
        
        
        return cell
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // initialize UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // add search bar to navigation bar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        doSearch()
        
    }
    
    private func doSearch () {
        
        Business.searchWithTerm(searchSettings.searchString!, sort: .Distance, categories: searchSettings.categories, deals: searchSettings.deals, radius: searchSettings.distance, limit:searchSettings.limit, offset: searchSettings.offset) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // when i press filter button and before i reach the filters page
    // assgin the delegate on this page to get data from another viewcontroller
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navigationController = segue.destinationViewController as! UINavigationController
        
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
        
    }
    
    func filtersViewController (filtersViewController: FiltersViewController, didUpdateFilters filters: [String: AnyObject]) {
                
        let categories = filters["categories"] as? [String]
        let deals = filters["deals"] as? Bool

        print(filters)
        
        let distance = filters["distance"] as? String

        let sortBy:YelpSortMode?
        
        let sortByString = filters["sortBy"] as? String
        
        if (sortByString == "2") {
            sortBy = .HighestRated
        } else  if (sortByString == "1") {
            sortBy = .Distance
        } else {
            sortBy = .BestMatched
        }
        
        searchSettings.categories = categories
        searchSettings.deals = deals
        searchSettings.distance = Int((distance)!)
        
        
        Business.searchWithTerm(searchSettings.searchString!, sort: sortBy , categories: categories, deals: deals, radius: Int((distance)!), limit: searchSettings.limit, offset: searchSettings.offset) { (businesses : [Business]!, error : NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
        
    }

}


extension BusinessesViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
