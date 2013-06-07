From: David Sommerseth <dazo@...384...>
Date: Fri,  7 Jun 2013 12:15:23 +0200
Message-Id: <1370600123-6029-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 2/3] Remove the --disable-eurephia configure
	option
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

From: David Sommerseth <davids@...1347...>

This "feature" has been enabled since OpenVPN 2.2 without any reports that
this has been causing issues.  All it does is to add an extra environment
variable 'tls_digest_{n}' with the certificate SHA1 fingerprint/digest hash.

Lets just simplify things by removing the possibility to disable this
environment variable.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 INSTALL                  |    2 --
 configure.ac             |    8 --------
 src/openvpn/options.c    |    7 +------
 src/openvpn/ssl.c        |    5 +----
 src/openvpn/ssl_verify.c |    2 --
 5 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/INSTALL b/INSTALL
index ed69667..61dc975 100644
--- a/INSTALL
+++ b/INSTALL
@@ -169,8 +169,6 @@ OPTIONS for ./configure:
   --disable-server        disable server support only (but retain client
                           support) [default=yes]
   --disable-plugins       disable plug-in support [default=yes]
-  --disable-eurephia      disable support for the eurephia plug-in
-                          [default=yes]
   --disable-management    disable management server support [default=yes]
   --enable-pkcs11         enable pkcs11 support [default=no]
   --disable-socks         disable Socks support [default=yes]
diff --git a/configure.ac b/configure.ac
index 5da5772..b1dd30e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -101,13 +101,6 @@ AC_ARG_ENABLE(
 )
 
 AC_ARG_ENABLE(
-	[eurephia],
-	[AS_HELP_STRING([--disable-eurephia], [disable support for the eurephia plug-in @<:@default=yes@:>@])],
-	,
-	[enable_eurephia="yes"]
-)
-
-AC_ARG_ENABLE(
 	[management],
 	[AS_HELP_STRING([--disable-management], [disable management server support @<:@default=yes@:>@])],
 	,
@@ -1020,7 +1013,6 @@ fi
 if test "${enable_plugins}" = "yes"; then
 	OPTIONAL_DL_LIBS="${DL_LIBS}"
 	AC_DEFINE([ENABLE_PLUGIN], [1], [Enable systemd support])
-	test "${enable_eurephia}" = "yes" && AC_DEFINE([ENABLE_EUREPHIA], [1], [Enable support for the eurephia plug-in])
 else
 	enable_plugin_auth_pam="no"
 	enable_plugin_down_root="no"
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8975bbc..500ae75 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6,9 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *
- *  Additions for eurephia plugin done by:
- *         David Sommerseth <dazo@...384...> Copyright (C) 2009
+ *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -107,9 +105,6 @@ const char title_string[] =
 #ifdef ENABLE_PKCS11
   " [PKCS11]"
 #endif
-#ifdef ENABLE_EUREPHIA
-  " [eurephia]"
-#endif
 #if ENABLE_IP_PKTINFO
   " [MH]"
 #endif
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d9076f3..657d31f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -7,10 +7,7 @@
  *
  *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
- *  Additions for eurephia plugin done by:
- *         David Sommerseth <dazo@...384...> Copyright (C) 2008-2009
- *
+ *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index e651a8e..0670f2a 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -425,7 +425,6 @@ verify_cert_set_env(struct env_set *es, openvpn_x509_cert_t *peer_cert, int cert
   setenv_str (es, envname, common_name);
 #endif
 
-#ifdef ENABLE_EUREPHIA
   /* export X509 cert SHA1 fingerprint */
   {
     unsigned char *sha1_hash = x509_get_sha1_hash(peer_cert, &gc);
@@ -434,7 +433,6 @@ verify_cert_set_env(struct env_set *es, openvpn_x509_cert_t *peer_cert, int cert
     setenv_str (es, envname, format_hex_ex(sha1_hash, SHA_DIGEST_LENGTH, 0, 1,
 					  ":", &gc));
   }
-#endif
 
   /* export serial number as environmental variable */
   serial = x509_get_serial(peer_cert, &gc);
-- 
1.7.10.2


