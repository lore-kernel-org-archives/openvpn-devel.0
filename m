From: David Sommerseth <openvpn@...2080...>
Date: Sun, 13 Mar 2022 20:31:51 +0100
Message-Id: <20220313193154.9350-1-openvpn@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 0/3] Disable multiple deferred
 authentication
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

From: David Sommerseth <davids@...515...>

It was discovered an issue with OpenVPN 2.x when multiple --plugin
modules were loaded and more than one of them used deferred
authentication.  To fix this properly will require a larger refactoring
of the plug-in code, so it was decided in the mean time to disable the
possibility to run an OpenVPN server with such a setup.  This issue
affects the OpenVPN server mode only.

This patch set adds a new test plug-in and adds some test documentation
on how to test various combinations of authentication plug-ins.  Since
this new plug-in (multi-auth.c) is fairly close to the simple.c plug-in,
just more flexible for test setups, we remove the old one.  The fix
itself is isolated in a separate patch in this set.

The order of patches are insignificant; there are no inter-dependencies
between them.

--
kind regards,

David Sommerseth
OpenVPN Inc

---

David Sommerseth (3):
  sample-plugin: New plugin for testing multiple auth plugins
  plug-ins: Disallow multiple deferred authentication plug-ins
  plugins: Remove defer/simple.c sample plugin

 doc/man-sections/plugin-options.rst           |   9 +
 doc/tests/authentication-plugins.md           | 153 +++++++++++
 include/openvpn-plugin.h.in                   |   4 +-
 sample/sample-plugins/Makefile.plugins        |   2 +-
 sample/sample-plugins/README                  |   6 +-
 .../defer/{simple.c => multi-auth.c}          | 248 ++++++++++--------
 sample/sample-plugins/defer/simple.def        |   6 -
 src/openvpn/plugin.c                          |  33 ++-
 8 files changed, 333 insertions(+), 128 deletions(-)
 create mode 100644 doc/tests/authentication-plugins.md
 rename sample/sample-plugins/defer/{simple.c => multi-auth.c} (61%)
 delete mode 100755 sample/sample-plugins/defer/simple.def

-- 
2.27.0


