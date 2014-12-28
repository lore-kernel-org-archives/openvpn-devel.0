From: Steffan Karger <steffan@...1856...>
Date: Sun, 28 Dec 2014 11:25:13 +0100
Message-Id: <1419762313-31233-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Set tls-version-max to 1.1 if cryptoapicert
	is used
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

OpenVPN's current cryptoapicert implementation does not support TLS 1.2
(and newer).  Fixing this requires a rewrite of our cryptoapi code to use
Microsofts' "Cryptography API: Next Generation", and several hacks to work
around that API.  As long as we don't fix that, make openvpn automatically
cap the TLS version to 1.1 when using cryptoapi (and tell the user we're
doing so).  This enables the user to use cryptoapi + TLS version
negotiation (upto TLS 1.1) without having to change his configuration.

This patch has been tested on Windows 8.1 for both the master and
release/2.3 branches.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/options.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2909c89..4ea03d1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2508,6 +2508,24 @@ options_postprocess_mutate (struct options *o)
 	options_postprocess_http_proxy_override(o);
 #endif
 
+#ifdef ENABLE_CRYPTOAPI
+  if (o->cryptoapi_cert)
+    {
+      const int tls_version_max =
+	  (o->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &
+	  SSLF_TLS_VERSION_MAX_MASK;
+
+      if (tls_version_max == TLS_VER_UNSPEC || tls_version_max > TLS_VER_1_1)
+	{
+	  msg(M_WARN, "Warning: cryptapicert used, setting maximum TLS "
+	      "version to 1.1.");
+	  o->ssl_flags &= ~(SSLF_TLS_VERSION_MAX_MASK <<
+	      SSLF_TLS_VERSION_MAX_SHIFT);
+	  o->ssl_flags |= (TLS_VER_1_1 << SSLF_TLS_VERSION_MAX_SHIFT);
+	}
+    }
+#endif /* ENABLE_CRYPTOAPI */
+
 #if P2MP
   /*
    * Save certain parms before modifying options via --pull
-- 
2.1.0


