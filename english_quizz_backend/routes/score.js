const express = require("express");
const router = express.Router();
const Score = require("../models/Score");
const User = require("../models/user");

// POST /api/score - Lưu điểm
router.post("/", async (req, res) => {
  try {
    const { email, score, level } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "Người dùng không tồn tại" });
    }

    const newScore = new Score({
      userId: user._id,
      score,
      level
    });

    await newScore.save();
    res.status(201).json({ message: "Lưu điểm thành công", data: newScore });

  } catch (err) {
    console.error("Lỗi lưu điểm:", err);
    res.status(500).json({ message: "Lỗi server" });
  }
});

module.exports = router;
