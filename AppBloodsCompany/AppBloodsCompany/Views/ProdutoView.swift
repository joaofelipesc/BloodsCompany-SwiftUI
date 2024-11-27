//
//  ProdutoView.swift
//  AppBloodsCompany
//
//  Created by JOAO FELIPE SILVA COROMBERK on 26/11/24.
//

import Foundation
class ProdutoViewModel: ObservableObject {
    @Published var produtos: [Produto] = []

    init() {
        // Sample product for testing
        produtos = [
            Produto(id: "1001", nome: "Tenis normal", descricao: "Tenis bem normal", preco: 190.00, tamanho: "41", imagemURL: "https://cdn.awsli.com.br/600x1000/1167/1167039/produto/232247520/20-9halrnzrtx.jpg")
            ,
            // Add more sample products here if you want to see multiple cards
            Produto(id: "1002", nome: "Outro Tenis", descricao: "Tenis diferente", preco: 250.00, tamanho: "42", imagemURL: "")
                    ]
    }
}
