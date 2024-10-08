import Controller from "@ember/controller";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { INPUT_DELAY } from "discourse-common/config/environment";
import discourseDebounce from "discourse-common/lib/debounce";
import discourseComputed from "discourse-common/utils/decorators";
import I18n from "discourse-i18n";

export default class GroupsIndexController extends Controller {
  @service router;

  queryParams = ["order", "asc", "filter", "type"];
  order = null;
  asc = null;
  filter = "";
  type = null;
  groups = null;
  isLoading = false;

  @discourseComputed("groups.extras.type_filters")
  types(typeFilters) {
    const types = [];

    if (typeFilters) {
      typeFilters.forEach((type) =>
        types.push({ id: type, name: I18n.t(`groups.index.${type}_groups`) })
      );
    }

    return types;
  }

  @action
  onFilterChanged(filter) {
    discourseDebounce(this, this._debouncedFilter, filter, INPUT_DELAY);
  }

  @action
  loadMore() {
    this.groups && this.groups.loadMore();
  }

  @action
  new() {
    this.router.transitionTo("groups.new");
  }

  _debouncedFilter(filter) {
    this.set("filter", filter);
  }
}
