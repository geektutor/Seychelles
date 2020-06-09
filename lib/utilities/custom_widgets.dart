//import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'styles.dart';

///Displays the logo of the Grant Consent App.
///
///Specify display style using ```
///LogoType
///``` enum
/// + mediumWithText
/// + mediumWithoutText
/// + largeWithText
/// + largeWithoutText
///
///

class GrantConsentLogo extends StatelessWidget {
  final LogoType type;

  GrantConsentLogo(this.type);

  final Widget mediumLogoImage = ConstrainedBox(
    constraints: BoxConstraints.tightFor(width: 78.9, height: 78.0),
    child: Image(
      image: kGrantConsentLogo,
    ),
  );

  final Widget largeLogoImage = ConstrainedBox(
    constraints: BoxConstraints.tightFor(width: 106.21, height: 105.0),
    child: Image(
      image: kGrantConsentLogo,
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (type == LogoType.mediumWithoutText)
      return mediumLogoImage;
    else if (type == LogoType.largeWithoutText)
      return largeLogoImage;
    else if (type == LogoType.mediumWithText)
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            mediumLogoImage,
            SizedBox(height: 6),
            Text(
              'CONSENT',
              style: GoogleFonts.quicksand(
                fontSize: 18,
                color: kButtonTextColor2,
              ),
            )
          ],
        ),
      );
    else
      /*  (type == LogoType.largeWithText) */
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            largeLogoImage,
            Text(
              'CONSENT',
              style: GoogleFonts.quicksand(
                fontSize: 27,
                color: kButtonTextColor2,
              ),
            )
          ],
        ),
      );
  }
}

///A rounded border button with ```
///Icons.chevron_right``` icon.
///Button used in ```
///SplashScreen()
///```
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    @required this.onTap,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightForFinite(width: 52, height: 40),
      child: FlatButton(
        onPressed: onTap,
        child: Icon(Icons.chevron_right, color: kButtonTextColor1),
        color: kButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

///Display Animated dot component for
///```
///SlideIndicatorPane ```
class SlideIndicatorDot extends StatelessWidget {
  final bool isActive;

  SlideIndicatorDot(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.only(right: 8.0),
      constraints: BoxConstraints.tightFor(width: 7, height: 7),
      decoration: BoxDecoration(
        color: isActive ? kButtonColor : kInactiveSlideDotColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

///Display a row of ```
///SlideIndicatorDot``` 's and indicate which page is active.
///
class SlideIndicatorPane extends StatelessWidget {
  SlideIndicatorPane({@required this.currentPage});

  final int currentPage;
  final List<SlideIndicatorDot> _slideIndicators = [
    SlideIndicatorDot(false),
    SlideIndicatorDot(false),
  ];
  final List<SlideIndicatorDot> _slideIndicatorsBlank = [
    SlideIndicatorDot(false),
    SlideIndicatorDot(false),
  ];

  void prepIndicators() {
    //  _slideIndicators.clear();
    _slideIndicators.setAll(0, _slideIndicatorsBlank);
    _slideIndicators[currentPage] = SlideIndicatorDot(true);
  }

  @override
  Widget build(BuildContext context) {
    prepIndicators();
    return Container(
      child: Row(
        children: _slideIndicators,
      ),
    );
  }
}

///Creates a button with.
/// +5 pixel rounded edges.
/// +Trailing ```
/// Icons.chevron_right ``` icon.
/// + and [label] String as title.
///
///
///
class UserActionButton extends StatelessWidget {
  UserActionButton({
    @required this.onTap,
    @required this.label,
    this.filled = true,
  });
  final Function onTap;
  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      constraints:
          BoxConstraints.tightFor(width: kScreenSize.width, height: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: filled ? kButtonColor : Colors.transparent,
        border: filled ? null : Border.all(color: kButtonColor),
      ),
      child: RawMaterialButton(
        padding: EdgeInsets.only(left: 40, right: 14.4),
        onPressed: onTap,
        constraints: BoxConstraints.expand(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              label,
              style: filled
                  ? kButtonTextStyle
                  : kButtonTextStyle.copyWith(color: kButtonTextColor2),
            ),
            Icon(
              Icons.chevron_right,
              color: filled ? kButtonTextColor1 : kButtonTextColor2,
            ),
          ],
        ),
      ),
    );
  }
}

class UserGoogleButton extends StatelessWidget {
  UserGoogleButton({this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xff4285f4), borderRadius: BorderRadius.circular(5)),
        height: 40,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 1),
          constraints:
              BoxConstraints.tightFor(width: kScreenSize.width, height: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: RawMaterialButton(
            padding: EdgeInsets.only(left: 2, right: 14.4),
            onPressed: onTap,
            constraints: BoxConstraints.expand(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Ink(
                      child: Image(image: kGoogleLogo),
                      padding: EdgeInsets.all(5),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    SizedBox(width: 30),
                    Text(
                      'Sign Up with Google',
                      style: kGoogleButtonLabelStyle,
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {@required this.hintText,
      this.icon,
      this.textInputType,
      this.onEditingComplete,
      this.obscure = false,
      this.controller});

  final String hintText;
  final Icon icon;
  final Function onEditingComplete;
  final TextInputType textInputType;
  final bool obscure;
  final TextEditingController controller;
  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isVisible;
  @override
  void initState() {
    super.initState();
    isVisible = !widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        enableSuggestions: true,
        controller: widget.controller,
        onEditingComplete: widget.onEditingComplete,
        cursorColor: kButtonColor,
        style: kInputTextStyle, //TextStyle(color: kButtonTextColor2),
        obscureText: !isVisible,
        decoration: InputDecoration(
          labelText: widget.hintText,
          labelStyle: kInputTextStyle.copyWith(
            fontSize: 15,
            color: Color.fromRGBO(202, 180, 128, 0.5),
          ),
          filled: true,
          suffixIcon: widget.obscure
              ? IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: kButtonColor,
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                )
              : null,
//          fillColor: Color.fromRGBO(202, 180, 128, 0.05),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(202, 180, 128, 0.2),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(3.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(202, 180, 128, 01),
            ),
          ),
        ),
        keyboardType: widget.textInputType,
        textCapitalization:
            widget.obscure ? TextCapitalization.none : TextCapitalization.words,
      ),
    );
  }
}

class ConsentOptionButton extends StatelessWidget {
  ConsentOptionButton(
      {@required this.type,
      this.label,
      this.selected = false,
      @required this.responseTap});
  final ConsentOptionType type;
  final String label;
  final bool selected;
  final Function responseTap;
  final size = Size(53, 23);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5, top: 8, bottom: 8),
      constraints:
          BoxConstraints.tightFor(width: size.width, height: size.height),
      decoration: BoxDecoration(
        color: selected
            ? (type == ConsentOptionType.no
                ? noColor[ColorType.fill]
                : yesColor[ColorType.fill])
            : neutralColor[ColorType.fill],
        border: Border.all(
          color: selected
              ? (type == ConsentOptionType.no
                  ? noColor[ColorType.border]
                  : yesColor[ColorType.border])
              : neutralColor[ColorType.border],
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: RawMaterialButton(
        onPressed: responseTap,
        padding: EdgeInsets.zero,
        child: Text(
          label ?? '',
          maxLines: 1,
          style: kConsentOptionButtonTextStyle,
        ),
      ),
    );
  }
}

class ConsentActionButton extends ConsentOptionButton {
  ConsentActionButton({
    this.labelText,
    this.buttonType,
    this.onTap,
  });
  final ConsentOptionType buttonType;
  final String labelText;
  final Function onTap;
  @override
  Function get responseTap => onTap;
  @override
  ConsentOptionType get type => buttonType;
  @override
  String get label => labelText;
  @override
  Size get size => Size(150, 50);
  @override
  bool get selected => true;
}

SnackBar customSnackBar({String message, int durationInSeconds}) {
  return SnackBar(
    backgroundColor: kButtonColor,
    behavior: SnackBarBehavior.fixed,
    duration: Duration(seconds: durationInSeconds ?? 2),
    content: Container(
      padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
      alignment: Alignment.center,
      height: 40,
      child: Text(
        message ?? "",
        textAlign: TextAlign.center,
        style: kBody1TextStyle.copyWith(color: kBackgroundColor),
      ),
    ),
  );
}

class ProfileTabsWidget extends StatelessWidget {
  ProfileTabsWidget({
    @required this.image,
    @required this.label,
    this.icon,
    this.onTap,
  });
  final IconData icon;
  final Image image;
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: SizedBox(
        height: 30,
        // decoration: BoxDecoration(
        //  // color: Color.fromRGBO(35, 35, 35, 0.1),
        //   //borderRadius: BorderRadius.circular(50),
        // ),
        child: FlatButton(
          onPressed: onTap,
          color: Color.fromRGBO(35, 35, 35, 0.1),
          disabledColor: Color.fromRGBO(35, 35, 35, 0.1),
          padding: const EdgeInsets.only(left: 6.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          splashColor: Color(0x55CAB480),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.white,
                  child: image,
                ),
                SizedBox(width: 13),
                Text(
                  label,
                  style: GoogleFonts.roboto(fontSize: 14),
                ),
                // Icon(
                //   icon,
                //   color: Color.fromRGBO(35, 35, 35, 0.3),
                // ),
              ]),
        ),
      ),
    );
  }
}

class AboutPageTemplate extends StatelessWidget {
  AboutPageTemplate(
      {@required this.onTap,
      @required this.title,
      @required this.valueListenableBuilder});
  final Function onTap;
  final String title;
  final ValueListenableBuilder valueListenableBuilder;

  @override
  Widget build(BuildContext context) {
    kScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFDED7C7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: InkResponse(
                  onTap: onTap,
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 5, 0),
                child: Text(
                  title,
                  style: kBody1TextStyle.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],),
        ),
      ),
    );
  }
}
