//
//  InjuredViewController.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 11/12/20.
//

import Foundation
import UIKit
import CoreData

class InjuredViewController:
    UITableViewController {
    
    var injuredPlayers = [InjuredList]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInjuredPlayers()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadInjuredPlayers()
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.injuredPlayers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "injuredCell", for: indexPath)
        let currentInjured = injuredPlayers[indexPath.row]
        cell.textLabel?.text = currentInjured.name
        cell.textLabel?.font = UIFont(name: "Arial", size: 20)
        cell.detailTextLabel?.text = "On this list since \(currentInjured.injury_date!)"
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 14)
        return cell
    }
    
    func loadInjuredPlayers(){
        let request: NSFetchRequest<InjuredList> = InjuredList.fetchRequest()
        
        do{
            self.injuredPlayers = try context.fetch(request)
            
        }catch{
            print("Error fetching data from context (core data)")
        }
        
        tableView.reloadData()
    }
        
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(action,  view, completionHandler) in
            
            let playerToRemove = self.injuredPlayers[indexPath.row]
            self.context.delete(playerToRemove)
            
            do {
                try self.context.save()
            } catch {
                
            }
            
            self.loadInjuredPlayers()
        }
        return UISwipeActionsConfiguration(actions:[action])
    }
}




        

