From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 25 Apr 2014 10:41:17 +0200
Message-ID: <1398415277-6880-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix bug that incorrectly refuses oid
	representation eku's in polar builds
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

The return value of x509_get_numeric_string() was interpreted incorrectly
by ssl_verify_polarssl.c's x509_verify_cert_eku(). This patch enables the
usage of oid represenation in --remote-cert-eku options.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_verify_polarssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 5db4f02..f2b0574 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -340,7 +340,7 @@ x509_verify_cert_eku (x509_cert *cert, const char * const expected_oid)
 		}
 	    }
 
-	  if (0 == x509_oid_get_numeric_string( oid_num_str,
+	  if (0 < x509_oid_get_numeric_string( oid_num_str,
 	      sizeof (oid_num_str), oid))
 	    {
 	      msg (D_HANDSHAKE, "++ Certificate has EKU (oid) %s, expects %s",
-- 
1.8.3.2


