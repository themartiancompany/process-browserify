..
   SPDX-License-Identifier: AGPL-3.0-or-later

   -------------------------------------------------------
   Copyright © 2024, 2025, 2026
               Pellegrino Prevete

   All rights reserved
   -------------------------------------------------------

   This program is free software: you can redistribute it
   and/or modify it under the terms of the
   GNU Affero General Public License as published by
   the Free Software Foundation, either version 3 of the
   License, or (at your option) any later version.

   This program is distributed in the hope that it will
   be useful, but WITHOUT ANY WARRANTY; without even the
   implied warranty of MERCHANTABILITY or FITNESS FOR A
   PARTICULAR PURPOSE.
   See the GNU Affero General Public License
   for more details.

   You should have received a copy of the
   GNU Affero General Public License
   along with this program.
   If not, see <https://www.gnu.org/licenses/>.


=====================================================
The Martian Company's Javascript Process Module
=====================================================

-----------------------------------------------------------
The Martian Company Javascript Process module
-----------------------------------------------------------
:Version: process-browserify |version|
:Manual section: 1

Synopsis
========


..  code-block:: javascript

  const
    _process =
      require(
        "process-browserify");



Description
===========

This is the man page for the system-wide version
of The Martian Company's platform-independent
Javascript Process module *process-browserify*,
which dynamically loads at runtime an appropriate
native file system module.

Usage
=========

In order for a standard *process*-using module
to seamlessly work in a browser, just
declare using webpack,
just add *process-browserify* to its
dependencies.

For example in a *webpack.config.cjs* file.

..  code-block:: javascript

  const
    _path =
      require(
        "path");
  module.exports = {
    entry:
      './my-node-module',
    output:
      _output,
    optimization: {
      moduleIds: 'deterministic',
    },
    resolve: {
      fallback: {
        "process":
          _path.resolve(
            __dirname,
            'node_modules/process-browserify/process'),
      },
    },
  };

If you stumbled upon this module because
you want to run your Javascript programs anywhere
and prefer a Bash-like style for your
code and you are looking for
a library which allows exactly the same workflow
of a Bash script with zero code changes, the Crash
Javascript [1]_ library is probably what you
are looking for.


Available functions
=====================

* chdir
* cwd
* exit

Bugs
====

https://github.com/themartiancompany/process-browserify/-/issues


Copyright
=========

Copyright Pellegrino Prevete. AGPL-3.0.


See also
========

* tmcfs
* opfs
* libcrash-js
* libcrash-bash
* libcrash-gpg


External Resources
===================

.. [1]  `Crash JavaScript`_
.. [2]  `Crash Bash`_

.. include:: variables.rst
