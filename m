From: Steffan Karger <steffan@...1856...>
Date: Sun, 25 Dec 2016 23:38:25 +0100
Message-Id: <1482705505-20302-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Document that RSA_SIGN can also request TLS
	1.2 signatures
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

Ever since we support TLS 1.2 (OpenVPN 2.3.3+), the RSA_SIGN might not
only request MD5-SHA1 'TLS signatures', but also other variants.
Document this by updating the implementation hints, and explicitly
stating that we expect a PKCS#1 1.5 signature.

Trac: #764

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/management-notes.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index dd870eb..29c3aad 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -773,8 +773,9 @@ via a notification as follows:
 
 >RSA_SIGN:[BASE64_DATA]
 
-The management interface client should then sign BASE64_DATA
-using the private key and return the SSL signature as follows:
+The management interface client should then create a PKCS#1 v1.5 signature of
+the (decoded) BASE64_DATA using the private key and return the SSL signature as
+follows:
 
 rsa-sig
 [BASE64_SIG_LINE]
@@ -783,8 +784,8 @@ rsa-sig
 .
 END
 
-Base64 encoded output of RSA_sign(NID_md5_sha1,... will provide a
-correct signature.
+Base64 encoded output of RSA_private_encrypt() (OpenSSL) or mbedtls_pk_sign()
+(mbed TLS) will provide a correct signature.
 
 This capability is intended to allow the use of arbitrary cryptographic
 service providers with OpenVPN via the management interface.
-- 
2.7.4


