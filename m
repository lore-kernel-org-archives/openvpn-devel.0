From: selva.nair@...277...
Date: Mon, 20 Nov 2017 20:43:25 -0500
Message-Id: <1511228605-23207-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1494859203-21904-1-git-send-email-selva.nair@...277...>
References: <1494859203-21904-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Correct the declaration of handle in
 'struct openvpn_plugin_args_open_return'
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

From: Selva Nair <selva.nair@...277...>

- This is an opaque pointer so the change should not affect
  existing plugins. But it makes the code consistent and clears up
  the documentation as the handle pointer is treated as of type
  "openvpn_plugin_handle_t" in the rest of the code.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 v2: no change

 include/openvpn-plugin.h.in | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index f29b3a0..dfc8e1e 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -355,7 +355,7 @@ struct openvpn_plugin_args_open_in
  *              type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT)
  *                         | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT)
  *
- * *handle :    Pointer to a global plug-in context, created by the plug-in.  This pointer
+ * handle :     Pointer to a global plug-in context, created by the plug-in.  This pointer
  *              is passed on to the other plug-in calls.
  *
  * return_list : used to return data back to OpenVPN.
@@ -364,7 +364,7 @@ struct openvpn_plugin_args_open_in
 struct openvpn_plugin_args_open_return
 {
     int type_mask;
-    openvpn_plugin_handle_t *handle;
+    openvpn_plugin_handle_t handle;
     struct openvpn_plugin_string_list **return_list;
 };
 
@@ -386,9 +386,9 @@ struct openvpn_plugin_args_open_return
  *        these variables are not actually written to the "official"
  *        environmental variable store of the process.
  *
- * *handle : Pointer to a global plug-in context, created by the plug-in's openvpn_plugin_open_v3().
+ * handle : Pointer to a global plug-in context, created by the plug-in's openvpn_plugin_open_v3().
  *
- * *per_client_context : the per-client context pointer which was returned by
+ * per_client_context : the per-client context pointer which was returned by
  *        openvpn_plugin_client_constructor_v1, if defined.
  *
  * current_cert_depth : Certificate depth of the certificate being passed over (only if compiled with ENABLE_CRYPTO defined)
-- 
2.1.4


