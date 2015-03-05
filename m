From: Steffan Karger <steffan@...1856...>
Date: Thu,  5 Mar 2015 22:58:35 +0100
Message-Id: <1425592716-14243-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] Get rid of old OpenSSL workarounds.
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

We now only support OpenSSL 0.9.8+, so we don't have to work around the bug
in 0.9.6b anymore.  Also, OBJ_txt2nid() now takes a const char * (instead
of a char *), so we no langer have to cast away const.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_verify_openssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 0348e98..81b2e38 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -169,8 +169,8 @@ extract_x509_field_ssl (X509_NAME *x509, const char *field_name, char *out,
   int tmp = -1;
   X509_NAME_ENTRY *x509ne = 0;
   ASN1_STRING *asn1 = 0;
-  unsigned char *buf = (unsigned char *)1; /* bug in OpenSSL 0.9.6b ASN1_STRING_to_UTF8 requires this workaround */
-  int nid = OBJ_txt2nid((char *)field_name);
+  unsigned char *buf = NULL;
+  int nid = OBJ_txt2nid(field_name);
 
   ASSERT (size > 0);
   *out = '\0';
-- 
2.1.0


