From: Mike Gilbert <floppym@...594...>
Date: Thu,  3 Jul 2014 16:24:05 -0400
Message-Id: <1404419045-14728-1-git-send-email-floppym@...594...>
Subject: [Openvpn-devel] [PATCH] Add configure check for the path to
	systemd-ask-password
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

Gentoo Linux installs this in /usr/bin by default. Also, the user may
have installed it in /usr/local/bin if building from source.
---
 configure.ac          | 3 +++
 src/openvpn/console.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 77e950d..faa2c4a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -368,15 +368,18 @@ AC_ARG_VAR([IPROUTE], [full path to ip utility])
 AC_ARG_VAR([NETSTAT], [path to netstat utility]) # tests
 AC_ARG_VAR([MAN2HTML], [path to man2html utility])
 AC_ARG_VAR([GIT], [path to git utility])
+AC_ARG_VAR([SYSTEMD_ASK_PASSWORD], [path to systemd-ask-password utility])
 AC_PATH_PROGS([IFCONFIG], [ifconfig],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
 AC_PATH_PROGS([ROUTE], [route],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
 AC_PATH_PROGS([IPROUTE], [ip],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
+AC_PATH_PROGS([SYSTEMD_ASK_PASSWORD], [systemd-ask-password],, [$PATH:/usr/local/bin:/usr/bin:/bin])
 AC_CHECK_PROGS([NETSTAT], [netstat], [netstat], [$PATH:/usr/local/sbin:/usr/sbin:/sbin:/etc]) # tests
 AC_CHECK_PROGS([MAN2HTML], [man2html])
 AC_CHECK_PROGS([GIT], [git]) # optional
 AC_DEFINE_UNQUOTED([IFCONFIG_PATH], ["$IFCONFIG"], [Path to ifconfig tool])
 AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Path to iproute tool])
 AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
+AC_DEFINE_UNQUOTED([SYSTEMD_ASK_PASSWORD_PATH], ["$SYSTEMD_ASK_PASSWORD"], [Path to systemd-ask-password tool])
 
 #
 # Libtool
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index afda8ca..059b6f0 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -162,7 +162,7 @@ get_console_input_systemd (const char *prompt, const bool echo, char *input, con
   struct argv argv;
 
   argv_init (&argv);
-  argv_printf (&argv, "/bin/systemd-ask-password");
+  argv_printf (&argv, SYSTEMD_ASK_PASSWORD_PATH);
   argv_printf_cat (&argv, "%s", prompt);
 
   if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
-- 
2.0.0


