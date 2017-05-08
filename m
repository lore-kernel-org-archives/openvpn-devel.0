From: David Sommerseth <davids@...515...>
Date: Mon,  8 May 2017 16:19:39 +0200
Message-Id: <20170508141939.31224-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] plugin: Fix documentation typo for type_mask
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

The v3 plug-in API was slightly misleading, as that interface does not
need to use an int pointer to setting the type_mask from the plug-in.

Signed-off-by: David Sommerseth <davids@...515...>
---
 include/openvpn-plugin.h.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index ec83f3a6..5e6f8743 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -347,12 +347,12 @@ struct openvpn_plugin_args_open_in
  *
  * STRUCT MEMBERS
  *
- * *type_mask : The plug-in should set this value to the logical OR of all script
+ * type_mask  : The plug-in should set this value to the logical OR of all script
  *              types which the plug-in wants to intercept.  For example, if the
  *              script wants to intercept the client-connect and client-disconnect
  *              script types:
  *
- *              *type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT)
+ *              type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT)
  *                         | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT)
  *
  * *handle :    Pointer to a global plug-in context, created by the plug-in.  This pointer
-- 
2.11.0


