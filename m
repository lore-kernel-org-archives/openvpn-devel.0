Message-ID: <4F4BE07E.70603@...1550...>
Date: Mon, 27 Feb 2012 23:58:54 +0400
From: Igor Novgorodov <igor@...1550...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080706070402040502000606"
Subject: [Openvpn-devel] [PATCH 01/02] Add support for PolarSSL 1.1.x branch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080706070402040502000606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Continuing to struggle with making OpenVPN as tiny as possible :)

The attached patch adds checking for PolarSSL version on 
crypto_polarssl.c and depending
on which version we are using (1.0.x or 1.1.x) chooses a new shiny 
havege_random() function,
or an old ugly while{} loop hack to generate randomness.

--------------080706070402040502000606
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="001-polarssl-havege-random.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="001-polarssl-havege-random.patch"

--- a/crypto_polarssl.c
+++ b/crypto_polarssl.c
@@ -41,6 +41,7 @@
 #include <polarssl/md5.h>
 #include <polarssl/cipher.h>
 #include <polarssl/havege.h>
+#include <polarssl/version.h>
 
 /*
  *
@@ -157,25 +158,24 @@
 rand_bytes (uint8_t *output, int len)
 {
   static havege_state hs = {0};
-  static bool hs_initialised = false;
-  const int int_size = sizeof(int);
 
-  if (!hs_initialised)
-    {
-      /* Initialise PolarSSL RNG */
-      havege_init(&hs);
-      hs_initialised = true;
-    }
+  /* Initialise PolarSSL RNG */
+  havege_init(&hs);
+#if (POLARSSL_VERSION_MAJOR >= 1 && POLARSSL_VERSION_MINOR >= 1)
+  havege_random(&hs, output, len);
+#else
+  const int int_size = sizeof(int);
 
   while (len > 0)
     {
-      const int blen 	= min_int (len, int_size);
-      const int rand_int 	= havege_rand(&hs);
+      const int blen    = min_int (len, int_size);
+      const int rand_int        = havege_rand(&hs);
 
       memcpy (output, &rand_int, blen);
       output += blen;
       len -= blen;
     }
+#endif
   return 1;
 }
 

--------------080706070402040502000606--

