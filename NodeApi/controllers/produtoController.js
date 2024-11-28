const Produto = require('../models/Produto');

// Retorna todos os produtos
exports.getProdutos = async (req, res) => {
  try {
    let produtos = await Produto.find();

    produtos = produtos.map(produto => ({
      id: produto._id,
      nome: produto.nome,
      descricao: produto.descricao,
      preco: produto.preco,
      tamanho: produto.tamanho,
      imagemURL: produto.imagemURL

    })) 
    res.status(200).json(produtos);
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Erro ao buscar produtos', error });
  }
};

// Adiciona um novo produto
exports.createProduto = async (req, res) => {
  try {
    const novoProduto = new Produto(req.body);
    const produtoSalvo = await novoProduto.save();
    res.status(201).json(produtoSalvo);
  } catch (error) {
    res.status(400).json({ message: 'Erro ao cadastrar produto', error });
  }
};

exports.deleteProduto = async (req, res) => {
  const { id } = req.params; // Obtém o ID do produto da URL

  try {
    // Remove o produto do banco de dados
    const produtoDeletado = await Produto.findByIdAndDelete(id);

    if (!produtoDeletado) {
      return res.status(404).json({ message: 'Produto não encontrado' });
    }

    res.status(200).json({ message: 'Produto excluído com sucesso', produto: produtoDeletado });
  } catch (error) {
    res.status(500).json({ message: 'Erro ao excluir o produto', error });
  }
};
