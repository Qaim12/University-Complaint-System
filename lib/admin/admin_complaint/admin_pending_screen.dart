import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../widget/utility.dart';

class AdminpendingScreen extends StatefulWidget {
  const AdminpendingScreen({Key? key}) : super(key: key);

  @override
  State<AdminpendingScreen> createState() => _AdminpendingScreenState();
}

class _AdminpendingScreenState extends State<AdminpendingScreen> {
  TextEditingController adminReplyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('admin_tasks').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No Tasks Yet'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String profile =
                      snapshot.data!.docs[index]['profileImage'].toString();
                  String id = snapshot.data!.docs[index]['id'].toString();
                  String fullName =
                      snapshot.data!.docs[index]['fullName'].toString();
                  String dt = snapshot.data!.docs[index]['dt'].toString();
                  String taskName =
                      snapshot.data!.docs[index]['taskName'].toString();
                  String natureName =
                      snapshot.data!.docs[index]['natureName'].toString();
                  String subCategoryName =
                      snapshot.data!.docs[index]['subCategoryName'].toString();
                  String Department =
                      snapshot.data!.docs[index]['Department'].toString();
                  String Category =
                      snapshot.data!.docs[index]['Category'].toString();

                  //--------------------------Card-----------------------------------------
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.greenAccent,
                      ),
                    ),
                    elevation: 50,
                    shadowColor: Colors.blueAccent,
                    child: Column(
                      children: [
                        ListTile(
                          //----------------------------Adding full name and date in listTile-------------
                          title: Text(snapshot.data!.docs[index]['fullName']
                              .toString()),
                          subtitle: Text(Utility.getHumanReadableDate(
                              snapshot.data!.docs[index]['dt'])),
                          trailing: ElevatedButton(
                              onPressed: () {
                                //--------------- View Complaint-------------------------
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                          appBar: AppBar(
                                            actions: [
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (ctx) {
                                                          return AlertDialog(
                                                            title:
                                                            const Text('Confirmation !!!'),
                                                            content: const Text(
                                                                'Are you sure to delete ? '),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: const Text('No')),
                                                              TextButton(
                                                                  onPressed: () async {
                                                                    Navigator.of(context).pop();
                                                                    if(FirebaseFirestore.instance.collection('admin_tasks').snapshots() != null){
                                                                      await FirebaseFirestore.instance.collection('admin_tasks')
                                                                          .doc(snapshot.data!.docs[index]['dt'].toString()).delete();
                                                                      // await taskRef!
                                                                      //     .doc(
                                                                      //     '${snapshot.data!.docs[index]['taskId']}')
                                                                      //     .delete();
                                                                      Navigator.of(context).pop();

                                                                    }
                                                                  },
                                                                  child: const Text('Yes')),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    size: 20,
                                                  )),
                                            ],

                                            title: Text(snapshot
                                                .data!.docs[index]['fullName']
                                                .toString()),
                                          ),
                                          body: SingleChildScrollView(
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 18,
                                                      ),
                                                      Text(Utility
                                                          .getHumanReadableDate(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['dt'])),
                                                    ],
                                                  ),
                                                  Card(
                                                    //----------------Card in view complaint---------------------
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      side: BorderSide(
                                                        color:
                                                            Colors.greenAccent,
                                                      ),
                                                    ),
                                                    elevation: 50,
                                                    shadowColor:
                                                        Colors.blueGrey[100],
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              right: 8,
                                                              left: 8,
                                                              bottom: 20),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('Category',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Text(snapshot
                                                                  .data!
                                                                  .docs[index][
                                                                      'Category']
                                                                  .toString()),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Department',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(snapshot
                                                                  .data!
                                                                  .docs[index][
                                                                      'Department']
                                                                  .toString()),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('Registration No',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Text(snapshot
                                                                  .data!
                                                                  .docs[index][
                                                                      'natureName']
                                                                  .toString()),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  'Sub_Category',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Text(snapshot
                                                                  .data!
                                                                  .docs[index][
                                                                      'subCategoryName']
                                                                  .toString()),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Divider(
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                          //-------Divider------------
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'Complaint',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            child: Text(
                                                              snapshot
                                                                  .data!
                                                                  .docs[index][
                                                                      'taskName']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Divider(
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                          //-------Divider---------------
                                                          Text(
                                                            'Replying.......',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          TextField(
                                                            controller:
                                                                adminReplyController,
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        'Reply',
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                    ),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color: Colors
                                                                                .greenAccent)),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Colors.greenAccent))),
                                                            maxLines: 3,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),

                                                          ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                //   ----------------------------------------------------------------------------
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'inprogress_users')
                                                                    .doc(id)
                                                                    .collection(
                                                                        'tasks')
                                                                    .doc(dt)
                                                                    .set({
                                                                  'profileImage':
                                                                      profile,
                                                                  'adminReply':
                                                                      adminReplyController
                                                                          .text
                                                                          .toString(),

                                                                  'id': id,
                                                                  'fullName':
                                                                      fullName,
                                                                  'dt': dt,
                                                                  'taskName':
                                                                      taskName,
                                                                  'natureName':
                                                                      natureName,
                                                                  'subCategoryName':
                                                                      subCategoryName,
                                                                  'Department':
                                                                      Department,
                                                                  'Category':
                                                                      Category,
                                                                }).then(
                                                                        (value) async {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'inprogress_admin')
                                                                      .doc(dt)
                                                                      .set({
                                                                    'profileImage':
                                                                        profile,
                                                                    'adminReply':
                                                                        adminReplyController
                                                                            .text
                                                                            .toString(),

                                                                    'id': id,
                                                                    'fullName':
                                                                        fullName,
                                                                    'dt': dt,
                                                                    'taskName':
                                                                        taskName,
                                                                    'natureName':
                                                                        natureName,
                                                                    'subCategoryName':
                                                                        subCategoryName,
                                                                    'Department':
                                                                        Department,
                                                                    'Category':
                                                                        Category,
                                                                  }).then(
                                                                          (value) async {
                                                                    // ----------------------------- delete task from users --------------------------------------
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'tasks')
                                                                        .doc(id)
                                                                        .collection(
                                                                            "tasks")
                                                                        .doc(dt)
                                                                        .delete()
                                                                        .then(
                                                                            (value) async {
                                                                      //   --------------------------- delete task from admin -----------------------------------------
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'admin_tasks')
                                                                          .doc(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                                  'dt']
                                                                              .toString())
                                                                          .delete()
                                                                          .then(
                                                                              (value) {
                                                                        Utility()
                                                                            .toastMessege("Process is Completed");
                                                                        Navigator.pop(
                                                                            context);
                                                                      }).onError((error,
                                                                              stackTrace) {
                                                                        Utility()
                                                                            .toastMessege(error.toString());
                                                                      });
                                                                    }).onError((error,
                                                                            stackTrace) {
                                                                      Utility()
                                                                          .toastMessege(
                                                                              error.toString());
                                                                    });
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    Utility()
                                                                        .toastMessege(
                                                                            error.toString());
                                                                  });
                                                                }).onError((error,
                                                                        stackTrace) {
                                                                  Utility()
                                                                      .toastMessege(
                                                                          error
                                                                              .toString());
                                                                });
                                                              },
                                                              child: Text(
                                                                  'Inprogress')),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Completed_users')
                                                                    .doc(id)
                                                                    .collection(
                                                                        'tasks')
                                                                    .doc(dt)
                                                                    .set({
                                                                  'profileImage':
                                                                      profile,
                                                                  'adminCompleted': adminReplyController
                                                                      .text
                                                                      .toString() ,

                                                                  'id': id,
                                                                  'fullName':
                                                                      fullName,
                                                                  'dt': dt,
                                                                  'taskName':
                                                                      taskName,
                                                                  'natureName':
                                                                      natureName,
                                                                  'subCategoryName':
                                                                      subCategoryName,
                                                                  'Department':
                                                                      Department,
                                                                  'Category':
                                                                      Category,
                                                                }).then(
                                                                        (value) async {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'Completed_admin')
                                                                      .doc(dt)
                                                                      .set({
                                                                    'profileImage':
                                                                        profile,
                                                                      'adminCompleted': adminReplyController
                                                                      .text
                                                                      .toString() ,

                                                                    'id': id,
                                                                    'fullName':
                                                                        fullName,
                                                                    'dt': dt,
                                                                    'taskName':
                                                                        taskName,
                                                                    'natureName':
                                                                        natureName,
                                                                    'subCategoryName':
                                                                        subCategoryName,
                                                                    'Department':
                                                                        Department,
                                                                    'Category':
                                                                        Category,
                                                                  }).then(
                                                                          (value) async {
                                                                    // ----------------------------- delete task from users --------------------------------------
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'tasks')
                                                                        .doc(id)
                                                                        .collection(
                                                                            "tasks")
                                                                        .doc(dt)
                                                                        .delete()
                                                                        .then(
                                                                            (value) async {
                                                                      //   --------------------------- delete task from admin -----------------------------------------
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'admin_tasks')
                                                                          .doc(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                                  'dt']
                                                                              .toString())
                                                                          .delete()
                                                                          .then(
                                                                              (value) {
                                                                        Utility()
                                                                            .toastMessege("Process is Completed");
                                                                        Navigator.pop(
                                                                            context);
                                                                      }).onError((error,
                                                                              stackTrace) {
                                                                        Utility()
                                                                            .toastMessege(error.toString());
                                                                      });
                                                                    }).onError((error,
                                                                            stackTrace) {
                                                                      Utility()
                                                                          .toastMessege(
                                                                              error.toString());
                                                                    });
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    Utility()
                                                                        .toastMessege(
                                                                            error.toString());
                                                                  });
                                                                }).onError((error,
                                                                        stackTrace) {
                                                                  Utility()
                                                                      .toastMessege(
                                                                          error
                                                                              .toString());
                                                                });
                                                              },
                                                              child: Text(
                                                                  'Reject')),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )));
                              },
                              //----------------------------------------------------------------------------
                              child: Text('View')),
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                        appBar: AppBar(
                                          title: Text(snapshot
                                              .data!.docs[index]['fullName']
                                              .toString()),
                                        ),
                                        body: Center(
                                          child: Hero(
                                            tag: () {},
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: snapshot.data!
                                                  .docs[index]['profileImage'],
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                              placeholder: (context, url) =>
                                                  Container(
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )));
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.docs[index]
                                      ['profileImage'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
