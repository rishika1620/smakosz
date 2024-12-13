import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions', style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to [Food Delivery App Name]! By using our app, you agree to the following terms and conditions. Please read them carefully before placing an order or using any service provided by our platform.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            _buildSectionTitle('1. Acceptance of Terms'),
            _buildSectionBody(
                'By downloading, installing, or using our app, you agree to these terms and conditions and any updates or changes made to them. If you do not agree, you must not use our services.'),
            _buildSectionTitle('2. Eligibility'),
            _buildSectionBody(
                'To use our app, you must:\n- Be at least 18 years old or have parental/guardian consent.\n- Provide accurate and up-to-date personal information during registration.'),
            _buildSectionTitle('3. Account Responsibility'),
            _buildSectionBody(
                'You are responsible for:\n- Maintaining the confidentiality of your account credentials.\n- All activities that occur under your account.\n- Immediately notifying us of any unauthorized use of your account.'),
            _buildSectionTitle('4. Ordering and Payment'),
            _buildSectionBody(
                'All orders placed through the app are subject to acceptance and availability.\nPrices listed on the app include applicable taxes unless stated otherwise.\nPayments must be made through the accepted payment methods listed in the app.\nOnce an order is placed, it cannot be canceled unless explicitly allowed by the app or the restaurant.'),
            _buildSectionTitle('5. Delivery Policy'),
            _buildSectionBody(
                'Delivery times are estimates and may vary due to factors beyond our control, such as traffic or weather conditions.\nYou are responsible for providing accurate delivery information.\nIf a delivery fails due to incorrect information provided by you, additional charges may apply.'),
            _buildSectionTitle('6. Refunds and Cancellations'),
            _buildSectionBody(
                'Refunds will be processed as per our refund policy, which can be found [here/link].\nIf you cancel an order before it is prepared, you may be eligible for a full or partial refund.\nRefunds are subject to approval and may take up to [X] business days to process.'),
            _buildSectionTitle('7. User Conduct'),
            _buildSectionBody(
                'You agree not to:\n- Use the app for unlawful purposes.\n- Interfere with or disrupt the app’s functionality.\n- Submit false or misleading information.\n- Post harmful, abusive, or offensive content in reviews or messages.'),
            _buildSectionTitle('8. Intellectual Property'),
            _buildSectionBody(
                'All content, trademarks, logos, and materials on the app are the property of [Company Name] or its licensors. You may not use, reproduce, or distribute any content without our prior written consent.'),
            _buildSectionTitle('9. Limitation of Liability'),
            _buildSectionBody(
                'We are not liable for:\n- Delays or failures in delivery caused by third-party partners or unforeseen events.\n- Any direct, indirect, or consequential damages resulting from the use of our app.'),
            _buildSectionTitle('10. Third-Party Services'),
            _buildSectionBody(
                'Our app may include links to third-party websites or services. We are not responsible for the content, terms, or privacy practices of these third parties.'),
            _buildSectionTitle('11. Termination'),
            _buildSectionBody(
                'We reserve the right to suspend or terminate your account if you violate these terms or engage in any conduct deemed inappropriate or harmful.'),
            _buildSectionTitle('12. Changes to Terms'),
            _buildSectionBody(
                'We may update these terms and conditions from time to time. Changes will be effective immediately upon posting on the app. Continued use of the app indicates acceptance of the updated terms.'),
            _buildSectionTitle('13. Contact Us'),
            _buildSectionBody(
                'For questions or concerns about these terms, please contact us at:\n\nEmail: support@smakosz.com\nPhone: +91 16688 16688\nAddress: Sector-71,Noida, UP'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSectionBody(String body) {
    return Text(
      body,
      style: TextStyle(fontSize: 14.0),
    );
  }
}
