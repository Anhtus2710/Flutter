const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const authRoutes = require('./routes/auth'); 
const questionRoutes = require('./routes/question');

const app = express();
const PORT = 3000;

// Kết nối MongoDB
mongoose.connect('mongodb://127.0.0.1:27017/english_quizz_app', {
  useNewUrlParser: true,
  useUnifiedTopology: true
})
.then(() => console.log('Đã kết nối MongoDB'))
.catch(err => console.error('Lỗi kết nối MongoDB:', err));

// Middleware
app.use(cors());
app.use(express.json()); // Đọc body JSON từ client

//Kiểm tra server
app.get('/', (req, res) => {
  res.send('Backend đang hoạt động!');
});

// Gắn các route từ auth
app.use('/api', authRoutes);
app.use('/api/questions', questionRoutes);

// Khởi chạy server
app.listen(PORT, () => {
  console.log(`Server đang chạy tại http://localhost:${PORT}`);
});
