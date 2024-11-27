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

    var body: some View {
        ZStack(alignment: .bottom) { // Alinhamento na parte inferior para a sobreposição
            if let image = imageLoader.image {
                image
                    .resizable()
                    .scaledToFill() // Preenche todo o espaço
                    .frame(width: 180, height: 220)
                    .clipped() // Recorta a imagem para caber no frame
            } else {
                ProgressView()
                    .frame(width: 180, height: 220)
            }

            // Sobreposição com gradiente para melhor legibilidade do texto
            LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)

            VStack(alignment: .center, spacing: 4) { // Centraliza o conteúdo verticalmente
                Text(produto.nome)
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .lineLimit(2) // Limita a duas linhas para evitar transbordamento

                Text("R$ \(produto.preco, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 10) // Adiciona um pequeno padding na parte inferior
        }
        .frame(width: 180, height: 220) // Define o tamanho do frame explicitamente
        .cornerRadius(10) // Adiciona cantos arredondados
        .shadow(radius: 4, x: 2, y: 2) // Adiciona uma sombra sutil
        .onAppear {
            if let url = URL(string: produto.imagemURL) {
                imageLoader.loadImage(from: url)
            }
        }
        .onDisappear {
            imageLoader.cancellable?.cancel()
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: Image? = nil
    var cancellable: AnyCancellable?

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
