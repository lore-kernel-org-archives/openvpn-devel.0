From: Antonio Quartulli <a@...2181...>
Date: Sat, 30 May 2020 02:05:59 +0200
Message-Id: <20200530000600.1680-7-a@...2181...>
In-Reply-To: <20200530000600.1680-1-a@...2181...>
References: <20200530000600.1680-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 6/7] options: enable IPv4 redirection
 logic only if really required
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
- move error message modification to previous patch

Changes from v3:
- patchset rebased on top of pre-ipv6-only patchset


 src/openvpn/options.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7556e7ee..3798731e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6591,7 +6591,14 @@ add_option(struct options *options,
         /* we need this here to handle pushed --redirect-gateway */
         remap_redirect_gateway_flags(options);
 #endif
-        options->routes->flags |= RG_ENABLE;
+        /* enable IPv4 redirection logic only if at least one IPv4 flag is set.
+         * For instance, when "redirect-gateway !ipv4 ipv6" is specified no
+         * IPv4 redirection should be activated.
+         */
+        if (options->routes->flags)
+        {
+            options->routes->flags |= RG_ENABLE;
+        }
     }
     else if (streq(p[0], "block-ipv6") && !p[1])
     {
-- 
2.26.2


