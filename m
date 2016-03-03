From: James Yonan <james@...515...>
Date: Thu,  3 Mar 2016 01:19:02 -0700
Message-Id: <1456993146-63968-6-git-send-email-james@...515...>
In-Reply-To: <1456993146-63968-1-git-send-email-james@...515...>
References: <1456993146-63968-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 06/10] PolarSSL x509_get_sha1_hash now
	returns correct SHA1 fingerprint.
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

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/ssl_verify_polarssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index e87d2e2..9d0d086 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -176,7 +176,7 @@ unsigned char *
 x509_get_sha1_hash (x509_crt *cert, struct gc_arena *gc)
 {
   unsigned char *sha1_hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
-  sha1(cert->tbs.p, cert->tbs.len, sha1_hash);
+  sha1(cert->raw.p, cert->raw.len, sha1_hash);
   return sha1_hash;
 }
 
-- 
1.9.1


