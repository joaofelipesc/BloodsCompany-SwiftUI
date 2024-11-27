const express = require('express');
const { getProdutos, createProduto, deleteProduto } = require('../controllers/produtoController');

const router = express.Router();

router.get('/', getProdutos);
router.post('/', createProduto);
router.delete('/:id', deleteProduto);

module.exports = router;
