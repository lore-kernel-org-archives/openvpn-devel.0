From: ValdikSS <iam@...2070...>
Date: Sat, 16 Jan 2016 02:35:38 +0300
Message-Id: <1452900938-3636-1-git-send-email-iam@...2070...>
Subject: [Openvpn-devel] [PATCH] Update --block-outside-dns to work on
	Windows Vista
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

Windows Vista doesn't support non-equal matching of application name, it is available only since Windows 7.
This commit splits 2 filtering conditions with non-equal matching to 2 filters each with 1 filtering
condition: permit IPv4 (first filter) and IPv6 (second filter) port 53 traffic from openvpn.exe
instead of blocking all non-openvpn.exe traffic on port 53 for both protocols.
---
 src/openvpn/win32.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index a01121b..e21870c 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1222,13 +1222,14 @@ win_wfp_block_dns (const NET_IFINDEX index)
     /* Prepare filter. */
     Filter.subLayerKey = SubLayer.subLayerKey;
     Filter.displayData.name = FIREWALL_NAME;
-    Filter.weight.type = FWP_EMPTY;
+    Filter.weight.type = FWP_UINT8;
+    Filter.weight.uint8 = 0xF;
     Filter.filterCondition = Condition;
     Filter.numFilterConditions = 2;
 
-    /* First filter. Block IPv4 DNS queries except from OpenVPN itself. */
+    /* First filter. Permit IPv4 DNS queries from OpenVPN itself. */
     Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
-    Filter.action.type = FWP_ACTION_BLOCK;
+    Filter.action.type = FWP_ACTION_PERMIT;
 
     Condition[0].fieldKey = FWPM_CONDITION_IP_REMOTE_PORT;
     Condition[0].matchType = FWP_MATCH_EQUAL;
@@ -1236,26 +1237,44 @@ win_wfp_block_dns (const NET_IFINDEX index)
     Condition[0].conditionValue.uint16 = 53;
 
     Condition[1].fieldKey = FWPM_CONDITION_ALE_APP_ID;
-    Condition[1].matchType = FWP_MATCH_NOT_EQUAL;
+    Condition[1].matchType = FWP_MATCH_EQUAL;
     Condition[1].conditionValue.type = FWP_BYTE_BLOB_TYPE;
     Condition[1].conditionValue.byteBlob = openvpnblob;
 
     /* Add filter condition to our interface. */
     if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
         goto err;
-    dmsg (D_LOW, "Filter (Block IPv4 DNS) added with ID=%I64d", filterid);
+    dmsg (D_LOW, "Filter (Permit OpenVPN IPv4 DNS) added with ID=%I64d", filterid);
 
-    /* Second filter. Block IPv6 DNS queries except from OpenVPN itself. */
+    /* Second filter. Permit IPv6 DNS queries from OpenVPN itself. */
     Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
 
     /* Add filter condition to our interface. */
     if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
         goto err;
+    dmsg (D_LOW, "Filter (Permit OpenVPN IPv6 DNS) added with ID=%I64d", filterid);
+
+    /* Third filter. Block all IPv4 DNS queries. */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
+    Filter.action.type = FWP_ACTION_BLOCK;
+    Filter.weight.type = FWP_EMPTY;
+    Filter.numFilterConditions = 1;
+
+    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
+        goto err;
+    dmsg (D_LOW, "Filter (Block IPv4 DNS) added with ID=%I64d", filterid);
+
+    /* Forth filter. Block all IPv6 DNS queries. */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+
+    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
+        goto err;
     dmsg (D_LOW, "Filter (Block IPv6 DNS) added with ID=%I64d", filterid);
 
-    /* Third filter. Permit IPv4 DNS queries from TAP. */
+    /* Fifth filter. Permit IPv4 DNS queries from TAP. */
     Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
     Filter.action.type = FWP_ACTION_PERMIT;
+    Filter.numFilterConditions = 2;
 
     Condition[1].fieldKey = FWPM_CONDITION_IP_LOCAL_INTERFACE;
     Condition[1].matchType = FWP_MATCH_EQUAL;
@@ -1267,7 +1286,7 @@ win_wfp_block_dns (const NET_IFINDEX index)
         goto err;
     dmsg (D_LOW, "Filter (Permit IPv4 DNS queries from TAP) added with ID=%I64d", filterid);
 
-    /* Forth filter. Permit IPv6 DNS queries from TAP. */
+    /* Sixth filter. Permit IPv6 DNS queries from TAP. */
     Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
 
     /* Add filter condition to our interface. */
-- 
2.7.0


