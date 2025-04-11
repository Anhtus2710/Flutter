const express = require('express');
const bcrypt = require('bcrypt');
const router = express.Router();
const User = require('../models/user');

// Đăng ký tài khoản
router.post('/register', async (req, res) => {
  const { username, email, password } = req.body;

  try {
    // Kiểm tra email hoặc username đã tồn tại
    const existingUser = await User.findOne({ $or: [{ email }, { username }] });
    if (existingUser) {
      return res.status(400).json({
        success: false,
        message: 'Tên người dùng hoặc email đã tồn tại',
      });
    }

    // Mã hóa mật khẩu
    const hashedPassword = await bcrypt.hash(password, 10);

    // Tạo user mới
    const newUser = new User({
      username,
      email,
      password: hashedPassword,
    });

    await newUser.save();

    res.status(201).json({
      success: true,
      message: 'Đăng ký thành công',
      user: {
        id: newUser._id,
        username: newUser.username,
        email: newUser.email,
      },
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: 'Lỗi server',
      error: err.message,
    });
  }
});

// Đăng nhập
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    // Tìm user theo email
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'Email không tồn tại',
      });
    }

    // So sánh mật khẩu
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: 'Sai mật khẩu',
      });
    }

    res.status(200).json({
      success: true,
      message: 'Đăng nhập thành công',
      user: {
        id: user._id,
        username: user.username,
        email: user.email,
      },
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: 'Lỗi server',
      error: err.message,
    });
  }
});

// Đặt lại mật khẩu
router.post('/reset-password', async (req, res) => {
  const { email, newPassword } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'Email không tồn tại',
      });
    }

    const hashedPassword = await bcrypt.hash(newPassword, 10);
    user.password = hashedPassword;

    await user.save();

    res.json({
      success: true,
      message: 'Mật khẩu đã được đặt lại thành công',
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: 'Lỗi server',
      error: err.message,
    });
  }
});

module.exports = router;
