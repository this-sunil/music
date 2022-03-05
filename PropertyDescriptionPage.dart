
import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo/Controller/AddWishListController.dart';
import 'package:demo/Controller/DeleteWishListController.dart';
import 'package:demo/Controller/FeaturedPropertiesController.dart';
import 'package:demo/Controller/LoginController.dart';
import 'package:demo/Controller/PropertyDescriptionSearchController.dart';
import 'package:demo/Controller/ZeroEdgeAddController.dart';
import 'package:demo/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:demo/Controller/wish_list_count.dart';
import 'package:html/parser.dart' as html;
class PropertyDescriptionPage extends StatefulWidget {
  final int index;
  final String id;
  final String locationId;
  final String categoryId;
  final String title;
  final String image;
  final String price;
  final String description;
  final String bed;
  final String bathroom;
  final String garages;
  final String amenities;
  final String status;
  final String equipment;
  final String remodalYear;
  final String deposit;
  final String poolSize;
  final String propertyType;
  final String area;
  final String yearBuilt;
  final String categoryName;
  final String view;

  const PropertyDescriptionPage({Key key,this.view,this.id,this.locationId,this.categoryId,this.index,this.title,this.image,this.price,this.description,this.bed,this.bathroom,this.garages,this.status,this.equipment,this.amenities,this.remodalYear,this.deposit,this.propertyType,this.poolSize,this.area,this.yearBuilt,this.categoryName}) : super(key: key);

  @override
  _PropertyDescriptionPageState createState() => _PropertyDescriptionPageState();
}

class _PropertyDescriptionPageState extends State<PropertyDescriptionPage> {
  PropertyDescriptionSearchController propertyDescriptionSearchController=Get.put(PropertyDescriptionSearchController());
  CountWishList wishListCount=Get.put(CountWishList());
  GlobalKey<FormState>formKey=GlobalKey<FormState>();
  TextEditingController name;
  TextEditingController email;
  TextEditingController phone;
  TextEditingController subject;
  TextEditingController message;
  LoginController loginController=Get.put(LoginController());
  ZeroEdgeAddController zeroEdgeAddController=Get.put(ZeroEdgeAddController());
  String firstHalf;
  String secondHalf;
  CarouselController carouselController=CarouselController();
  int currentIndex=0;
  FeaturedPropertiesController featuredPropertiesController=Get.put(FeaturedPropertiesController());
  bool flag = true;
  String details;
  bool fav=false;
  DeleteWishListController deleteWishListController=Get.put(DeleteWishListController());
  AddWishListController addWishListController=Get.put(AddWishListController());
  contact(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        contentPadding: EdgeInsets.all(20),
        title: Column(
          children: [
            Text("Listed By",style: TextStyle(fontSize: 18),),
            SizedBox(height:5),
            loginController.apiModelList.length>0?Text("${loginController.apiModelList.first.data.firstName}"+" "+"${loginController.apiModelList[0].data.lastName}",style: TextStyle(fontSize: 16)):Text(""),
            SizedBox(height:5),
            loginController.apiModelList.length>0?Text("${loginController.apiModelList.first.data.email}",style: TextStyle(fontSize: 16)):Text(""),
          ],
        ),
        actions: [],
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: GetBuilder(
            init: zeroEdgeAddController,
            builder: (controller){
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(5),
                      child: TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                            hintText: "Enter Your Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            )

                        ),
                        validator: (val)=>val.isEmpty?"Enter your name":"",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            hintText: "Email address",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )
                        ),
                        validator: (val)=>val.isEmpty?"Enter your email Address":"",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: phone,
                        decoration: InputDecoration(
                            hintText: "Phone Number",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )
                        ),
                        validator: (val)=>val.isEmpty?"Enter your phone number":"",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: subject,
                        decoration: InputDecoration(

                            hintText: "Subject",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )
                        ),
                        validator: (val)=>val.isEmpty?"Enter your Subject":"",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        controller: message,
                        decoration: InputDecoration(

                            hintText: "\n\n\nMessage\n\n\n",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )

                        ),
                      ),
                    ),
                    SizedBox(height:20),
                    Center(
                      child: Padding(
                        padding:  EdgeInsets.all(10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width/1.5,
                          height: 60.0,

                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                primary: Colors.deepPurpleAccent,
                              ),
                              onPressed: (){
                              setState(() {
                                if(formKey.currentState.validate()){
                                  zeroEdgeAddController.fetchZeroAdd(name.text, email.text, phone.text, subject.text, message.text);
                                  Fluttertoast.showToast(msg: "Thank you for contacting us! We will get back to you soon");
                                  formKey.currentState.save();

                                  Navigator.pop(context);
                                }
                                name.text="";
                                email.text="";
                                phone.text="";
                                subject.text="";
                                message.text="";
                              });
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                              }, child: Text("Contact")),
                        ),
                      ),
                    ),
                    SizedBox(height:10),
                  ],
                ),


              );
            },
          )
        ),
      );
    });
  }

parseData(String description){
    setState(() {
      final data=html.parse(description).body.text;
      print("data is here"+data);
      return data;
    });
}
String s="";
  @override
  void initState() {
    print("Property Id"+widget.id);
    name=TextEditingController();
    email=TextEditingController();
    phone=TextEditingController();
    subject=TextEditingController();
    message=TextEditingController();
    int id=int.parse(widget.id);
    wishListCount.fetchWishList(101);
    s=wishListCount.wishNumbers.first;
    setState(() {
      // if(widget.description.length>100){
      //   var f=html.parse(widget.description.substring(0,200)).body.text;
      //   firstHalf=f;
      // //  firstHalf=widget.description.substring(0,50);
      //   var s=html.parse(widget.description.substring(0,widget.description.length)).body.text;
      //   secondHalf=s;
      // }
      // else{
      //   var s=html.parse(widget.description).body.text;
      //   firstHalf=s;
      //   secondHalf="";
      // }

     details= html.parse(widget.description).body.text;
      propertyDescriptionSearchController.fetchSearchPropertyDescription(widget.categoryId,widget.locationId);
      print("Id: ${widget.categoryId}");
    });

    super.initState();
  }
  @override
  void dispose() {
    propertyDescriptionSearchController.searchList.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            setState(() {
              Navigator.pop(context);
            });
          },
        ),

        //backgroundColor: Colors.white,
        title:Text("Property"),

      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CarouselSlider(
                    items: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: 500,
                            height: 200,
                            child: Image.network(
                              "${baseUrl+"uploads/"+widget.image}",
                              fit: BoxFit.cover,
                            ),
                          )),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child:Container(
                            width: 500,
                            height: 200,
                            child: Image.network(
                              "${baseUrl+"uploads/"+widget.image}",
                              fit: BoxFit.fill,
                            ),
                          )),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child:Container(
                            width: 500,
                            height: 200,
                            child: Image.network(
                              "${baseUrl+"uploads/"+widget.image}",
                              fit: BoxFit.fill,
                            ),
                          )),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(25),
                      //   child: Image.asset("assets/Adds/photo-2.png",
                      //       fit: BoxFit.fill),
                      // ),
                    ],
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 190,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                    )),
              ),
              SizedBox(height: 15,),
              Padding(
                padding:  EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text("${widget.title}",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                          ),),
                        ),
                        IconButton(onPressed: (){

                          setState(() {
                            int id=int.parse(widget.id);
                            fav==false?addWishListController.addWishList(widget.id,"${loginController.apiModelList.first.data.id}"):deleteWishListController.deleteWishList(id,loginController.apiModelList.first.data.id);
                            fav=!fav;


                          });
                        }, icon: Icon(fav==false?Icons.favorite_border_outlined:Icons.favorite_outlined,size: 30,)),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text("${widget.price.replaceAll(".", "")} ₹",style: TextStyle(

                    ),),
                    SizedBox(height: 0,),
                  ],
                ),
              ),

              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.remove_red_eye),
                      Text(widget.view)
                    ],
                  ),
                  VerticalDivider(color: Colors.red),
                  Column(
                    children: [
                      Icon(Icons.favorite),
                      Obx(()=>Text(wishListCount.wishNumbers.first)),
                    ],
                  ),

                ],
              ),
              Divider(),
              SizedBox(
                height: 0,
              ),
              Padding(
                padding:  EdgeInsets.only(left: 15.0),
                child: Text("Key Features",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 15.0,right: 15,top: 8,bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Text("Bedroom:"),
                        SizedBox(height: 10,),
                        Text("Property Size :"),
                        SizedBox(height: 10,),
                        Text("Price :")


                      ],

                    ),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("${widget.bed}", style: TextStyle(
                            fontWeight: FontWeight.bold,
                          fontSize: 10,
                        )),
                        SizedBox(height: 15,),
                        Text("${widget.area} sq.", style: TextStyle(
                            fontWeight: FontWeight.bold,
                          fontSize: 10,
                        )),
                        SizedBox(height: 15,),
                        Text("${widget.price}", style: TextStyle(
                            fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ))

                      ],
                    ),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bathroom:"),
                        SizedBox(height: 10,),
                        Text("Year Built :    "),
                        SizedBox(height: 10,),
                        Text("Deposit:"),
                        SizedBox(height: 10,),

                      ],
                    ),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("${widget.bathroom}", style: TextStyle(
                            fontWeight: FontWeight.bold,
                          fontSize: 10,
                        )),
                        SizedBox(height: 15,),

                        Text("${widget.yearBuilt}", style: TextStyle(
                            fontWeight: FontWeight.bold,
                          fontSize: 10,
                        )),
                        SizedBox(height: 15,),
                        Text("${widget.deposit}", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        )),
                        SizedBox(height: 15,),
                      ],
                    ),



                  ],
                ),
              ),
              Divider(),
              Padding(
                padding:  EdgeInsets.only(left: 15.0),
                child: Text("Description",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
              ),

              Padding(
                padding:  EdgeInsets.only(left: 14.0,right: 14,top: 6),
                child: Container(
                  decoration: BoxDecoration(


                  ),
                    child: Text("""$details""",style: TextStyle(fontSize: 10),)),
              ),
              // secondHalf==null
              //     ? new Text(firstHalf)
              //     : new Column(
              //   children: <Widget>[
              //     new Text(flag ? (firstHalf+"....") : (firstHalf +secondHalf)),
              //     new InkWell(
              //       child: new Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: <Widget>[
              //           new Text(
              //             flag ? "show more" : "show less",
              //             style: new TextStyle(color: Colors.blue),
              //           ),
              //         ],
              //       ),
              //       onTap: () {
              //         setState(() {
              //           flag = !flag;
              //         });
              //       },
              //     ),
              //   ],
              // ),
              Divider(),
              Padding(padding:EdgeInsets.all(8.0),child: Center(child: Text("Similar Properties",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)))),
              SizedBox(height:20),
              Obx((){
                return  propertyDescriptionSearchController.searchList.length>0?CarouselSlider.builder(
                  carouselController: carouselController,
                  itemCount: propertyDescriptionSearchController.searchList.length,
                  itemBuilder: (context,index,child){
                    //locationController.fetchLocation(featuredPropertiesController.featuredPropertyList.length==0?"1":featuredPropertiesController.featuredPropertyList[index].data[index].locationId.toString());
                    // imageInfoController.fetchImageInfo(featuredPropertiesController.featuredPropertyList.length==0?"1":featuredPropertiesController.featuredPropertyList[index].data[index].imageId.toString());
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>PropertyDescriptionPage(
                              index: index,
                              id:propertyDescriptionSearchController.searchList[index].data[index].id.toString(),
                              title: propertyDescriptionSearchController.searchList[index].data[index].title,
                              categoryId: propertyDescriptionSearchController.searchList[index].data[index].categoryId.toString(),
                              image: propertyDescriptionSearchController.searchList[index].data[index].mediaFile.filePath,
                              description: "${propertyDescriptionSearchController.searchList[index].data[index].content}",
                              price: propertyDescriptionSearchController.searchList[index].data[index].price,
                              amenities: propertyDescriptionSearchController.searchList[index].data[index].amenities,
                              equipment: propertyDescriptionSearchController.searchList[index].data[index].equipment,
                              status: propertyDescriptionSearchController.searchList[index].data[index].status,
                              bed: propertyDescriptionSearchController.searchList[index].data[index].bed.toString(),
                              deposit: propertyDescriptionSearchController.searchList[index].data[index].deposit,
                              garages: propertyDescriptionSearchController.searchList[index].data[index].garages.toString(),
                              bathroom: propertyDescriptionSearchController.searchList[index].data[index].bathroom.toString(),
                              area: propertyDescriptionSearchController.searchList[index].data[index].area.toString(),
                              propertyType: propertyDescriptionSearchController.searchList[index].data[index].propertyType.toString(),
                              poolSize: propertyDescriptionSearchController.searchList[index].data[index].poolSize,
                              yearBuilt: propertyDescriptionSearchController.searchList[index].data[index].yearBuilt.toString(),
                              remodalYear:propertyDescriptionSearchController.searchList[index].data[index].remodalYear,
                              categoryName: propertyDescriptionSearchController.searchList[index].data[index].category.name,
                            )
                        ));
                      },
                      child: Card(
                        child: Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // Text("Length is+${imageInfoController.imageInfo.length}"+"\n"+"${featuredPropertiesController.featuredPropertyList.length}"),
                            Container(

                              width: MediaQuery.of(context).size.width,
                              height:MediaQuery.of(context).size.height/3.5,

                              decoration:propertyDescriptionSearchController.searchList.length>0? BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                //color: Colors.black54,
                                image: propertyDescriptionSearchController.searchList[index].data[index]?.mediaFile?.filePath==null?DecorationImage(image: NetworkImage("https://media.istockphoto.com/vectors/error-404-vector-id538038858")):DecorationImage(
                                  image: NetworkImage('${baseUrl+"uploads/"+propertyDescriptionSearchController.searchList[index].data[index].mediaFile.filePath}'),
                                  fit: BoxFit.cover,
                                ),


                              ):BoxDecoration(
                                color: Colors.black54,
                              ),
                              child: Stack(
                                children: [
                                  // Container(
                                  //     margin: EdgeInsets.only(top: 20,left:20),
                                  //     width: 80,
                                  //     height: 30,
                                  //     decoration: BoxDecoration(
                                  //         color:Colors.black,
                                  //         borderRadius: BorderRadius.circular(5)
                                  //     ),
                                  //     child: Center(child: Text("${propertyDescriptionSearchController.searchList[index].data[index].amenities}",style: TextStyle(fontSize: 10,color: Colors.white),))),
                                  Positioned(
                                    bottom: 10,
                                    left:20,
                                    right:0,
                                    child: Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: [

                                        Text("From ${propertyDescriptionSearchController.searchList.length>0?propertyDescriptionSearchController.searchList[index]?.data[index]?.price:""} \u{20B9}",style: TextStyle(fontSize: 16,color: Colors.white)),

                                        IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined,color: Colors.white)),
                                      ],),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:20.0),
                                  child: Text("${propertyDescriptionSearchController.searchList[index].data[index].category.name}",style: TextStyle(color: Colors.pink)),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:20.0),
                                    child: Text("${propertyDescriptionSearchController.searchList[index].data[index].title}",style: TextStyle(fontSize: 12),),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:20.0),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on_outlined,size: 15,color: Colors.black),
                                  SizedBox(width:10),

                                  Text("${propertyDescriptionSearchController.searchList[index].data[index].location.name}",style: TextStyle(fontSize: 12)),
                                ],),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Beds:${propertyDescriptionSearchController.searchList.length>0?propertyDescriptionSearchController.searchList[index]?.data[index]?.bed:""}",style: TextStyle(fontSize: 12)),
                                Text("Baths:${propertyDescriptionSearchController.searchList.length>0?propertyDescriptionSearchController.searchList[index]?.data[index]?.bathroom:""}",style: TextStyle(fontSize: 12)),
                                Text("Sq:${propertyDescriptionSearchController.searchList.length>0?propertyDescriptionSearchController.searchList[index]?.data[index]?.square:""}",style: TextStyle(fontSize: 12)),
                              ],),
                            SizedBox(height:10),
                          ],
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                      initialPage: currentIndex, autoPlay: true,
                      aspectRatio: 16/9,
                      height:390,
                      autoPlayAnimationDuration: Duration(seconds: 8),
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      onPageChanged: (index,_){
                        setState(() {

                          currentIndex=index;


                          //print(currentIndex);
                        });
                      }
                  ),
                ):Center(child:CircularProgressIndicator(
                  color: Colors.pinkAccent,
                ));

              }),
              SizedBox(height: 10,),
              Padding(padding:EdgeInsets.all(8.0),child: Center(child: Text("Related Properties",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)))),
              SizedBox(height:20),
              featuredPropertiesController.featuredPropertyList.length>0?CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: featuredPropertiesController.featuredPropertyList.length,
                itemBuilder: (context,index,child){

                  //locationController.fetchLocation(featuredPropertiesController.featuredPropertyList.length==0?"1":featuredPropertiesController.featuredPropertyList[index].data[index].locationId.toString());
                  // imageInfoController.fetchImageInfo(featuredPropertiesController.featuredPropertyList.length==0?"1":featuredPropertiesController.featuredPropertyList[index].data[index].imageId.toString());
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>PropertyDescriptionPage(
                            index: index,
                            id:featuredPropertiesController.featuredPropertyList[index].data[index].id.toString(),
                            title: featuredPropertiesController.featuredPropertyList[index].data[index].title,
                            image: featuredPropertiesController.featuredPropertyList[index].data[index].filepath,
                            description: "${featuredPropertiesController.featuredPropertyList[index].data[index].content}",
                            price: featuredPropertiesController.featuredPropertyList[index].data[index].price,
                            amenities: featuredPropertiesController.featuredPropertyList[index].data[index].amenities,
                            equipment: featuredPropertiesController.featuredPropertyList[index].data[index].equipment,
                            status: featuredPropertiesController.featuredPropertyList[index].data[index].status.name,
                            bed: featuredPropertiesController.featuredPropertyList[index].data[index].bed.toString(),
                            deposit: featuredPropertiesController.featuredPropertyList[index].data[index].deposit,
                            garages: featuredPropertiesController.featuredPropertyList[index].data[index].garages.toString(),
                            bathroom: featuredPropertiesController.featuredPropertyList[index].data[index].bathroom.toString(),
                            area: featuredPropertiesController.featuredPropertyList[index].data[index].area.toString(),
                            propertyType: featuredPropertiesController.featuredPropertyList[index].data[index].propertyType.toString(),
                            poolSize: featuredPropertiesController.featuredPropertyList[index].data[index].poolSize,
                            yearBuilt: featuredPropertiesController.featuredPropertyList[index].data[index].yearBuilt.toString(),
                            remodalYear: featuredPropertiesController.featuredPropertyList[index].data[index].remodalYear,

                          )
                      ));
                    },
                    child: Card(
                      child: Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Text("Length is+${imageInfoController.imageInfo.length}"+"\n"+"${featuredPropertiesController.featuredPropertyList.length}"),
                          Container(

                            width: MediaQuery.of(context).size.width,
                            height:MediaQuery.of(context).size.height/3.5,

                            decoration:featuredPropertiesController.featuredPropertyList.length>0? BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              //color: Colors.black54,
                              image: featuredPropertiesController.featuredPropertyList[index].data[index].filepath==null?DecorationImage(image: NetworkImage("https://media.istockphoto.com/vectors/error-404-vector-id538038858")):DecorationImage(
                                image: NetworkImage("${baseUrl+"uploads/"+featuredPropertiesController.featuredPropertyList[index].data[index].filepath}"),
                                fit: BoxFit.cover,
                              ),


                            ):BoxDecoration(
                              color: Colors.black54,
                            ),
                            child: Stack(
                              children: [
                                // Container(
                                //     margin: EdgeInsets.only(top: 20,left:20),
                                //     width: 80,
                                //     height: 30,
                                //     decoration: BoxDecoration(
                                //         color:Colors.black,
                                //         borderRadius: BorderRadius.circular(5)
                                //     ),
                                //     child: Center(child: Text("${featuredPropertiesController.featuredPropertyList[index].data[index].amenities}",style: TextStyle(fontSize: 10,color: Colors.white),))),
                                // Positioned(
                                //   bottom: 10,
                                //   left:20,
                                //   right:0,
                                //   child: Row(
                                //     mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                //     children: [
                                //
                                //       Text("From ${featuredPropertiesController.featuredPropertyList.length>0?featuredPropertiesController?.featuredPropertyList[index]?.data[index]?.price:""} \u{20B9}",style: TextStyle(fontSize: 16,color: Colors.white)),
                                //
                                //       IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined,color: Colors.white)),
                                //     ],),
                                // )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:20.0),
                                child: Text("${featuredPropertiesController.featuredPropertyList[index].data[index].categoryName}",style: TextStyle(color: Colors.pink)),
                              ),

                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left:20.0),
                                  child: Text("${featuredPropertiesController.featuredPropertyList[index].data[index].title}",style: TextStyle(fontSize: 12),),
                                ),
                              ),
                            ],
                          ),



                          Padding(
                            padding: const EdgeInsets.only(left:20.0),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined,size: 15,color: Colors.black),
                                SizedBox(width:10),

                                Text("${featuredPropertiesController.featuredPropertyList[index].data[index].name}",style: TextStyle(fontSize: 12)),
                              ],),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Beds:${featuredPropertiesController.featuredPropertyList.length>0?featuredPropertiesController?.featuredPropertyList[index]?.data[index]?.bed:""}",style: TextStyle(fontSize: 12)),
                              Text("Baths:${featuredPropertiesController.featuredPropertyList.length>0?featuredPropertiesController?.featuredPropertyList[index]?.data[index]?.bathroom:""}",style: TextStyle(fontSize: 12)),
                              Text("Sq:${featuredPropertiesController.featuredPropertyList.length>0?featuredPropertiesController?.featuredPropertyList[index]?.data[index]?.square:""}",style: TextStyle(fontSize: 12)),
                            ],),
                          SizedBox(height:10),
                        ],
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                    initialPage: currentIndex, autoPlay: true,
                    aspectRatio: 16/9,
                    height:390,
                    autoPlayAnimationDuration: Duration(seconds: 8),
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                    onPageChanged: (index,_){
                      setState(() {

                        currentIndex=index;


                        //print(currentIndex);
                      });
                    }
                ),
              ):Center(child: CircularProgressIndicator()),
              SizedBox(height:100),

            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
              isExtended: true,
              backgroundColor: Colors.pinkAccent,
              label: Row(
                children: [
                  Icon(Icons.call),
                  Text("Contact"),
                ],
              ),
              onPressed: (){
                setState(() {
                  contact(context);
                });
              }),
        ),
      ),
    );
  }
}
