import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:taka_naqis/core/widgets/app_bar.dart';
import 'package:taka_naqis/core/widgets/circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ navigation/navigation.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AdminCubit()..getStats(context: context),
      child: BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var stats = AdminCubit.get(context).statsModel;
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  CustomAppBarBack(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ConditionalBuilder(
                        condition: stats != null,
                        builder: (c) => SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),

                              // ====== Users Card ======
                              _buildCard(
                                title: "المستخدمين",
                                children: [
                                  Text(": توزيع المستخدمين", style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 220, child: _buildUsersPieChart(stats)),
                                  const Divider(),

                                  _buildStatRow("المجموع", stats!.users.total.toString()),
                                  _buildStatRow("الموثقين", stats.users.verified.toString()),
                                  _buildStatRow("المسؤولين", stats.users.roles.admin.toString()),
                                  // _buildStatRow("الوكلاء", stats.users.roles.agent.toString()),
                                  _buildStatRow("المستخدمين العاديين", stats.users.roles.user.toString()),
                                  const Divider(),
                                  Text(": المستخدمين الجدد", style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 150, child: _buildUsersBarChart(stats)),
                                  const SizedBox(height: 12),
                                  _buildStatRow("اليوم", stats.users.usersNew.today.toString()),
                                  _buildStatRow("هذا الأسبوع", stats.users.usersNew.thisWeek.toString()),
                                  _buildStatRow("هذا الشهر", stats.users.usersNew.thisMonth.toString()),

                                ],
                              ),


                              const SizedBox(height: 16),

                              // ====== Orders Card ======
                              _buildCard(
                                title: "الطلبات",
                                children: [
                                  // Text(": توزيع الطلبات حسب الحالة", style: TextStyle(fontWeight: FontWeight.bold)),
                                  // SizedBox(height: 220, child: _buildOrdersPieChart(stats)),
                                  // const Divider(),
                                  Text(": الطلبات الجديدة", style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 150, child: _buildOrdersBarChart(stats)),
                                  const Divider(),
                                  _buildStatRow("المجموع", stats.orders.total.toString()),
                                  _buildStatRow("قيد الانتضار", stats.orders.status["قيد الانتضار"].toString()),
                                  _buildStatRow("قيد التوصيل", stats.orders.status["قيد التوصيل"].toString()),
                                  _buildStatRow("مكتمل", stats.orders.status["مكتمل"].toString()),
                                  _buildStatRow("ملغي", stats.orders.status["ملغي"].toString()),
                                  const Divider(),
                                  _buildStatRow("اليوم", stats.orders.ordersNew.today.toString()),
                                  _buildStatRow("هذا الأسبوع", stats.orders.ordersNew.thisWeek.toString()),
                                  _buildStatRow("هذا الشهر", stats.orders.ordersNew.thisMonth.toString()),
                                  const Divider(),
                                  _buildStatRow("إجمالي الإيرادات", "${stats.orders.revenue.total}"),
                                ],
                              ),


                              const SizedBox(height: 16),

                              // ====== Products Card ======
                              // _buildCard(
                              //   title: "المنتجات",
                              //   children: [
                              //     _buildStatRow("المجموع", stats.products.total.toString()),
                              //     const Divider(),
                              //     Text(": جدد", style: TextStyle(fontWeight: FontWeight.bold)),
                              //     _buildStatRow("اليوم", stats.products.productsNew.today.toString()),
                              //     _buildStatRow("هذا الأسبوع", stats.products.productsNew.thisWeek.toString()),
                              //     _buildStatRow("هذا الشهر", stats.products.productsNew.thisMonth.toString()),
                              //     const Divider(),
                              //     Text(": حسب الفئات", style: TextStyle(fontWeight: FontWeight.bold)),
                              //     ...stats.products.byCategory.map((c) =>
                              //         _buildStatRow("الفئة ${c.categoryId}", c.count.toString())
                              //     ),
                              //     const Divider(),
                              //     Text(": أفضل البائعين", style: TextStyle(fontWeight: FontWeight.bold)),
                              //     ...stats.products.topSellers.map((s) =>
                              //         _buildStatRow("البائع ${s.userId}", s.count.toString())
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        fallback: (c) => Center(child: CircularProgress()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard({required String title, required List<Widget> children}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildUsersBarChart(stats) {
    final values = [
      stats.users.usersNew.today.toDouble(),
      stats.users.usersNew.thisWeek.toDouble(),
      stats.users.usersNew.thisMonth.toDouble()
    ];
    final labels = ["اليوم", "الأسبوع", "الشهر"];
    final colors = [Colors.blue, Colors.green, Colors.orange];

    final maxValue = values.reduce((a, b) => a > b ? a : b);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(values.length, (index) {
        final heightPercent = maxValue == 0 ? 0.0 : values[index] / maxValue;
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(values[index].toInt().toString(), style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Container(
              width: 30,
              height: (90 * heightPercent).toDouble(),
              decoration: BoxDecoration(color: colors[index],borderRadius: BorderRadius.circular(10)),

            ),
            const SizedBox(height: 8),
            Text(labels[index]),
          ],
        );
      }),
    );
  }

  Widget _buildUsersPieChart(stats) {
    final total = stats.users.total.toDouble();
    final verified = stats.users.verified.toDouble();
    final admins = stats.users.roles.admin.toDouble();
    // final agents = stats.users.roles.agent.toDouble();
    final normalUsers = stats.users.roles.user.toDouble();

    final data = [verified, admins, normalUsers];
    final colors = [Colors.green, Colors.red, Colors.blue];
    final labels = ["موثقين", "مسؤولين", "مستخدمين"];

    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          Center(
            child: CustomPaint(
              size: Size(200, 200),
              painter: PieChartPainter(data: data, colors: colors, labels: labels),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersPieChart(stats) {
    final pending = stats.orders.status["قيد الانتضار"].toDouble();
    final delivering = stats.orders.status["قيد التوصيل"].toDouble();
    final completed = stats.orders.status["مكتمل"].toDouble();
    final canceled = stats.orders.status["ملغي"].toDouble();

    final data = [pending, delivering, completed, canceled];
    final colors = [Colors.orange, Colors.blue, Colors.green, Colors.red];
    final labels = ["قيد الانتظار", "قيد التوصيل", "مكتمل", "ملغي"];

    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          Center(
            child: CustomPaint(
              size: const Size(200, 200),
              painter: PieChartPainter(
                data: data,
                colors: colors,
                labels: labels,
              ),
            ),
          ),
          Center(
            child: Text(
              "إجمالي الطلبات: ${stats.orders.total}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersBarChart(stats) {
    final today = stats.orders.ordersNew.today.toDouble();
    final thisWeek = stats.orders.ordersNew.thisWeek.toDouble();
    final thisMonth = stats.orders.ordersNew.thisMonth.toDouble();

    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildBar("اليوم", today, Colors.orange),
          _buildBar("الأسبوع", thisWeek, Colors.blue),
          _buildBar("الشهر", thisMonth, Colors.green),
        ],
      ),
    );
  }

  Widget _buildBar(String label, double value, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: value * 5,
          decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(10)),

        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value.toInt().toString(), style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

}

class PieChartPainterOrder extends CustomPainter {
  final List<double> data;
  final List<Color> colors;
  final List<String>? labels;

  PieChartPainterOrder({required this.data, required this.colors, this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final total = data.fold(0.0, (sum, val) => sum + val);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    double startAngle = -pi / 2; // البداية من الأعلى

    for (int i = 0; i < data.length; i++) {
      final sweepAngle = (data[i] / total) * 2 * pi;
      paint.color = colors[i];

      // ارسم القطاع
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // ارسم النص فوق القطاع
      if (labels != null) {
        final angle = startAngle + sweepAngle / 2;
        final textPainter = TextPainter(
          text: TextSpan(
            text: labels![i],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        final labelX = center.dx + radius * 0.6 * cos(angle) - textPainter.width / 2;
        final labelY = center.dy + radius * 0.6 * sin(angle) - textPainter.height / 2;
        textPainter.paint(canvas, Offset(labelX, labelY));
      }

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PieChartPainter extends CustomPainter {
  final List<dynamic> data;
  final List<Color> colors;
  final List<String>? labels;

  PieChartPainter({required this.data, required this.colors, this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    double total = data.fold(0, (sum, item) => sum + item);
    double startAngle = -3.14 / 2;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final radius = size.width / 2;
    final center = Offset(radius, radius);

    for (int i = 0; i < data.length; i++) {
      final sweepAngle = (data[i] / total) * 3.14159265359 * 2;
      paint.color = colors[i];
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);

      if (labels != null) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: labels![i],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        // منتصف الجزء
        final angle = startAngle + sweepAngle / 2;
        final labelX = center.dx + radius * 0.6 * cos(angle) - textPainter.width / 2;
        final labelY = center.dy + radius * 0.6 * sin(angle) - textPainter.height / 2;
        textPainter.paint(canvas, Offset(labelX, labelY));
      }

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
