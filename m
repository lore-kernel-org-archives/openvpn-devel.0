From: Gert Doering <gert@...1296...>
Date: Mon, 11 May 2026 22:06:39 +0200
Message-ID: <20260511200645.24711-1-gert@...1296...>
In-Reply-To: <gerrit.1778102459000.I5c9b54dca0a14688a3bb7798cb086f5bde7311b8@...2715...>
References: <gerrit.1778102459000.I5c9b54dca0a14688a3bb7798cb086f5bde7311b8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] route: Clarify operator precedence in a
 & b ? c : d
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

As suggested by cppcheck.

Change-Id: I5c9b54dca0a14688a3bb7798cb086f5bde7311b8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1668
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1668
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3b18f74..81ce867 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2884,7 +2884,7 @@
                             .prefix.ipv4.s_addr = htonl(r->network),
                             .gateway.ipv4.s_addr = htonl(r->gateway),
                             .iface = { .index = if_index, .name = "" },
-                            .metric = (r->flags & RT_METRIC_DEFINED ? r->metric : -1) };
+                            .metric = (r->flags & RT_METRIC_DEFINED) ? r->metric : -1 };
 
     netmask_to_netbits(r->network, r->netmask, &msg.prefix_len);
     if (msg.prefix_len == -1)
@@ -2986,7 +2986,7 @@
                             .prefix_len = r->netbits,
                             .gateway.ipv6 = r->gateway,
                             .iface = { .index = tt->adapter_index, .name = "" },
-                            .metric = ((r->flags & RT_METRIC_DEFINED) ? r->metric : -1) };
+                            .metric = (r->flags & RT_METRIC_DEFINED) ? r->metric : -1 };
 
     if (r->adapter_index) /* vpn server special route */
     {

