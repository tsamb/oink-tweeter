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

### Binding a listener for keyboard input
The next step is to tell our browser to listen out for any key presses and do something every time a key is pressed. We need to bind this key listener to a specific element on the page. It makes sense in this case to bind it to our `<textarea>` since that's where we write the text for our tweet.

We set up the listener like this:

```js
$(document).ready(function() {
  $("textarea").keyup(function() {
    // code here will run when a user presses keys while a textarea is in focus
    console.log("Someone pressed a key!");
  });
});
```

Notice the `console.log` in the code above. This is good for getting feedback that your code is doing what you expect. Run your server and open up your page. Open up your JavaScript console (<cmd+opt+J> in Chrome and <cmd+opt+I> in Firefox). Now when you type in your text area, you should see "Someone pressed a key!" in the console.

### Reading and updating the character count
Each time a user types a key we want to read how many characters are in our text field and update the number in our `<span>` accordingly. Here's how we can do that:

```js
$(document).ready(function() {
  $("textarea").keyup(function() {
    // declare a variable that grabs the length of the string in the textarea
    var charCount = $(this).val().length;

    // replace the current html inside the span with the character count
    $(".char-count").html(charCount);
  });
});
```

