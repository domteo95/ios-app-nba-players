//
//  ViewController.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 10/1/20.
//

import UIKit

class FilmListViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var films: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.films = ["Godfather", "Harry Potter", "Once Upon A Time In Hollywood", "Godfather", "Harry Potter", "Once Upon A Time In Hollywood", "Godfather", "Harry Potter", "Once Upon A Time In Hollywood", "Godfather", "Harry Potter", "Once Upon A Time In Hollywood"]
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
  
}

extension FilmListViewController: UITableViewDataSource {
    
    //MARK: DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "filmCell")!
        
        cell.textLabel?.text = self.films[indexPath.row]
        
        return cell
    }
}

extension FilmListViewController: UITableViewDelegate {
    //MARK: Delegate
    
    
}
