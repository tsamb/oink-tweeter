# Scripting a character counter

## Overview
To create a counter for our text field, we need to make some subtle changes to our HTML and write a short script to listen for keystrokes and update a counter when that listener fires.

## Linking file and JQuery
Create a JavaScript file and place it in your public directory. I called mine `character-count.js`. In your HTML file (`index.erb` in this case) add the following two `<script>` tags in the `<></head>`:

```html
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="character-count.js"></script>
```

The first script tag is linking to the JQuery library. This will give us an easier time building our counter logic. The second tag is linking to the script we are about to write.

## Setting up your page for manipulation
Right next to the submit button in your form, add a span containing a lonely default "0". Give this span a class called 'char-count':

```html
<span class="char-count">0</span>
```

## Writing the JavaScript

### Waiting for the rest of the page
We want our JS file to run only once all of the other elements on our page have loaded. So we begin by wrapping everything in the following JQuery function:

```js
$(document).ready(function() {
  // your code will eventually go here
});
```

Any code you put inside the function after the "ready" will run as soon as the page has loaded.

