From: Antonio Quartulli <a@...2181...>
Date: Mon,  8 Jun 2020 17:32:39 +0200
Message-Id: <20200608153239.2260-1-a@...2181...>
In-Reply-To: <20200608141620.GI1431@...1296...>
References: <20200608141620.GI1431@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] options: enable IPv4 redirection logic
 only if really required
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

If no IPv4 redirection flag is set, do not enable the IPv4
redirection logic at all so that it won't bother adding any
useless IPv4 route.

Trac: #208
Signed-off-by: Antonio Quartulli <antonio@...515...>

---
Changes from v4:
- add warning about undefined behaviour when specifying
  redirect-gateway/private at the same time
- fix behaviour of redirect-private

Changes from v3:
- move error message modification to previous patch

Changes from v2:
- patchset rebased on top of pre-ipv6-only patchset
---
 src/openvpn/options.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7556e7ee..018f6f18 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6542,6 +6542,18 @@ add_option(struct options *options,
         int j;
         VERIFY_PERMISSION(OPT_P_ROUTE);
         rol_check_alloc(options);
+
+        if (options->routes->flags & RG_ENABLE)
+        {
+            msg(M_WARN,
+                "WARNING: You have specified redirect-gateway and "
+                "redirect-private at the same time (or the same option "
+                "multiple times). This is not well supported and may lead to "
+                "unexpected results");
+        }
+
+        options->routes->flags |= RG_ENABLE;
+
         if (streq(p[0], "redirect-gateway"))
         {
             options->routes->flags |= RG_REROUTE_GW;
@@ -6579,7 +6591,7 @@ add_option(struct options *options,
             }
             else if (streq(p[j], "!ipv4"))
             {
-                options->routes->flags &= ~RG_REROUTE_GW;
+                options->routes->flags &= ~(RG_REROUTE_GW | RG_ENABLE);
             }
             else
             {
@@ -6591,7 +6603,6 @@ add_option(struct options *options,
         /* we need this here to handle pushed --redirect-gateway */
         remap_redirect_gateway_flags(options);
 #endif
-        options->routes->flags |= RG_ENABLE;
     }
     else if (streq(p[0], "block-ipv6") && !p[1])
     {
-- 
2.27.0


