import 'package:flutter_test/flutter_test.dart';
import 'package:shopping/data/dummy_products.dart';
import 'package:shopping/main.dart';

void main() {
  final dummyData = dummyProducts;
  testWidgets('products overview screen ...', (tester) async {
    await tester.pumpWidget(const MyApp());
    dummyData.map((e) => {expect(find.text(e.title), findsOne)});
  });
}
