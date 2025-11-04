From: Gert Doering <gert@...1296...>
Date: Tue,  4 Nov 2025 09:55:47 +0100
Message-ID: <20251104085553.8218-1-gert@...1296...>
In-Reply-To: <gerrit.1762166039000.Ie15977b44091445b9d1edebe885d92ec5cb5770a@...2715...>
References: <gerrit.1762166039000.Ie15977b44091445b9d1edebe885d92ec5cb5770a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] PUSH_UPDATE server: update
 reporting_addr after ifconfig update
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

From: Marco Baffo <marco@...2726...>

Update mi->reporting_addr(_ipv6) for status reporting purposes
after sending a PUSH_UPDATE containing an ifconfig(-ipv6) option.

Github: fixes OpenVPN/openvpn#889

Change-Id: Ie15977b44091445b9d1edebe885d92ec5cb5770a
Signed-off-by: Marco Baffo <marco@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1340
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1340
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 261209d..2b944667 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4346,6 +4346,7 @@
     multi_unlearn_in_addr_t(m, mi, old_addr);
     mi->context.c2.push_ifconfig_defined = false;
     mi->context.c2.push_ifconfig_local = 0;
+    mi->reporting_addr = 0;
 }
 
 /* Function to unlearn previous ifconfig-ipv6 of a client in the server multi_context after a PUSH_UPDATE */
@@ -4358,6 +4359,7 @@
     multi_unlearn_in6_addr(m, mi, old_addr6);
     mi->context.c2.push_ifconfig_ipv6_defined = false;
     CLEAR(mi->context.c2.push_ifconfig_ipv6_local);
+    CLEAR(mi->reporting_addr_ipv6);
 }
 
 /**
@@ -4389,6 +4391,8 @@
         {
             mi->context.c2.push_ifconfig_defined = true;
             mi->context.c2.push_ifconfig_local = ntohl(new_addr.s_addr);
+            /* set our client's VPN endpoint for status reporting purposes */
+            mi->reporting_addr = mi->context.c2.push_ifconfig_local;
         }
     }
 
@@ -4408,6 +4412,8 @@
         {
             mi->context.c2.push_ifconfig_ipv6_defined = true;
             mi->context.c2.push_ifconfig_ipv6_local = new_addr6;
+            /* set our client's VPN endpoint for status reporting purposes */
+            mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
         }
     }
 }

