//
//  HomeViewController.swift
//  iOSAvanzadoOpenBank
//
//  Created by Ismael Sabri Pérez on 24/7/23.
//

import UIKit

final class HomeViewController: UITableViewController {
    
    
    // MARK: - ViewModel
    var homeViewModel: HomeViewModel?
    
    // MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(UINib(nibName: "HomeCellView", bundle: nil), forCellReuseIdentifier: "homeCellReuseIdentifier")
        tableView.delegate = self
        tableView.separatorStyle = .none
        setViewModel()
    }
    
    private func setViewModel() {
        let remoteDataSource = RemoteDataSourceImpl()
        let repository = RepositoryImpl(remoteDataSource: remoteDataSource)
        self.homeViewModel = HomeViewModel(repository: repository, homeView: self)
    }
        
    // MARK: - UITableDataSource methods -> presentar los datos en la tabla
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel?.onNeedHeroes().count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCellReuseIdentifier", for: indexPath) as? HomeCellViewController else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Esta celda no es la correcta"
            return cell
        }
        
       
        cell.heroImage.setImage(url: homeViewModel?.onNeedHeroes()[indexPath.row].photo)
        cell.heroName.text = homeViewModel?.onNeedHeroes()[indexPath.row].name
        cell.heroDescription.text =  homeViewModel?.onNeedHeroes()[indexPath.row].description
        return cell
    }
    
    // MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = homeViewModel?.onNeedHeroes()[indexPath.row].name
        print(name)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(73)
    }
}
