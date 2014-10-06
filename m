Message-ID: <5432E951.6020405@...1435...>
Date: Mon, 6 Oct 2014 21:11:13 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090009090308010801080703"
Subject: [Openvpn-devel] [PATCH] Fix regression with password protected
	private keys (polarssl)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--------------090009090308010801080703
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

Between versions 1.2.7 and 1.2.8, polarssl changed the errors returned
by the X509 parsing functions, which broke the OpenVPN implementation
for password protected private keys in polarssl builds. Later, for
polarssl 1.3, the return codes changed again.

The attached patches fix the regression by checking for the new errors
in OpenVPN. Since the 2.3 and master code is slightly different here, I
made a patch for each branch.

The polarssl change for 1.2.8:
https://github.com/polarssl/polarssl/commit/b495d3a

An later for polarssl 1.3 (search for pk_parse_key()):
https://github.com/polarssl/polarssl/commit/1a7550a

-Steffan

--------------090009090308010801080703
Content-Type: text/x-patch;
	name="2.3-Fix-regression-with-password-protected-private-keys-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="2.3-Fix-regression-with-password-protected-private-keys-.pat";
	filename*1="ch"

From 3c6c25b8c2270ad0af71a8837b60ea40ecfe66be Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 19 Sep 2014 06:43:48 +0200
Subject: [PATCH (2.3)] Fix regression with password protected private keys
 (polarssl)

Between versions 1.2.7 and 1.2.8, polarssl changed the errors
returned by the X509 parsing functions, which broke the OpenVPN
implementation for password protected private keys in polarssl
builds. This patch fixes that by checking for the new errors in
OpenVPN.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_polarssl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index e3e3017..aba405b 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -273,7 +273,7 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
       status = x509parse_key(ctx->priv_key,
 	  priv_key_file_inline, strlen(priv_key_file_inline),
 	  NULL, 0);
-      if (POLARSSL_ERR_PEM_PASSWORD_REQUIRED == status)
+      if (POLARSSL_ERR_X509_PASSWORD_REQUIRED == status)
 	{
 	  char passbuf[512] = {0};
 	  pem_password_callback(passbuf, 512, 0, NULL);
@@ -285,7 +285,7 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
   else
     {
       status = x509parse_keyfile(ctx->priv_key, priv_key_file, NULL);
-      if (POLARSSL_ERR_PEM_PASSWORD_REQUIRED == status)
+      if (POLARSSL_ERR_X509_PASSWORD_REQUIRED == status)
 	{
 	  char passbuf[512] = {0};
 	  pem_password_callback(passbuf, 512, 0, NULL);
@@ -295,7 +295,7 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
   if (0 != status)
     {
 #ifdef ENABLE_MANAGEMENT
-      if (management && (POLARSSL_ERR_PEM_PASSWORD_MISMATCH == status))
+      if (management && (POLARSSL_ERR_X509_PASSWORD_MISMATCH == status))
 	  management_auth_failure (management, UP_TYPE_PRIVATE_KEY, NULL);
 #endif
       msg (M_WARN, "Cannot load private key file %s", priv_key_file);
-- 
1.9.1


--------------090009090308010801080703
Content-Type: text/x-patch;
	name="master-Fix-regression-with-password-protected-private-keys-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="master-Fix-regression-with-password-protected-private-keys-.";
	filename*1="patch"

From 5671a73039e94df29fbe07b8250284366ebcda7d Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 19 Sep 2014 06:19:13 +0200
Subject: [PATCH (master)] Fix regression with password protected private keys
 (polarssl)

Between versions 1.2 and 1.3, polarssl changed the errors
returned by the X509 parsing functions, which broke the OpenVPN
implementation for password protected private keys in polarssl
builds. This patch fixes that by checking for the new errors in
OpenVPN.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_polarssl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 102a5a4..94ae4c3 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -298,7 +298,7 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
 	  (const unsigned char *) priv_key_inline, strlen(priv_key_inline),
 	  NULL, 0);
 
-      if (POLARSSL_ERR_PEM_PASSWORD_REQUIRED == status)
+      if (POLARSSL_ERR_PK_PASSWORD_REQUIRED == status)
 	{
 	  char passbuf[512] = {0};
 	  pem_password_callback(passbuf, 512, 0, NULL);
@@ -310,7 +310,7 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
   else
     {
       status = pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL);
-      if (POLARSSL_ERR_PEM_PASSWORD_REQUIRED == status)
+      if (POLARSSL_ERR_PK_PASSWORD_REQUIRED == status)
 	{
 	  char passbuf[512] = {0};
 	  pem_password_callback(passbuf, 512, 0, NULL);
@@ -320,7 +320,7 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
   if (0 != status)
     {
 #ifdef ENABLE_MANAGEMENT
-      if (management && (POLARSSL_ERR_PEM_PASSWORD_MISMATCH == status))
+      if (management && (POLARSSL_ERR_PK_PASSWORD_MISMATCH == status))
 	  management_auth_failure (management, UP_TYPE_PRIVATE_KEY, NULL);
 #endif
       msg (M_WARN, "Cannot load private key file %s", priv_key_file);
-- 
1.9.1


--------------090009090308010801080703--

