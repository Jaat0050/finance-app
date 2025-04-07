import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  List<Map<String, String>> faqData = [
    {
      "question": "How can I become a Mitra Fintech agent?",
      "answer":
          "To become a Mitra Fintech agent, you can sign up on our website or mobile app. Complete the registration process, and our team will review your application."
    },
    {
      "question": "What commissions do agents earn for successful loan sales?",
      "answer":
          "The commission structure for agents is dynamic and may vary based on the type of loan and other factors. Please refer to the agent commission documentation or contact our support team for detailed information."
    },
    {
      "question": "Are there training programs available for agents?",
      "answer":
          "Yes, Mitra Fintech provides training programs for agents to enhance their skills and knowledge. These programs cover various aspects of the loan distribution process, ensuring agents are well-equipped to assist customers."
    },
    {
      "question": "How do I submit a loan application on behalf of a customer?",
      "answer":
          "As a Mitra Fintech agent, you can submit a loan application on behalf of a customer through the agent portal on our website or the mobile app. Follow the step-by-step process to enter customer details and initiate the loan application."
    },
    {
      "question": "Can I track the status of loan applications I've submitted?",
      "answer":
          "Yes, the Mitra Fintech agent portal provides a tracking system where agents can monitor the status of loan applications they've submitted. Real-time updates on application progress are available for better transparency."
    },
    {
      "question": "What support services are available for agents?",
      "answer":
          "Mitra Fintech offers comprehensive support services for agents, including a dedicated helpline, online chat support, and a knowledge base. Agents can reach out for assistance with any queries or concerns."
    },
    {
      "question": "How often are commissions paid to agents?",
      "answer":
          "Commissions are typically paid out on a regular schedule. The specific payment frequency may vary, and agents will be notified of payment details upon successful completion of transactions."
    },
    {
      "question":
          "What security measures are in place to protect customer data?",
      "answer":
          "Mitra Fintech prioritizes the security of customer data. Stringent security measures, including encryption protocols and adherence to industry standards, are implemented to ensure the protection and confidentiality of customer information."
    },
    {
      "question":
          "Is there a registration fee to become a Mitra Fintech agent?",
      "answer":
          "No, Mitra Fintech does not charge a registration fee for agents. The registration process is free of cost, allowing individuals to join our network without any financial barriers."
    },
    {
      "question": "Can agents offer services in multiple loan categories?",
      "answer":
          "Yes, Mitra Fintech encourages agents to diversify and offer services in multiple loan categories. This allows agents to cater to a broader customer base and increase earning potential."
    },
    {
      "question":
          "What documentation is required during the agent registration process?",
      "answer":
          "During the agent registration process, you will need to provide basic personal information, proof of identity, and relevant contact details. Additional documentation may be required based on regulatory requirements and specific loan categories."
    },
    {
      "question":
          "Are there performance incentives for high-performing agents?",
      "answer":
          "Yes, Mitra Fintech recognizes and rewards high-performing agents with performance incentives. Agents who consistently achieve targets and contribute significantly to loan sales may qualify for additional rewards and bonuses."
    },
    {
      "question":
          "Can agents access marketing materials and promotional tools?",
      "answer":
          "Mitra Fintech provides agents with marketing materials and promotional tools to assist in customer outreach. These materials may include brochures, digital assets, and promotional content to support agents in their marketing efforts."
    },
    {
      "question":
          "What types of customer support channels are available for agents?",
      "answer":
          "Agents can access customer support through various channels, including email, phone support, and an online chat system. Mitra Fintech is committed to providing timely and efficient support to address agent queries and concerns."
    },
    {
      "question":
          "Are there exclusive benefits for long-term agents with Mitra Fintech?",
      "answer":
          "Yes, long-term agents with a successful track record may qualify for exclusive benefits, such as higher commission rates, priority support, and participation in special promotions or events. These benefits are designed to recognize and appreciate the loyalty and contributions of long-term agents."
    },
    {
      "question": "Can agents participate in training programs remotely?",
      "answer":
          "Yes, Mitra Fintech offers remote training programs to provide flexibility for agents. Agents can access training materials, webinars, and interactive sessions from the convenience of their location, making it convenient to enhance their skills and stay updated on industry trends."
    }
  ];

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.dullWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text(
              'FAQs',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            // Spacer(),
            // InkWell(
            //   onTap: (){
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => EditProfile(),
            //       ),
            //     );
            //   },
            //   child: Text(
            //     'Edit Profile',
            //     style: TextStyle(
            //       fontFamily: 'Nunito',
            //       fontWeight: FontWeight.w500,
            //       color: MyColors.veryLightBlue, // Adjust color as needed
            //       fontSize: 15,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      body: Container(
        color: MyColors.dullWhite,
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: faqData
              .map(
                (faq) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ExpansionTile(
                        expandedAlignment: Alignment.centerLeft,
                        shape: Border.all(color: Colors.white),
                        collapsedIconColor: MyColors.greyShadow,
                        iconColor: Colors.black,
                        title: Text(
                          faq["question"]!,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              faq["answer"]!,
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 1,
                      color: MyColors.greyShadow,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
