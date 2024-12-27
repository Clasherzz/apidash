import 'package:apidash_core/apidash_core.dart';
import 'package:apidash_core/services/graphql.dart';
import 'package:apidash_design_system/apidash_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apidash/providers/providers.dart';
import 'package:apidash/widgets/widgets.dart';
import '../../common_widgets/common_widgets.dart';

class EditorPaneRequestURLCard extends StatelessWidget {
  const EditorPaneRequestURLCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kColorTransparent,
      surfaceTintColor: kColorTransparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        borderRadius: kBorderRadius12,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: !context.isMediumWindow ? 20 : 6,
        ),
        child: context.isMediumWindow
            ? const Row(
                children: [
                  DropdownButtonHTTPMethod(),
                  kHSpacer5,
                  Expanded(
                    child: URLTextField(),
                  ),
                ],
              )
            : const Row(
                children: [
                  DropdownButtonHTTPMethod(),
                  kHSpacer20,
                  Expanded(
                    child: URLTextField(),
                  ),
                  kHSpacer20,
                  SizedBox(
                    height: 36,
                    child: SendRequestButton(),
                  )
                ],
              ),
      ),
    );
  }
}

class DropdownButtonHTTPMethod extends ConsumerWidget {
  const DropdownButtonHTTPMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final method = ref.watch(selectedRequestModelProvider
        .select((value) => value?.httpRequestModel?.method));
    return DropdownButtonHttpMethod(
      method: method,
      onChanged: (HTTPVerb? value) {
        final selectedId = ref.read(selectedRequestModelProvider)!.id;
        ref
            .read(collectionStateNotifierProvider.notifier)
            .update(selectedId, method: value);
      },
    );
  }
}

class URLTextField extends ConsumerWidget {
  const URLTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedIdStateProvider);
    final selectedAPIType = ref.watch(selectedRequestModelProvider.select((value) => value?.apiType));;
    return EnvURLField(
      selectedId: selectedId!,
      initialValue: selectedAPIType == APIType.rest ? 
          ref
          .read(collectionStateNotifierProvider.notifier)
          .getRequestModel(selectedId)
          ?.httpRequestModel
          ?.url : 
          ref
          .read(collectionStateNotifierProvider.notifier)
          .getRequestModel(selectedId)
          ?.graphqlRequestModel
          ?.url,
      onChanged: (value) {
        selectedAPIType == APIType.rest ? 
        ref
            .read(collectionStateNotifierProvider.notifier)
            .update(selectedId, httpUrl: value) : ref
            .read(collectionStateNotifierProvider.notifier)
            .update(selectedId, graphqlUrl: value);
      },
      onFieldSubmitted: (value) {
        ref.read(collectionStateNotifierProvider.notifier).sendRequest();
      },
    );
  }
}

class SendRequestButton extends ConsumerWidget {
  final Function()? onTap;
  const SendRequestButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(selectedIdStateProvider);
    final isWorking = ref.watch(
        selectedRequestModelProvider.select((value) => value?.isWorking));
    print(isWorking);
    return SendButton(
      isWorking: isWorking ?? false,
      onTap: (){
        onTap?.call();
        print("Send button tapped");

        ref.read(collectionStateNotifierProvider.notifier).sendRequest();
      },
      onCancel: () {
        ref.read(collectionStateNotifierProvider.notifier).cancelRequest();

      },
    );
  }
}
