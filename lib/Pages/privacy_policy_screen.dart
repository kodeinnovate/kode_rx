import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/bullet_list.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/register.dart';

class PrivacyPolicy extends StatelessWidget {
  static PrivacyPolicy get instance => Get.find();
  const PrivacyPolicy({super.key});
  final primaryColor = AppColors.customBackground;
  final textAlignStart = TextAlign.start;
  final textAlignJustify = TextAlign.justify;
  final mainHeadingSize = 28.0;
  final subHeadingSize = 22.0;
  final smallHeading = 18.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Privacy Policy',
                          style: TextStyle(color: primaryColor, fontSize: 35.0),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Last updated: January 01, 2024',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Interpretation and Definitions',
                          style: TextStyle(
                              color: primaryColor, fontSize: mainHeadingSize),
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Interpretation',
                          style: TextStyle(
                              color: primaryColor, fontSize: subHeadingSize),
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Definitions',
                          style: TextStyle(
                              color: primaryColor, fontSize: subHeadingSize),
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('For the purposes of this Privacy Policy:'),
                        const BulletList([
                          'Account means a unique account created for You to access our Service or parts of our Service',
                          'Affiliate means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.',
                          'Application refers to KodeRx, the software program provided by the Company.',
                          'Company (referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to Kodeinnovate Solutions Pvt. Ltd., Office No. 3, Armash apartment, Almas Colony, Near High Intensity Gym, Kausa, Mumbra, Thane - 400612.',
                          'Country refers to: Maharashtra, India',
                          'Device means any device that can access the Service such as a computer, a cellphone or a digital tablet.',
                          'Personal Data is any information that relates to an identified or identifiable individual.',
                          'Service refers to the Application.',
                          'Service Provider means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.',
                          'Usage Data refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).',
                          'You means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.'
                        ]),
                        const SizedBox(height: 10.0),
                        Text(
                          'Collecting and Using Your Personal Data',
                          textAlign: textAlignStart,
                          style: TextStyle(
                              color: primaryColor, fontSize: mainHeadingSize),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Types of Data Collected',
                          textAlign: textAlignStart,
                          style: TextStyle(
                              fontSize: subHeadingSize, color: primaryColor),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Personal Data',
                          textAlign: textAlignStart,
                          style: TextStyle(
                              color: primaryColor, fontSize: smallHeading),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:',
                          textAlign: textAlignJustify,
                        ),
                        const BulletList([
                          'Email address',
                          'First name and last name',
                          'Phone number',
                          'Usage Data'
                        ]),
                        const SizedBox(height: 10.0),
                        Text(
                          'Usage Data',
                          style: TextStyle(
                              color: primaryColor, fontSize: smallHeading),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Usage Data is collected automatically when using the Service.',
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Usage Data may include information such as Your Device\'s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.',
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Information Collected while Using the Application',
                          style: TextStyle(
                              color: primaryColor, fontSize: smallHeading),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'While using Our Application, in order to provide features of Our Application, We may collect, with Your prior permission:',
                          textAlign: textAlignJustify,
                        ),
                        const BulletList([
                          'Pictures and other information from your Device\'s camera and photo library'
                        ]),
                        Text(
                          'We use this information to provide features of Our Service, to improve and customize Our Service. The information may be uploaded to the Company\'s servers and/or a Service Provider\'s server or it may be simply stored on Your device.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'You can enable or disable access to this information at any time, through Your Device settings.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Use of Your Personal Data',
                          textAlign: textAlignStart,
                          style: TextStyle(
                              color: primaryColor, fontSize: subHeadingSize),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'The Company may use Personal Data for the following purposes:',
                          textAlign: textAlignJustify,
                        ),
                        const BulletList([
                          'To provide and maintain our Service, including to monitor the usage of our Service.',
                          'To manage Your Account: to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.',
                          'For the performance of a contract: the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.',
                          'To contact You: To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application\'s push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.',
                          'To provide You with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.',
                          'To manage Your requests: To attend and manage Your requests to Us.',
                          'For business transfers: We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred.',
                          'For other purposes: We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.'
                        ]),
                        Text(
                          'We may share Your personal information in the following situations:',
                          textAlign: textAlignStart,
                        ),
                        const BulletList([
                          'With Service Providers: We may share Your personal information with Service Providers to monitor and analyze the use of our Service, to contact You.',
                          'For business transfers: We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.',
                          'With Affiliates: We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us.',
                          'With business partners: We may share Your information with Our business partners to offer You certain products, services or promotions.',
                          'With other users: when You share personal information or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside.',
                          'With Your consent: We may disclose Your personal information for any other purpose with Your consent.'
                        ]),
                        Text(
                          'Retention of Your Personal Data',
                          style: TextStyle(
                              color: primaryColor, fontSize: subHeadingSize),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Transfer of Your Personal Data',
                          style: TextStyle(
                              color: primaryColor, fontSize: subHeadingSize),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Your information, including Personal Data, is processed at the Company\'s operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from Your jurisdiction.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Delete Your Personal Data',
                          style: TextStyle(
                              color: primaryColor, fontSize: subHeadingSize),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'You have the right to delete or request that We assist in deleting the Personal Data that We have collected about You.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Our Service may give You the ability to delete certain information about You from within the Service.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'You may update, amend, or delete Your information at any time by signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information. You may also contact Us to request access to, correct, or delete any personal information that You have provided to Us.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Please note, however, that We may need to retain certain information when we have a legal obligation or lawful basis to do so.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Disclosure of Your Personal Data',
                          style: TextStyle(
                              color: primaryColor, fontSize: subHeadingSize),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Business Transactions',
                          style: TextStyle(
                              color: primaryColor, fontSize: smallHeading),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Law enforcement',
                          style: TextStyle(
                              color: primaryColor, fontSize: smallHeading),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Other legal requirements',
                          style: TextStyle(
                              color: primaryColor, fontSize: smallHeading),
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:',
                          textAlign: textAlignJustify,
                        ),
                        const BulletList([
                          'Comply with a legal obligation',
                          'Protect and defend the rights or property of the Company',
                          'Prevent or investigate possible wrongdoing in connection with the Service',
                          'Protect the personal safety of Users of the Service or the public',
                          'Protect against legal liability'
                        ]),
                        Text(
                          'Security of Your Personal Data',
                          style: TextStyle(
                              color: primaryColor, fontSize: subHeadingSize),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Children\'s Privacy',
                          style: TextStyle(
                              color: primaryColor, fontSize: mainHeadingSize),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent\'s consent before We collect and use that information.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Links to Other Websites',
                          style: TextStyle(
                              color: primaryColor, fontSize: mainHeadingSize),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party\'s site. We strongly advise You to review the Privacy Policy of every site You visit.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Changes to this Privacy Policy',
                          style: TextStyle(
                              fontSize: mainHeadingSize, color: primaryColor),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.',
                          textAlign: textAlignJustify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Contact Us',
                          style: TextStyle(
                              fontSize: mainHeadingSize, color: primaryColor),
                          textAlign: textAlignStart,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'If you have any questions about this Privacy Policy, You can contact us:',
                          textAlign: textAlignJustify,
                        ),
                        const BulletList([
                          'By email: kodeinnovate@gmail.com',
                          'By visiting this page on our website: https://kodeinnovate.in/'
                              'By phone number: +91 932 650 0602'
                        ]),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ),
            )),
            Container(
              height: 100,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, elevation: 3, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                      onPressed: () => {
                        Navigator.pop(context),
                        Get.snackbar('Privacy Policy Rejected', 'You must accept the Privacy policy to register')
                        }, child: const Padding(
                          padding:  EdgeInsets.all(20.0),
                          child:  Text('Decline', style: TextStyle(color: Colors.white, fontSize: 16),),
                        )),
                  ElevatedButton(            
                    style: ElevatedButton.styleFrom(backgroundColor: primaryColor, elevation: 3, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                      onPressed: () => Get.to(() => Signup()),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text('Accept', style: TextStyle(color: Colors.white, fontSize: 16),),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}