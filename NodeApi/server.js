const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const produtoRoutes = require('./routes/produtoRoutes');

const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());

mongoose.set('strictQuery', true);

// Conexão com o MongoDB Atlas
const uri = 'mongodb://tiagocps123:xq5pPEbqmbgf7Z1b@cluster-shard-00-00.62yiy.mongodb.net:27017,cluster-shard-00-01.62yiy.mongodb.net:27017,cluster-shard-00-02.62yiy.mongodb.net:27017/?ssl=true&replicaSet=atlas-m8v90o-shard-0&authSource=admin&retryWrites=true&w=majority&appName=Cluster';
mongoose.connect(uri, { dbName:"BloodsCompany", useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('Conectado ao MongoDB Atlas'))
  .catch(err => console.log('Erro ao conectar ao MongoDB Atlas', err));

// Rotas
app.use('/api/produtos', produtoRoutes);

// Inicializa o servidor
const PORT = 5000;
app.listen(PORT, () => console.log(`Servidor rodando na porta ${PORT}`));

//