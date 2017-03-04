From: Steffan Karger <steffan@...1856...>
Date: Sat,  4 Mar 2017 19:49:57 +0100
Message-Id: <1488653397-2309-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Deprecate --ns-cert-type
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

The nsCertType x509 extension is very old, and barely used.  We already
have had an alternative for a long time: --remote-cert-tls uses the far
more common keyUsage and extendedKeyUsage extensions instead.

OpenSSL 1.1 longer exposes an API to (separately) check the nsCertType x509
extension.  Since we want be able to migrate to OpenSSL 1.1, we should
deprecate this option immediately.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst              | 13 +++++++++++--
 doc/openvpn.8            |  8 ++++++--
 src/openvpn/init.c       |  4 ++++
 src/openvpn/options.c    |  4 ++--
 tests/t_client.rc-sample |  2 +-
 5 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 7ffd89e..0af29e3 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -1,5 +1,5 @@
-Version 2.4.0
-=============
+Overview of changes in 2.4
+==========================
 
 
 New features
@@ -302,3 +302,12 @@ Maintainer-visible changes
   header combinations.  In most of these situations it is recommended to
   use -std=gnu99 in CFLAGS.  This is known to be needed when doing
   i386/i686 builds on RHEL5.
+
+
+Version 2.4.1
+=============
+ - ``--ns-cert-type`` is deprecated.  Use ``--remote-cert-tls`` instead.
+   The nsCertType x509 extension is very old, and barely used.
+   ``--remote-cert-tls`` uses the far more common keyUsage and extendedKeyUsage
+   extension instead.  Make sure your certificates carry these to be able to
+   use ``--remote-cert-tls``.
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index e3d603e..f6822ec 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -327,7 +327,7 @@ http\-proxy 192.168.0.8 8080
 persist\-key
 persist\-tun
 pkcs12 client.p12
-ns\-cert\-type server
+remote\-cert\-tls server
 verb 3
 .in -4
 .ft
@@ -5313,7 +5313,11 @@ as X509_<depth>_<attribute>=<value>.  Multiple
 options can be defined to track multiple attributes.
 .\"*********************************************************
 .TP
-.B \-\-ns\-cert\-type client|server
+.B \-\-ns\-cert\-type client|server (DEPRECATED)
+This option is deprecated.  Use the more modern equivalent
+.B \-\-remote\-cert\-tls
+instead.  This option will be removed in OpenVPN 2.5.
+
 Require that peer certificate was signed with an explicit
 .B nsCertType
 designation of "client" or "server".
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 975700b..5c34cda 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2979,6 +2979,10 @@ do_option_warnings(struct context *c)
     {
         msg(M_WARN, "WARNING: No server certificate verification method has been enabled.  See http://openvpn.net/howto.html#mitm for more info.");
     }
+    if (o->ns_cert_type)
+    {
+        msg(M_WARN, "WARNING: --ns-cert-type is DEPRECATED.  Use --remote-cert-tls instead.");
+    }
 #endif /* ifdef ENABLE_CRYPTO */
 
     /* If a script is used, print appropiate warnings */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0e6b393..1243db0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -635,8 +635,8 @@ static const char usage_message[] =
     "--verify-x509-name name: Accept connections only from a host with X509 subject\n"
     "                  DN name. The remote host must also pass all other tests\n"
     "                  of verification.\n"
-    "--ns-cert-type t: Require that peer certificate was signed with an explicit\n"
-    "                  nsCertType designation t = 'client' | 'server'.\n"
+    "--ns-cert-type t: (DEPRECATED) Require that peer certificate was signed with \n"
+    "                  an explicit nsCertType designation t = 'client' | 'server'.\n"
     "--x509-track x  : Save peer X509 attribute x in environment for use by\n"
     "                  plugins and management interface.\n"
 #if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x10001000
diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index 4fdea48..355e8bb 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -40,7 +40,7 @@ TEST_RUN_LIST="1 2"
 #
 OPENVPN_BASE_P2MP="--client --ca $CA_CERT \
 	--cert $CLIENT_CERT --key $CLIENT_KEY \
-	--ns-cert-type server --nobind --comp-lzo --verb 3"
+	--remote-cert-tls server --nobind --comp-lzo --verb 3"
 
 # base config for p2p tests
 #
-- 
2.7.4


