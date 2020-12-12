//
//  FavouriteListViewController.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 11/10/20.
//

import Foundation
import UIKit
import CoreData

class FavouriteListViewController:
    UITableViewController {
    
    var favPlayers = [FavList]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavPlayers()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavPlayers()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? FavDetailViewController,
            let selectedIndexPath = self.tableView.indexPathForSelectedRow,
            let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? FavCell else {return}
        
        let confirmedFav = confirmedCell.favPlayer
        destination.favList = confirmedFav
    }
            
        
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favPlayers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favPlayer", for: indexPath) as! FavCell
        let currentFav = favPlayers[indexPath.row]
        cell.favPlayer = currentFav
        cell.name.text = currentFav.name
        cell.name.font = UIFont(name: "Arial", size: 20)
        cell.team.text = currentFav.team_name
        cell.team.font = UIFont(name: "Arial", size: 14)
        return cell
    }
    
    func loadFavPlayers(){
        let request: NSFetchRequest<FavList> = FavList.fetchRequest()
        
        do{
            self.favPlayers = try context.fetch(request)
            
        }catch{
            print("Error fetching data from context (core data)")
        }
        
        tableView.reloadData()
    }
        
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(action,  view, completionHandler) in
            
            let playerToRemove = self.favPlayers[indexPath.row]
            self.context.delete(playerToRemove)
            
            do {
                try self.context.save()
            } catch {
                
            }
            
            self.loadFavPlayers()
        }
        return UISwipeActionsConfiguration(actions:[action])
    }
}




        
