From: Gert Doering <gert@...1296...>
Date: Sat, 11 Oct 2025 10:22:26 +0200
Message-ID: <20251011082232.27602-1-gert@...1296...>
In-Reply-To: <gerrit.1760136547000.Ie41101bd00d038fa6fb906f3d30d44bf65788b96@...2715...>
References: <gerrit.1760136547000.Ie41101bd00d038fa6fb906f3d30d44bf65788b96@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dhcp: Replace DHCP Option types with
 defines
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

From: Frank Lichtenheld <frank@...2641...>

Just nicer. Verified against
https://www.iana.org/assignments/bootp-dhcp-parameters/bootp-dhcp-parameters.xhtml

Change-Id: Ie41101bd00d038fa6fb906f3d30d44bf65788b96
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1266
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1266
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 653127d..56f03f2 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -342,27 +342,27 @@
     bool error = false;
     if (o->domain)
     {
-        write_dhcp_str(buf, 15, o->domain, &error);
+        write_dhcp_str(buf, DHCP_DOMAIN_NAME, o->domain, &error);
     }
 
     if (o->netbios_scope)
     {
-        write_dhcp_str(buf, 47, o->netbios_scope, &error);
+        write_dhcp_str(buf, DHCP_NETBIOS_SCOPE, o->netbios_scope, &error);
     }
 
     if (o->netbios_node_type)
     {
-        write_dhcp_u8(buf, 46, o->netbios_node_type, &error);
+        write_dhcp_u8(buf, DHCP_NETBIOS_NODE_TYPE, o->netbios_node_type, &error);
     }
 
-    write_dhcp_u32_array(buf, 6, (uint32_t *)o->dns, o->dns_len, &error);
-    write_dhcp_u32_array(buf, 44, (uint32_t *)o->wins, o->wins_len, &error);
-    write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &error);
-    write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, &error);
+    write_dhcp_u32_array(buf, DHCP_DOMAIN_SERVER, (uint32_t *)o->dns, o->dns_len, &error);
+    write_dhcp_u32_array(buf, DHCP_NETBIOS_DOMAIN_SERVER, (uint32_t *)o->wins, o->wins_len, &error);
+    write_dhcp_u32_array(buf, DHCP_NTP_SERVER, (uint32_t *)o->ntp, o->ntp_len, &error);
+    write_dhcp_u32_array(buf, DHCP_NETBIOS_DIST_SERVER, (uint32_t *)o->nbdd, o->nbdd_len, &error);
 
     if (o->domain_search_list_len > 0)
     {
-        write_dhcp_search_str(buf, 119, o->domain_search_list, o->domain_search_list_len, &error);
+        write_dhcp_search_str(buf, DHCP_DOMAIN_SEARCH, o->domain_search_list, o->domain_search_list_len, &error);
     }
 
     /* the MS DHCP server option 'Disable Netbios-over-TCP/IP
@@ -375,7 +375,7 @@
             msg(M_WARN, "build_dhcp_options_string: buffer overflow building DHCP options");
             return false;
         }
-        buf_write_u8(buf, 43);
+        buf_write_u8(buf, DHCP_VENDOR);
         buf_write_u8(buf, 6); /* total length field */
         buf_write_u8(buf, 0x001);
         buf_write_u8(buf, 4); /* length of the vendor specified field */
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index 8e15a39..3fcd2b6 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -30,10 +30,19 @@
 #pragma pack(1)
 
 /* DHCP Option types */
-#define DHCP_PAD      0
-#define DHCP_ROUTER   3
-#define DHCP_MSG_TYPE 53 /* message type (u8) */
-#define DHCP_END      255
+#define DHCP_PAD                   0
+#define DHCP_ROUTER                3
+#define DHCP_DOMAIN_SERVER         6
+#define DHCP_DOMAIN_NAME           15
+#define DHCP_NTP_SERVER            42
+#define DHCP_VENDOR                43
+#define DHCP_NETBIOS_DOMAIN_SERVER 44
+#define DHCP_NETBIOS_DIST_SERVER   45
+#define DHCP_NETBIOS_NODE_TYPE     46
+#define DHCP_NETBIOS_SCOPE         47
+#define DHCP_MSG_TYPE              53
+#define DHCP_DOMAIN_SEARCH         119
+#define DHCP_END                   255
 
 /* DHCP Messages types */
 #define DHCPDISCOVER 1

