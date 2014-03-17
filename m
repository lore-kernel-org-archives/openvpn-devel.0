From: Arne Schwabe <arne@...1227...>
Date: Mon, 17 Mar 2014 13:56:53 +0100
Message-Id: <1395061013-1802-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Introduce safety check for http proxy
	options
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

---
 src/openvpn/options.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d69e28f..d4c8196 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1986,6 +1986,9 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 #ifdef ENABLE_HTTP_PROXY
   if ((ce->http_proxy_options) && ce->proto != PROTO_TCP_CLIENT)
     msg (M_USAGE, "--http-proxy MUST be used in TCP Client mode (i.e. --proto tcp-client)");
+  if ((ce->http_proxy_options) && !ce->http_proxy_options->server)
+    msg (M_USAGE, "--http-proxy not specified but other http proxy options present");
+
 #endif
 
 #if defined(ENABLE_HTTP_PROXY) && defined(ENABLE_SOCKS)
-- 
1.8.5.2 (Apple Git-48)


