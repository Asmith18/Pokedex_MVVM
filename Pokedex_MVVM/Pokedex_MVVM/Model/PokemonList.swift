//
//  PokemonList.swift
//  Pokedex_MVVM
//
//  Created by adam smith on 2/16/22.
//

import Foundation

struct PokemonList: Decodable {
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
    let count: Int
    let next: String
    let previous: String?
    let results: [PokemonResults]
}

struct PokemonResults: Decodable {
    let name: String
    let url: String
}
