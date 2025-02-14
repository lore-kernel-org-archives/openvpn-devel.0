From: Gert Doering <gert@...1296...>
Date: Fri, 14 Feb 2025 16:34:34 +0100
Message-ID: <20250214153434.18539-1-gert@...1296...>
In-Reply-To: <gerrit.1739527719000.I02afe6817433ca21aae76671c35151ec6a066933@...2715...>
References: <gerrit.1739527719000.I02afe6817433ca21aae76671c35151ec6a066933@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] get_default_gateway(): Prevent passing
 IPV4_INVALID_ADDR as a destination
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

When using --redirect-gateway (IPv4) while connected to an IPv6 remote,
OpenVPN still attempts to determine the IPv4 default gateway,
so link_socket_current_remote() returns IPV4_INVALID_ADDR (0xffffffff)
as the destination, leading to unintended behavior:

- the IPv4 default gateway (rl->rgi.gateway.addr) gets wiped.
- this prevents proper restoration of the original route when needed.

To fix this, if link_socket_current_remote() returns IPV4_INVALID_ADDR,
we now pass INADDR_ANY (0x00000000) to get_default_gateway(),
ensuring the function behaves correctly.

Change-Id: I02afe6817433ca21aae76671c35151ec6a066933
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/898
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d895e1c..bc41492 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -655,7 +655,7 @@
         rl->spec.flags |= RTSA_DEFAULT_METRIC;
     }
 
-    get_default_gateway(&rl->rgi, remote_host, ctx);
+    get_default_gateway(&rl->rgi, remote_host != IPV4_INVALID_ADDR ? remote_host : INADDR_ANY, ctx);
     if (rl->rgi.flags & RGI_ADDR_DEFINED)
     {
         setenv_route_addr(es, "net_gateway", rl->rgi.gateway.addr, -1);

