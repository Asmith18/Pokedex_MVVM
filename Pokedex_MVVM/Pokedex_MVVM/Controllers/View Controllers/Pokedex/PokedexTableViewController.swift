//
//  PokedexTableViewController.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var viewModel: PokedexViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PokedexViewModel(delegate: self)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.pokedexResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonTableViewCell else {return UITableViewCell()}
        let pokemonURLString = viewModel.pokedexResults[indexPath.row].url
        cell.updateViews(pokemonURlString: pokemonURLString)
        return cell
    }
    
    //MARK: - Pagination
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        let lastPokedexIndex = pokedexResults.count - 1
//        guard let pokedex = pokedex, let nextURL = URL(string: pokedex.next) else {return}
        
//        if indexPath.row == lastPokedexIndex {
//            NetworkingController.fetchPokedex(with: nextURL) { result in
//                switch result {
//                case .success(let pokedex):
//                    self.pokedex = pokedex
//                    self.pokedexResults.append(contentsOf: pokedex.results)
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                case .failure(let error):
//                    print("There was an error!", error.errorDescription!)
//                }
//            }
//        }
    }
    
    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toPokemonDetails",
//           let destinationVC = segue.destination as? PokemonViewController {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let pokemonToSend = self.pokedexResults[indexPath.row]
//                NetworkingController.fetchPokemon(with: pokemonToSend.url) { result in
//                    switch result {
//                    case .success(let pokemon):
//                        DispatchQueue.main.async {
//                            destinationVC.pokemon = pokemon
//                        }
//                    case .failure(let error):
//                        print("There was an error!", error.errorDescription!)
//                    }
//                }
//            }
//        }
//    }
}

extension PokedexTableViewController: PokedexViewModelDelegate {
    
    func pokemonListHasData() {
        tableView.reloadData()
    }
    
    func encountered(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Close", style: .cancel))
                alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
                    self?.viewModel?.fetch()
                }))
                present(alertController, animated: true)
    }
}
