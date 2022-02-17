//
//  PokedexViewModel.swift
//  Pokedex_MVVM
//
//  Created by adam smith on 2/16/22.
//

import Foundation
// need a delegate from the ViewModel for the view to load
protocol PokedexViewModelDelegate: AnyObject {
    func pokemonListHasData()
    func encountered(_ error: Error)
}
class PokedexViewModel {
    
    var pokemonList: PokemonList?
    var pokedexResults: [PokemonResults] = []
    var dataProvider = PokedexDataProvider()
    weak var delegate: PokedexViewModelDelegate?
    
    init(delegate: PokedexViewModelDelegate) {
        self.delegate = delegate
        fetch()
    }
    // need to fetch pokedex data
    func fetch() {
        dataProvider.fetch(from: .pokedex) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemonList):
                    self?.pokemonList = pokemonList
                    self?.pokedexResults.append(contentsOf: pokemonList.results)
                    self?.delegate?.pokemonListHasData()
                case .failure(let error):
                    print(error)
                    self?.delegate?.encountered(error)
                }
            }
        }
    }
}
