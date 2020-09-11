From: Gert Doering <gert@...1296...>
Date: Fri, 11 Sep 2020 10:59:07 +0200
Message-Id: <20200911085907.26004-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix handling of 'route remote_host' for
 IPv6 transport case.
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

If we connect to a VPN server over IPv6, and the config has a
route like this:

  route remote_host default net_gateway

OpenVPN would try to install a route to "255.255.255.255", which
is obviously bogus.

The bug is twofold: init_route_list() should not set RTSA_REMOTE_HOST
for an "IPV4_INVALID_ADDR" remote_host (wrong condition, this is not
a pointer but an integer, and "invalid" is "-1" numerically here),
and init_route() must not ignore "status = false" returns from
get_special_addr().

I have just added the "if (!status)" check, not done refactoring for
init_route() to see whether I could make it "more pretty".

Trac: #1247

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index f127a90a..3c94a861 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -323,6 +323,10 @@ init_route(struct route_ipv4 *r,
 
     if (get_special_addr(rl, ro->network, (in_addr_t *) &special.s_addr, &status))
     {
+        if (!status)
+        {
+            goto fail;
+        }
         special.s_addr = htonl(special.s_addr);
         ret = openvpn_getaddrinfo(0, inet_ntoa(special), NULL, 0, NULL,
                                   AF_INET, network_list);
@@ -619,7 +623,7 @@ init_route_list(struct route_list *rl,
 
     rl->flags = opt->flags;
 
-    if (remote_host)
+    if (remote_host != IPV4_INVALID_ADDR)
     {
         rl->spec.remote_host = remote_host;
         rl->spec.flags |= RTSA_REMOTE_HOST;
-- 
2.26.2


