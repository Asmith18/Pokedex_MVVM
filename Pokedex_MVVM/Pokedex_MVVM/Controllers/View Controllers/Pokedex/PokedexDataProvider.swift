//
//  DataProvider.swift
//  Pokedex_MVVM
//
//  Created by adam smith on 2/16/22.
//

import Foundation

protocol PokedexDataProvidable {
    func fetch(from endpoint: PokemonEndpoint, completion: @escaping (Result<PokemonList, NetworkError>) -> Void)
}

struct PokedexDataProvider: APIDataProvidable, PokedexDataProvidable {
    func fetch(from endpoint: PokemonEndpoint, completion: @escaping (Result<PokemonList, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.badURL))
            return
        }
        perform(URLRequest(url: url)) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let pokemon = try decoder.decode(PokemonList.self, from: data)
                    completion(.success(pokemon))
                } catch {
                    completion(.failure(.errorDecoding))
                }
            case .failure(let error):
                completion(.failure(.requestError(error)))
            }
        }
    }
}
