From: Greg Cox <gcox@...1057...>
Date: Sun, 24 Jan 2021 23:46:13 +0000
Message-Id: <1611531973-443-1-git-send-email-gcox@...1057...>
Subject: [Openvpn-devel] [PATCH] Documentation fixes around
 openvpn_plugin_func_v3 in openvpn-plugin.h.in
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

The comments refered to parameters found in openvpn_plugin_func_v2 but not in v3
---
 include/openvpn-plugin.h.in | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 64b20886eb364c9317fbb177abe827158b7e3018..b73b7453397344beda7543183fe989eda268a372 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -670,12 +670,12 @@ OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_open_v3)
  * ARGUMENTS
  *
  * version : fixed value, defines the API version of the OpenVPN plug-in API.  The plug-in
- *           should validate that this value is matching the OPENVPN_PLUGIN_VERSION value.
+ *           should validate that this value is matching the OPENVPN_PLUGINv3_STRUCTVER
+ *           value.
  *
- * handle : the openvpn_plugin_handle_t value which was returned by
- *          openvpn_plugin_open.
+ * arguments : Structure with all arguments available to the plug-in.
  *
- * return_list : used to return data back to OpenVPN.
+ * retptr :    used to return data back to OpenVPN.
  *
  * RETURN VALUE
  *
@@ -736,8 +736,8 @@ OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_open_v3)
  * A given client or subnet rule applies to both incoming and outgoing
  * packets.
  *
- * See plugin/defer/simple.c for an example on using asynchronous
- * authentication and client-specific packet filtering.
+ * See sample/sample-plugins/defer/simple.c for an example on using
+ * asynchronous authentication and client-specific packet filtering.
  */
 OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v3)
     (const int version,
-- 
2.7.6


