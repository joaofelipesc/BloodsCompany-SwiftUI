const mongoose = require('mongoose');

// Modelo de Produto
const produtoSchema = new mongoose.Schema({
  nome: { type: String, required: true },
  descricao: { type: String, required: true },
  preco: { type: Number, required: true },
  tamanho: { type: String, required: true },
  imagemURL: { type: String, required: true },
  tipo: { type: String, required: true }
});

module.exports = mongoose.model('Produto', produtoSchema);
