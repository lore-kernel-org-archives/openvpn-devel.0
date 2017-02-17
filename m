Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: logout@...260...
Date: Fri, 17 Feb 2017 23:00:53 +0100
Message-Id: <0e0d4a67192b563cd07d3f06685f85e34c304142.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [RFC PATCH v1 14/15] OpenSSL: check for the SSL
	reason, not the full error
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

From: Emmanuel Deloget <logout@...260...>

OpenSSL 1.1 changed the SSLv3 API and removed many SSL_L_SSL3_*
constants. Moreover, new code might use different function
code for the same error.

Thus, we extract the error reason from the error code before
we compare it instead of trying to rebuild an error code
that might not be correct.

The new version is compatible with OpenSSL 1.0.x as well as
with older versions (starting at 0.9.8).

Signed-off-by: Emmanuel Deloget <logout@...260...>
---
 src/openvpn/crypto_openssl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 2f77a9853ac484770dcd808efdf13671ade7e758..23de17542bf0f4a311825373ecf8d8261fd21c73 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -194,8 +194,7 @@ crypto_print_openssl_errors(const unsigned int flags)
     while ((err = ERR_get_error()))
     {
         /* Be more clear about frequently occurring "no shared cipher" error */
-        if (err == ERR_PACK(ERR_LIB_SSL,SSL_F_SSL3_GET_CLIENT_HELLO,
-                            SSL_R_NO_SHARED_CIPHER))
+        if (ERR_GET_REASON(err) == SSL_R_NO_SHARED_CIPHER)
         {
             msg(D_CRYPT_ERRORS, "TLS error: The server has no TLS ciphersuites "
                 "in common with the client. Your --tls-cipher setting might be "
-- 
2.7.4


