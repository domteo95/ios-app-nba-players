//
//  PlayerService.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 10/8/20.
//

import Foundation

enum PlayerCallingError: Error {
    case problemGeneratingURL
    case problemGettingDataFromAPI
    case problemDecodingData
}

class PlayerService {
    
    private let urlString = "https://nba-players.herokuapp.com/players-stats"
    
    func getPlayers(completion: @escaping ([player]?, Error?) -> ()) {
            guard let url = URL(string: self.urlString) else {
                DispatchQueue.main.async {
                    completion(nil, PlayerCallingError.problemGeneratingURL) }
                return
        }
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async { completion(nil, PlayerCallingError.problemGettingDataFromAPI) }
                    return
                }
                do {
                    let playerResult = try JSONDecoder().decode([player].self, from: data)
                    DispatchQueue.main.async { completion(playerResult, nil) }
                } catch (let error) {
                    print(error)
                    DispatchQueue.main.async { completion(nil, PlayerCallingError.problemDecodingData) }
                }
            }
            task.resume()
        }
}
    

