From: David Sommerseth <openvpn.list@...1114...>
Date: Tue, 11 Aug 2015 18:41:48 +0200
Message-Id: <1439311312-2682-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH v3 0/4] Reworking the interface for querying
	users
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: David Sommerseth <davids@...1347...>

This is the third round of improving the API for querying users for information,
after it was discussed in the developer meeting August 10 2015.

The previous patch set can be found here:
 <http://thread.gmane.org/gmane.network.openvpn.devel/9657>

Most of the changes was in patch 1/4, where the most important changes are
replacing QUERY_USER_FOREACH macro with a for() loop and the query_user_init() 
function was changed to a void function which will do msg(M_FATAL,...) on
malloc() failures directly.  The QUERY_USER_FOREACH change also required a
minor adoptation in patch 2/4 too.

It was also reported build issues [1] if both systemd.pc and libsystemd.pc files
were installed.  This has also been fixed in patch 4/4.  The issue was that
the previous PKG_CHECK_MODULES() check would do call 
'pkg-config --modversion systemd libsystemd' which would return the mod-version
twice, separated by a newline.  The check for systemd, libsystemd and
libsystemd-daemon have now been split into separate checks.

[1] <http://thread.gmane.org/gmane.network.openvpn.devel/9657/focus=9661>

During the review it was also discovered that the announced --icon argument
was not present in patch 4/4.  This had just slipped in the patches sent to
the mailing list.

David Sommerseth (4):
  Rework the user input interface to make it more modular
  Re-implement the systemd support using the new query user API
  autotools: Add support for extracting version information from
    pkg-config modules
  systemd: Do not mask usernames when querying for it via
    systemd-ask-password

 configure.ac                  |  13 ++-
 m4/pkg.m4                     |   7 +-
 src/openvpn/Makefile.am       |  15 ++-
 src/openvpn/console.c         | 224 ++++++--------------------------------
 src/openvpn/console.h         |  83 +++++++++++++-
 src/openvpn/console_builtin.c | 246 ++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/console_systemd.c | 119 ++++++++++++++++++++
 src/openvpn/misc.c            |  64 ++++++++---
 src/openvpn/pkcs11.c          |  12 ++-
 9 files changed, 562 insertions(+), 221 deletions(-)
 create mode 100644 src/openvpn/console_builtin.c
 create mode 100644 src/openvpn/console_systemd.c

-- 
1.8.3.1


