//
//  ProdutoBloods.swift
//  AppBloodsCompany
//
//  Created by JOAO FELIPE SILVA COROMBERK on 26/11/24.
//

import Foundation
struct Produto: Identifiable, Codable {
    let id: String
    let nome: String
    let descricao: String
    let preco: Double
    let tamanho: String
    let imagemURL: String
}
