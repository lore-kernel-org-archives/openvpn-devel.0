From: Gert Doering <gert@...1296...>
Date: Mon,  1 Jun 2015 21:04:47 +0200
Message-Id: <1433185487-9724-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Use configure.ac hack to apply serial_test
	AM option only if supported.
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

Inspired by libguestfs' configure.ac hack - test automake version,
and if 1.12 or newer, use m4 magic to pass "serial_tests" option
to AM_INIT_AUTOMAKE().

https://www.redhat.com/archives/libguestfs/2013-February/msg00102.html

Trac #427

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 54fe4f5..cd450d3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -35,7 +35,21 @@ AC_CONFIG_AUX_DIR([.])
 AC_CONFIG_HEADERS([config.h])
 AC_CONFIG_SRCDIR([src/openvpn/syshead.h])
 AC_CONFIG_MACRO_DIR([m4])
-AM_INIT_AUTOMAKE
+
+dnl Initialize automake.  automake < 1.12 didn't have serial-tests and
+dnl gives an error if it sees this, but for automake >= 1.13
+dnl serial-tests is required so we have to include it.  Solution is to
+dnl test for the version of automake (by running an external command)
+dnl and provide it if necessary.  Note we have to do this entirely using
+dnl m4 macros since automake queries this macro by running
+dnl 'autoconf --trace ...'.
+m4_define([serial_tests], [
+    m4_esyscmd([automake --version |
+                head -1 |
+                awk '{split ($NF,a,"."); if (a[1] == 1 && a[2] >= 12) { print "serial-tests" }}'
+    ])
+])
+AM_INIT_AUTOMAKE(foreign serial_tests) dnl NB: Do not [quote] this parameter.
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
 
-- 
2.3.6


