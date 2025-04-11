const mongoose = require("mongoose");

const questionSchema = new mongoose.Schema({
  questionText: {
    type: String,
    required: true
  },
  options: {
    type: [String],
    validate: [arr => arr.length === 4, 'Phải có đúng 4 đáp án']
  },
  correctAnswer: {
    type: Number,
    required: true
  },
  level: {
    type: String,
    enum: ["easy", "medium", "hard"],
    required: true
  }
});

module.exports = mongoose.model("Question", questionSchema);
