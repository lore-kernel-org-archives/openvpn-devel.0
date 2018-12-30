From: Antonio Quartulli <a@...2181...>
Date: Sun, 30 Dec 2018 21:28:57 +1000
Message-Id: <20181230112901.29241-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/4] Transport API: offload traffic
 manipulation to plugins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: antonio@...515..., Brandon Wiley <brandon@...2483...>, Justin Henck <henck@...410...>

From: Antonio Quartulli <antonio@...515...>

Dear all,

This patchset implements a new API called "Transport API" which allows the
core codebase to offload traffic/socket manipulations to an external plugin.

To understand its potential, imagine you want to apply a specific
"mutation" on any packet going out and apply the its inverse, on the receiver
side, for any incoming packet.
Without this patchset, achieving this result would require a big surgery
through the OpenVPN code, and it would be the same for any new mutation one
wants to implements. Thanks to this new API the deemed effort
is drastically reduced.

In a few words, OpenVPN becomes extendible on a new front, by cutting the
need to touch the core codebase any longer.

An easy to imagine use case for this new API would be any "traffic obfuscation
technique": instead of patching the core code (like the famous "xor
patch"), a developer is now allowed to implement an external obfuscation
plugin and distribute/maintain it indepdendently.

This patchset comes with a sample plugin (obfs-test) which can be used as
starting point for new implementations.

Any feedback is welcome!

Note: the code has gone through the following tests with positive outcome:
- uncrustify
- GitLab-CI (with my configs)
- openvpn community buildbots

Since it is quite a change (even though most of the new code is fairly
isolated in its own module - transport.c/h), I expect more
comments/discussion/bugs to spark from here.

In any case, please consider myself as direct contact point to discuss
further changes and improvements (even though I am not the signer of the
patches). I'll be in responsible for ensuring this code gets merged sooner
rather than later.

Thanks a lot!!

== Credits ==

This code has been developed by the Operator Foundation[1], under the
umbrella project called "Jigsaw"[2], mainly promoted/sponsored by Google, Inc.

Brandon, reading this email in CC, has been the contact point on
the Operator Foundation's side, while Justin (in CC as well), managed the
task on Google's behalf.


OpenVPN, Inc. has offered its support to the cause by allowing its devs to
allocate a number of hours to follow the project and ensure it could
get all the guidance it required.

[1] https://operatorfoundation.org/
[2] https://jigsaw.google.com/


Best Regards,



Robin Tarsiger (4):
  transport: introduce tranport API plugin codebase
  socket: introduce INDIRECT transport protocol abstraction
  options: add support for --transport-plugin
  transport-plugin: add sample obfs-test plugin

 configure.ac                              |   9 +
 doc/openvpn.8                             |  40 ++
 include/Makefile.am                       |   1 +
 include/openvpn-plugin.h.in               |  31 +-
 include/openvpn-transport.h               | 240 +++++++++
 src/openvpn/Makefile.am                   |   1 +
 src/openvpn/forward.c                     |   5 +
 src/openvpn/init.c                        |   1 +
 src/openvpn/options.c                     |  31 ++
 src/openvpn/options.h                     |   1 +
 src/openvpn/plugin.c                      |   4 +
 src/openvpn/plugin.h                      |   1 +
 src/openvpn/socket.c                      | 148 +++++-
 src/openvpn/socket.h                      |  74 +++
 src/openvpn/transport.c                   | 303 +++++++++++
 src/openvpn/transport.h                   |  99 ++++
 src/plugins/Makefile.am                   |   2 +-
 src/plugins/obfs-test/Makefile.am         |  29 ++
 src/plugins/obfs-test/README.obfs-test    |  26 +
 src/plugins/obfs-test/obfs-test-args.c    |  60 +++
 src/plugins/obfs-test/obfs-test-munging.c | 129 +++++
 src/plugins/obfs-test/obfs-test-posix.c   | 207 ++++++++
 src/plugins/obfs-test/obfs-test-win32.c   | 579 ++++++++++++++++++++++
 src/plugins/obfs-test/obfs-test.c         |  94 ++++
 src/plugins/obfs-test/obfs-test.exports   |   4 +
 src/plugins/obfs-test/obfs-test.h         |  42 ++
 26 files changed, 2155 insertions(+), 6 deletions(-)
 create mode 100644 include/openvpn-transport.h
 create mode 100644 src/openvpn/transport.c
 create mode 100644 src/openvpn/transport.h
 create mode 100644 src/plugins/obfs-test/Makefile.am
 create mode 100644 src/plugins/obfs-test/README.obfs-test
 create mode 100644 src/plugins/obfs-test/obfs-test-args.c
 create mode 100644 src/plugins/obfs-test/obfs-test-munging.c
 create mode 100644 src/plugins/obfs-test/obfs-test-posix.c
 create mode 100644 src/plugins/obfs-test/obfs-test-win32.c
 create mode 100644 src/plugins/obfs-test/obfs-test.c
 create mode 100644 src/plugins/obfs-test/obfs-test.exports
 create mode 100644 src/plugins/obfs-test/obfs-test.h

-- 
2.19.2


