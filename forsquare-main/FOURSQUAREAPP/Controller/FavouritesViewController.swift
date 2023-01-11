//
//  FavouritesViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 04/01/23.
//

import UIKit

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
   
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ContentTableViewCell ?? UITableViewCell()
            return cell
    }
    

  
}
