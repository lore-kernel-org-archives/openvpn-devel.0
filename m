From: David Sommerseth <davids@...515...>
Date: Thu, 11 Aug 2016 16:33:55 +0200
Message-Id: <1470926035-434-1-git-send-email-davids@...515...>
In-Reply-To: <1470684488-21307-5-git-send-email-davids@...515...>
References: <1470684488-21307-5-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH v4.1] systemd: Do not mask usernames when
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

In systemd after version 216, systemd-ask-password will support --echo which
will avoid masking the user input.  As OpenVPN uses this mechanism collecting
usernames when systemd is available, this will avoid the input of usernames to
be masked.

This patch also adds the --icon argument, which is aimed at graphical inputs.
For example when OpenVPN is started at system boot-time using a graphical boot
interface such as Plymouth.

  [v2 - Avoid pkg.m4 hacks and use pkgconfig/autoconf methods to flag
        if systemd is recent enough for --echo support]

Signed-off-by: David Sommerseth <davids@...515...>
---
 configure.ac                  | 6 ++++++
 src/openvpn/console_systemd.c | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/configure.ac b/configure.ac
index c3088fd..b2fa41c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1012,6 +1012,12 @@ if test "$enable_systemd" = "yes" ; then
                       [],
                       [PKG_CHECK_MODULES([libsystemd], [libsystemd-daemon])]
                       )
+
+    PKG_CHECK_EXISTS( [libsystemd > 216],
+                     [AC_DEFINE([SYSTEMD_NEWER_THAN_216], [1],
+                           [systemd is newer than v216])]
+                    )
+
     AC_CHECK_HEADERS(systemd/sd-daemon.h,
        ,
        [
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index bf0f99d..f385c0c 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -64,6 +64,14 @@ get_console_input_systemd (const char *prompt, const bool echo, char *input, con
 
     argv_init (&argv);
     argv_printf (&argv, SYSTEMD_ASK_PASSWORD_PATH);
+#ifdef SYSTEMD_NEWER_THAN_216
+    /* the --echo support arrived in upstream systemd 217 */
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


