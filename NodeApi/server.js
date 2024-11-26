// Importar dependências
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { MongoClient } = require('mongodb');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

const MONGO_URL = 'mongodb://tiagocps123:xq5pPEbqmbgf7Z1b@cluster-shard-00-00.62yiy.mongodb.net:27017,cluster-shard-00-01.62yiy.mongodb.net:27017,cluster-shard-00-02.62yiy.mongodb.net:27017/?ssl=true&replicaSet=atlas-m8v90o-shard-0&authSource=admin&retryWrites=true&w=majority&appName=Cluster';

let db;

async function connectToDatabase() {
  try {
    const client = await MongoClient.connect(MONGO_URL, {
      useNewUrlParser: true,
      useUnifiedTopology: true
    });
    db = client.db();
    console.log('Conectado ao banco de dados!');
  } catch (err) {
    console.error('Erro ao conectar ao MongoDB:', err);
  }
}

connectToDatabase();


// Modelo com 5 atributos
app.get('/items', (req, res) => {
  db.collection('items').find().toArray((err, results) => {
    if (err) {
      res.status(500).send('Erro ao buscar itens.');
    } else {
      res.status(200).json(results);
    }
  });
});

app.post('/items', (req, res) => {
  const newItem = req.body;

  // Verificar campos obrigatórios
  if (!newItem.name || !newItem.description || !newItem.price || !newItem.imageUrl || !newItem.category) {
    console.error('Campos obrigatórios ausentes:', newItem);
    return res.status(400).send('Todos os campos são obrigatórios.');
  }

  db.collection('items').insertOne(newItem, (err, result) => {
    if (err) {
      console.error('Erro ao inserir item no MongoDB:', err);
      res.status(500).send('Erro ao adicionar item.');
    } else {
      console.log('Item adicionado com sucesso:', result.ops[0]);
      res.status(201).send('Item adicionado com sucesso.');
    }
  });
});

// Iniciar servidor
app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
});
