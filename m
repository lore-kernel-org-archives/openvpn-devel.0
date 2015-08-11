From: David Sommerseth <openvpn.list@...1114...>
Date: Tue, 11 Aug 2015 18:41:52 +0200
Message-Id: <1439311312-2682-5-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1439311312-2682-1-git-send-email-openvpn.list@...1114...>
References: <1439311312-2682-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH v3 4/4] systemd: Do not mask usernames when
	querying for it via systemd-ask-password
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

In systemd after version 216, systemd-ask-password will support --echo which
will avoid masking the user input.  As OpenVPN uses this mechanism collecting
usernames when systemd is available, this will avoid the input of usernames to
be masked.

This patch also adds the --icon argument, which is aimed at graphical inputs.
For example when OpenVPN is started at system boot-time using a graphical boot
interface such as Plymouth.

The patch also fixes an issue with pkg-config if both systemd.pc and
libsystemd.pc is installed, which would result in the systemd version number
being reported twice.  The autotools check for sd_booted() is also removed,
as this check doesn't really provide much of value.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac                  | 11 +++++++----
 src/openvpn/console_systemd.c |  7 +++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 182e116..133d35e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -995,10 +995,13 @@ dnl Check for systemd
 dnl
 AM_CONDITIONAL([ENABLE_SYSTEMD], [test "${enable_systemd}" = "yes"])
 if test "$enable_systemd" = "yes" ; then
-    PKG_CHECK_MODULES([libsystemd], [systemd libsystemd],
+    PKG_CHECK_MODULES([libsystemd], [systemd],
                       [],
-                      [PKG_CHECK_MODULES([libsystemd], [libsystemd-daemon])]
-                      )
+                      [PKG_CHECK_MODULES([libsystemd], [libsystemd],
+                                         [],
+                                         [PKG_CHECK_MODULES([libsystemd], [libsystemd-daemon])]
+                                         )]
+                      ])
     AC_CHECK_HEADERS(systemd/sd-daemon.h,
        ,
        [
@@ -1007,9 +1010,9 @@ if test "$enable_systemd" = "yes" ; then
 
     saved_LIBS="${LIBS}"
     LIBS="${LIBS} ${libsystemd_LIBS}"
-    AC_CHECK_FUNCS([sd_booted], [], [AC_MSG_ERROR([systemd library is missing sd_booted()])])
     OPTIONAL_SYSTEMD_LIBS="${libsystemd_LIBS}"
     AC_DEFINE(ENABLE_SYSTEMD, 1, [Enable systemd integration])
+    AC_DEFINE_UNQUOTED(SYSTEMD_VERSION, [`echo ${libsystemd_MODVERSION}`], [systemd version installed])
     LIBS="${saved_LIBS}"
 fi
 
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index a9cfbe6..5a85e38 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -61,6 +61,13 @@ get_console_input_systemd (const char *prompt, const bool echo, char *input, con
 
     argv_init (&argv);
     argv_printf (&argv, SYSTEMD_ASK_PASSWORD_PATH);
+#if SYSTEMD_VERSION > 216
+    if( echo )
+    {
+	argv_printf_cat(&argv, "--echo");
+    }
+#endif
+    argv_printf_cat (&argv, "--icon network-vpn");
     argv_printf_cat (&argv, "%s", prompt);
 
     if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
-- 
1.8.3.1


