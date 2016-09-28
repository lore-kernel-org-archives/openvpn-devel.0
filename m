From: Steffan Karger <steffan@...1856...>
Date: Wed, 28 Sep 2016 11:33:51 +0200
Message-Id: <1475055231-1778-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Make sure options->ciphername and
	options->authname are always defined
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

The NCP code does a strcmp(options->ciphername, ...) without first checking
whether options->ciphername is NULL.  This could cause a crash when using
"--cipher none".  This patch fixes that problem by ensuring that
options->ciphername (and options->authname) are never NULL.  Ensuring that
options->ciphername is never null prevents us from having to write null
checks everywhere.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c  | 7 +++++--
 src/openvpn/init.c    | 2 +-
 src/openvpn/options.c | 8 --------
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 1b17f9d..3dd4a9e 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -759,8 +759,11 @@ init_key_type (struct key_type *kt, const char *ciphername,
 {
   bool aead_cipher = false;
 
+  ASSERT(ciphername);
+  ASSERT(authname);
+
   CLEAR (*kt);
-  if (ciphername)
+  if (strcmp (ciphername, "none") != 0)
     {
       kt->cipher = cipher_kt_get (translate_cipher_name_from_openvpn(ciphername));
       if (!kt->cipher)
@@ -790,7 +793,7 @@ init_key_type (struct key_type *kt, const char *ciphername,
       if (warn)
 	msg (M_WARN, "******* WARNING *******: null cipher specified, no encryption will be used");
     }
-  if (authname)
+  if (strcmp (authname, "none") != 0)
     {
       if (!aead_cipher) { /* Ignore auth for AEAD ciphers */
 	kt->digest = md_kt_get (authname);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9cbbe9d..49f4220 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2259,7 +2259,7 @@ do_init_crypto_tls_c1 (struct context *c)
 
 	  /* Initialize key_type for tls-auth with auth only */
 	  CLEAR (c->c1.ks.tls_auth_key_type);
-	  if (options->authname)
+	  if (!streq (options->authname, "none"))
 	    {
 	      c->c1.ks.tls_auth_key_type.digest = md_kt_get (options->authname);
 	      c->c1.ks.tls_auth_key_type.hmac_length =
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1358237..53b4617 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6653,19 +6653,11 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->authname = p[1];
-      if (streq (options->authname, "none"))
-	{
-	  options->authname = NULL;
-	}
     }
   else if (streq (p[0], "cipher") && p[1] && !p[2])
     {
       VERIFY_PERMISSION (OPT_P_NCP);
       options->ciphername = p[1];
-      if (streq (options->ciphername, "none"))
-	{
-	  options->ciphername = NULL;
-	}
     }
   else if (streq (p[0], "ncp-ciphers") && p[1] && !p[2])
     {
-- 
2.7.4


