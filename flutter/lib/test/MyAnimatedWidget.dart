import 'package:flutter/material.dart';

class MyAnimatedWidget extends StatefulWidget {
  @override
  _MyAnimatedWidgetState createState() => _MyAnimatedWidgetState();
}

class _MyAnimatedWidgetState extends State<MyAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Tạo một AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Thời gian hoạt ảnh
      vsync: this, 
    );

    // Tạo một Animation với AnimationController
    _animation = Tween<double>(begin: 0.0, end: 300.0).animate(_controller);

    // Bắt đầu hoạt ảnh
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Giải phóng tài nguyên khi widget bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimationController Example'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: _animation.value,
              height: _animation.value,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/1.jpeg"))),
            );
          },
        ),
      ),
    );
  }
}
