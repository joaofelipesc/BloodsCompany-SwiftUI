//
//  Favorito.swift
//  AppBloodsCompany
//
//  Created by JOAO FELIPE SILVA COROMBERK on 26/11/24.
//

import Foundation

struct Favorito: Identifiable {
    let id: UUID
    let idProduto: String
}

class Favoritos: ObservableObject {
    @Published private(set) var items: Set<String> = [] // Usando Set para evitar duplicatas e melhor performance

    func contains(_ idProduto: String) -> Bool {
        items.contains(idProduto)
    }

    func add(_ idProduto: String) {
        items.insert(idProduto)
    }

    func remove(_ idProduto: String) {
        items.remove(idProduto)
    }
}
