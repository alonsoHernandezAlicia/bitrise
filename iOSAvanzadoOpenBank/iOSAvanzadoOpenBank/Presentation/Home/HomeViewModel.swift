//
//  HomeViewModel.swift
//  iOSAvanzadoOpenBank
//
//  Created by Ismael Sabri Pérez on 24/7/23.
//

import Foundation

final class HomeViewModel {
    
    // MARK: Properties
    private let repository: RepositoryProtocol
    private weak var homeView: HomeViewController?
    private var heroes: [Hero] = []
    
    // MARK: - Init
    init(repository: RepositoryProtocol, homeView: HomeViewController) {
        self.repository = repository
        self.homeView = homeView
        getHeroes() {
            DispatchQueue.main.async{
                homeView.tableView.reloadData()
                print("Se ha ejecutado getHeroes")
            }
        }
    }
    
    // MARK: - Methods
    private func getHeroes(completion: @escaping () -> ()) {
        repository.getHeroes(name: "") { heroes, error in
            guard error == nil else {
                print("Error loading heroes")
                return
            }
            self.heroes = heroes
            completion()
        }
    }
    
    func onNeedHeroes() -> [Hero] {
        return heroes
    }
}
