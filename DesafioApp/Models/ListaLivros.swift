//
//  ListaLivros.swift
//  DesafioApp
//
//  Created by humberto Lima on 08/12/19.
//  Copyright © 2019 humberto Lima. All rights reserved.
//

struct ListaLivros: Codable {
    var resultCount: Int?
    var results: [ListaLivrosResults]?
}


struct ListaLivrosResults: Codable {
    var artistName: String?
    var artistViewUrl: String?
    var artworkUrl100: String?
    var artworkUrl60: String?
    var currency: String?
    var description: String?
    var formattedPrice: String?
    var trackCensoredName: String?
    var trackId: Int?
}
