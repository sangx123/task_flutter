
import 'package:flutter_deer/mvp/base_page_presenter.dart';
import 'package:flutter_deer/net/net.dart';
import 'package:flutter_deer/order/models/search_entity.dart';
import 'package:flutter_deer/order/page/order_search_page.dart';
import 'package:flutter_deer/task/models/recommand_result_new_entity.dart';
import 'package:flutter_deer/widgets/state_layout.dart';


class OrderSearchPresenter extends BasePagePresenter<OrderSearchPageState> {

  Future search(String text, int page, bool isShowDialog) async{

    //NavigatorUtils.push(context, StoreRouter.auditPage);
    await DioUtils.instance.requestNetwork<RecommandResultNewEntity>(
        Method.post, HttpApi.getHomeSearchResultBusinessTaskList, isList: true, onSuccessList: (data) {

      if(data != null){
        /// 一页30条数据，等于30条认为有下一页
        /// 具体的处理逻辑根据具体的接口情况处理，这部分可以抽离出来
        view.provider.setHasMore(data.length == 10);
        if (page == 1){
          /// 刷新
          view.provider.list.clear();
          if (data.isEmpty){
            view.provider.setStateType(StateType.order);
          }else{
            view.provider.addAll(data);
          }
        }else{
          view.provider.addAll(data);
        }
      }else{
        /// 加载失败
        view.provider.setHasMore(false);
        view.provider.setStateType(StateType.network);
      }
    }, onError: (code, msg) {
        /// 加载失败
        view.provider.setHasMore(false);
        view.provider.setStateType(StateType.network);
    }, params: {"content":text,"pageSize": 10, "pageNumber": page});
  }
 
}