From: Gert Doering <gert@...1296...>
Date: Sat, 11 Oct 2025 13:14:11 +0200
Message-ID: <20251011111417.11802-1-gert@...1296...>
In-Reply-To: <gerrit.1758706218000.Ib3458a9ed2eb38e00184c4a92659b83b97fe476c@...2715...>
References: <gerrit.1758706218000.Ib3458a9ed2eb38e00184c4a92659b83b97fe476c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] redirect-gateway: only redirect traffic
 through TUN if address families match
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

Adds a check in do_init_route_ipv6_list() to add default routes toward the TUN
only if the TUN has IPv6 addresses.

Github: fixes OpenVPN/openvpn#850
github.com/OpenVPN/openvpn/issues/850

Change-Id: Ib3458a9ed2eb38e00184c4a92659b83b97fe476c
Signed-off-by: mrbff <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1210
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1210
This mail reflects revision 4 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f8a0fee..aaa0573 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1523,7 +1523,7 @@
 
     /* redirect (IPv6) gateway to VPN?  if yes, add a few more specifics
      */
-    if (options->routes_ipv6->flags & RG_REROUTE_GW)
+    if (options->routes_ipv6->flags & RG_REROUTE_GW && options->ifconfig_ipv6_local)
     {
         char *opt_list[] = { "::/3", "2000::/4", "3000::/4", "fc00::/7", NULL };
         int i;

