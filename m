From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 19 Jun 2017 11:28:36 +0200
Message-ID: <1497864520-12219-2-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1497864520-12219-1-git-send-email-steffan.karger@...1435...>
References: <1497864520-12219-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/5] mbedtls: fix --x509-track
 post-authentication remote DoS (CVE-2017-7522)
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

asn1_buf_to_c_string() returned a literal string if the input ASN.1 string
contained a NUL character, while the caller expects a mutable string.
The caller will attempt to change this string, which allows a client to
crash a server by sending a certificate with an embedded NUL character.

(The other way around is not interesting, as servers are allowed to stop
a client by design.)

Impact analysis:
 * applies to mbedtls builds only
 * introduced in 2.4 (so 2.3 is not affected)
 * can only be exploited if the --x509-track option is used
 * requires the CA to sign a certificate with an embedded NUL in the
   certificate subject

This bug was discovered and reported to the OpenVPN security team by
Guido Vranken.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 Changes.rst                      | 8 ++++++++
 src/openvpn/ssl_verify_mbedtls.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Changes.rst b/Changes.rst
index 94cba07..f1aed2d 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -306,6 +306,14 @@ Maintainer-visible changes
 Version 2.4.3
 =============
 
+Security
+--------
+- CVE-2017-7522: Fix --x509-track post-authentication remote DoS
+  A client could crash a 2.4+ mbedtls server, if that server uses the
+  --x509-track option and the client has a correct, signed and unrevoked
+  certificate that contains an embedded NUL in the certificate subject.
+  Discovered and reported to the OpenVPN security team by Guido Vranken.
+
 User-visible Changes
 --------------------
 - ``--verify-hash`` can now take an optional flag which changes the hashing
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 2b7056c..d3b36dc 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -271,7 +271,7 @@ asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct gc_arena *gc)
     {
         if (orig->p[i] == '\0')
         {
-            return "ERROR: embedded null value";
+            return string_alloc("ERROR: embedded null value", gc);
         }
     }
     val = gc_malloc(orig->len+1, false, gc);
-- 
2.7.4



