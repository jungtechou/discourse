import { tagName } from "@ember-decorators/component";
import SelectedNameComponent from "select-kit/components/selected-name";

@tagName("")
export default class SelectedFlair extends SelectedNameComponent {}

{{#if this.item.url}}
  <AvatarFlair
    @flairName={{this.item.name}}
    @flairUrl={{this.item.url}}
    @flairBgColor={{this.item.bgColor}}
    @flairColor={{this.item.color}}
  />
{{/if}}

<span>{{this.label}}</span>