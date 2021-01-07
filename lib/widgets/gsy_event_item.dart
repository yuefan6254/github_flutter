import 'package:flutter/material.dart';
import 'package:github_flutter/common/localization/localizations.dart';
import 'package:github_flutter/common/style/gsy_style.dart';
import 'package:github_flutter/common/utils/common_utils.dart';
import 'package:github_flutter/common/utils/event_utils.dart';
import 'package:github_flutter/model/RepoCommit.dart';
import 'package:github_flutter/model/Notification.dart' as Model;
import 'package:github_flutter/model/Event.dart';
import 'package:github_flutter/widgets/gsy_card_item.dart';
import 'package:github_flutter/widgets/gsy_user_icon_widget.dart';

/**
 * 事件Item
 */

class GSYEventItem extends StatelessWidget {
  final EventViewModel eventViewModel;

  final VoidCallback onPressed;

  final bool needImage;

  GSYEventItem({this.eventViewModel, this.onPressed, this.needImage = true});

  Widget build(BuildContext context) {
    Widget des = (eventViewModel.actionDes == null ||
            eventViewModel.actionDes.length == 0)
        ? Container()
        : Container(
            child: Text(
              eventViewModel.actionDes,
              style: GSYConstant.smallSubText,
              maxLines: 3,
            ),
            margin: EdgeInsets.only(top: 6, bottom: 3),
            alignment: Alignment.topLeft,
          );

    Widget userImage = needImage
        ? GSYUserIconWidget(
            padding: EdgeInsets.only(top: 0, right: 5.0, left: 0),
            width: 30,
            height: 30,
            image: eventViewModel.actionUserPic,
            onPressed: () {},
          )
        : Container();

    return Container(
      child: GSYCardItem(
        child: FlatButton(
          onPressed: onPressed,
          child: Padding(
            padding:
                EdgeInsets.only(top: 10.0, right: 0, bottom: 10.0, left: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    // userImage,
                    Expanded(
                        child: Text(
                      eventViewModel.actionUser,
                      style: GSYConstant.smallTextBold,
                    )),
                    Text(
                      eventViewModel.actionTime,
                      style: GSYConstant.smallSubText,
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    eventViewModel.actionTarget,
                    style: GSYConstant.smallTextBold,
                  ),
                  margin: EdgeInsets.only(top: 6, bottom: 2),
                  alignment: Alignment.topLeft,
                ),
                des
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventViewModel {
  String actionUser;
  String actionUserPic;
  String actionDes;
  String actionTime;
  String actionTarget;

  EventViewModel.fromEventMap(Event event) {
    actionTime = CommonUtils.getNewsTimeStr(event.createdAt);
    actionUser = event.actor.login;
    actionUserPic = event.actor.avatar_url;
    var other = EventUtils.getActionAndDes(event);
    actionDes = other["des"];
    actionTarget = other["actionStr"];
  }

  EventViewModel.fromCommitMap(RepoCommit eventMap) {
    actionTime = CommonUtils.getNewsTimeStr(eventMap.commit.committer.date);
    actionUser = eventMap.commit.committer.name;
    actionDes = "sha:" + eventMap.sha;
    actionTarget = eventMap.commit.message;
  }

  EventViewModel.fromNotify(BuildContext context, Model.Notification eventMap) {
    actionTime = CommonUtils.getNewsTimeStr(eventMap.updateAt);
    actionUser = eventMap.repository.fullName;
    String type = eventMap.subject.type;
    String status = eventMap.unread
        ? GSYLocalizations.i18n(context).notify_unread
        : GSYLocalizations.i18n(context).notify_readed;
    actionDes = eventMap.reason +
        "${GSYLocalizations.i18n(context).notify_type}：$type，${GSYLocalizations.i18n(context).notify_status}：$status";
    actionTarget = eventMap.subject.title;
  }
}
