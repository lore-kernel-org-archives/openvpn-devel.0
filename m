From: Steffan Karger <steffan@...1856...>
Date: Sat, 25 Oct 2014 22:35:24 +0200
Message-Id: <1414269324-14102-7-git-send-email-steffan@...1856...>
In-Reply-To: <1414269324-14102-1-git-send-email-steffan@...1856...>
References: <1414269324-14102-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 6/6] openssl: add more descriptive message
	for "no shared cipher" error
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

Overzealous users using the --tls-cipher option, or users with actual
incompatible crypto libaries often waste quite some time debugging the
"no shared cipher" error from openssl. See e.g. trac ticket #359:
https://community.openvpn.net/openvpn/ticket/359

This change adds a more clear, verb 1 error message reporting the problem
directly to the user, instead of just printing the openssl error.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_openssl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 114a856..6c02d9c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -45,6 +45,7 @@
 #include <openssl/objects.h>
 #include <openssl/evp.h>
 #include <openssl/des.h>
+#include <openssl/ssl.h>
 
 /*
  * Check for key size creepage.
@@ -201,7 +202,18 @@ crypto_print_openssl_errors(const unsigned int flags) {
   size_t err = 0;
 
   while ((err = ERR_get_error ()))
-    msg (flags, "OpenSSL: %s", ERR_error_string (err, NULL));
+    {
+      /* Be more clear about frequently occurring "no shared cipher" error */
+      if (err == ERR_PACK(ERR_LIB_SSL,SSL_F_SSL3_GET_CLIENT_HELLO,
+	  SSL_R_NO_SHARED_CIPHER))
+	{
+	  msg (D_CRYPT_ERRORS, "TLS error: The server has no TLS ciphersuites "
+	      "in common with the client. Your --tls-cipher setting might be "
+	      "too restrictive.");
+	}
+
+      msg (flags, "OpenSSL: %s", ERR_error_string (err, NULL));
+    }
 }
 
 
-- 
1.9.1


