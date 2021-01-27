From: Greg Cox <gcox@...1057...>
Date: Wed, 27 Jan 2021 20:21:49 +0000
Message-Id: <1611778909-20630-2-git-send-email-gcox@...1057...>
In-Reply-To: <1611778909-20630-1-git-send-email-gcox@...1057...>
References: <1611778909-20630-1-git-send-email-gcox@...1057...>
Subject: [Openvpn-devel] [PATCH 2/2] More explicit versioning compatibility
 in sample-plugins/defer/simple.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

While not required, adding openvpn_plugin_min_version_required_v1 helps
by making an example for others to copy, and helps to explicitly call
attention to the difference between the API version number and the
struct version number in v3 calls.
---
 sample/sample-plugins/defer/simple.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
index a2e47cfc3953ae188a5a2588a3d21e12404c75f1..05bfc4efa6d85bb1696b6811428260f4cc5e9914 100644
--- a/sample/sample-plugins/defer/simple.c
+++ b/sample/sample-plugins/defer/simple.c
@@ -66,7 +66,15 @@
 static plugin_log_t plugin_log = NULL;
 
 /*
- * Our context, where we keep our state.
+ * Constants indicating minimum API and struct versions by the functions
+ * in this plugin.  Consult openvpn-plugin.h, look for:
+ * OPENVPN_PLUGIN_VERSION and OPENVPN_PLUGINv3_STRUCTVER
+ */
+#define OPENVPN_PLUGIN_VERSION_MIN 3
+#define OPENVPN_PLUGIN_STRUCTVER_MIN 5
+
+/*
+* Our context, where we keep our state.
  */
 
 struct plugin_context {
@@ -136,6 +144,13 @@ atoi_null0(const char *str)
     }
 }
 
+/* Require a minimum OpenVPN Plugin API */
+OPENVPN_EXPORT int
+openvpn_plugin_min_version_required_v1()
+{
+    return OPENVPN_PLUGIN_VERSION_MIN;
+}
+
 /* use v3 functions so we can use openvpn's logging and base64 etc. */
 OPENVPN_EXPORT int
 openvpn_plugin_open_v3(const int v3structver,
@@ -146,7 +161,7 @@ openvpn_plugin_open_v3(const int v3structver,
     struct plugin_context *context;
 
     /* Check API compatibility -- struct version 5 or higher needed */
-    if (v3structver < 5)
+    if (v3structver < OPENVPN_PLUGIN_STRUCTVER_MIN)
     {
         fprintf(stderr, "%s: this plugin is incompatible with the running version of OpenVPN\n", MODULE);
         return OPENVPN_PLUGIN_FUNC_ERROR;
@@ -428,7 +443,7 @@ openvpn_plugin_func_v3(const int v3structver,
                        struct openvpn_plugin_args_func_return *ret)
 {
     /* Check API compatibility -- struct version 5 or higher needed */
-    if (v3structver < 5)
+    if (v3structver < OPENVPN_PLUGIN_STRUCTVER_MIN)
     {
         fprintf(stderr, "%s: this plugin is incompatible with the running version of OpenVPN\n", MODULE);
         return OPENVPN_PLUGIN_FUNC_ERROR;
-- 
2.7.6


