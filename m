From: Arne Schwabe <arne@...1227...>
Date: Fri, 20 May 2022 23:32:46 +0200
Message-Id: <20220520213250.3126372-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 0/4] Implement exit notifcation via
 control channel and temporary AUTH_FAIL
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

This patchset consts of three patches and one small clean up patches.
The first patch deals with exit notification via control channel instead
of using OCC data message if both peers support it.
This is need to avoid implementing OCC exit messages in DCO implementation.
In p2p mode this is also implemented keeps the behaviour that an OCC_EXIT
triggers a SIGTERM on receiving side. This is questionable but should be
addressed in a different patch after a discussion.

The second patch implements a way for OpenVPN server to temporarily reject
a user or send them directly to the next server. 

To allow testing and using this feature without needing to use the management
interface and client-deny, the third patch adds support for providing a
AUTH_FAIL message from plugins and scripts.

Finally, here is my own script that I use for testing the custom AUTH_FAIL and
auth-pending messages. It will change its behaviour depending on the username:
https://gist.github.com/schwabe/2d412ae9236888b398063317ed6a9be4

Patchset v2 includes the comment from Frank to patch 1-3 and patch 4 is resent
to have a complete patch set again, so v1 can be ignored

Arne Schwabe (4):
  Implement exit notification via control channel
  Cleanup receive_auth_failed and simplify method
  Implement AUTH_FAIL,TEMP message support
  Allow scripts and plugins to set a custom AUTH_FAILED message

 doc/man-sections/client-options.rst  |   7 +-
 doc/man-sections/script-options.rst  |  36 ++++++++
 src/openvpn/Makefile.am              |   1 +
 src/openvpn/crypto.h                 |   5 ++
 src/openvpn/forward.c                |   4 +
 src/openvpn/init.c                   |   9 +-
 src/openvpn/multi.c                  |   5 ++
 src/openvpn/openvpn.vcxproj          |   2 +
 src/openvpn/openvpn.vcxproj.filters  |   3 +
 src/openvpn/options.c                |  20 +++++
 src/openvpn/options.h                |   9 +-
 src/openvpn/options_util.c           | 104 ++++++++++++++++++++++
 src/openvpn/options_util.h           |  33 +++++++
 src/openvpn/push.c                   | 127 ++++++++++++++++-----------
 src/openvpn/push.h                   |   2 +
 src/openvpn/sig.c                    |  27 +++++-
 src/openvpn/ssl.c                    |  16 +++-
 src/openvpn/ssl.h                    |   6 ++
 src/openvpn/ssl_common.h             |   1 +
 src/openvpn/ssl_ncp.c                |   5 ++
 src/openvpn/ssl_verify.c             |  74 +++++++++++++++-
 tests/unit_tests/openvpn/Makefile.am |   1 +
 tests/unit_tests/openvpn/test_misc.c |  49 +++++++++++
 23 files changed, 486 insertions(+), 60 deletions(-)
 create mode 100644 src/openvpn/options_util.c
 create mode 100644 src/openvpn/options_util.h

-- 
2.32.0 (Apple Git-132)


