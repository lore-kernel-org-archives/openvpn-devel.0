From: Pavel Raiskup <praiskup@...1347...>
Date: Sun, 15 Jan 2017 07:17:18 +0100
Message-Id: <20170115061718.3218-1-praiskup@...1347...>
Subject: [Openvpn-devel] [PATCH] options: allow setting default --ca
	argument value
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

Adding a new --with-ca-bundle configure option.  It's argument is
used as default CA file when no --ca option is specified at
runtime.

This option is primarily designed for systems where users are
allowed to manage trusted authorities for whole system (in one
consolidated file; usually implemented in 'ca-certificates'
package).

Signed-off-by: Pavel Raiskup <praiskup@...1347...>
---
 configure.ac          | 5 +++++
 src/openvpn/options.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/configure.ac b/configure.ac
index 43487b0..f5e1e63 100644
--- a/configure.ac
+++ b/configure.ac
@@ -308,6 +308,11 @@ AC_ARG_WITH(
 	[with_plugindir="\$(libdir)/openvpn/plugins"]
 )
 
+AC_ARG_WITH(
+	[ca-bundle],
+	[AS_HELP_STRING([--with-ca-bundle], [use consolidated CA bundle])],
+	[AC_DEFINE_UNQUOTED([DEFAULT_CA_FILE], ["$withval"], [Default --ca argument])]
+)
 
 AC_DEFINE_UNQUOTED([TARGET_ALIAS], ["${host}"], [A string representing our host])
 case "$host" in
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d9c384e..92d81ae 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3000,6 +3000,15 @@ options_postprocess_mutate(struct options *o)
     }
 #endif
 
+#ifdef DEFAULT_CA_FILE
+    if (!o->ca_file && !platform_access(DEFAULT_CA_FILE, R_OK))
+    {
+        msg(M_WARN, "option '--ca' unspecified; using system bundle '%s'",
+            DEFAULT_CA_FILE);
+        o->ca_file = DEFAULT_CA_FILE;
+    }
+#endif
+
 #if ENABLE_MANAGEMENT
     if (o->http_proxy_override)
     {
-- 
2.9.3


