import SwiftUI

struct PaginaInicial: View {
    @State private var produtos: [Produto] = []
    @State private var isLoading = true
    let produtoService = ProdutoService()

    var body: some View {
        NavigationView {
            ZStack {
                Color(white: 0.2).ignoresSafeArea()

                VStack(spacing: 0) {
                    // Cabeçalho com cor e texto estilizado
                    ZStack {
                        Rectangle()
                            .fill(Color(red: 0.5, green: 0.0, blue: 0.1))
                            .frame(height: 50)

                        Text("Bloods Company")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: Color.red.opacity(0.5), radius: 2, x: 0, y: 2)
                    }

                    // Saudação do usuário
                    Text("Bem vindo à Bloods Company")
                        .font(.system(size: 20, weight: .black, design: .serif))
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    // Carregar os produtos da API
                    if isLoading {
                        ProgressView("Carregando produtos...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    } else {
                        // Lista de produtos com cards
                        ScrollView(.vertical) {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                ForEach(produtos) { produto in
                                    NavigationLink(destination: TelaDetalhes(produto: produto)) {
                                        CardProduto(produto: produto)
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding(.top, 20)
                    }

                    // Botão para cadastrar produto
                    NavigationLink(destination: TelaCadastro(atualizarProdutos: atualizarProdutos)) {
                        Text("Cadastrar Produto")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.top, 20)
                }
            }
            .onAppear {
                // Chamar a função para buscar os produtos
                produtoService.getProdutos { produtosRecebidos in
                    if let produtosRecebidos = produtosRecebidos {
                        self.produtos = produtosRecebidos
                        self.isLoading = false
                    } else {
                        // Tratar erro de carregamento
                        self.isLoading = false
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }

    // Função para atualizar os produtos
    func atualizarProdutos() {
        produtoService.getProdutos { produtosRecebidos in
            if let produtosRecebidos = produtosRecebidos {
                self.produtos = produtosRecebidos
            }
        }
    }
}
