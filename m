From: Greg Cox <gcox@...1057...>
Date: Mon,  1 Feb 2021 07:09:49 +0000
Message-Id: <1612163389-16421-1-git-send-email-gcox@...1057...>
Subject: [Openvpn-devel] [PATCH] Explain structvar usage in sample defer
 plugin.
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

sample-plugins/defer/simple.c uses OPENVPN_PLUGINv3_STRUCTVER settings
that may not be obvious to a new author.  Add a comment to reduce
possible confusion.
---
 sample/sample-plugins/defer/simple.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
index 05bfc4efa6d85bb1696b6811428260f4cc5e9914..6f08bedd6319827c05786303f8a4007791042208 100644
--- a/sample/sample-plugins/defer/simple.c
+++ b/sample/sample-plugins/defer/simple.c
@@ -69,12 +69,18 @@ static plugin_log_t plugin_log = NULL;
  * Constants indicating minimum API and struct versions by the functions
  * in this plugin.  Consult openvpn-plugin.h, look for:
  * OPENVPN_PLUGIN_VERSION and OPENVPN_PLUGINv3_STRUCTVER
+ *
+ * Strictly speaking, this sample code only requires plugin_log, a feature
+ * of structver version 1.  However, '1' lines up with ancient versions
+ * of openvpn that are past end-of-support.  As such, we are requiring
+ * structver '5' here to indicate a desire for modern openvpn, rather
+ * than a need for any particular feature found in structver beyond '1'.
  */
 #define OPENVPN_PLUGIN_VERSION_MIN 3
 #define OPENVPN_PLUGIN_STRUCTVER_MIN 5
 
 /*
-* Our context, where we keep our state.
+ * Our context, where we keep our state.
  */
 
 struct plugin_context {
@@ -160,7 +166,6 @@ openvpn_plugin_open_v3(const int v3structver,
     const char **envp = args->envp;       /* environment variables */
     struct plugin_context *context;
 
-    /* Check API compatibility -- struct version 5 or higher needed */
     if (v3structver < OPENVPN_PLUGIN_STRUCTVER_MIN)
     {
         fprintf(stderr, "%s: this plugin is incompatible with the running version of OpenVPN\n", MODULE);
@@ -442,7 +447,6 @@ openvpn_plugin_func_v3(const int v3structver,
                        struct openvpn_plugin_args_func_in const *args,
                        struct openvpn_plugin_args_func_return *ret)
 {
-    /* Check API compatibility -- struct version 5 or higher needed */
     if (v3structver < OPENVPN_PLUGIN_STRUCTVER_MIN)
     {
         fprintf(stderr, "%s: this plugin is incompatible with the running version of OpenVPN\n", MODULE);
-- 
2.7.6


