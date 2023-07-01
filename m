From: Arne Schwabe <arne@...1227...>
Date: Sat,  1 Jul 2023 22:24:53 +0200
Message-Id: <20230701202453.3517822-2-arne@...1227...>
In-Reply-To: <20230701202453.3517822-1-arne@...1227...>
References: <20230629215611.3292788-1-arne@...1227...>
 <20230701202453.3517822-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 4/4] Avoid unused function warning/error
 on FreeBSD (and potientially others)
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

the funktion is_on_link is not used on FreeBSD and triggers a
warning/error (-Werror) on FreeBSD.

Patch v2: use actual platforms instead an ifndef FreeBSD

Change-Id: I6757d6509ff3ff522d6de417372a21e73ccca3ba
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/route.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d18acd016..0d04a5a33 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1541,13 +1541,15 @@ local_route(in_addr_t network,
     return LR_NOMATCH;
 }
 
-/* Return true if the "on-link" form of the route should be used.  This is when the gateway for a
+/* Return true if the "on-link" form of the route should be used.  This is when the gateway for
  * a route is specified as an interface rather than an address. */
+#if defined(TARGET_LINUX) || defined(_WIN32) || defined(TARGET_DARWIN)
 static inline bool
 is_on_link(const int is_local_route, const unsigned int flags, const struct route_gateway_info *rgi)
 {
     return rgi && (is_local_route == LR_MATCH || ((flags & ROUTE_REF_GW) && (rgi->flags & RGI_ON_LINK)));
 }
+#endif
 
 bool
 add_route(struct route_ipv4 *r,
-- 
2.39.2 (Apple Git-143)


