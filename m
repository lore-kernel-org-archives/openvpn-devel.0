From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 19 Jun 2017 11:28:37 +0200
Message-ID: <1497864520-12219-3-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1497864520-12219-1-git-send-email-steffan.karger@...1435...>
References: <1497864520-12219-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/5] mbedtls: require C-string compatible
 types for --x509-username-field
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

In the --x509-username-field extenstion, we handle the subject string as
if it is a C string.  Make this assumption explicit and reject incomatible
ASN.1 string types.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_verify_mbedtls.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index d3b36dc..838c217 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -267,6 +267,14 @@ asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct gc_arena *gc)
     size_t i;
     char *val;
 
+    if (!(orig->tag == MBEDTLS_ASN1_UTF8_STRING
+          || orig->tag == MBEDTLS_ASN1_PRINTABLE_STRING
+          || orig->tag == MBEDTLS_ASN1_IA5_STRING))
+    {
+        /* Only support C-string compatible types */
+        return string_alloc("ERROR: unsupported ASN.1 string type", gc);
+    }
+
     for (i = 0; i < orig->len; ++i)
     {
         if (orig->p[i] == '\0')
-- 
2.7.4



