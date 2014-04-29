From: Gert Doering <gert@...1296...>
Date: Tue, 29 Apr 2014 23:09:39 +0200
Message-Id: <1398805779-29376-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Conditionalize calls to
	print_default_gateway on !ENABLE_SMALL
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

Calls to print_default_gateway() depended on #ifdef ENABLE_DEBUG, but
the actual function wasn't compiled in #ifdef ENABLE_SMALL, so the
combination "configure --enable-small --enable-debug" didn't work. Fix.

Fix trac #397

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 2 +-
 src/openvpn/route.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 40210e6..fe9b99d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4144,7 +4144,7 @@ add_option (struct options *options,
 
       read_config_file (options, p[1], level, file, line, msglevel, permission_mask, option_types_found, es);
     }
-#ifdef ENABLE_DEBUG
+#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
   else if (streq (p[0], "show-gateway"))
     {
       struct route_gateway_info rgi;
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 1d9da42..12f5b62 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -579,7 +579,7 @@ init_route_list (struct route_list *rl,
   if (rl->rgi.flags & RGI_ADDR_DEFINED)
     {
       setenv_route_addr (es, "net_gateway", rl->rgi.gateway.addr, -1);
-#ifdef ENABLE_DEBUG
+#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
       print_default_gateway (D_ROUTE, &rl->rgi);
 #endif
     }
-- 
1.8.3.2


