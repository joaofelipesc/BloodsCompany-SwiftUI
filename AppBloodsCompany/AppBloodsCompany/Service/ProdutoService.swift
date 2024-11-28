import Foundation

class ProdutoService {
    let baseURL = "http://localhost:5000/api/produtos/"

    func getProdutos(completion: @escaping ([Produto]?) -> Void) {
        guard let url = URL(string: "\(baseURL)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Erro ao buscar produtos: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let produtos = try JSONDecoder().decode([Produto].self, from: data)
                DispatchQueue.main.async {
                    completion(produtos)
                }
            } catch {
                print("Erro ao decodificar JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }

    func createProduto(produto: Produto, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(produto)
            request.httpBody = jsonData
        } catch {
            print("Erro ao codificar JSON: \(error.localizedDescription)")
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("Erro ao cadastrar produto: \(error.localizedDescription)")
                completion(false)
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                completion(true)
            } else {
                completion(false)
            }
        }.resume()
    }
}
