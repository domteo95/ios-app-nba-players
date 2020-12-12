//
//  ViewController.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 10/1/20.
//

import UIKit
import CoreData
import SwiftUI

class PlayersListViewController: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    var players: [player] = []
    var filteredPlayers: [player] = []
    var names: [player] = []
    var teams: [player] = []
    var playerService: PlayerService!
    var activitySpinner = UIActivityIndicatorView(style: .large)
    var sortBy: String = "Name"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        activitySpinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activitySpinner)
        activitySpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activitySpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activitySpinner.startAnimating()
        
        self.playerService = PlayerService()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        rightBarButton.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont(name: "Arial", size: 12)!], for: UIControl.State.normal)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let confirmedService = self.playerService else {return}
        self.searchBar.text = ""
        self.rightBarButton.title = "Sort By Points"
        confirmedService.getPlayers(completion: { players, error in
            guard let players = players, error == nil else {
                self.activitySpinner.stopAnimating()
                
                if error as! PlayerCallingError == PlayerCallingError.problemGeneratingURL{
                        let image = UIImage(named: "no_results")
                        let imageView = UIImageView()
                        imageView.image = image
                        imageView.contentMode = .scaleAspectFit
                        imageView.center = self.tableView.center
                        self.tableView.backgroundColor = .systemRed
                        self.tableView.separatorStyle = .none
                        self.tableView.backgroundView = imageView
                }
                
                if error as! PlayerCallingError == PlayerCallingError.problemGettingDataFromAPI  {
                    let alert = UIAlertController(title: "Network Issue", message: "App is working but either there's no wifi or network connection",         preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "Thanks", style: UIAlertAction.Style.default, handler: { _ in
                                //Cancel Action
                            }))
                    alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { _ in
                        self.viewDidLoad()
                        self.viewWillAppear(true)
                        
                            }))
                        
                            self.present(alert, animated: true, completion: nil)
                }
                
                if error as! PlayerCallingError == PlayerCallingError.problemDecodingData {
                    let alert = UIAlertController(title: "API call problem", message: "App is working but the API is not working!",         preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "Thanks", style: UIAlertAction.Style.default, handler: { _ in
                                
                            }))
                    
                            self.present(alert, animated: true, completion: nil)
                }
                
                return
            }
            
            self.players = players
            self.filteredPlayers = players
            self.tableView.reloadData()
            self.activitySpinner.stopAnimating()
            
        })
    }
    
    
    @IBAction func sortBy(_ sender: Any) {
        if self.sortBy == "Name" {
            self.sortBy = "Points"
            rightBarButton.title = "Sort by Name"
            self.filteredPlayers = players.sorted(by: {Double($0.points_per_game)! > Double($1.points_per_game)!})
        }
        else {
            self.sortBy = "Name"
            rightBarButton.title = "Sort by Points"
            self.filteredPlayers = players.sorted(by: {$0.name < $1.name})

        }
        self.tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? DetailViewController,
            let selectedIndexPath = self.tableView.indexPathForSelectedRow,
            let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? NbaCell else { return}
        
        let confirmedPlayer = confirmedCell.player
        destination.player = confirmedPlayer
                    
    }
    
    // Search Bar Config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // when we change the text in the search bar
        
        self.searchBar.setShowsScope(true, animated: true)
        self.searchBar.scopeButtonTitles = ["Both", "Player Name", "Team Name"]
        self.filteredPlayers = []
        self.teams = []
        self.names = []
        
        let scopeButton = self.searchBar.scopeButtonTitles![self.searchBar.selectedScopeButtonIndex]
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        if searchText == "" {
            self.filteredPlayers = self.players
            self.searchBar.setShowsScope(false, animated: true)
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
        if scopeButton == "Both" || scopeButton == "Player Name"{
            for player in self.players {
                if player.name.lowercased().contains(searchText.lowercased()){
                    self.names.append(player)
                }
            }
        }
        
        if scopeButton == "Both" || scopeButton == "Team Name"{
            for player in self.players{
                if player.team_name.lowercased().contains(searchText.lowercased()){
                    self.teams.append(player)
                }
            }
        }
        self.filteredPlayers += self.names + self.teams
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        // when we switch between the different scopes
        self.filteredPlayers = []
        self.searchBar.showsScopeBar = true
        let scopeButton = self.searchBar.scopeButtonTitles![self.searchBar.selectedScopeButtonIndex]

        if scopeButton == "Both" || scopeButton == "Player Name"{
            self.filteredPlayers += self.names
        }
        else if scopeButton == "Both" || scopeButton == "Team Name"{
            self.filteredPlayers += self.teams
        }
        self.tableView.reloadData()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
        self.searchBar.showsScopeBar = false
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}

extension PlayersListViewController: UITableViewDataSource {
    
    //MARK: DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.filteredPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "filmCell") as! NbaCell
        let currentPlayer = self.filteredPlayers[indexPath.row]
        cell.player = currentPlayer
        return cell
    }
}

extension PlayersListViewController: UITableViewDelegate {
    //MARK: Delegate
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let injured = injuredAction(at: indexPath)

        return UISwipeActionsConfiguration(actions: [injured])
    }
    
    func injuredAction(at indexPath: IndexPath) -> UIContextualAction {

        let cell = self.tableView.cellForRow(at: indexPath) as? NbaCell, confirmedPlayer = cell?.player
        
        let choice = "Injured"
        
        let action = UIContextualAction(style: .normal, title: choice){(action, view, completion) in
            confirmedPlayer!.injured = !confirmedPlayer!.injured

            if confirmedPlayer!.injured {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                let entity = NSEntityDescription.entity(forEntityName: "InjuredList", in: context)
                let injuredPlayer = NSManagedObject(entity: entity!, insertInto: context)
                injuredPlayer.setValue(confirmedPlayer!.name, forKey: "name")
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let today = dateFormatter.string(from: date)
                injuredPlayer.setValue(today, forKey: "injury_date")
                
                do {
                   try context.save()
                    print(confirmedPlayer!.name, "added to list on \(today)")
                  } catch {
                   print("Failed saving")
                }
                
            }
            completion(true)
                
        }
        action.backgroundColor = .systemRed
        action.image = UIImage(systemName: "cross.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return action
       
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let fav = favAction(at: indexPath)

        return UISwipeActionsConfiguration(actions: [fav])
    }
    
    func favAction(at indexPath: IndexPath) -> UIContextualAction {

        let cell = self.tableView.cellForRow(at: indexPath) as? NbaCell, confirmedPlayer = cell?.player
        
        let choice = "Add to Favorites"
        let action = UIContextualAction(style: .normal, title: choice){(action, view, completion) in
            confirmedPlayer!.fav = !confirmedPlayer!.fav
        
            if confirmedPlayer!.fav {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                let entity = NSEntityDescription.entity(forEntityName: "FavList", in: context)
                let favPlayer = NSManagedObject(entity: entity!, insertInto: context)
                favPlayer.setValue(confirmedPlayer!.name, forKey: "name")
                favPlayer.setValue(confirmedPlayer!.team_name, forKey: "team_name")
                favPlayer.setValue(confirmedPlayer!.points_per_game, forKey: "points")
                favPlayer.setValue(confirmedPlayer!.assists_per_game, forKey: "assists")
                favPlayer.setValue(confirmedPlayer!.blocks_per_game, forKey: "blocks")
                favPlayer.setValue(confirmedPlayer!.minutes_per_game, forKey: "minutes")
                favPlayer.setValue(confirmedPlayer!.imageUrl, forKey: "image")
                favPlayer.setValue(confirmedPlayer!.steals_per_game, forKey:"steals")
                favPlayer.setValue(confirmedPlayer!.rebounds_per_game, forKey:"rebounds")
                favPlayer.setValue(confirmedPlayer!.player_efficiency_rating, forKey:"per")
                do {
                   try context.save()
                    print(confirmedPlayer!.name)
                  } catch {
                   print("Failed saving")
                }
                
            }
            completion(true)
                
        }
        action.backgroundColor = .white
        action.image = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        
        return action
       
    }
}

