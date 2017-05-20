From: Steffan Karger <steffan@...1856...>
Date: Sat, 20 May 2017 14:57:55 +0200
Message-Id: <1495285075-4957-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix mbedtls fingerprint calculation
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

Commit 'Migrate to mbed TLS 2.x' (86d8cd68) introduced a bug in mbedtls
builds where we would calculate the certificate fingerprint over the
(too-short) 'to-be-signed' length of the certificate, rather than over the
certificate including the signature.  Fix that.

The security impact of the incorrect calculation is very minimal; the last
few bytes (max 4, typically 4) are not verified by the fingerprint.  We
expect no real-world impact, because users that used this feature before
will notice that it has suddenly stopped working, and users that didn't
will notice that connection setup fails.

Even if the user managed to somehow extract the incorrect hash (e.g. by
reading out the tls_digest_* env vars using a --tls-verify script), the
impact is miminal: the last 4 bytes must still be properly signed by the
CA, and typically contain extension fields, or the last bytes of the
public key (which are hard to choose).  The most important bits of the
certificate were always checked: the version, serial, signature algorithm,
issuer, validity and subject.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst                      | 16 ++++++++++++++++
 src/openvpn/ssl_verify_mbedtls.c |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Changes.rst b/Changes.rst
index 5a02ad0..0017b7b 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -339,3 +339,19 @@ Security
   causing a packet id roll over.  An attack is rather inefficient; a peer
   would need to get us to send at least about 196 GB of data.
   (OSTIF/Quarkslab audit finding 5.2, CVE-2017-7479)
+
+
+Version 2.4.2
+=============
+
+Bugfixes
+--------
+- Fix fingerprint calculation in mbed TLS builds.  This means that mbed TLS users
+  of OpenVPN 2.4.0, 2.4.1 and 2.4.2 that rely on the values of the
+  ``tls_digest_*`` env vars, or that use `--verify-hash` will have to change
+  the fingerprint values they check against.  The security impact of the
+  incorrect calculation is very minimal; the last few bytes (max 4, typically
+  4) are not verified by the fingerprint.  We expect no real-world impact,
+  because users that used this feature before will notice that it has suddenly
+  stopped working, and users that didn't will notice that connection setup
+  fails if they specify correct fingerprints.
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index c32e481..a1ebd4f 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -209,7 +209,7 @@ x509_get_fingerprint(const mbedtls_md_info_t *md_info, mbedtls_x509_crt *cert,
 {
     const size_t md_size = mbedtls_md_get_size(md_info);
     struct buffer fingerprint = alloc_buf_gc(md_size, gc);
-    mbedtls_md(md_info, cert->raw.p, cert->tbs.len, BPTR(&fingerprint));
+    mbedtls_md(md_info, cert->raw.p, cert->raw.len, BPTR(&fingerprint));
     ASSERT(buf_inc_len(&fingerprint, md_size));
     return fingerprint;
 }
-- 
2.7.4


