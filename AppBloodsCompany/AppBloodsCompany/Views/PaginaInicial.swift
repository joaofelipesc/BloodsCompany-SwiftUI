import SwiftUI

struct PaginaInicial: View {
    @StateObject private var viewModel = ProdutoViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color(white: 0.2).ignoresSafeArea()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .fill(Color(red: 0.5, green: 0.0, blue: 0.1))
                            .frame(height: 50)

                        Text("Bloods Company")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: Color.red.opacity(0.5), radius: 2, x: 0, y: 2)
                    }

                    Text("Bem vindo à Bloods Company")
                        .font(.system(size:20, weight: .black, design: .serif))
                        .foregroundColor(.white)
                        .padding(.top, 20)


                    ScrollView(.vertical) {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(viewModel.produtos) { produto in
                                NavigationLink(destination: DetalhesView(produto: produto)) {
                                    CardProduto(produto: produto)
                                }
                            }
                        }
                        .padding()
                    }
                    .padding(.top, 20)
                }

            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}
