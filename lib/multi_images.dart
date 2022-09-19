import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';




class MultiImages extends StatefulWidget {




  @override
  State<MultiImages> createState() => _MultiImagesState();
}

class _MultiImagesState extends State<MultiImages> {
  final controller = CarouselController();
  int activeIndex = 0;


  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  void selectImages() async{
    final List<XFile>?  selectedImages = await imagePicker.pickMultiImage();
    if(selectedImages!.isNotEmpty){
      imageFileList!.addAll(selectedImages);
    }

    setState((){

    });


  }
  Widget buildImage(String urlImage ,int index ){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Image.file(File(imageFileList![index].path),fit: BoxFit.fill,),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("Image Picker Example"),
        // ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                MaterialButton(
                    color: Colors.blue,
                    child: const Text(
                        "Pick Images from Gallery",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold
                        )
                    ),
                    onPressed: () {
                      selectImages();
                    }
                ),

                SizedBox(height: 20,),
                // Container(
                //   height: 400,
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(vertical: 10),
                //       child: ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         itemCount: imageFileList!.length,
                //         itemBuilder: (BuildContext context,int index){
                //           return Image.file(File(imageFileList![index].path),fit: BoxFit.cover,);
                //
                //         },
                //
                //       ),
                //
                //     ),
                // ),
                CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: imageFileList!.length,
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                      height: 400,
                      aspectRatio: 16/12,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason){
                        setState((){
                          activeIndex = index;
                        });
                      }
                  ),
                  itemBuilder: (BuildContext context,index,newIndex){
                    final urlImage = imageFileList![index];
                    return buildImage(urlImage.path, index);
                  },
                ),
                SizedBox(height: 30,),

                CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: imageFileList!.length,
                  options: CarouselOptions(
                      height: 20,


                      initialPage: 2,
                      viewportFraction: 0.1,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason){
                        setState((){
                          activeIndex = index;
                        });
                      }
                  ),
                  itemBuilder: (context,index,newIndex){
                    final urlImage = imageFileList![index];
                    return buildImage( urlImage.path, index );
                  },
                ),

              ],
            ),
          ),
        ),
    );
  }
}