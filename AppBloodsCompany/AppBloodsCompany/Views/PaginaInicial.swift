import SwiftUI

struct PaginaInicial: View {
    @State private var produtos: [Produto] = []
    @State private var mostrarCadastro = false

    var body: some View {
        NavigationView {
            VStack {
                if produtos.isEmpty {
                    Text("Nenhum produto disponível.")
                        .padding()
                } else {
                    ScrollView {
                        ForEach(produtos) { produto in
                            NavigationLink(destination: TelaDetalhes(produto: produto)) {
                                HStack {
                                    AsyncImage(url: URL(string: produto.imagemURL)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))

                                    VStack(alignment: .leading) {
                                        Text(produto.nome)
                                            .font(.headline)
                                        Text("R$ \(produto.preco, specifier: "%.2f")")
                                            .font(.subheadline)
                                    }
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                    }
                }

                Button(action: {
                    mostrarCadastro.toggle()
                }) {
                    Text("Cadastrar Produto")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .sheet(isPresented: $mostrarCadastro) {
                    TelaCadastro(atualizarProdutos: carregarProdutos)
                }
            }
            .navigationTitle("Produtos")
            .onAppear(perform: carregarProdutos)
        }
    }

    private func carregarProdutos() {
        ProdutoService().getProdutos { produtos in
            if let produtos = produtos {
                self.produtos = produtos
            }
        }
    }
}
