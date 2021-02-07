

import 'package:flutter/material.dart';
import 'package:flutter_deer/mvp/base_page_state.dart';
import 'package:flutter_deer/order/models/search_entity.dart';
import 'package:flutter_deer/order/presenter/order_search_presenter.dart';
import 'package:flutter_deer/provider/base_list_provider.dart';
import 'package:flutter_deer/task/models/recommand_result_new_entity.dart';
import 'package:flutter_deer/task/page/task_recommand_item.dart';
import 'package:flutter_deer/widgets/my_refresh_list.dart';
import 'package:flutter_deer/widgets/search_bar.dart';
import 'package:flutter_deer/widgets/state_layout.dart';
import 'package:provider/provider.dart';


/// design/3订单/index.html#artboard8
class OrderSearchPage extends StatefulWidget {
  @override
  OrderSearchPageState createState() => OrderSearchPageState();
}

class OrderSearchPageState extends BasePageState<OrderSearchPage, OrderSearchPresenter> {

  BaseListProvider<RecommandResultNewEntity> provider = BaseListProvider<RecommandResultNewEntity>();
  
  String _keyword;
  int _page = 1;
  
  @override
  void initState() {
    /// 默认为加载中状态，本页面场景默认为空
    provider.setStateTypeNotNotify(StateType.empty);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<RecommandResultNewEntity>>(
      create: (_) => provider,
      child: Scaffold(
        appBar: SearchBar(
          hintText: "请输入任务名称查询",
          onPressed: (text){
            if (text.isEmpty){
              showToast("搜索关键字不能为空！");
              return;
            }
            FocusScope.of(context).unfocus();
            _keyword = text;
            provider.setStateType(StateType.loading);
            _page = 1;
            presenter.search(_keyword, _page, true);
          },
        ),
        body: Consumer<BaseListProvider<RecommandResultNewEntity>>(
          builder: (_, provider, __) {
            return DeerListView(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0,bottom: 10.0),
              key: Key('order_search_list'),
              itemCount: provider.list.length,
              stateType: provider.stateType,
              onRefresh: _onRefresh,
              loadMore: _loadMore,
              hasMore: provider.hasMore,
              itemBuilder: (_, index){
                return TaskRecommandItemPage(
                    key: Key('order_item_$index'),
                    index: index,
                    tabIndex: 0,
                    model: provider.list[index]);
              },
            );
          }
        ),
      ),
    );
  }

  Future _onRefresh() async {
    _page = 1;
    await presenter.search(_keyword, _page, false);
  }

  Future _loadMore() async {
    _page++;
    await presenter.search(_keyword, _page, false);
  }

  @override
  OrderSearchPresenter createPresenter() {
    return OrderSearchPresenter();
  }
}
