Message-ID: <53BAEF65.2070509@...1856...>
Date: Mon, 07 Jul 2014 21:05:09 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1402244175-31462-1-git-send-email-steffan@...1856...>
	<1402244175-31462-4-git-send-email-steffan@...1856...>
	<53BA6036.3030305@...1227...> <53BADAE4.5040903@...1856...>
	<53BADE4A.4040609@...1227...> <53BAE57F.3030503@...1856...>
In-Reply-To: <53BAE57F.3030503@...1856...>
Content-Type: multipart/mixed; boundary="------------050702000107080804040508"
Subject: Re: [Openvpn-devel] [PATCH 3/4] Improve --show-ciphers to show if a
 cipher can be used in static key mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050702000107080804040508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 07-07-14 20:22, Steffan Karger wrote:
> On 07-07-14 19:52, Arne Schwabe wrote:
>> Am 07.07.14 19:37, schrieb Steffan Karger:
>>> On 07-07-14 10:54, Arne Schwabe wrote:
>>>> Am 08.06.14 18:16, schrieb Steffan Karger:
>>>>> Also remove the bulky warning from init_key_type() and add the information
>>>>> to the --show-ciphers output.
>>>>>
>>>> It does what it says but I think most users will be confused about what
>>>> (SSL mode only) is about. Most people which are not familar with openvpn
>>>> will not parse it as "non --static mode".
>>> Hmm, you're right. I'm not very good at this sort of thing. What about
>>> "(no static key mode)"? Any other suggestions?
>>>
>> Maybe (tls-client/tls-server mode only) or (Not in --static mode)? That
>> way the users knows what option you are referring to?
> 
> Well, users will probably use 'client' or 'server' in their configs,
> which expands to tls-client or tls-server. Also, --static is actually
> called --secret, which is not very descriptive either (otherwise that
> would be great). Gah.
> 
> So, "(client/server mode only)"?

After some discussion on IRC, settled for "(TLS client/server mode)".
Updated patch attached.

-Steffan

--------------050702000107080804040508
Content-Type: text/x-patch;
	name="0003-Improve-show-ciphers-to-show-if-a-cipher-can-be-used.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0003-Improve-show-ciphers-to-show-if-a-cipher-can-be-used.pa";
	filename*1="tch"

From 630ecfa6a73a99e2d2b4498c9706ba0cbe1478e7 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Sun, 8 Jun 2014 17:04:32 +0200
Subject: [PATCH 3/4] Improve --show-ciphers to show if a cipher can be used in
 static key mode

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
index 1159299..0ac89a1 100644
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
+		  " (TLS client/server mode)" : "";
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


--------------050702000107080804040508--

