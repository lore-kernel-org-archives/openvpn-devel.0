From: Adriaan de Jong <dejong@...1435...>
Date: Tue, 28 Feb 2012 17:29:47 +0100
Message-ID: <1330446587-5727-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fixed off-by-one in serial length
	calculation
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

The serial length was one digit too short, resulting in missing digits at the end of the certificate's stringified serial number.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 ssl_verify_polarssl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ssl_verify_polarssl.c b/ssl_verify_polarssl.c
index 2ba0a5c..4206578 100644
--- a/ssl_verify_polarssl.c
+++ b/ssl_verify_polarssl.c
@@ -121,7 +121,7 @@ x509_get_serial (x509_cert *cert, struct gc_arena *gc)
   int ret = 0;
   int i = 0;
   char *buf = NULL;
-  size_t len = cert->serial.len * 3;
+  size_t len = cert->serial.len * 3 + 1;
 
   buf = gc_malloc(len, true, gc);
 
-- 
1.7.5.4


