import SwiftUI

struct TelaDetalhes: View {
    let produto: Produto

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: URL(string: produto.imagemURL)) { image in
                image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            Text(produto.nome)
                .font(.largeTitle)
            Text("Descrição: \(produto.descricao)")
            Text("Preço: R$ \(produto.preco, specifier: "%.2f")")
            Text("Tamanho: \(produto.tamanho)")

            Spacer()
        }
        .padding()
        .navigationTitle("Detalhes")
    }
}
