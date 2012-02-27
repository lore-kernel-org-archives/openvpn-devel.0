Message-ID: <4F4BE238.502@...1550...>
Date: Tue, 28 Feb 2012 00:06:16 +0400
From: Igor Novgorodov <igor@...1550...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060602040504050501060103"
Subject: [Openvpn-devel] [PATCH 02/02] Remove calls to OpenSSL when building
	with --disable-ssl
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
--------------060602040504050501060103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch removes deprecated(?) calls to OpenSSL functions from 
crypro.c,
which are called when USE_SSL is not defined.

I'm not so deep into OpenVPN, so maybe these functions are needed, but i 
thought that all crypto-lib
dependent functions should be moved to the corresponding crypto_LIB.c files.

If they are needed, we should #ifdef them, so that PolarSSL-based build 
won't break on it.

--------------060602040504050501060103
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="002-nossl-disable-openssl-functions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="002-nossl-disable-openssl-functions.patch"

--- openvpn/crypto.c	2012-02-27 23:10:53.613624010 +0400
+++ openvpn.mod/crypto.c	2012-02-27 23:45:02.128929211 +0400
@@ -1378,8 +1378,6 @@
 void
 init_ssl_lib (void)
 {
-  ERR_load_crypto_strings ();
-  OpenSSL_add_all_algorithms ();
   crypto_init_lib ();
 }
 
@@ -1388,8 +1386,6 @@
 {
   crypto_uninit_lib ();
   prng_uninit();
-  EVP_cleanup ();
-  ERR_free_strings ();
 }
 
 #endif /* USE_SSL */

--------------060602040504050501060103--

