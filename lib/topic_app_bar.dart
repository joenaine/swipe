import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:swifeeapp/constants/app_assets.dart';
import 'package:swifeeapp/constants/app_colors_const.dart';
import 'package:swifeeapp/repos/topics.dart';

class TopicAppBar extends StatefulWidget {
  const TopicAppBar(
      {Key? key,
      this.listOfTopics,
      this.indexActive = 0,
      required this.horizontalController})
      : super(key: key);
  final List<String>? listOfTopics;
  final int? indexActive;
  final PageController horizontalController;

  @override
  State<TopicAppBar> createState() => _TopicAppBarState();
}

class _TopicAppBarState extends State<TopicAppBar> {
  final itemController = ItemScrollController();
  final itemKey = GlobalKey();

  Future scrollToItem(index) async {
    itemController.scrollTo(
      index: index,
      alignment: .1,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    var topBar = MediaQuery.of(context).viewPadding.top;
    return SizedBox(
      height: (MediaQuery.of(context).size.height * 0.1),
      width: double.maxFinite,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          const SizedBox(width: 10),
          SvgPicture.asset(AppAssets.svg.logo),
          const SizedBox(width: 10),
          ScrollablePositionedList.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemScrollController: itemController,
            itemCount: topics.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (BuildContext context, int index) {
              return Center(
                  child: GestureDetector(
                onTap: () {
                  widget.horizontalController.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                  scrollToItem(index);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  decoration: BoxDecoration(
                    color: widget.indexActive == index
                        ? AppColors.grey50
                        : AppColors.grey25,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    topics[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ));
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
