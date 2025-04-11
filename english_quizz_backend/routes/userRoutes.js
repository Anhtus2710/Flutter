res.status(200).json({
    success: true,
    message: 'Đăng nhập thành công',
    user: {
      id: user._id,
      username: user.username, // ← dòng này phải có
      email: user.email,
    },
  });
  