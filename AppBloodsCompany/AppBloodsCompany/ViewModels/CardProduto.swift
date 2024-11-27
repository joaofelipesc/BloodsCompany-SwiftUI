//
//  CardProduto.swift
//  AppBloodsCompany
//
//  Created by JOAO FELIPE SILVA COROMBERK on 26/11/24.
//

import Foundation
import SwiftUI
import Combine

struct CardProduto: View {
    let produto: Produto
    @StateObject private var imageLoader = ImageLoader()
    @EnvironmentObject var favoritos: Favoritos // Injeta o observable object Favoritos

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 180, height: 220)

            VStack {
                if let image = imageLoader.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .cornerRadius(8)
                } else {
                    ProgressView()
                        .frame(width: 150, height: 150)
                }

                Text(produto.nome)
                    .font(.headline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("\(produto.preco, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.bottom)
                
                HStack { // Adiciona o botão de favorito
                    Spacer()
                    Button(action: {
                        toggleFavorite()
                    }) {
                        Image(systemName: favoritos.contains(produto.id) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(.plain) // Remove o estilo de botão padrão
                    Spacer()
                }
                .padding(.bottom, 5)


            }
        }
        .onAppear {
            if let url = URL(string: produto.imagemURL) {
                imageLoader.loadImage(from: url)
            }
        }
        .onDisappear {
            imageLoader.cancellable?.cancel()
        }
    }

    private func toggleFavorite() {
        if favoritos.contains(produto.id) {
            favoritos.remove(produto.id)
        } else {
            favoritos.add(produto.id)
        }
    }
}


class ImageLoader: ObservableObject {
    @Published var image: Image? = nil
    var cancellable: AnyCancellable? // Tornando acessível fora da classe

    func loadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ in UIImage(data: data) }
            .compactMap { $0 }
            .map { Image(uiImage: $0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                self?.image = $0
            })
    }

    deinit {
        cancellable?.cancel()
    }
}

