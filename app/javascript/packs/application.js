// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
import { initInstanceChannel } from '../channels/instance_channel';
import { highlighter } from "../plugins/rough_notation";
import { initRoundCable } from '../channels/round_channel';
import { autoClick } from "../components/popup";
import { autoFocus } from "../components/auto_focus";
import { updateDiv } from "../components/auto_refresh";

// next 3 lines is from https://fontsource.org/fonts
import "@fontsource/roboto";
import "@fontsource/play";
import "@fontsource/dosis";

document.addEventListener('turbolinks:load', () => {

  initInstanceChannel();
  initRoundCable();
  autoClick();
  highlighter();
  autoFocus();
  updateDiv();
});
