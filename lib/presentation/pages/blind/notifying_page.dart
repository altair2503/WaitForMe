import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class NotifyingPage extends StatefulWidget {
  const NotifyingPage({super.key});

  @override
  State<NotifyingPage> createState() => _NotifyingPageState();
}

class _NotifyingPageState extends State<NotifyingPage> {

  bool found = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map.png'),
                fit: BoxFit.cover
              )
            )
          ),
          Padding(padding: const EdgeInsets.only(top: 50), child: TextButton(onPressed: () {setState(() {found = !found;});}, child: const Text("Press"))),
          AnimatedPadding(
            duration: const Duration(milliseconds: 300),
            padding: !found ? const EdgeInsets.only(bottom: 20) : const EdgeInsets.only(bottom: 140),
            child: const Align(
              alignment: Alignment.center,
              child: Image(image: AssetImage('assets/icons/location.gif'), width: 90)
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.center,
            margin: !found ? const EdgeInsets.only(bottom: 29) : const EdgeInsets.only(bottom: 149),
            child: const Image(image: AssetImage('assets/icons/locationicon.png'), width: 45)
          ),
          SafeArea(
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: !found ? const EdgeInsets.fromLTRB(20, 30, 20, 30) : const EdgeInsets.fromLTRB(15, 45, 15, 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(.06)),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                // child: Column(
                //   mainAxisSize: MainAxisSize.min,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     // const Image(image: AssetImage('assets/icons/driver.gif'), width: 400),
                //     Row(
                //       children: [
                //         const Text('We notifying drivers nearby ', style: TextStyle(fontSize: 19)),
                //         AnimatedTextKit(
                //           repeatForever: true,
                //           pause: const Duration(milliseconds: 500),
                //           animatedTexts: [
                //             TyperAnimatedText('...', textStyle: const TextStyle(fontSize: 19), speed: const Duration(milliseconds: 250))
                //           ]
                //         )
                //       ],
                //     ),
                //     const SizedBox(height: 15),
                //     SizedBox(
                //       width: double.infinity,
                //       height: 65,
                //       child: TextButton(
                //         onPressed: () => { Navigator.pop(context) },
                //         style: TextButton.styleFrom(
                //           backgroundColor: const Color.fromRGBO(22, 35, 56, 1),
                //           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                //         ),
                //         child: const Text(
                //           "Cancel",
                //           style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white)
                //         ),
                //       )
                //     )
                //   ]
                // )
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(found) const Image(image: AssetImage('assets/icons/driver.gif.webp'), width: 300),
                    if(found) const SizedBox(height: 18),
                    if(found) const Text('Drivers have been notified, expect.', style: TextStyle(fontSize: 18)),
                    if(found) const Divider(height: 40, color: Color.fromRGBO(0, 0, 0, .1)),
                    if(found) const SizedBox(height: 10),
                    if(!found) Row(
                      children: [
                        const Text('We notifying drivers nearby ', style: TextStyle(fontSize: 19)),
                        AnimatedTextKit(
                          repeatForever: true,
                          pause: const Duration(milliseconds: 500),
                          animatedTexts: [
                            TyperAnimatedText('...', textStyle: const TextStyle(fontSize: 19), speed: const Duration(milliseconds: 250))
                          ]
                        )
                      ],
                    ),
                    if(!found) const SizedBox(height: 15),
                    Row(
                      children: [
                        if(found) Expanded(
                          child: TextButton(
                            onPressed: () => { Navigator.pop(context) },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(22, 35, 56, 1),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                              padding: const EdgeInsets.symmetric(vertical: 16)
                            ),
                            child: const Text(
                              "I'm in bus",
                              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white)
                            ),
                          )
                        ),
                        if(found) const SizedBox(width: 10),
                        Expanded(
                          child: TextButton(
                            onPressed: () => { Navigator.pop(context) },
                            style: TextButton.styleFrom(
                              backgroundColor: found ? const Color.fromRGBO(243, 243, 243, 1) : const Color.fromRGBO(22, 35, 56, 1),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                              padding: EdgeInsets.symmetric(vertical: found ? 16 : 18)
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: found ? Colors.black : Colors.white)
                            ),
                          )
                        )
                      ],
                    )
                  ]
                ),
              ) 
            )
          )
        ],
      ),
    );
  }

}