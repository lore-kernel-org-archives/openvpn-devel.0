From: Steffan Karger <steffan@...1856...>
Date: Tue,  8 Aug 2017 22:00:47 +0200
Message-Id: <1502222447-8186-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (2.3)] Deprecate --ns-cert-type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This is a manual cherry-pick of commit 2dc33226 of the master branch,
for the release/2.3 branch.

The nsCertType x509 extension is very old, and barely used.  We already
have had an alternative for a long time: --remote-cert-tls uses the far
more common keyUsage and extendedKeyUsage extensions instead.

OpenSSL 1.1 no longer exposes an API to (separately) check the nsCertType
x509 extension.  Since we want be able to migrate to OpenSSL 1.1, we
should deprecate this option immediately.

Trac: #876

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst              | 12 ++++++++++++
 doc/openvpn.8            |  8 ++++++--
 src/openvpn/init.c       |  4 ++++
 src/openvpn/options.c    |  4 ++--
 tests/t_client.rc-sample |  2 +-
 5 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index b9fe6d5..3d164b9 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -105,6 +105,18 @@ Behavioral changes
 - Do not randomize resolving of IP addresses in getaddr()
 
 
+Version 2.3.18
+==============
+
+Deprecated features
+-------------------
+- ``--ns-cert-type`` is deprecated.  Use ``--remote-cert-tls`` instead.
+  The nsCertType x509 extension is very old, and barely used.
+  ``--remote-cert-tls`` uses the far more common keyUsage and extendedKeyUsage
+  extension instead.  Make sure your certificates carry these to be able to
+  use ``--remote-cert-tls``.
+
+
 Version 2.3.17
 ==============
 
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 109afe6..c6389f1 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -324,7 +324,7 @@ http-proxy-retry
 persist-key
 persist-tun
 pkcs12 client.p12
-ns-cert-type server
+remote-cert-tls server
 verb 3
 .in -4
 .ft
@@ -5094,7 +5094,11 @@ options can be defined to track multiple attributes.
 Not available with PolarSSL.
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
index c6546e6..f676b51 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2591,6 +2591,10 @@ do_option_warnings (struct context *c)
       && !(o->ns_cert_type & NS_CERT_CHECK_SERVER)
       && !o->remote_cert_eku)
     msg (M_WARN, "WARNING: No server certificate verification method has been enabled.  See http://openvpn.net/howto.html#mitm for more info.");
+  if (o->ns_cert_type)
+    {
+      msg(M_WARN, "WARNING: --ns-cert-type is DEPRECATED.  Use --remote-cert-tls instead.");
+    }
 #endif
 #endif
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6faa280..20ca37e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -622,8 +622,8 @@ static const char usage_message[] =
   "--verify-x509-name name: Accept connections only from a host with X509 subject\n"
   "                  DN name. The remote host must also pass all other tests\n"
   "                  of verification.\n"
-  "--ns-cert-type t: Require that peer certificate was signed with an explicit\n"
-  "                  nsCertType designation t = 'client' | 'server'.\n"
+  "--ns-cert-type t: (DEPRECATED) Require that peer certificate was signed with \n"
+  "                  an explicit nsCertType designation t = 'client' | 'server'.\n"
 #ifdef ENABLE_X509_TRACK
   "--x509-track x  : Save peer X509 attribute x in environment for use by\n"
   "                  plugins and management interface.\n"
diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index 59f34c7..78b0ebb 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -39,7 +39,7 @@ TEST_RUN_LIST="1 2"
 #
 OPENVPN_BASE_P2MP="--client --ca $CA_CERT \
 	--cert $CLIENT_CERT --key $CLIENT_KEY \
-	--ns-cert-type server --nobind --comp-lzo --verb 3"
+	--remote-cert-tls server --nobind --comp-lzo --verb 3"
 
 # base config for p2p tests
 #
-- 
2.7.4


