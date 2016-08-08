From: David Sommerseth <davids@...515...>
Date: Mon,  8 Aug 2016 21:28:08 +0200
Message-Id: <1470684488-21307-5-git-send-email-davids@...515...>
In-Reply-To: <1470684488-21307-1-git-send-email-davids@...515...>
References: <1470684488-21307-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH v4 4/4] systemd: Do not mask usernames when
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

Signed-off-by: David Sommerseth <davids@...515...>
---
 configure.ac                  | 1 +
 src/openvpn/console_systemd.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/configure.ac b/configure.ac
index c3088fd..a44e1df 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1023,6 +1023,7 @@ if test "$enable_systemd" = "yes" ; then
     AC_CHECK_FUNCS([sd_booted], [], [AC_MSG_ERROR([systemd library is missing sd_booted()])])
     OPTIONAL_SYSTEMD_LIBS="${libsystemd_LIBS}"
     AC_DEFINE(ENABLE_SYSTEMD, 1, [Enable systemd integration])
+    AC_DEFINE_UNQUOTED(SYSTEMD_VERSION, [`echo ${libsystemd_MODVERSION}`], [systemd version installed])
     LIBS="${saved_LIBS}"
 fi
 
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index bf0f99d..62aba44 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -64,6 +64,13 @@ get_console_input_systemd (const char *prompt, const bool echo, char *input, con
 
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


