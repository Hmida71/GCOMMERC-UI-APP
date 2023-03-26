import 'package:flutter/material.dart';
import 'package:gcommerc/animation/bouncing_effects.dart';
import 'package:gcommerc/constants.dart';

class DetailsPage extends StatefulWidget {
  final Map? data;
  final String? hero;
  const DetailsPage({super.key, required this.data, required this.hero});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int sizeSelected = 1;
  bool like = false;
  @override
  void initState() {
    if (widget.data!["isLiked"]) {
      like = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: AppBar(
          elevation: 0,
          leading: Bouncing(
            onPress: () async {
              Navigator.pop(context, like);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                  size: 26,
                ),
              ),
            ),
          ),
          title: const Text(
            "ORDER DETAILS",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    like = !like;
                  });
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: like
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 22,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          color: Colors.black,
                          size: 22,
                        ),
                ),
              ),
            ),
          ],
          backgroundColor: defaultBackgroundColor,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: w,
            height: h,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Hero(
                    tag: widget.hero!,
                    child: Container(
                      height: 350,
                      color: defaultBackgroundColor,
                      width: w,
                      child: InteractiveViewer(
                        child: Image.network(widget.data!["image"]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 30,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.data!["stars"].toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "(${widget.data!["reviews"].toString()} reviews)",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "${widget.data!["name"]}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.share,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "By -  ${widget.data!["store"]}",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 24,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "DESCRIPTION :",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${widget.data!["descripstion"]}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "SIZE :",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            ...List.generate(
                              widget.data!["size"].length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sizeSelected = index;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: sizeSelected == index
                                        ? customColor
                                        : Colors.transparent,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(14),
                                    ),
                                  ),
                                  child: Text(
                                    "${widget.data!["size"][index]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: sizeSelected == index
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: w * 0.95,
            height: 80,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: blackColor,
              borderRadius: BorderRadius.all(
                Radius.circular(36),
              ),
            ),
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          " Price",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${widget.data!["price"].toString()} £",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Bouncing(
                  onPress: () {},
                  child: Container(
                    width: 160,
                    height: 65,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: customColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(36),
                      ),
                    ),
                    child: const Text(
                      "ADD TO CART",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
