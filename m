From: James Yonan <james@...515...>
Date: Thu,  3 Mar 2016 01:18:59 -0700
Message-Id: <1456993146-63968-3-git-send-email-james@...515...>
In-Reply-To: <1456993146-63968-1-git-send-email-james@...515...>
References: <1456993146-63968-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 03/10] tls_serial_{n} value should be
	distinguishable as hex or decimal.
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
Cc: James Yonan <james@...515...>

To accomplish this, prepend 'x' before hex serial numbers, so they
can be distinguished from decimal serial numbers.  For example:

  tls_serial_1 = "x4D:9B:7C:94"

is equivalent to:

  tls_serial_1 = "1302035604"

Currently, only PolarSSL generates hex serial numbers while
OpenSSL returns decimal serial numbers.

RFC 5280, published in 2008, decrees that serial numbers can be
up to 20 bytes long, hence it is necessary to support SSL
libraries that return the serial number as a hex string.

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/ssl_verify_polarssl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index a2e6a8e..e87d2e2 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -161,11 +161,12 @@ char *
 backend_x509_get_serial_hex (openvpn_x509_cert_t *cert, struct gc_arena *gc)
 {
   char *buf = NULL;
-  size_t len = cert->serial.len * 3 + 1;
+  size_t len = cert->serial.len * 3;
 
-  buf = gc_malloc(len, true, gc);
+  buf = gc_malloc(len+1, true, gc);
 
-  if(x509_serial_gets(buf, len-1, &cert->serial) < 0)
+  buf[0] = 'x';
+  if(x509_serial_gets(buf+1, len, &cert->serial) < 0)
     buf = NULL;
 
   return buf;
-- 
1.9.1


