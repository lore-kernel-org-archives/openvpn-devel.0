From: Steffan Karger <steffan@...1856...>
Date: Sun,  8 Jun 2014 18:16:14 +0200
Message-Id: <1402244175-31462-4-git-send-email-steffan@...1856...>
In-Reply-To: <1402244175-31462-1-git-send-email-steffan@...1856...>
References: <1402244175-31462-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 3/4] Improve --show-ciphers to show if a
	cipher can be used in static key mode
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

Also remove the bulky warning from init_key_type() and add the information
to the --show-ciphers output.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c         |  4 ----
 src/openvpn/crypto_openssl.c | 19 +++++++++++++------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 2a863b9..ef2bde1 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -434,11 +434,7 @@ init_key_type (struct key_type *kt, const char *ciphername,
 	      || (cfb_ofb_allowed && cipher_kt_mode_ofb_cfb(kt->cipher))
 #endif
 	      ))
-#ifdef ENABLE_SMALL
 	  msg (M_FATAL, "Cipher '%s' mode not supported", ciphername);
-#else
-	  msg (M_FATAL, "Cipher '%s' uses a mode not supported by " PACKAGE_NAME " in your current configuration.  CBC mode is always supported, while CFB and OFB modes are supported only when using SSL/TLS authentication and key exchange mode, and when " PACKAGE_NAME " has been built with ALLOW_NON_CBC_CIPHERS.", ciphername);
-#endif
       }
     }
   else
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 1159299..579696e 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -40,6 +40,7 @@
 #include "basic.h"
 #include "buffer.h"
 #include "integer.h"
+#include "crypto.h"
 #include "crypto_backend.h"
 #include <openssl/objects.h>
 #include <openssl/evp.h>
@@ -253,7 +254,7 @@ show_available_ciphers ()
 	  "used as a parameter to the --cipher option.  The default\n"
 	  "key size is shown as well as whether or not it can be\n"
           "changed with the --keysize directive.  Using a CBC mode\n"
-	  "is recommended.\n\n");
+	  "is recommended. In static key mode only CBC mode is allowed.\n\n");
 #endif
 
   for (nid = 0; nid < 10000; ++nid)	/* is there a better way to get the size of the nid list? */
@@ -266,11 +267,17 @@ show_available_ciphers ()
 	      || cipher_kt_mode_ofb_cfb(cipher)
 #endif
 	      )
-	    printf ("%s %d bit default key (%s)\n",
-		    OBJ_nid2sn (nid),
-		    EVP_CIPHER_key_length (cipher) * 8,
-		    ((EVP_CIPHER_flags (cipher) & EVP_CIPH_VARIABLE_LENGTH) ?
-		     "variable" : "fixed"));
+	    {
+	      const char *var_key_size =
+		  (EVP_CIPHER_flags (cipher) & EVP_CIPH_VARIABLE_LENGTH) ?
+		       "variable" : "fixed";
+	      const char *ssl_only = cipher_kt_mode_ofb_cfb(cipher) ?
+		  " (SSL mode only)" : "";
+
+	      printf ("%s %d bit default key (%s)%s\n", OBJ_nid2sn (nid),
+		      EVP_CIPHER_key_length (cipher) * 8, var_key_size,
+		      ssl_only);
+	    }
 	}
     }
   printf ("\n");
-- 
1.9.1


