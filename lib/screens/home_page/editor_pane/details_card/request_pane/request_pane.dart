import 'package:apidash/screens/home_page/editor_pane/details_card/request_pane/graphql/graphql_query.dart';
import 'package:apidash/screens/home_page/editor_pane/details_card/request_pane/graphql/graphql_variables.dart';
import 'package:apidash_core/apidash_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apidash/providers/providers.dart';
import 'package:apidash/widgets/widgets.dart';
import 'request_headers.dart';
import 'request_params.dart';
import 'request_body.dart';
import 'package:apidash/consts.dart';
class EditRequestPane extends ConsumerWidget {
  const EditRequestPane({super.key});
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apitype = ref.watch(selectedAPITypeProvider)!;
    final selectedId = ref.watch(selectedIdStateProvider);
    final codePaneVisible = ref.watch(codePaneVisibleStateProvider);
    final tabIndex = ref.watch(
        selectedRequestModelProvider.select((value) => value?.requestTabIndex));

    final headerLength = ref.watch(selectedRequestModelProvider
            .select((value) => value?.httpRequestModel?.headersMap.length)) ??
        0;
    final paramLength = ref.watch(selectedRequestModelProvider
            .select((value) => value?.httpRequestModel?.paramsMap.length)) ??
        0;
    final hasBody = ref.watch(selectedRequestModelProvider
            .select((value) => value?.httpRequestModel?.hasBody)) ??
        false;

    return RequestPane(
      selectedId: selectedId,
      codePaneVisible: codePaneVisible,
      apiType: apitype,
      tabIndex: tabIndex,
      onPressedCodeButton: () {
        ref.read(codePaneVisibleStateProvider.notifier).state =
            !codePaneVisible;
      },
      onTapTabBar: (index) {
        ref
            .read(collectionStateNotifierProvider.notifier)
            .update(selectedId!, requestTabIndex: index);
      },
      showIndicators: [
        paramLength > 0,
        headerLength > 0,
        hasBody,
      ],
      children: [
        // if(apitype == APIType.rest)...[
        //     EditRequestURLParams(),
        //     EditRequestHeaders(),
        //     EditRequestBody(),
        // ]else if(apitype == APIType.graphql)...[
        //     EditRequestHeaders(),
        //     EditGraphqlQuery(),
        //     EditGraphqlVariable()
        // ]
        EditRequestURLParams(),
            EditRequestHeaders(),
            EditRequestBody(),
        
        
      ],
    );
  }
}
