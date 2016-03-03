From: James Yonan <james@...515...>
Date: Thu,  3 Mar 2016 01:19:04 -0700
Message-Id: <1456993146-63968-8-git-send-email-james@...515...>
In-Reply-To: <1456993146-63968-1-git-send-email-james@...515...>
References: <1456993146-63968-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 08/10] Added ./configure flag to disable
	user-defined scripts.
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
Cc: James Yonan <james@...515...>

Added ./configure --disable-scripts build flag to ignore the
"script-security" directive in configs.  This can be used to
prevent configs from raising the script-security level to
allow user-defined script execution.

At the C level, script support is enabled by:

  /* Enable user-defined scripting */
  #define ENABLE_SCRIPTS 1

or disabled by ensuring that ENABLE_SCRIPTS is undefined.

If ENABLE_SCRIPTS is undefined, OpenVPN will log "[NOSCRIPTS]"
in the initial version info line.

This patch assumes that script_security defaults to
SSEC_BUILT_IN or less.

Signed-off-by: James Yonan <james@...515...>
---
 configure.ac          | 8 ++++++++
 src/openvpn/options.c | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/configure.ac b/configure.ac
index b75d51f..c3ff472 100644
--- a/configure.ac
+++ b/configure.ac
@@ -128,6 +128,13 @@ AC_ARG_ENABLE(
 )
 
 AC_ARG_ENABLE(
+	[scripts],
+	[AS_HELP_STRING([--disable-scripts], [disable user-defined scripting support @<:@default=yes@:>@])],
+	,
+	[enable_scripts="yes"]
+)
+
+AC_ARG_ENABLE(
 	[pkcs11],
 	[AS_HELP_STRING([--enable-pkcs11], [enable pkcs11 support @<:@default=no@:>@])],
 	,
@@ -1059,6 +1066,7 @@ test "${ac_cv_header_sys_uio_h}" = "yes" && AC_DEFINE([HAVE_IOVEC], [1], [struct
 test "${enable_multi}" = "yes" && AC_DEFINE([ENABLE_CLIENT_SERVER], [1], [Enable client/server capability])
 test "${enable_server}" = "no" && AC_DEFINE([ENABLE_CLIENT_ONLY], [1], [Enable client capability only])
 test "${enable_management}" = "yes" && AC_DEFINE([ENABLE_MANAGEMENT], [1], [Enable management server capability])
+test "${enable_scripts}" = "yes" && AC_DEFINE([ENABLE_SCRIPTS], [1], [Enable user-defined scripting])
 test "${enable_multihome}" = "yes" && AC_DEFINE([ENABLE_MULTIHOME], [1], [Enable multi-homed UDP server capability])
 test "${enable_debug}" = "yes" && AC_DEFINE([ENABLE_DEBUG], [1], [Enable debugging support])
 test "${enable_small}" = "yes" && AC_DEFINE([ENABLE_SMALL], [1], [Enable smaller executable size])
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0942a4d..b53f7ac 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -99,6 +99,9 @@ const char title_string[] =
 #if ENABLE_IP_PKTINFO
   " [MH]"
 #endif
+#ifndef ENABLE_SCRIPTS
+  " [NOSCRIPTS]"
+#endif
   " [IPv6]"
   " built on " __DATE__
 ;
@@ -5476,7 +5479,11 @@ add_option (struct options *options,
   else if (streq (p[0], "script-security") && p[1] && !p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
+#ifdef ENABLE_SCRIPTS
       script_security = atoi (p[1]);
+#else
+      msg (M_WARN, "NOTE: script-security directive ignored due to build setting");
+#endif
     }
   else if (streq (p[0], "mssfix") && !p[2])
     {
-- 
1.9.1


