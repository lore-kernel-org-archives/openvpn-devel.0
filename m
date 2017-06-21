From: Steffan Karger <steffan@...1856...>
Date: Wed, 21 Jun 2017 23:21:31 +0200
Message-Id: <20170621212131.6776-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix typo in extract_x509_extension() debug
 message
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

This message should use the external name, not the internal one.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_verify_openssl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index f9e889ff..ea474955 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -129,8 +129,7 @@ extract_x509_extension(X509 *cert, char *fieldname, char *out, int size)
     if (!x509_username_field_ext_supported(fieldname))
     {
         msg(D_TLS_ERRORS,
-            "ERROR: --x509-alt-username field 'ext:%s' not supported",
-            fieldname);
+            "ERROR: --x509-username-field 'ext:%s' not supported", fieldname);
         return false;
     }
 
-- 
2.11.0


