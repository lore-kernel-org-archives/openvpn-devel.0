Message-ID: <53BED57C.7070300@...1435...>
Date: Thu, 10 Jul 2014 20:03:40 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040406050603030202080300"
Subject: [Openvpn-devel] [PATCH] Don't exit daemon if opening or parsing the
	CRL fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--------------040406050603030202080300
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

Attached two patches, one for the release/2.3 branch, and one for the
master branch.

As requested in trac ticket #83, the daemon should not exit if opening
the CRL file during a connection attempt fails; OpenVPN should merely
deny the connection.

CRL files need to be periodically updated. When users update their CRL
in place and a connection attempt takes place simultaneously, the CRL
file might temporarily not be available, or not be in a consistent
state. Previously, that would result in the daemon exiting. With this
patch, that results in one (or possibly a few) failed connection
attempts, but service will restore automatically as soon as the CRL is
again available in a valid state.

Note that on startup OpenVPN still checks the existence and
accessibility of the CRL file, and will refuse to start on error.

While I was touching the code, I improved error reporting for the
PolarSSL code a bit. The polar code opens and parses the CRL in a single
call, so on error retrieve details from polarssl and report those to the
user.

-Steffan

--------------040406050603030202080300
Content-Type: text/x-patch;
	name="2.3-Don-t-exit-daemon-if-opening-or-parsing-the-CRL-fail.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="2.3-Don-t-exit-daemon-if-opening-or-parsing-the-CRL-fail.pat";
	filename*1="ch"

From 5ab41a0c45b24abd3e83b88435e7f275117e299e Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan.karger@...1435...>
Date: Sun, 6 Jul 2014 11:34:34 +0200
Subject: [PATCH] Don't exit daemon if opening or parsing the CRL fails.

As requested in trac ticket #83, the daemon should not exit if opening the
CRL file during a connection attempt fails; OpenVPN should merely deny the
connection.

CRL files need to be periodically updated. When users update their CRL in
place and a connection attempt takes place simultaneously, the CRL file
might temporarily not be available, or not be in a consistent state.
Previously, that would result in the daemon exiting. With this patch, that
results in one (or possibly a few) failed connection attempts, but service
will restore automatically as soon as the CRL is again available in a valid
state.

Note that on startup OpenVPN still checks the existence and accessibility
of the CRL file, and will refuse to start on error.

While I was touching the code, I improved error reporting for the PolarSSL
code a bit. The polar code opens and parses the CRL in a single call, so
on error retrieve details from polarssl and report those to the user.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_verify_openssl.c  | 4 ++--
 src/openvpn/ssl_verify_polarssl.c | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 9b712e1..3f7c3f7 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -645,12 +645,12 @@ x509_verify_crl(const char *crl_file, X509 *peer_cert, const char *subject)
   in = BIO_new_file (crl_file, "r");
 
   if (in == NULL) {
-    msg (M_ERR, "CRL: cannot read: %s", crl_file);
+    msg (M_WARN, "CRL: cannot read: %s", crl_file);
     goto end;
   }
   crl=PEM_read_bio_X509_CRL(in,NULL,NULL,NULL);
   if (crl == NULL) {
-    msg (M_ERR, "CRL: cannot read CRL from file %s", crl_file);
+    msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
     goto end;
   }
 
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index a53d3dc..8b9e4d1 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -440,9 +440,12 @@ x509_verify_crl(const char *crl_file, x509_cert *cert, const char *subject)
   result_t retval = FAILURE;
   x509_crl crl = {0};
 
-  if (x509parse_crlfile(&crl, crl_file) != 0)
+  int polar_retval = x509parse_crlfile(&crl, crl_file);
+  if (polar_retval != 0)
     {
-      msg (M_ERR, "CRL: cannot read CRL from file %s", crl_file);
+      char errstr[128];
+      error_strerror(polar_retval, errstr, sizeof(errstr));
+      msg (M_WARN, "CRL: cannot read CRL from file %s (%s)", crl_file, errstr);
       goto end;
     }
 
-- 
1.9.1


--------------040406050603030202080300
Content-Type: text/x-patch;
	name="master-Don-t-exit-daemon-if-opening-or-parsing-the-CRL-fail.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="master-Don-t-exit-daemon-if-opening-or-parsing-the-CRL-fail.";
	filename*1="patch"

From 70d6d8a26d891565862d20f6daa3e766698b68da Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan.karger@...1435...>
Date: Sun, 6 Jul 2014 11:27:21 +0200
Subject: [PATCH] Don't exit daemon if opening or parsing the CRL fails.

As requested in trac ticket #83, the daemon should not exit if opening the
CRL file during a connection attempt fails; OpenVPN should merely deny the
connection.

CRL files need to be periodically updated. When users update their CRL in
place and a connection attempt takes place simultaneously, the CRL file
might temporarily not be available, or not be in a consistent state.
Previously, that would result in the daemon exiting. With this patch, that
results in one (or possibly a few) failed connection attempts, but service
will restore automatically as soon as the CRL is again available in a valid
state.

Note that on startup OpenVPN still checks the existence and accessibility
of the CRL file, and will refuse to start on error.

While I was touching the code, I improved error reporting for the PolarSSL
code a bit. The polar code opens and parses the CRL in a single call, so
on error retrieve details from polarssl and report those to the user.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_verify_openssl.c  | 4 ++--
 src/openvpn/ssl_verify_polarssl.c | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 2482eaa..cbcff02 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -591,12 +591,12 @@ x509_verify_crl(const char *crl_file, X509 *peer_cert, const char *subject)
   in = BIO_new_file (crl_file, "r");
 
   if (in == NULL) {
-    msg (M_ERR, "CRL: cannot read: %s", crl_file);
+    msg (M_WARN, "CRL: cannot read: %s", crl_file);
     goto end;
   }
   crl=PEM_read_bio_X509_CRL(in,NULL,NULL,NULL);
   if (crl == NULL) {
-    msg (M_ERR, "CRL: cannot read CRL from file %s", crl_file);
+    msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
     goto end;
   }
 
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 7e8b517..2b7c214 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -371,9 +371,12 @@ x509_verify_crl(const char *crl_file, x509_crt *cert, const char *subject)
   result_t retval = FAILURE;
   x509_crl crl = {0};
 
-  if (x509_crl_parse_file(&crl, crl_file) != 0)
+  int polar_retval = x509_crl_parse_file(&crl, crl_file);
+  if (polar_retval != 0)
     {
-      msg (M_ERR, "CRL: cannot read CRL from file %s", crl_file);
+      char errstr[128];
+      polarssl_strerror(polar_retval, errstr, sizeof(errstr));
+      msg (M_WARN, "CRL: cannot read CRL from file %s (%s)", crl_file, errstr);
       goto end;
     }
 
-- 
1.9.1


--------------040406050603030202080300--

