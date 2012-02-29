From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:34 +0200
Message-Id: <1330546342-17794-5-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 04/52] cleanup: remove C++ warnings
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 httpdigest.c   |    4 ++--
 init.c         |    2 +-
 misc.c         |    6 +++---
 options.c      |    4 ++--
 socket.c       |    4 ++--
 ssl_polarssl.c |    6 ++++--
 6 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/httpdigest.c b/httpdigest.c
index 5907637..1aa19ae 100644
--- a/httpdigest.c
+++ b/httpdigest.c
@@ -111,7 +111,7 @@ DigestCalcResponse(
   md_ctx_t md5_ctx;
   const md_kt_t *md5_kt = md_kt_get("MD5");
 
-  // calculate H(A2)
+  /* calculate H(A2) */
   md_ctx_init(&md5_ctx, md5_kt);
   md_ctx_update(&md5_ctx, pszMethod, strlen(pszMethod));
   md_ctx_update(&md5_ctx, ":", 1);
@@ -124,7 +124,7 @@ DigestCalcResponse(
   md_ctx_final(&md5_ctx, HA2);
   CvtHex(HA2, HA2Hex);
 
-  // calculate response
+  /* calculate response */
   md_ctx_init(&md5_ctx, md5_kt);
   md_ctx_update(&md5_ctx, HA1, HASHHEXLEN);
   md_ctx_update(&md5_ctx, ":", 1);
diff --git a/init.c b/init.c
index fb8fe00..d2ad318 100644
--- a/init.c
+++ b/init.c
@@ -745,7 +745,7 @@ init_static (void)
     uint8_t rndbuf[8];
     int i;
     prng_init ("sha1", 16);
-    //prng_init (NULL, 0);
+    /*prng_init (NULL, 0);*/
     const int factor = 1;
     for (i = 0; i < factor * 8; ++i)
       {
diff --git a/misc.c b/misc.c
index a07780f..2a1c1c9 100644
--- a/misc.c
+++ b/misc.c
@@ -2457,17 +2457,17 @@ argv_test (void)
   argv_printf (&a, "%sc foo bar %s", "c:\\\\src\\\\test\\\\jyargs.exe", "foo bar");
   argv_msg_prefix (M_INFO, &a, "ARGV");
   msg (M_INFO, "ARGV-S: %s", argv_system_str(&a));
-  //openvpn_execve_check (&a, NULL, 0, "command failed");
+  /*openvpn_execve_check (&a, NULL, 0, "command failed");*/
 
   argv_printf (&a, "%sc %s %s", "c:\\\\src\\\\test files\\\\batargs.bat", "foo", "bar");  
   argv_msg_prefix (M_INFO, &a, "ARGV");
   msg (M_INFO, "ARGV-S: %s", argv_system_str(&a));
-  //openvpn_execve_check (&a, NULL, 0, "command failed");
+  /*openvpn_execve_check (&a, NULL, 0, "command failed");*/
 
   argv_printf (&a, "%s%sc foo bar %s %s/%d %d %u", "/foo", "/bar.exe", "one two", "1.2.3.4", 24, -69, 96);
   argv_msg_prefix (M_INFO, &a, "ARGV");
   msg (M_INFO, "ARGV-S: %s", argv_system_str(&a));
-  //openvpn_execve_check (&a, NULL, 0, "command failed");
+  /*openvpn_execve_check (&a, NULL, 0, "command failed");*/
 
   argv_printf (&a, "this is a %s test of int %d unsigned %u", "FOO", -69, 42);
   s = argv_str (&a, &gc, PA_BRACKET);
diff --git a/options.c b/options.c
index 3d8085c..f11849d 100644
--- a/options.c
+++ b/options.c
@@ -4764,7 +4764,7 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "fragment") && p[1])
     {
-//      VERIFY_PERMISSION (OPT_P_MTU);
+/*      VERIFY_PERMISSION (OPT_P_MTU); */
       VERIFY_PERMISSION (OPT_P_MTU|OPT_P_CONNECTION);
       options->ce.fragment = positive_atoi (p[1]);
     }
@@ -5118,7 +5118,7 @@ add_option (struct options *options,
   else if (streq (p[0], "explicit-exit-notify"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-//      VERIFY_PERMISSION (OPT_P_EXPLICIT_NOTIFY);
+/*      VERIFY_PERMISSION (OPT_P_EXPLICIT_NOTIFY); */
       if (p[1])
 	{
 	  options->ce.explicit_exit_notification = positive_atoi (p[1]);
diff --git a/socket.c b/socket.c
index 1a772af..61265e4 100644
--- a/socket.c
+++ b/socket.c
@@ -3106,7 +3106,7 @@ openvpn_inet_ntop(int af, const void *src, char *dst, socklen_t size)
     default:
       ASSERT (0);
   }
-  // cannot direclty use &size because of strict aliasing rules
+  /* cannot direclty use &size because of strict aliasing rules */
   return (WSAAddressToString((struct sockaddr *)&ss, sizeof(ss), NULL, dst, &s) == 0)?
           dst : NULL;
 }
@@ -3119,7 +3119,7 @@ openvpn_inet_pton(int af, const char *src, void *dst)
   char src_copy[INET6_ADDRSTRLEN+1];
 
   CLEAR(ss);
-  // stupid non-const API
+  /* stupid non-const API */
   strncpynt(src_copy, src, INET6_ADDRSTRLEN+1);
 
   if (WSAStringToAddress(src_copy, af, NULL, (struct sockaddr *)&ss, &size) == 0) {
diff --git a/ssl_polarssl.c b/ssl_polarssl.c
index c50cf0a..02dc233 100644
--- a/ssl_polarssl.c
+++ b/ssl_polarssl.c
@@ -324,8 +324,10 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file
   warn_if_group_others_accessible (priv_key_file);
 
   /* TODO: Check Private Key */
-//  if (!SSL_CTX_check_private_key (ctx))
-//    msg (M_SSLERR, "Private key does not match the certificate");
+#if 0
+  if (!SSL_CTX_check_private_key (ctx))
+    msg (M_SSLERR, "Private key does not match the certificate");
+#endif
   return 0;
 }
 
-- 
1.7.3.4


