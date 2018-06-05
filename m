From: selva.nair@...277...
Date: Tue,  5 Jun 2018 16:06:10 -0400
Message-Id: <1528229170-6175-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Replace M_DEBUG with D_LOW as the former is
 too verbose
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

From: Selva Nair <selva.nair@...277...>

M_DEBUG only indicates the type of the message and will print even
at verb 0.  Use D_LOW which is M_DEBUG combined with verb = 4 and
a mute level.

---
Moving towards what the man page says:
   verb 0 means "No output except fatal errors."

M_WARN also needs replacement but that one is more pervasive and
needs more care. 

 src/openvpn/ssl_openssl.c | 2 +-
 src/openvpn/tun.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 8ef68eb..527a600 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -622,7 +622,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
 
     EC_KEY_free(ecdh);
 #else  /* ifndef OPENSSL_NO_EC */
-    msg(M_DEBUG, "Your OpenSSL library was built without elliptic curve support."
+    msg(D_LOW, "Your OpenSSL library was built without elliptic curve support."
         " Skipping ECDH parameter loading.");
 #endif /* OPENSSL_NO_EC */
 }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 2e33880..688a920 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1043,7 +1043,7 @@ do_ifconfig(struct tuntap *tt,
         const char *ifconfig_broadcast = NULL;
         struct argv argv = argv_new();
 
-        msg( M_DEBUG, "do_ifconfig, tt->did_ifconfig_ipv6_setup=%d",
+        msg( D_LOW, "do_ifconfig, tt->did_ifconfig_ipv6_setup=%d",
              tt->did_ifconfig_ipv6_setup );
 
         /*
-- 
2.6.2


