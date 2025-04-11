const express = require("express");
const router = express.Router();
const Question = require("../models/Question");

// ➕ Thêm câu hỏi mới
router.post("/", async (req, res) => {
  try {
    const newQuestion = new Question(req.body);
    await newQuestion.save();
    res.status(201).json({ message: "Thêm câu hỏi thành công", data: newQuestion });
  } catch (err) {
    res.status(500).json({ message: "Lỗi thêm câu hỏi", error: err.message });
  }
});

// 📋 Lấy toàn bộ câu hỏi
router.get("/", async (req, res) => {
  try {
    const questions = await Question.find();
    res.json(questions);
  } catch (err) {
    res.status(500).json({ message: "Lỗi lấy danh sách", error: err.message });
  }
});

// 🧠 Lấy ngẫu nhiên 10 câu theo mức độ
router.get("/random/:level", async (req, res) => {
  try {
    const questions = await Question.aggregate([
      { $match: { level: req.params.level } },
      { $sample: { size: 10 } }
    ]);
    res.json(questions);
  } catch (err) {
    res.status(500).json({ message: "Lỗi lấy câu hỏi ngẫu nhiên", error: err.message });
  }
});

// 📝 Sửa câu hỏi theo ID
router.put("/:id", async (req, res) => {
  try {
    const updated = await Question.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!updated) return res.status(404).json({ message: "Không tìm thấy câu hỏi" });
    res.json({ message: "Cập nhật thành công", data: updated });
  } catch (err) {
    res.status(500).json({ message: "Lỗi cập nhật", error: err.message });
  }
});

// ❌ Xóa câu hỏi theo ID
router.delete("/:id", async (req, res) => {
  try {
    const deleted = await Question.findByIdAndDelete(req.params.id);
    if (!deleted) return res.status(404).json({ message: "Không tìm thấy câu hỏi để xóa" });
    res.json({ message: "Xóa thành công" });
  } catch (err) {
    res.status(500).json({ message: "Lỗi xóa", error: err.message });
  }
});

module.exports = router;
