//
//  ViewController.swift
//  Project01
//
//  Created by Thonatas Borges on 03/07/21.
//

import UIKit

class PetitionViewController: UITableViewController {

    var petitions = [Petition]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(PetitionTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        
        let urlString = navigationController?.tabBarItem.tag == 0 ? Network.urlTopRated : Network.urlMostRecent
        
        loadData(with: urlString)
        
    }
   
    private func loadData(with urlString: String) {
        Network.shared.fetch(Petitions.self, urlString: urlString) { result in
            switch result {
            case .success(let petitions):
                self.petitions = petitions.results
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Ops!!", message: error.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)

                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PetitionTableViewCell else { return UITableViewCell() }
        let petition = petitions[indexPath.row]
        cell.setup(petition: petition)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let petition = petitions[indexPath.row]
        let detailViewController = DetailViewController()
        detailViewController.detailItem = petition

        navigationController?.pushViewController(detailViewController, animated: true)
    }

}

