[comment]: <> (SPDX-License-Identifier: AGPL-3.0)

[comment]: <> (-------------------------------------------------------------)
[comment]: <> (Copyright © 2024, 2025  Pellegrino Prevete)
[comment]: <> (All rights reserved)
[comment]: <> (-------------------------------------------------------------)

[comment]: <> (This program is free software: you can redistribute)
[comment]: <> (it and/or modify it under the terms of the GNU Affero)
[comment]: <> (General Public License as published by the Free)
[comment]: <> (Software Foundation, either version 3 of the License.)

[comment]: <> (This program is distributed in the hope that it will be useful,)
[comment]: <> (but WITHOUT ANY WARRANTY; without even the implied warranty of)
[comment]: <> (MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the)
[comment]: <> (GNU Affero General Public License for more details.)

[comment]: <> (You should have received a copy of the GNU Affero General Public)
[comment]: <> (License along with this program.)
[comment]: <> (If not, see <https://www.gnu.org/licenses/>.)

# The Martian Company's Javascript Process Module (`process-browserify`)

[![NPM version](
  https://img.shields.io/npm/v/@themartiancompany/process-browserify.svg)](
    https://npmjs.org/package/@themartiancompany/process-browserify)

Platform-independent Javascript Process `process` module,
which dynamically loads the platform's native
`process` module in Node.js environment and a native browser
implementation leveraging
[Origin Private File System](
  https://github.com/themartiancompany/opfs)
(OPFS) module.

## Installation

To build the Node module package from source run

```bash
$ make \
    all
```

A `process-browserify-<version>.tgz` archive
will be generated in the root of the repository.

To install the module system-wide run

```bash
# make \
    install-npm
```

To install it as a
[DogeOS](
  https://githubcom/themartiancompany/dogeos)
system package from the
[Ur](
  https://github.com/themartiancompany/ur)
uncensorable user repository and application
store run

```bash
ur \
  "nodejs-process"
```

A mirror of the Ur universal recipe
has been made available on The Martian
Company's Github at
[`nodejs-process-ur`](
  https://github.com/themartiancompany/nodejs-process-ur).

To download the library from
the NPM Registry run

```bash
npm \
  install \
  --save \
    "process-browserify"
```

### Documentation

For API documentation
refer to the
[Process API](
  https://nodejs.org/api/process.html).

Usage manual is located in `man` in reStructured
text format and can be accessed upon module
installation with

```bash
man \
  "process-browserify"
```

If you are looking for an example of how
to write a full computer application
composed of only Bash programs and
Node modules but which runs the
same and with zero modifications
regardless of whether it has available
for display a terminal or a browser window,
you can look at the
[Ahsi](
  https://github.com/themartiancompany/ahsi)
program, written using the
[Crash Javascript](
  https://github.com/themartiancompany/crash-js)
and
[Crash Bash](
  https://github.com/themartiancompany/crash-bash)
libraries.

Refer to the Ahsi repository for more information
about installing and running it.

## License

This software repository is released
under the terms of the GNU Affero
General Public License version 3.
