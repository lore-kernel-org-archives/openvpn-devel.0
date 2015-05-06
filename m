From: David Sommerseth <openvpn.list@...1114...>
Date: Wed,  6 May 2015 22:06:26 +0200
Message-Id: <1430942786-31419-5-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1430942786-31419-1-git-send-email-openvpn.list@...1114...>
References: <1430942786-31419-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCHv2 4/4] systemd: Do not mask usernames when
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

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac                  | 1 +
 src/openvpn/console_systemd.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index 4e9fbfc..0c7eed4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1010,6 +1010,7 @@ if test "$enable_systemd" = "yes" ; then
     AC_CHECK_FUNCS([sd_booted], [], [AC_MSG_ERROR([systemd library is missing sd_booted()])])
     OPTIONAL_SYSTEMD_LIBS="${libsystemd_LIBS}"
     AC_DEFINE(ENABLE_SYSTEMD, 1, [Enable systemd integration])
+    AC_DEFINE_UNQUOTED(SYSTEMD_VERSION, [`echo ${libsystemd_MODVERSION}`], [systemd version installed])
     LIBS="${saved_LIBS}"
 fi
 
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index 1fb0891..b8be691 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -61,6 +61,12 @@ get_console_input_systemd (const char *prompt, const bool echo, char *input, con
 
     argv_init (&argv);
     argv_printf (&argv, SYSTEMD_ASK_PASSWORD_PATH);
+#if SYSTEMD_VERSION > 216
+    if( echo )
+    {
+	argv_printf_cat(&argv, "--echo");
+    }
+#endif
     argv_printf_cat (&argv, "%s", prompt);
 
     if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
-- 
1.8.3.1


