import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/core/widgets/app_text_button.dart';

import '../../core/theming/colors.dart';
import '../places/data/models/hotel_model.dart';

class HotelDetails extends StatelessWidget {
  final HotelModel hotel;

  const HotelDetails({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(hotel.image!),
              ),
              FractionalTranslation(
                translation: const Offset(0, 0.5),
                child: SizedBox(
                  width: 315,
                  height: 170,
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(right: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias,

                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                hotel.hotelName,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: ColorsManger.darkBlue,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: ColorsManger.white,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Cairo',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ColorsManger.lightGray,
                            ),
                          ),
                          SizedBox(height: 10),

                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: hotel.price?.toString() ?? '0',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsManger.darkBlue,
                                  ),
                                ),
                                TextSpan(
                                  text: 'EGP',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorsManger.darkBlue,
                                  ),
                                ),
                                TextSpan(
                                  text: ' / A night',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: ColorsManger.lightGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 7),

                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 25),
                              SizedBox(width: 3),
                              Text(
                                hotel.rating?.toString() ?? '0',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 90),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 18),
            child: Column(
              children: [
                Row(
                  spacing: 35,
                  children: [
                    Text(
                      'Detail',
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorsManger.darkBlue,
                        decorationThickness: 2,

                        fontWeight: FontWeight.bold,
                        color: ColorsManger.darkBlue,
                      ),
                    ),
                    Text('Overview',style: TextStyle(
                      color: ColorsManger.lightGray,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),),
                    Text('Review',style: TextStyle(
                        color: ColorsManger.lightGray,
                      fontSize: 16,

                      fontWeight: FontWeight.w600,

                    )),
                  ],
                ),
                SizedBox( height: 20),
                Text(hotel.description,maxLines: 3,overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorsManger.gray.withOpacity(.7),
                    fontWeight: FontWeight.w500,
                  )),
                SizedBox(height: 30,),
                AppTextButton(
                  buttonWidth: 380,
                    backgroundColor: ColorsManger.darkBlue,
                    buttonText: "Book Now", textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorsManger.white,
                ), onPressed: (){})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
