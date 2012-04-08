From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sun,  8 Apr 2012 22:21:47 +0300
Message-Id: <1333912907-7916-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] build: properly detect TUNSETPERSIST
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Do not rely on system symbol throught sources
but on autoconf detection.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac          |   10 ++++++++++
 src/openvpn/init.c    |    2 +-
 src/openvpn/options.c |    8 ++++----
 src/openvpn/tun.c     |    4 ++--
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0f1ca99..d40f7dc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -595,6 +595,16 @@ AC_CHECK_HEADERS(
 	],
 	[have_tap_header="yes"]
 )
+AC_CHECK_DECLS(
+	[TUNSETPERSIST],
+	[AC_DEFINE([ENABLE_FEATURE_TUN_PERSIST], [1], [We have persist tun capability])],
+	,
+	[[
+		#ifdef HAVE_LINUX_IF_TUN_H
+		#include <linux/if_tun.h>
+		#endif
+	]]
+)
 CFLAGS="${old_CFLAGS}"
 test "${have_tap_header}" = "yes" || AC_MSG_ERROR([no tap header could be found])
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index bc7718e..d022edc 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -954,7 +954,7 @@ do_genkey (const struct options * options)
 bool
 do_persist_tuntap (const struct options *options)
 {
-#ifdef TUNSETPERSIST
+#ifdef ENABLE_FEATURE_TUN_PERSIST
   if (options->persist_config)
     {
       /* sanity check on options for --mktun or --rmtun */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bd83843..33fcb87 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -725,7 +725,7 @@ static const char usage_message[] =
   "                  for use with the --secret option.\n"
   "--secret file   : Write key to file.\n"
 #endif				/* ENABLE_CRYPTO */
-#ifdef TUNSETPERSIST
+#ifdef ENABLE_FEATURE_TUN_PERSIST
   "\n"
   "Tun/tap config mode (available with linux 2.4+):\n"
   "--mktun         : Create a persistent tunnel.\n"
@@ -791,7 +791,7 @@ init_options (struct options *o, const bool init_gc)
   o->management_echo_buffer_size = 100;
   o->management_state_buffer_size = 100;
 #endif
-#ifdef TUNSETPERSIST
+#ifdef ENABLE_FEATURE_TUN_PERSIST
   o->persist_mode = 1;
 #endif
 #ifndef WIN32
@@ -1420,7 +1420,7 @@ show_settings (const struct options *o)
   
   SHOW_INT (mode);
 
-#ifdef TUNSETPERSIST
+#ifdef ENABLE_FEATURE_TUN_PERSIST
   SHOW_BOOL (persist_config);
   SHOW_INT (persist_mode);
 #endif
@@ -6788,7 +6788,7 @@ add_option (struct options *options,
       options->pkcs11_id_management = true;
     }
 #endif
-#ifdef TUNSETPERSIST
+#ifdef ENABLE_FEATURE_TUN_PERSIST
   else if (streq (p[0], "rmtun"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index b99071c..227bfde 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1517,7 +1517,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 
 #endif /* HAVE_LINUX_IF_TUN_H */
 
-#ifdef TUNSETPERSIST
+#ifdef ENABLE_FEATURE_TUN_PERSIST
 
 /*
  * This can be removed in future
@@ -1567,7 +1567,7 @@ tuncfg (const char *dev, const char *dev_type, const char *dev_node, int persist
   msg (M_INFO, "Persist state set to: %s", (persist_mode ? "ON" : "OFF"));
 }
 
-#endif /* TUNSETPERSIST */
+#endif /* ENABLE_FEATURE_TUN_PERSIST */
 
 void
 close_tun (struct tuntap *tt)
-- 
1.7.3.4


