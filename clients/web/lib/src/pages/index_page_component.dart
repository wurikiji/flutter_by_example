import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:angular_bloc/angular_bloc.dart';
import 'package:angular_router/angular_router.dart';
import 'package:common/common.dart';
import 'package:web/src/components/post_list_component.dart';

@Component(
  selector: 'index-page',
  templateUrl: 'index_page_component.html',
  styleUrls: [
    'package:angular_components/app_layout/layout.scss.css',
    'index_page_component.css'
  ],
  directives: [PostListComponent],
  providers: [FilesystemBrowserPostsRepository],
  pipes: [BlocPipe],
)
class IndexPageComponent implements OnActivate, OnDestroy {
  PageConfigurationBloc pageBloc;
  final FilesystemBrowserPostsRepository _postsRepository;

  IndexPageComponent(this._postsRepository);

  @override
  void onActivate(_, RouterState current) async {
    pageBloc = new PageConfigurationBloc(repository: _postsRepository);
    await pageBloc.dispatch(new LoadAllPageFrontmatter());
  }

  @override
  void ngOnDestroy() {
    pageBloc.dispose();
  }
}