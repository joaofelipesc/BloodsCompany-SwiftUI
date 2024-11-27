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
    @StateObject private var imageLoader = ImageLoader()
    @State private var image: Image?

    var body: some View {
        ScrollView { // Added ScrollView for longer content
            VStack(alignment: .leading, spacing: 10) { // Use VStack for vertical layout
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    ProgressView() // Show progress while loading
                }

                Text("Nome: \(produto.nome)")
                    .font(.headline)
                Text("Descrição: \(produto.descricao)")
                Text("Preço: \(String(format: "%.2f", produto.preco))") // Format price
                Text("Tamanho: \(produto.tamanho)")
            }
            .padding()
            .onAppear {
                if let url = URL(string: produto.imagemURL) {
                    imageLoader.loadImage(from: url)
                    image = imageLoader.image // Update the @State image
                }
            }
            .onReceive(imageLoader.$image) { newImage in
                self.image = newImage
            }
        }
        .navigationTitle(produto.nome) // Set navigation title
        .navigationBarTitleDisplayMode(.inline) // Display title inline

    }
}
