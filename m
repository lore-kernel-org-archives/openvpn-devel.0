From: Steffan Karger <steffan@...1856...>
Date: Wed,  6 Jan 2016 21:59:03 +0100
Message-Id: <1452113943-30684-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] polarssl: actually use polarssl debug
	logging
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

We had the machinery in place, but did not actually use it because nothing
will be logged untill the debug threshold is increased.

This commit makes --verb 8 result is level 2 polar logging (which is
verbose, and --verb 9 result in level 3 polar logging (which is very
verbose).  There are higher levels, but those are extremely verbose.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_polarssl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 339d1fb..58b2116 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -49,6 +49,7 @@
 #include <polarssl/havege.h>
 
 #include "ssl_verify_polarssl.h"
+#include <polarssl/debug.h>
 #include <polarssl/error.h>
 #include <polarssl/oid.h>
 #include <polarssl/pem.h>
@@ -679,8 +680,8 @@ static int endless_buf_write( void *ctx, const unsigned char *in, size_t len )
 
 static void my_debug( void *ctx, int level, const char *str )
 {
-  int my_loglevel = (level < 2) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;
-  msg (my_loglevel, "PolarSSL alert: %s", str);
+  int my_loglevel = (level < 3) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;
+  msg (my_loglevel, "PolarSSL msg: %s", str);
 }
 
 /*
@@ -762,6 +763,7 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
   if (polar_ok(ssl_init(ks_ssl->ctx)))
     {
       /* Initialise SSL context */
+      debug_set_threshold(3);
       ssl_set_dbg (ks_ssl->ctx, my_debug, NULL);
       ssl_set_endpoint (ks_ssl->ctx, ssl_ctx->endpoint);
 
-- 
2.5.0


