From: Steffan Karger <steffan@...1856...>
Date: Sun,  1 Jun 2014 19:58:52 +0200
Message-Id: <1401645536-27849-2-git-send-email-steffan@...1856...>
In-Reply-To: <1401645536-27849-1-git-send-email-steffan@...1856...>
References: <1401645536-27849-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/5] Use generic openvpn_x509_cert_t in
	ssl_verify_polarssl.c
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

For symmetry with ssl_verify_openssl.c and release/2.3 branch.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_verify_polarssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 1d622cc..71d38a9 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -126,7 +126,7 @@ backend_x509_get_username (char *cn, int cn_len,
 }
 
 char *
-backend_x509_get_serial (x509_crt *cert, struct gc_arena *gc)
+backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
 {
   char *buf = NULL;
   size_t buflen = 0;
@@ -164,7 +164,7 @@ backend_x509_get_serial (x509_crt *cert, struct gc_arena *gc)
 }
 
 char *
-backend_x509_get_serial_hex (x509_crt *cert, struct gc_arena *gc)
+backend_x509_get_serial_hex (openvpn_x509_cert_t *cert, struct gc_arena *gc)
 {
   char *buf = NULL;
   size_t len = cert->serial.len * 3 + 1;
-- 
1.9.1


