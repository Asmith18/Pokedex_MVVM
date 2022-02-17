//
//  PokemonEndpoint.swift
//  Pokedex_MVVM
//
//  Created by adam smith on 2/16/22.
//

import Foundation

extension URL {
    static let pokemonBaseURL = URL(string: "https://pokeapi.co/api/v2/")
}

enum PokemonEndpoint {
    case pokedex
    case pokemon(String)
    
    var url: URL? {
        guard var baseURL = URL.pokemonBaseURL else { return nil }
        baseURL.appendPathComponent("pokemon")
        
        switch self {
        case .pokedex:
            //https://pokeapi.co/api/v2/pokemon/
            return baseURL
        case .pokemon(let pokemon):
            baseURL.appendPathComponent(pokemon)
            //https://pokeapi.co/api/v2/pokemon/112
            return baseURL
        }
    }
}
