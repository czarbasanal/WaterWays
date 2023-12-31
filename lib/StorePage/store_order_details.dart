import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waterways/OrderManagement/custom_appbar2.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:waterways/app_styles.dart';
import 'package:waterways/models/users.dart';

class StoreOrderStatus extends StatefulWidget {
  const StoreOrderStatus({Key? key, required this.customer}) : super(key: key);
  final Customer customer;

  @override
  _StoreOrderStatusState createState() => _StoreOrderStatusState();
}

class _StoreOrderStatusState extends State<StoreOrderStatus>
    with SingleTickerProviderStateMixin {
  int currentStep = 0;
  late AnimationController _controller;
  late Animation<double> _lineAnimation;
  double _previousStep = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _lineAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementStep() {
    if (currentStep < 5) {
      setState(() {
        _previousStep = currentStep / 5;
        currentStep++;
      });
      _controller.forward(from: _previousStep);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double circleSize = 36.0;
    double spaceBetweenCircles = screenWidth / 5; // Adjust according to your UI
    double lineStart = spaceBetweenCircles / 2;
    double lineEnd = screenWidth - spaceBetweenCircles / 2;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppStyles.colorScheme.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBarToHome(
            customer: widget.customer,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              itemCard(screenHeight, screenWidth),
              SizedBox(height: 15),
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: spaceBetweenCircles / 2,
                    right: screenWidth - spaceBetweenCircles / 2,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        double lineStart = spaceBetweenCircles / 2;
                        double lineEnd = (spaceBetweenCircles * currentStep) -
                            spaceBetweenCircles / 2;
                        double lineLength =
                            (lineEnd - lineStart) * _lineAnimation.value;

                        return Positioned(
                          left: lineStart,
                          child: Container(
                            width: lineLength,
                            height: 5,
                            color: Color(0xFF007AFF),
                          ),
                        );
                      },
                    ),
                  ),
                  StepProgressIndicator(
                    totalSteps: 5,
                    currentStep: currentStep,
                    size: circleSize,
                    selectedColor: Color(0xFF007AFF),
                    unselectedColor: Colors.white,
                    customStep: (index, color, _) => Container(
                      decoration: BoxDecoration(
                        color: index == 0
                            ? Color(0xFF007AFF)
                            : (index < currentStep
                                ? Color(0xFF007AFF)
                                : Colors.white),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF007AFF),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: index < currentStep
                            ? Icon(Icons.check, color: Colors.white)
                            : Text(
                                '${index + 1}',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: index == 0
                                      ? Colors.white
                                      : Color(0xFF007AFF),
                                ),
                              ),
                      ),
                    ),
                  ),
                  _buildLabelsRow(),
                ],
              ),
              SizedBox(height: 15),
              _buildViewLocation(screenHeight, screenWidth),
              SizedBox(
                height: 15,
              ),
              line(screenWidth),
              _buildPaymentOptions(screenHeight, screenWidth),
              buildTextSection3(screenHeight, screenWidth, 'Cash on Delivery',
                  AppStyles.bodyText6),
              _buildAddress(screenHeight, screenWidth),
              buildTextSection3(screenHeight, screenWidth,
                  'Basak, Pardo, 123 Street', AppStyles.bodyText6),
              _buildOrderSummary(screenHeight, screenWidth),
              textRow6(screenHeight, screenWidth),
              _buildOrderTotal(screenHeight, screenWidth),
              buildTextSection3(screenHeight, screenWidth,
                  'Transaction Code: MYUI7821A-G2-90A', AppStyles.bodyText2),
              _buildViewChat(screenHeight, screenWidth),
              _buildTotalPayment(screenHeight, screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(top: 70, right: 30),
      // Adjust the padding to create the desired gap
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: Color(0xFF313144),
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),

        softWrap: true, // Allow wrapping
        overflow: TextOverflow.visible,
      ),
    );
  }

  Widget _buildLabelsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStepLabel('''       Process'''),
        _buildStepLabel('''On the way
  to station'''),
        _buildStepLabel('''On the way'''),
        _buildStepLabel(''''Delivered'''),
        _buildStepLabel('''    Rate'''),
      ],
    );
  }

  Widget buildTextSection(
      double screenHeight, double screenWidth, String text, TextStyle style) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: screenHeight * 0.0),
      child: Text(text, style: style),
    );
  }

  Widget buildTextSection2(
      double screenHeight, double screenWidth, String text, TextStyle style) {
    return Padding(
      padding: EdgeInsets.only(
          left: 15, // Set or reduce the left padding as needed
          top: screenHeight * 0.03),
      child: Text(text, style: style),
    );
  }

  Widget buildTextSection3(
      double screenHeight, double screenWidth, String text, TextStyle style) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: screenHeight * 0.009),
      child: Text(text, style: style),
    );
  }

  Widget buildTextSection4(
      double screenHeight, double screenWidth, String text, TextStyle style) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: screenHeight * 0.001),
      child: Text(text, style: style),
    );
  }

  Widget buildTextSection5(
      double screenHeight, double screenWidth, String text, TextStyle style) {
    return Padding(
      padding: EdgeInsets.only(left: 105, top: 25),
      child: Text(text, style: style),
    );
  }

  Widget buildTextSection6(
      double screenHeight, double screenWidth, String text, TextStyle style) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(text, style: style),
    );
  }

  Widget itemCard(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 10.0, bottom: 10.0),
      child: Stack(
        children: [
          Container(
              height: 180,
              width: 390,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(17.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: cardFullDetails(screenHeight, screenWidth)),
          buildTextSection2(
              screenHeight, screenWidth, 'Aqua Atlan', AppStyles.headline2),
        ],
      ),
    );
  }

  Widget cardDetails(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 45.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextSection(screenHeight, screenWidth, 'Barrel (200 Liters) x3',
              AppStyles.bodyText2),
          SizedBox(
            height: 8,
          ),
          buildTextSection(
              screenHeight, screenWidth, 'Delivery', AppStyles.bodyText2),
          SizedBox(
            height: 8,
          ),
          buildTextSection(
              screenHeight, screenWidth, 'P12.00', AppStyles.bodyText2),
        ],
      ),
    );
  }

  Widget cardFullDetails(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 10.0),
      child: Row(
        children: [
          card(),
          // SizedBox(
          //   width: 8,
          // ),
          cardDetails(screenHeight, screenWidth),
          edit()
        ],
      ),
    );
  }

  Widget _buildOrderTotal(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          clipboard(),
          buildTextSection3(screenHeight, screenWidth,
              'Order Total ( 3 Items )', AppStyles.bodyText6),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          summary(),
          buildTextSection3(
              screenHeight, screenWidth, 'Order Summary', AppStyles.bodyText6),
        ],
      ),
    );
  }

  Widget _buildViewLocation(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          location(),
          buildTextSection3(screenHeight, screenWidth,
              'View real-time Location', AppStyles.bodyText6),
          SizedBox(width: 60),
          ElevatedButton(
            onPressed: _incrementStep,
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF007AFF), // Button background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              fixedSize: Size(100, 40), // Button size
            ),
            child: Text(
              'Confirm',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewChat(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          message(),
          buildTextSection3(
              screenHeight, screenWidth, 'View Chat', AppStyles.bodyText6),
        ],
      ),
    );
  }

  Widget _buildAddress(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          marker(),
          buildTextSection3(
              screenHeight, screenWidth, 'Address', AppStyles.bodyText6),
          SizedBox(width: 45.00)
        ],
      ),
    );
  }

  Widget textCol1(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextSection3(screenHeight, screenWidth, 'Product Subtotal',
              AppStyles.bodyText6),
          SizedBox(height: 5.00),
          buildTextSection3(screenHeight, screenWidth, 'Delivery Subtotal',
              AppStyles.bodyText6),
        ],
      ),
    );
  }

  Widget textCol2(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextSection3(
              screenHeight, screenWidth, '720', AppStyles.bodyText6),
          SizedBox(height: 5.00),
          buildTextSection3(
              screenHeight, screenWidth, '320', AppStyles.bodyText6),
        ],
      ),
    );
  }

  Widget textRow6(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textCol1(screenHeight, screenWidth),
          SizedBox(width: 185.00),
          textCol2(screenHeight, screenWidth)
        ],
      ),
    );
  }

  Widget _buildTotalPayment(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextSection3(
              screenHeight, screenWidth, 'Total Payment', AppStyles.headline2),
          SizedBox(width: 90.00),
          buildTextSection3(
              screenHeight, screenWidth, 'P7520.00', AppStyles.headline2),
        ],
      ),
    );
  }

  Widget line(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(left: 9.0),
      child: Container(
        height: 1,
        width: 390,
        decoration: BoxDecoration(color: Color(0xFF007AFF)),
      ),
    );
  }

  Widget line2(double screenWidth) {
    return Container(
      height: 2,
      width: 290,
      decoration: BoxDecoration(color: Color(0xFF007AFF)),
    );
  }

  Widget _buildPaymentOptions(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          wallet(),
          buildTextSection3(screenHeight, screenWidth, 'Payment Options',
              AppStyles.bodyText6),
        ],
      ),
    );
  }

  Widget CustomImageRow() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        line2(290),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                imageContainer('assets/Order/CircleChecked.png'),
                imageContainer('assets/Order/CircleChecked.png'),
                imageContainer('assets/Order/Circle3.png'),
                imageContainer('assets/Order/CircleW4.png'),
                imageContainer('assets/Order/CircleW5.png'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                textWithMaxWidth('Process', AppStyles.subText1, 70),
                textWithMaxWidth(
                    'On the way to station', AppStyles.subText1, 70),
                textWithMaxWidth(
                    'On the way to customer', AppStyles.subText1, 70),
                textWithMaxWidth('Delivered', AppStyles.subText1, 70),
                textWithMaxWidth('Rate', AppStyles.subText1, 70),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget textWithMaxWidth(String text, TextStyle style, double width) {
    return Container(
      width: width,
      alignment: Alignment.center, // Center align the text
      child: Text(
        text,
        textAlign: TextAlign.center, // Center text alignment
        style: style,
        softWrap: true, // Enable text wrapping
        overflow: TextOverflow.visible, // To ensure text flows to a new line
      ),
    );
  }

  Widget imageContainer(String imagePath) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget left() => Image.asset('assets/Main/left.png');
  Widget card() {
    return Padding(
      padding: EdgeInsets.only(top: 40.0),
      child: Image.asset('assets/Order/AquaAtlanSmall.png'),
    );
  }

  Widget edit() {
    return Padding(
      padding: EdgeInsets.only(left: 0.0, top: 145.00),
      child: Image.asset('assets/Order/edit.png'),
    );
  }

  Widget down() {
    return Padding(
      padding: EdgeInsets.only(left: 0.0, top: 10.00),
      child: Image.asset('assets/Order/downIcon.png'),
    );
  }

  Widget delivery() {
    return Padding(
      padding: EdgeInsets.only(left: 0.0, top: 6.00),
      child: Image.asset('assets/Order/delivery.png'),
    );
  }

  Widget wallet() {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Image.asset('assets/Order/wallet.png'),
    );
  }

  Widget clipboard() {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Image.asset('assets/Order/clipboard.png'),
    );
  }

  Widget summary() {
    return Padding(
      padding: EdgeInsets.only(
        top: 7.0,
      ),
      child: Image.asset('assets/Order/summary.png'),
    );
  }

  Widget message() {
    return Padding(
      padding: EdgeInsets.only(
        top: 11.0,
      ),
      child: Image.asset('assets/Order/messageIcon2.png'),
    );
  }

  Widget marker() {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Image.asset('assets/Order/locationMarker.png'),
    );
  }

  Widget location() {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Image.asset('assets/Order/track.png'),
    );
  }
}
