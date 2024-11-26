//
//  DetalhesView.swift
//  AppBloodsCompany
//
//  Created by JOAO FELIPE SILVA COROMBERK on 26/11/24.
//
import SwiftUI
import Foundation
struct DetalhesView: View {
    let produto: Produto
    var body: some View {
        Text("Detalhes de \(produto.nome)")
    }
}
