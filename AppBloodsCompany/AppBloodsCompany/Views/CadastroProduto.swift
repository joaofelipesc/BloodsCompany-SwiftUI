import SwiftUI

struct TelaCadastro: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var nome = ""
    @State private var descricao = ""
    @State private var preco = ""
    @State private var tamanho = ""
    @State private var imagemURL = ""
    @State private var mostrarAlertaConfirmacao = false
    var atualizarProdutos: () -> Void

    var body: some View {
        Form {
            Section(header: Text("Informações do Produto")) {
                TextField("Nome", text: $nome)
                TextField("Descrição", text: $descricao)
                TextField("Preço", text: $preco)
                    .keyboardType(.decimalPad)
                TextField("Tamanho", text: $tamanho)
                TextField("URL da Imagem", text: $imagemURL)
            }

            Button("Cadastrar") {
                mostrarAlertaConfirmacao = true
            }
            .disabled(nome.isEmpty || descricao.isEmpty || preco.isEmpty || tamanho.isEmpty || imagemURL.isEmpty)
            .alert("Confirmar Cadastro", isPresented: $mostrarAlertaConfirmacao) {
                Button("Cancelar", role: .cancel) { }
                Button("Confirmar") {
                    guardarProduto()
                }
            } message: {
                Text("Tem certeza que deseja cadastrar este produto?")
            }
        }
        .navigationTitle("Cadastrar Produto")
    }

    private func guardarProduto() {
        guard let precoDouble = Double(preco) else { return }
        let novoProduto = Produto(id: UUID().uuidString, nome: nome, descricao: descricao, preco: precoDouble, tamanho: tamanho, imagemURL: imagemURL)

        ProdutoService().createProduto(produto: novoProduto) { sucesso in
            if sucesso {
                atualizarProdutos()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
