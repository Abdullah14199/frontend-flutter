import 'package:flutter/material.dart';
import 'package:skep_home_pro/constatns/constants.dart';

class TermsAndCondations extends StatefulWidget {
  const TermsAndCondations({Key? key}) : super(key: key);

  @override
  State<TermsAndCondations> createState() => _TermsAndCondationsState();
}

class _TermsAndCondationsState extends State<TermsAndCondations> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Image.asset("assets/images/ring.png"),
            onPressed: () {
              // do something
            },
          )
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Center(
          child: Text(
            "Terms & condaition",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0 , right: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text( """
TERMS AND CONDITIONS
Last updated: April 24,2022
        1. CONTRACTUAL RELATIONSHIP
        These Terms of Use ("Terms") govern the access or use by you, a User (as defined below), and 
        Skep Solutions Corp., a private Canadian federal corporation, having its offices at 1487 Spring 
        Garden Court, Mississauga, ON, L5N 8K7 ("Skep", "we", "us" and "our") and govern the 
        access or use by you from within any part of the greater Toronto area in Ontario, Canada of 
        the applications, websites, content, products, and services (the "Services") made available by Skep. 
        PLEASE READ THESE TERMS CAREFULLY BEFORE ACCESSING OR USING THE 
        SERVICES.
        Your access and use of the Services constitutes your acceptance of the agreement to be bound 
        by these Terms, together with the privacy policy available at www.skephome.com
        ("Privacy Policy") and the rules, policies, terms and conditions set forth in, referred to and/or 
        linked herein, all of which are incorporated herein by reference (collectively, the 
        "Agreement") and the acceptance of any person you purport to represent to be bound 
        by the Agreement. This Agreement establishes a contractual relationship between you and 
        Skep regarding your accesses and use of the Services. IF YOU DO NOT AGREE TO BE BOUND BY 
        THIS AGREEMENT, YOU MAY NOT ACCESS OR USE THE SERVICES. This Agreement expressly 
            supersedes any and all prior agreements or arrangements between you and Skep 
            regarding the subject matter of these Terms. Skep may immediately terminate these Terms 
            or any Services with respect to you, or generally cease offering or deny access to the Services 
            or any portion thereof, at any time for any reason. By accessing and using the Services, you 
            acknowledge that you have read, understood, and agree to accept and be bound by the Terms. 
            Supplemental terms may apply to certain Services, such as policies for a particular event, 
            activity or promotion, and such supplemental terms will be disclosed to you in connection 
            with the applicable Services. Supplemental terms are in addition to, and shall be deemed a 
            part of, the Terms for the purposes of the applicable Services. Supplemental terms shall prevail 
            over these Terms in the event of a conflict with respect to the applicable Services. 
            Skep may, in its discretion, amend the Terms related to the Services from time to time. 
            Amendments will be effective upon Skep’s posting of such updated Terms at this location or the 
            amended policies or supplemental terms on the applicable Service. Skep recommends that you 
            review the then current Terms each time that you access or use the Services as the Terms may 
            have been modified since your last access. The most recent date on which the Terms were 
            updated will be indicated above. Your continued access or use of the Services after such posting 
            constitutes your consent to be bound by the Terms, as amended. 
            Our collection and use of personal information in connection with the Services is as provided in 
            the Privacy Policy. Skep may provide to a claims processor or an insurer any necessary 
            information (including your contact information) if there is a complaint, dispute or conflict, which 
            may include any damages or losses, involving any Users of the Services and such information or 
            data is necessary to resolve the complaint, dispute or conflict. 
            
            2. THE SERVICES
            
            The Services constitute a technology platform that enables users of Skep’s mobile applications or 
            websites provided as part of the Services (each, an "Application" or "App") to enable the 
            connection between individuals (collectively the "Requesting Parties" and each a "Requesting 
            Party") seeking to connect, schedule and obtain cleaning services (the "Cleaning Services") 
            and/or independent cleaning service providers/individuals (collectively, the "Cleaning Service 
            Providers" and each a "Cleaning Service Provider") seeking to provide the Cleaning Services 
            (collectively, the Requesting Parties and the Cleaning Service Parties are collectively referred to 
            as the "Users" and each is a "User"). Unless otherwise agreed by Skep in a separate written 
            agreement with you, the Services are made available to you, the User, solely for your personal, 
            non-commercial use. YOU ACKNOWLEDGE THAT SKEP DOES NOT PROVIDE CLEANING SERVICES 
            OR FUNCTION AS A SIMILAR SERVICE PROVIDER IN ANY MANNER AND THAT ALL SUCH 
            CLEANING SERVICES ARE PROVIDED BY INDEPENDENT THIRD PARTY CONTRACTORS WHO ARE 
            NOT EMPLOYED BY SKEP OR ANY OF ITS AFFILIATES.
            
            3. LICENSE
            
            Subject to your compliance with these Terms, Skep grants you a limited, non-exclusive, 
            revocable, non-sublicensable, non-transferrable license and right to: (a) access and use the 
            Applications on your personal device solely in connection with your use of the Services; (b) access 
            and use any content, information and related materials that may be made available through the 
            Services, in each case solely for your personal, non-commercial use, and (c) any intellectual 
            property of Skep in the furtherance of the license and right described in the subject matter of 
            clause (a) and clause (b) above in this paragraph. Any rights not expressly granted herein are 
            reserved by Skep and Skep’s licensors.
            License Restrictions.
            You may not: (a) remove, alter, cover or obscure any confidentiality, trademark, logo, copyright, 
            patent or other proprietary notices, legends, symbols or labels from any portion of the Services; 
            (b) reverse engineer, decompile, or disassemble the Services except as may be permitted by
            applicable law; (c) link to, mirror or frame any portion of the Services, (d) reproduce, modify,
            prepare derivative works based upon, distribute, license, lease, sell, resell, transfer, publicly
            display, publicly perform, transmit, stream, broadcast or otherwise exploit the Services except as
            expressly permitted by Skep; (e) use any trademarks or copyrightable information of Skep or its
            licensors in any way except as expressly provided herein; (f) cause or launch any programs or
            scripts for the purpose of scraping, indexing, surveying, or otherwise data mining any portion of 
            the Services or unduly burdening or hindering the operation and/or functionality of any aspect 
            of the Services; (g) use the Services in any manner that conflicts with the license and rights
            granted herein; or (h) attempt, directly or indirectly, to gain unauthorized access to, or impair or 
            interfere with, any aspect of the Services, including any security features of the Services, or its 
            related systems or networks.
            Ownership.
            The Services and all rights therein are and shall remain Skep’s property or, as applicable, the 
            property of Skep’s licensors. Neither this Agreement, these Terms nor your access or use of the 
            Services convey or grant to you any rights: (a) in or related to the Services except for the limited 
            license granted above; or (b) to use or reference in any manner Skep’s company names, logos, 
            product and service names, trademarks or services marks or those of Skep’s licensors.
            Third Party Services and Content.
            The Services may be made available or accessed in connection with third party services and 
            content (including advertising) that Skep does not control. You acknowledge that different terms 
            of use and privacy policies may apply to your use of such third party services and content. Skep
            does not endorse such third party services and content in any manner and Skep shall not be 
            responsible or liable for any services or products of such third party providers under any 
            circumstance or in any manner. Additionally, Apple Inc., Alphabet Inc., Microsoft Corporation or
            other third party providers and/or their applicable international subsidiaries and affiliates will be 
            third-party beneficiaries to this Agreement if you access the Services using Applications (or Apps) 
            developed for Apple iOS, Android, Microsoft Windows, or other powered mobile devices, 
            respectively. These third party beneficiaries are not parties to this Agreement and are not 
            responsible for the provision or support of the Services in any manner. Your access to the Services 
            using these devices is subject to terms set forth in the applicable third party beneficiary’s terms 
            of service.
            
            4. YOUR USE OF THE SERVICES
            
            SKEP, THROUGH THE APPLICATION, OFFERS INFORMATION AND A METHOD TO OBTAIN THE 
            CLEANING SERVICES AND/OR MERCHANDISE, BUT DOES NOT AND DOES NOT INTEND TO 
            PROVIDE SUCH CLEANING SERVICES OR MERCHANDISE ITSELF OR ACT IN ANY WAY AS A RETAILER 
            OR MANUFACTURER, OR AS A CLEANING SERVICE PROVIDER, AND HAS NO RESPONSIBILITY OR 
            LIABILITY FOR ANY CLEANING SERVICES AND/OR MERCHANDISE PROVIDED TO THE REQUESTER 
            BY CLEANING SERVICE PROVIDERS, INCLUDING A WARRANTY OR CONDITION OF GOOD AND 
            WORKMANLIKE CLEANING SERVICES, WARRANTY OF FITNESS FOR A PARTICULAR PURPOSE OR 
            COMPLIANCE WITH ANY LAW, REGULATION, OR CODE. SKEP IS NOT AFFILIATED WITH, 
            ENDORSED OR SPONSORED BY ANY THIRD PARTY MERCHANDISE PROVIDER OR RETAILER.
            Background Checks.
            Skep checks the backgrounds of the Cleaning Service Provider via third party background check 
            services to the extent permitted by applicable law. However, each Requesting Party should 
            exercise caution and common sense to protect its personal safety and property, just as you would 
            when interacting with any person whom you do not know. BY USING THE SERVICES, THE 
            REQUESTING PARTY AGREES TO HOLD SKEP FREE FROM THE RESPONSIBILITY FOR ANY LIABILITY 
            OR DAMAGE THAT MIGHT ARISE OUT OF THE CLEANING SERVICES. SKEP IS NOT RESPONSIBLE 
            FOR THE CONDUCT, WHETHER ONLINE OR OFFLINE, OF ANY USER INCLUDING CLEANING SERVICE 
            PROVIDERS, AND WILL NOT BE LIABLE FOR ANY CLAIM, INJURY OR DAMAGE ARISING IN 
            CONNECTION WITH ANY CLEANING SERVICES.
            Collection of your Personal Information.
            You will be required complete a registration with us to access and use the Services. You will be 
            required to provide certain personal information, including your mobile device telephone 
            number, a selfie of the User, an email address and an official copy of a governmental ID, including
            a driver's licence or passport. Each Cleaning Service Provider will also be required to provide a 
            social insurance number. You agree that such information will be true, accurate and complete, 
            and that you will update this information promptly when it changes. If you provide any 
            information that is untrue or inaccurate, not current, or incomplete, or if we suspect that your 
            information is untrue or inaccurate, not current, or incomplete, we may, in our sole discretion, 
            suspend or terminate your right to access the Services. Such information is required as part of 
            our corporate internal verification of all Users and security purposes, including providing 
            information for background checks of the Cleaning Service Providers. Upon completing the 
            registration, the background check service provider will send each Cleaning Service Provider a 
            link to the Cleaning Service Provider's email with a form to be completed and sent back to the 
            service provider. We will communicate with Requesting Parties primarily by emails. Once Users 
            are registered, and as applicable background checks are clear, we will email Users that they may 
            use the Services. 
            Any personally identifiable information collected, used, and disclosed hereunder will be subject 
            to the terms of the Privacy Policy. 
            User Accounts.
            In order to use most aspects of the Services, you must register for and maintain an active personal 
            user Services account ("Account"). You must be at least 18 years of age, or the age of legal 
            majority in your jurisdiction (if different than 18), to obtain an Account. Account registration 
            requires you to submit to Skep certain personal information, such as your name, address, mobile 
            phone number and age, as well as at least one valid payment method (either a credit card or 
            accepted payment partner). You agree that the information that you provide us regarding your 
            Account will be entirely truthful and accurate. You agree to maintain accurate, complete, and upto-date information in your Account. Your failure to maintain accurate, complete, and up-to-date 
            Account information, including having an invalid or expired payment method on file, may result 
            in your inability to access and use the Services or Skep’s termination of these Terms with you. 
            You are responsible for all activity that occurs under your Account, and you agree to maintain the 
            security and secrecy of your Account username and password at all times. Unless otherwise 
            permitted by Skep in writing, you may only possess one Account.
            You will be asked to create a username and password in connection with such an Account. You 
            are responsible for maintaining the confidentiality of the password and Account and are fully 
            responsible for all activities that occur under your password or Account. You agree to 
            immediately notify us of any unauthorized use of your password or account or any other breach 
            of security that you become aware of. Skep cannot and will not be liable for any loss or damage 
            arising from your failure to comply with this Section 4 if such loss or damage could not have been 
            prevented by reasonable precautions on our part.
            User Requirements and Conduct.
            The Service is not available for use by persons under the age of 18. You may not authorize third 
            parties to use your Account, and you may not allow persons under the age of 18 to receive 
            Cleaning Services from Cleaning Service Providers unless they are accompanied by you. You may 
            not assign or otherwise transfer your Account to any other person or entity. You agree to use the 
            Services for only lawful purposes and agree to comply with all applicable laws when accessing or 
            using the Services. You will not, in your use of the Services, (a) cause nuisance, annoyance, 
            inconvenience, or property damage, whether to the Cleaning Service Provider or any other 
            service provider; or (b) use the Services (i) to solicit others to perform or participate in any 
            unlawful acts; (ii) to violate any international, federal, provincial or state regulations, rules, laws, 
            or local ordinances; (iii) to infringe upon or violate our intellectual property rights or the 
            intellectual property rights of others; (iv) to harass, abuse, insult, harm, defame, slander, 
            disparage, intimidate, or discriminate based on gender, sexual orientation, religion, ethnicity, 
            race, age, national origin, or disability; (v) to submit false or misleading information; or (vi) to 
            upload or transmit viruses or any other type of malicious code that will or may be used in any 
            way that will affect the functionality or operation of the Services. In certain instances you may 
            be asked to provide proof of identity to access or use the Services, and you agree that you may 
            be denied access to or use of the Services if you refuse to provide proof of identity.
            Email Messaging.
            By creating an Account, you agree that Skep may send you email messages as part of the 
            normal business operation of your use of the Services. You may opt-out of receiving email 
            messages from Skep at any time by following the directions found at htttp://[]/unsubscribe.
            [Note: Add link] You acknowledge that opting out of receiving email messages may impact your 
            use, or continued use, of the Services.
            Promotional Programs.
            We may provide promotional programs from time-to-time for the Users and we will notify the 
            Users of such promotional programs via email and or code on the App.
            Network Access and Devices.
            You are responsible for obtaining the data network access necessary to use the Services. Your 
            mobile network’s data and messaging rates and fees may apply if you access or use the Services 
            from a wireless-enabled device and you shall be responsible for such rates and fees. You are 
            responsible for acquiring and updating compatible hardware or devices necessary to access and 
            use the Services and Applications and any updates thereto. Skep does not guarantee that the 
            Services, or any portion thereof, will function on any particular hardware or devices. In 
            addition, the Services may be subject to malfunctions and delays inherent in the use of the 
            Internet and electronic communications.
            
            5. PAYMENT
            
            You understand that use of the Services may result in charges to you for the Cleaning Services
            you receive from a Cleaning Service Provider ("Charges"). You will be required to pay the Charges, 
            and any applicable harmonized sales taxes ("HST") required by law shall be included in the 
            Charges and, as applicable, the Cleaning Service Provider shall be solely responsible for any 
            remittance applicable thereto. Each Requesting Party will pay the full amount payable to the 
            Cleaning Service through our third party service provider's payment gateway platform. We will 
            notify each Requesting Party and Cleaning Service Provider of the Charges applicable to the 
            Cleaning Services. Each Requesting Party will pay the full amount payable to the Cleaning Service 
            through our third party service provider's payment gateway platform
            Payment processing services for you, the Account holder under this Agreement, are provided by
            Stripe (“Stripe”) and are subject to the Stripe Connected Account Agreement, which includes the
            Stripe Terms of Service (collectively, Stripe Connected Account Agreement and Stripe Terms of
            Service are the “Stripe Services Agreement”). By agreeing to this Agreement or continuing to
            operate as an Account holder under this Agreement, you agree to be bound by the Stripe Services
            Agreement, as the same may be modified by Stripe from time to time. As a condition of the App
            enabling payment processing services through Stripe, you agree to provide Skep with accurate
            and complete information about you and your business, and you authorize Skep to share it and
            transaction information related to your use of the payment processing services provided by
            Stripe.
            After the Requesting Party has received the Cleaning Service obtained through the use of the 
            Services, Skep will, through its third party service provider, facilitate payment of the applicable 
            Cleaning Services payments to the Cleaning Service Provider less the Charges, together with the 
            HST thereon, which are paid to Skep. Charges paid by Users are final and non-refundable, unless 
            otherwise determined by Skep. 
            All Charges are due immediately and payment will be facilitated by Skep using the preferred 
            payment method designated in your Account, after which Skep will send you a receipt by email. 
            If your primary Account payment method is determined to be expired, invalid or otherwise not 
            able to be charged, you agree that Skep may, as the Cleaning Service Provider’s limited 
            payment collection agent, use a secondary payment method in your Account, if available, 
            failing which your Account will be suspended until we receive an updated valid Account 
            payment method.
            As between you and Skep, Skep reserves the right to establish, remove and/or revise Charges for 
            any or all Cleaning Services obtained through the use of the Services at any time in Skep’s sole 
            discretion. 
            This payment structure is intended to fully compensate the Cleaning Service Provider for the 
            Cleaning Services provided. Skep does not designate any portion of your payment as a tip or 
            gratuity to the Cleaning Service Provider. Any representation by Skep (on Skep’s website, in the 
            Application, or in Skep’s marketing materials) to the effect that tipping is "voluntary," "not 
            required," and/or "included" in the payments you make for services or goods provided is not 
            intended to suggest that Skep provides any additional amounts, beyond those described above, 
            to the Cleaning Service Provider. You understand and agree that, while you are free to provide 
            additional payment as a gratuity to any Cleaning Services Provider who provides you with services 
            or goods obtained through the Service, you are under no obligation to do so. Gratuities are 
            voluntary. After the Requesting Party received Cleaning Services through the Service, the 
            Requesting Party will have the opportunity to rate his/her experience and leave additional 
            feedback about Cleaning Service Provider. 
            
            6. SCHEDULING CLEANING SERVICES
            
            The Cleaning Services include recurring or scheduled booking Cleaning Services 
            (" Booking"). The Requesting Party will be able to select the desired Cleaning Services by
            following the steps on the app starting by selecting the address on the bottom of the 
            dashboard page:
            (a) The Requesting Party can click on the "Enter address" box on the bottom of
            the dashboard page and they will go through a series of pages where they
            would select the date, time and type of Cleaning Services the User requires
            on the specified "Place" on the App that need to cleaned. In addition it will allow
            the User to select one of their previously identified favorite Cleaning Service
            Provider.
            (b) The Requesting Party's will then hit the "Send Request" button and the App will
            send the request to all available service providers in the area. Once the request is
            accepted the app will provide the Requesting Party the expected time of arrival
            of a Cleaning Service Provider.
            8. RATING OF CLEANING SERVICE PROVIDERS
            Each Cleaning Service Provider will be rated by us in accordance with our rating system set out 
            on our website and communicated to the Cleaning Service Provider. Each Requesting Party will 
            be able to rate the Cleaning Service Providers and will be able to see the Cleaning Service 
            Providers' respective ratings.
            (c) The App will prompt the Requesting Party with any available information
            for this request, including estimated times of arrival, text messages,
            cancellation, etc.
            (d) The Requesting Party will have the ability to track the location of the
            service provider prior to commencing the service.
            (e) The Cleaning Service Provider will confirm when the Cleaning Services job has
            started. Upon the Cleaning Services being completed, the Cleaning Services
            Provider will be able to complete the job on the app using button at the detailed
            page
            
            7. CANCELLATION
            
            Requests for Cleaning Services may be cancelled by Users at any time prior to such Cleaning 
            Service Provider’s arrival at the location for the Cleaning Services, subject to the following 
            provisions:
            (a) Any User may cancel any Cleaning Services without being charged a cancellation
            fee or penalty if such cancellation request is made at any time 1 hour prior to
            the scheduled appointment time for the Cleaning Services.
            (b) If a cancellation attempt is made within 1 hour of a scheduled appointment time
            for the Cleaning Services, a warning message will be sent to the User that is
            seeking to cancel the Cleaning Services as follows:
            (i) If the User is the Requesting Party, the message will reflect that 10% of the
            total amount of the Cleaning Services will be charged to the Requesting
            Party's Account as a cancellation fee. If the User accepts the deduction, the
            cancellation will be completed and the credit card on file will be charged
            10% of the total amount of the Cleaning Services. If the User does not
            accept the deduction, the Cleaning Services will proceed as initially
            requested and will be processed at the full Charge thereto.
            (ii) If the User is the Cleaning Service Provider, the message will reflect that
            the Cleaning Service Provider's rating will be reduced. If the Cleaning
            Service Provider accepts the notice of the rating reduction, the
            cancellation will be completed and rating will be reduced. A notification
            will be sent to the Requesting Party that a new Cleaning Service
            Provider is being sourced.
            
            9. USER COMMENTS, FEEDBACK AND OTHER SUBMISSIONS
            
            If, at our request, you send certain specific submissions (for example contest entries) or without 
            a request from us you send creative ideas, suggestions, proposals, plans, or other materials, 
            whether online, by email, by postal mail, or otherwise (collectively, "comments"), you agree that 
            we may, at any time, without restriction, edit, copy, publish, distribute, translate and otherwise 
            use in any medium any comments that you forward to us. We are and shall be under no 
            obligation (a) to maintain any comments in confidence; (b) to pay compensation for any 
            comments; or (c) to respond to any comments.
            We may, but have no obligation to, monitor, edit or remove content that we determine in our 
            sole discretion is unlawful, offensive, threatening, libelous, defamatory, pornographic, obscene 
            or otherwise objectionable or violates any party’s intellectual property or these Terms.
            You agree that your comments will not violate any right of any third-party, including copyright, 
            trademark, privacy, personality or other personal or proprietary right. You further agree that 
            your comments will not contain libelous or otherwise unlawful, abusive or obscene 
            material, or contain any computer virus or other malware that could in any way affect the 
            operation of the website or the services obtained therefrom. You may not use a false e-mail 
            address, pretend to be someone other than yourself, or otherwise mislead us or third-parties as 
            to the origin of any comments. You are solely responsible for any comments you make and their 
            accuracy. We take no responsibility and assume no liability for any comments posted by you or 
            any third-party. 
            The Cleaning Service Providers should at all times maintain their own insurance that adequately 
            deals with any losses or damages caused by the Cleaning Services. 
            
            10. CONFIDENTIALITY (Internet and Email) AND PERSONAL INFORMATION
            
            Skep cannot ensure the privacy and authenticity of any information you send to us or that we 
            send to you over the Internet. Skep will not be responsible for any losses or damages you may 
            incur if you communicate confidential information to us over the internet or if we communicate 
            such information to you at your request. 
            Email over the Internet is not a secure medium and privacy cannot be assured. Email 
            communication is not confidential, is subject to possible interception or loss, and is also subject 
            to possible alteration. Skep is not responsible for and will not be liable for any loss or damages 
            in connection with an email containing personal or confidential information sent by you to Skep, 
            or an email by Skep to you at your request. 
            The transmission of data or information over the Internet or other forms of networks may not 
            be secure, and is subject to possible loss, interception or alteration while in transit. Skep 
            cannot guarantee the security of any communication to or from the website. Skep does not 
            assume any liability for any damage you may experience or costs you may incur as a result of 
            any electronic transmissions over the Internet, other forms of networks or otherwise while 
            using the website. 
            Any personal information (as such term is described in our Privacy Policy) is governed by our 
            Privacy Policy. 
            
            11. ERRORS, INACCURACIES AND OMISSIONS
            
            Occasionally there may be information on our site that contains typographical 
            errors, inaccuracies or omissions that may relate to the Services. We reserve the right to 
            correct any errors, inaccuracies or omissions, and to change or update information or cancel 
            orders if any information in this website or any products or services obtained therefrom is 
            inaccurate at any time without prior notice (including after you have submitted your order). 
            We undertake no obligation to update, amend or clarify information in the Services, 
            including without limitation, pricing information, except as required by law. No specified update 
            or refresh date applied in these Terms or on any related website, should be taken to 
            indicate that all information in these Terms or on any related website has been modified or 
            updated. 
            Downloading the content when accessing or using the Services is solely at your own risk. Skep 
            cannot and does not guarantee or warrant that the content will be free of viruses, worms, 
            trojan horses or disabling devices or other code that manifests contaminating or destructive 
            properties. You are responsible for implementing safeguards to protect the security and 
            integrity of your mobile device and you are responsible for the entire cost of any services, 
            repairs or connections of and to your mobile device which may be necessary as a result of your 
            use of the Services. 
            
            12. DISCLAIMERS; LIMITATION OF LIABILITY Disclaimer.
            
            THE SERVICES ARE PROVIDED "AS IS" AND "AS AVAILABLE." SKEP DISCLAIMS 
            ALL REPRESENTATIONS AND WARRANTIES, EXPRESS, IMPLIED OR STATUTORY, NOT EXPRESSLY 
            SET OUT IN THESE TERMS, INCLUDING THE IMPLIED WARRANTIES OF MERCHANTABILITY, 
            FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN ADDITION, SKEP 
            MAKES NO REPRESENTATION, WARRANTY, OR GUARANTEE REGARDING THE RELIABILITY, 
            TIMELINESS, QUALITY, SUITABILITY OR AVAILABILITY OF THE SERVICES OR ANY SERVICES 
            OR GOODS REQUESTED THROUGH THE USE OF THE SERVICES, OR THAT THE SERVICES WILL 
            MEET YOUR REQUIREMENTS, BE UNINTERRUPTED OR ERROR-FREE, OR THAT THERE WILL BE 
            NO DELAYS, FAILURES, ERRORS (INCLUDING TYPOGRAPHICAL) OR OMISSIONS OR LOSS OF 
            TRANSMITTED INFORMATION, THAT IT WILL BE SECURE, THAT NO VIRUSES OR OTHER 
            CONTAMINATING OR DESTRUCTIVE PROPERTIES WILL BE TRANSMITTED OR THAT NO DAMAGE 
            WILL OCCUR TO YOUR MOBILE DEVICE. YOU HAVE THE SOLE RESPONSIBILITY FOR 
            ADEQUATE PROTECTION AND BACKUP OF DATA AND/OR EQUIPMENT AND TO TAKE 
            REASONABLE AND APPROPRIATE PRECAUTIONS TO SCAN FOR VIRUSES OR OTHER 
            DESTRUCTIVE PROPERTIES. SKEP DOES NOT GUARANTEE THE QUALITY, SUITABILITY, SAFETY 
            OR ABILITY OF CLEANING SERVICE PROVIDERS. YOU AGREE THAT THE ENTIRE RISK ARISING 
            OUT OF YOUR USE OF THE SERVICES, AND ANY SERVICE OR GOOD REQUESTED IN 
            CONNECTION THEREWITH, REMAINS SOLELY WITH YOU, TO THE MAXIMUM EXTENT 
            PERMITTED UNDER APPLICABLE LAW. 
            You agree that from time to time we may prevent you from accessing the Services and/or remove 
            the Services thereon for indefinite periods of time or cancel the Services at any time, without 
            notice to you. 
            You expressly agree that your access and use of, or inability to use, the Services thereto is at your 
            sole risk. 
            Limitation of Liability.
            TO THE FULLEST EXTENT PERMITTED BY LAW, YOU RELEASE SKEP FROM, AND IN NO EVENT SHALL 
            SKEP BE LIABLE, WHETHER BASED ON WARRANTY, CONTRACT, TORT, NEGLIGENCE, STRICT 
            LIABILITY OR ANY OTHER LEGAL THEORY, FOR ANY DAMAGES OF ANY KIND, FOR ANY LOSS OR 
            DAMAGES OF ANY KIND (INCLUDING INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, PUNITIVE OR 
            CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, LOSS OF USE, LOST DATA, PERSONAL
            INJURY, PROPERTY DAMAGE, FINES, FEES, PENALTIES OR OTHER LIABILITIES), WHETHER OR NOT 
            SKEP OR ANY OTHER SKEP PARTY IS ADVISED OF THE POSSIBILITY OF SUCH LOSSES OR DAMAGES, 
            RELATED TO, IN CONNECTION WITH, OR OTHERWISE RESULTING FROM ANY USE OF THE 
            SERVICES, EVEN IF SKEP HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. SKEP SHALL 
            NOT BE LIABLE FOR ANY DAMAGES, LIABILITY OR LOSSES ARISING OUT OF: (i) YOUR USE OF OR 
            RELIANCE ON THE SERVICES OR YOUR INABILITY TO ACCESS OR USE THE SERVICES; OR (ii) ANY 
            TRANSACTION OR RELATIONSHIP BETWEEN YOU AND ANY THIRD PARTY PROVIDER, EVEN IF SKEP 
            HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. SKEP SHALL NOT BE LIABLE FOR 
            DELAY OR FAILURE IN PERFORMANCE RESULTING FROM CAUSES BEYOND SKEP’S REASONABLE 
            CONTROL. IN NO EVENT SHALL SKEP’S TOTAL LIABILITY TO YOU IN CONNECTION WITH THE 
            SERVICES FOR ALL DAMAGES, LOSSES AND CAUSES OF ACTION EXCEED FIVE HUNDRED 
            CANADIAN DOLLARS (${'\$'}500).
            SKEP’S SERVICES MAY BE USED BY YOU TO REQUEST AND SCHEDULE CLEANING SERVICES WITH 
            CLEANING SERVICE PROVIDERS, BUT YOU AGREE THAT SKEP HAS NO RESPONSIBILITY OR 
            LIABILITY TO YOU RELATED TO ANY CLEANING SERVICES PROVIDED TO YOU BY CLEANING 
            SERVICE PROVIDERS OTHER THAN AS EXPRESSLY SET FORTH IN THESE TERMS.
            THE LIMITATIONS AND DISCLAIMER IN THIS SECTION 12 DO NOT PURPORT TO LIMIT LIABILITY 
            OR ALTER YOUR RIGHTS AS A CONSUMER THAT CANNOT BE EXCLUDED UNDER APPLICABLE LAW.
            SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OF CERTAIN WARRANTIES OR THE 
            LIMITATION OR EXCLUSION OF LIABILITY FOR CONSEQUENTIAL OR INCIDENTAL DAMAGES. 
            ACCORDINGLY, SOME OF THE ABOVE LIMITATIONS MAY NOT APPLY TO YOU.
            
            13. INDEMNITY
            
            As a condition of use of the Services, you agree to indemnify, defend and hold harmless Skep and 
            its successors in interest (collectively, the "Indemnified Parties" and each an "Indemnified 
            Party") from and all claims, demands, losses, liabilities, and expenses, including reasonable 
            lawyers' and advisors’ fees and costs, incurred or suffered by any of the Indemnified Parties in 
            connection with, related to or arising out of: (a) your breach of the Agreement, these Terms or 
            the documents they incorporate herein by reference; (b) your use of the Services or services or 
            goods obtained through your use of the Services; (c) your violation of any law or the rights of a 
            third-party, including the Cleaning Service Providers; or (d) Skep’s use of your User information 
            in accordance with this Agreement. You agree to cooperate fully in Skep's defense of any such 
            claim. You agree that you will not in any event settle any matter involving Skep, whether or not 
            the settlement binds or is on behalf of Skep, without the written consent of Skep.
            
            14. NOTICE
            
            Skep may give notice by means of a general notice on the Services, electronic mail to your email 
            address associated with your Account, or by written communication sent to your address as set 
            forth in your Account. You may give notice to Skep as set out below in the Agreement.
            15. GOVERNING LAW
            Except as otherwise set forth in these Terms, these Terms shall be exclusively governed by and 
            construed in accordance with the laws of the Province of Ontario, and any applicable federal 
            law of Canada thereto. 
            
            16. INTELLECTUAL PROPERTY
            All information provided or accessed through the Services and App is protected under the 
            copyright laws of Canada and, as applicable, other countries. The information is for your personal, 
            educational and non-commercial use only and may be used and reproduced provided that it is 
            not modified and that you maintain all copyright and other notices contained in the App or 
            accessed through the Services. The contents of the App or accessed through the Services may 
            not be otherwise used, copied, redistributed, reproduced, republished, stored in any medium, 
            retransmitted, modified or broadcasted, in any form.
            Claims of Copyright Infringement.
            Claims of copyright infringement or violation should be sent to us in accordance with our contact 
            information below. 
            17. TERMINATION
            The obligations and liabilities of the parties incurred prior to the termination date of this 
            Agreement shall survive the termination of this Agreement for all purposes.
            You acknowledge and agree that Skep may restrict, suspend or terminate your access to, and use 
            of, all or any part of the Services, at any time, with or without cause, including, without limitation, 
            any breach of the terms of the legal notices set out herein, in Skep's absolute discretion and 
            without prior notice or liability. 
            You may terminate this Agreement at any time by notifying us as described below that you cease 
            to use Services. 
            18. GENERAL TERMS
            The failure of us to exercise or enforce any right or provision of these Terms shall not constitute 
            a waiver of such right or provision. 
            You may not assign or transfer these Terms in whole or in part without Skep’s prior written 
            approval. You give your approval to Skep for it to assign or transfer these Terms in whole or in 
            part, including to: (a) a subsidiary or affiliate; (b) an acquirer of Skep’s equity, business or assets; 
            or (c) a successor by merger. No joint venture, partnership, employment or agency relationship 
            exists between you, Skep or any third party provider of Skep as a result of the contract between 
            you and Skep or use of the Services. 
            If any provision of these Terms is held to be illegal, invalid or unenforceable, in whole or in part, 
            under any law, such provision or part thereof shall to that extent be deemed not to form part of 
            these Terms but the legality, validity and enforceability of the other provisions in these Terms 
            shall not be affected. In that event, the parties shall replace the illegal, invalid or unenforceable 
            provision or part thereof with a provision or part thereof that is legal, valid and enforceable and 
            that has, to the greatest extent possible, a similar effect as the illegal, invalid or unenforceable 
            provision or part thereof, given the contents and purpose of these Terms. The Agreement 
            constitutes the entire agreement between you and us regarding the subject matter set out in 
            these Terms and governs your use of the Services and supersedes and replaces any and all prior 
            or contemporaneous agreements, communications, undertakings and proposals, whether oral or 
            written, between you and us regarding such subject matter. In these Terms, the words 
            "including" and "include" mean "including, but not limited to". 
            Any ambiguities in the interpretation of these Terms shall not be construed against the drafting 
            party. 
            
            19. CONTACT INFORMATION
            Questions about the Terms should be sent to us in writing by email at info.legal@skephome.com 
            This Agreement was last updated and is effective as of Aug 10, 2021. © 2021 Skep Solutions Corp. All rights reserved. 
            Reproduction in whole or in part without permission is prohibited.
            
        """, style: TextStyle(fontSize: 12 , color: constants.darkgrey , fontWeight: FontWeight.normal , fontFamily: 'Ubuntu'),)
            ],
          ),
        ),
      ),
    ));
  }
}
