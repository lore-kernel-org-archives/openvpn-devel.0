Message-ID: <516BCEA2.6000608@...1435...>
Date: Mon, 15 Apr 2013 11:55:46 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <20130414100733.GL569@...1296...>
In-Reply-To: <20130414100733.GL569@...1296...>
Content-Type: multipart/mixed; boundary="------------010507060700060505030103"
Subject: Re: [Openvpn-devel] stray USE_SSL in crypto_openssl.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--------------010507060700060505030103
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi Gert,

On 04/14/2013 12:07 PM, Gert Doering wrote:
> this is something for Adriaan or Steffan, I think...  in crypto_openssl.c,
> we have two stray uses of #ifdef USE_SSL...
>
> void
> crypto_init_lib (void)
> {
> #ifndef USE_SSL
> #ifndef ENABLE_SMALL
>   ERR_load_crypto_strings ();
> #endif
>   OpenSSL_add_all_algorithms ();
> #endif
>
> ...
> void
> crypto_uninit_lib (void)
> {
> #ifndef USE_SSL
>   EVP_cleanup ();
> #ifndef ENABLE_SMALL
>   ERR_free_strings ();
> #endif
> #endif
>
>
> ... should this be ENABLE_SSL?  Or not be there at all?

It should indeed be ENABLE_SSL. The #ifndef confused me at first, so I
also added some comments to clarify.
> I won't claim to understand the code, but I can say for sure that we
> do not have a "USE_SSL" conditional anymore :-) - this is now ENABLE_SSL.
>
> Please check and send patch :-)

Yes sir ;) I attached the patch.

-Steffan

--------------010507060700060505030103
Content-Type: text/x-patch;
	name="0001-Fixed-usage-of-stale-define-USE_SSL-to-ENABLE_SSL.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-Fixed-usage-of-stale-define-USE_SSL-to-ENABLE_SSL.patch"

From a4d045dd3acd78999371db8d87c320aa0d0669e5 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 15 Apr 2013 10:45:28 +0200
Subject: [PATCH] Fixed usage of stale define USE_SSL to ENABLE_SSL

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 doc/doxygen/openvpn.doxyfile |    2 +-
 src/openvpn/crypto_openssl.c |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/doxygen/openvpn.doxyfile b/doc/doxygen/openvpn.doxyfile
index 5d87172..cf26c42 100644
--- a/doc/doxygen/openvpn.doxyfile
+++ b/doc/doxygen/openvpn.doxyfile
@@ -235,7 +235,7 @@ EXPAND_ONLY_PREDEF     = NO
 SEARCH_INCLUDES        = YES
 INCLUDE_PATH           =
 INCLUDE_FILE_PATTERNS  =
-PREDEFINED             = WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER USE_CRYPTO USE_SSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
+PREDEFINED             = WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER ENABLE_CRYPTO ENABLE_CRYPTO_OPENSSL ENABLE_SSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
 EXPAND_AS_DEFINED      =
 SKIP_FUNCTION_MACROS   = YES
 #---------------------------------------------------------------------------
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 21d1762..1501bc8 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -194,7 +194,8 @@ crypto_init_lib_engine (const char *engine_name)
 void
 crypto_init_lib (void)
 {
-#ifndef USE_SSL
+#ifndef ENABLE_SSL
+  /* If SSL is enabled init is taken care of in ssl_openssl.c */
 #ifndef ENABLE_SMALL
   ERR_load_crypto_strings ();
 #endif
@@ -215,7 +216,8 @@ crypto_init_lib (void)
 void
 crypto_uninit_lib (void)
 {
-#ifndef USE_SSL
+#ifndef ENABLE_SSL
+  /* If SSL is enabled cleanup is taken care of in ssl_openssl.c */
   EVP_cleanup ();
 #ifndef ENABLE_SMALL
   ERR_free_strings ();
-- 
1.7.9.5


--------------010507060700060505030103--

