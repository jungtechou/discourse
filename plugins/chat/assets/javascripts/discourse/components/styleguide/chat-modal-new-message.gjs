import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import ChatModalNewMessage from "discourse/plugins/chat/discourse/components/chat/modal/new-message";

export default class ChatStyleguideChatModalNewMessage extends Component {
  @service modal;

  @action
  openModal() {
    return this.modal.show(ChatModalNewMessage);
  }
}

<StyleguideExample @title="<Chat::Modal::NewMessage>">
  <Styleguide::Controls::Row>
    <DButton @translatedLabel="Open modal" @action={{this.openModal}} />
  </Styleguide::Controls::Row>
</StyleguideExample>