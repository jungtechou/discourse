import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { TOAST } from "float-kit/lib/constants";
import DummyComponent from "discourse/plugins/styleguide/discourse/components/dummy-component";

export default class Toasts extends Component {
  @service toasts;

  @tracked title = "Title";
  @tracked message = "Message";
  @tracked duration = TOAST.options.duration;
  @tracked autoClose = TOAST.options.autoClose;
  @tracked showProgressBar = TOAST.options.showProgressBar;
  @tracked class;
  @tracked action = true;
  @tracked icon;

  @action
  showCustomComponentToast() {
    this.toasts.show({
      duration: this.duration,
      autoClose: this.autoClose,
      class: this.class,
      component: DummyComponent,
      data: {
        foo: 1,
      },
    });
  }

  @action
  showToast(theme) {
    const actions = [];

    if (this.action) {
      actions.push({
        label: "Ok",
        class: "btn-primary",
        action: (args) => {
          // eslint-disable-next-line no-alert
          alert("Closing toast:" + args.data.title);
          args.close();
        },
      });
    }

    this.toasts[theme]({
      duration: this.duration,
      autoClose: this.autoClose,
      showProgressBar: this.showProgressBar,
      class: this.class,
      data: {
        title: this.title,
        message: this.message,
        icon: this.icon,
        actions,
      },
    });
  }

  @action
  toggleAction() {
    this.action = !this.action;
  }

  @action
  toggleAutoClose() {
    this.autoClose = !this.autoClose;
  }

  @action
  toggleShowProgressBar() {
    this.showProgressBar = !this.showProgressBar;
  }
}

{{! template-lint-disable no-potential-path-strings }}
<StyleguideExample @title="Toasts service">
  <Styleguide::Component @tag="default">
    <:actions>
      <DButton
        @translatedLabel="Show default toast"
        @action={{fn this.showToast "default"}}
      />
    </:actions>
  </Styleguide::Component>

  <Styleguide::Component @tag="success">
    <:actions>
      <DButton
        @translatedLabel="Show success toast"
        @action={{fn this.showToast "success"}}
      />
    </:actions>
  </Styleguide::Component>

  <Styleguide::Component @tag="warning">
    <:actions>
      <DButton
        @translatedLabel="Show warning toast"
        @action={{fn this.showToast "warning"}}
      />
    </:actions>
  </Styleguide::Component>

  <Styleguide::Component @tag="info">
    <:actions>
      <DButton
        @translatedLabel="Show info toast"
        @action={{fn this.showToast "info"}}
      />
    </:actions>
  </Styleguide::Component>

  <Styleguide::Component @tag="error">
    <:actions>
      <DButton
        @translatedLabel="Show error toast"
        @action={{fn this.showToast "error"}}
      />
    </:actions>
  </Styleguide::Component>

  <Styleguide::Component @tag="custom component">
    <:actions>
      <DButton
        @translatedLabel="Show toast"
        @action={{this.showCustomComponentToast}}
      />
    </:actions>
  </Styleguide::Component>

  <Styleguide::Controls>
    <Styleguide::Controls::Row @name="[@options.autoClose]">
      <DToggleSwitch
        @state={{this.autoClose}}
        {{on "click" this.toggleAutoClose}}
      />
    </Styleguide::Controls::Row>
    <Styleguide::Controls::Row @name="[@options.showProgressBar]">
      <DToggleSwitch
        @state={{this.showProgressBar}}
        {{on "click" this.toggleShowProgressBar}}
      />
    </Styleguide::Controls::Row>
    {{#if this.autoClose}}
      <Styleguide::Controls::Row @name="[@options.duration] ms">
        <Input @value={{this.duration}} @type="number" />
      </Styleguide::Controls::Row>
    {{/if}}
    <Styleguide::Controls::Row @name="[@options.class]">
      <Input @value={{this.class}} />
    </Styleguide::Controls::Row>
    <Styleguide::Controls::Row>
      <b>Model props for default:</b>
    </Styleguide::Controls::Row>
    <Styleguide::Controls::Row @name="[@options.data.title]">
      <Input @value={{this.title}} />
    </Styleguide::Controls::Row>
    <Styleguide::Controls::Row @name="[@options.data.message]">
      <Input @value={{this.message}} />
    </Styleguide::Controls::Row>
    <Styleguide::Controls::Row @name="[@options.data.icon]">
      <IconPicker
        @name="icon"
        @value={{this.icon}}
        @options={{hash maximum=1}}
        @onChange={{fn (mut this.icon)}}
      />
    </Styleguide::Controls::Row>
    <Styleguide::Controls::Row @name="With an action">
      <DToggleSwitch @state={{this.action}} {{on "click" this.toggleAction}} />
    </Styleguide::Controls::Row>
  </Styleguide::Controls>
</StyleguideExample>