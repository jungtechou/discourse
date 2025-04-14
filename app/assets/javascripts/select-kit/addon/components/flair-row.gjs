import { classNames } from "@ember-decorators/component";
import SelectKitRowComponent from "select-kit/components/select-kit/select-kit-row";

@classNames("flair-row")
export default class FlairRow extends SelectKitRowComponent {}

{{#if this.item.url}}
  <AvatarFlair
    @flairName={{this.item.name}}
    @flairUrl={{this.item.url}}
    @flairBgColor={{this.item.bgColor}}
    @flairColor={{this.item.color}}
  />
{{/if}}

<span>{{this.label}}</span>