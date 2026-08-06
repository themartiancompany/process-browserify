# `argv`

The `process.argv` array is obtained from
the web page url. Suppose you have

```html
https://my.domain/my-page.html?option=value&o=another-value
```

then `process.argv` becomes

```javascript
> console.log(
    process.argv);
[
  "--option",
  "value",
  "-o",
  "another-value"
]
```

This document is released under the terms of the
GNU Affero General Public License version 3.
