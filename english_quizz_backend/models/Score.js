const mongoose = require("mongoose");

const scoreSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true
  },
  score: {
    type: Number,
    required: true
  },
  level: {
    type: String,
    enum: ["easy", "medium", "hard"],
    required: true
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model("Score", scoreSchema);
// Đảm bảo rằng bạn đã cài đặt mongoose trước khi chạy đoạn mã này  