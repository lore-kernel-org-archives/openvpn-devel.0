From: Davide Brini <dave_br@...1278...>
Date: Tue, 27 Apr 2010 12:20:05 +0100
Message-Id: <1272367205-1912-1-git-send-email-dave_br@...1278...>
In-Reply-To: <4BD56520.9070807@...1114...>
References: <4BD56520.9070807@...1114...>
Subject: [Openvpn-devel] [PATCH] Serial number export, better
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

    contrib/OCSP_check/OCSP_check.sh:
             New barebone script to demonstrate how to use $tls_serial_{n}
             to perform simple OCSP queries using OpenSSL command line
             "openssl ocsp". Minimal sanity checks to fail if user tries to
             use it without customizing.

    openvpn.8:
             Added some notes about $tls_serial_{n} format and usage to the
             existing description.

    ssl.c:
             correctly manage and export serial numbers of any size (as
             parsed by OpenSSL) into the environment. Set to empty string
             in case of errors, as 0 and negative numbers are all possible
             (although illegal) certificate serial numbers. Use an OpenSSL
             BIO object to do the job. Conforms to coding style guidelines.

    See the discussion at

    http://article.gmane.org/gmane.network.openvpn.devel/3588

    for more details.

Signed-off-by: Davide Brini <dave_br@...1278...>
---
 contrib/OCSP_check/OCSP_check.sh |   89 ++++++++++++++++++++++++++++++++++++++
 openvpn.8                        |    7 +++-
 ssl.c                            |   27 ++++++++++-
 3 files changed, 119 insertions(+), 4 deletions(-)
 create mode 100644 contrib/OCSP_check/OCSP_check.sh

diff --git a/contrib/OCSP_check/OCSP_check.sh b/contrib/OCSP_check/OCSP_check.sh
new file mode 100644
index 0000000..2ffe5d6
--- /dev/null
+++ b/contrib/OCSP_check/OCSP_check.sh
@@ -0,0 +1,89 @@
+#!/bin/sh
+
+# Sample script to perform OCSP queries with OpenSSL
+# given a certificate serial number.
+
+# If you run your own CA, you can set up a very simple
+# OCSP server using the -port option to "openssl ocsp".
+
+# Full documentation and examples:
+# http://www.openssl.org/docs/apps/ocsp.html
+
+
+# Edit the following values to suit your needs
+
+# OCSP responder URL (mandatory)
+# YOU MUST UNCOMMENT ONE OF THESE AND SET IT TO A VALID SERVER
+#ocsp_url="http://ocsp.example.com/"
+#ocsp_url="https://ocsp.secure.example.com/"
+
+# Path to issuer certificate (mandatory)
+# YOU MUST SET THIS TO THE PATH TO THE CA CERTIFICATE
+issuer="/path/to/CAcert.crt"
+
+# use a nonce in the query, set to "-no_nonce" to not use it
+nonce="-nonce"
+
+# Verify the response
+# YOU MUST SET THIS TO THE PATH TO THE RESPONSE VERIFICATION CERT
+verify="/path/to/CAcert.crt"
+
+# Depth in the certificate chain where the cert to verify is.
+# Set to -1 to run the verification at every level (NOTE that
+# in that case you need a more complex script as the various
+# parameters for the query will likely be different at each level)
+# "0" is the usual value here, where the client certificate is
+check_depth=0
+
+cur_depth=$1     # this is the *CURRENT* depth
+common_name=$2   # CN in case you need it
+
+# minimal sanity checks
+
+err=0
+if [ -z "$issuer" ] || [ ! -e "$issuer" ]; then
+  echo "Error: issuer certificate undefined or not found!" >&2
+  err=1
+fi
+
+if [ -z "$verify" ] || [ ! -e "$verify" ]; then
+  echo "Error: verification certificate undefined or not found!" >&2
+  err=1
+fi
+
+if [ -z "$ocsp_url" ]; then
+  echo "Error: OCSP server URL not defined!" >&2
+  err=1
+fi
+
+if [ $err -eq 1 ]; then
+  echo "Did you forget to customize the variables in the script?" >&2
+  exit 1
+fi
+
+# begin
+if [ $check_depth -eq -1 ] || [ $cur_depth -eq $check_depth ]; then
+  eval serial="\$tls_serial_${cur_depth}"
+
+  # Check that the serial is not empty
+  if [ -n "$serial" ]; then
+
+    # This is only an example; you are encouraged to run this command (without
+    # redirections) manually against your or your CA's OCSP server to see how
+    # it responds, and adapt accordingly.
+    # Sample output:
+    #
+    # Response verify OK
+    # 0x428740A5: good
+    #      This Update: Apr 24 19:38:49 2010 GMT
+    #      Next Update: May  2 14:23:42 2010 GMT
+
+    openssl ocsp -issuer "$issuer" \
+                 "$nonce" \
+                 -CAfile "$verify" \
+                 -url "$ocsp_url" \
+                 -serial "0x${serial}" >/dev/null 2>&1
+  else
+    exit 1
+  fi
+fi
diff --git a/openvpn.8 b/openvpn.8
index 45e61fa..a31596a 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -5321,7 +5321,12 @@ where
 is the verification level.  Only set for TLS connections.  Set prior
 to execution of
 .B --tls-verify
-script.
+script. This is in the form of a hex string like "37AB46E0", which is
+suitable for doing serial-based OCSP queries (with OpenSSL, you have
+to prepend "0x" to the string). If something goes wrong while reading
+the value from the certificate it will be an empty string, so your
+code should check that.
+See the contrib/OCSP_check/OCSP_check.sh script for an example.
 .\"*********************************************************
 .TP
 .B tun_mtu
diff --git a/ssl.c b/ssl.c
index 1b275af..68a3e3b 100644
--- a/ssl.c
+++ b/ssl.c
@@ -788,9 +788,30 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
 
   /* export serial number as environmental variable */
   {
-    const int serial = (int) ASN1_INTEGER_get (X509_get_serialNumber (ctx->current_cert));
-    openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", ctx->error_depth);
-    setenv_int (opt->es, envname, serial);
+    BIO *bio = NULL;
+    char serial[100];
+    int n1, n2;
+
+    CLEAR (serial);
+    if ((bio = BIO_new (BIO_s_mem ())) == NULL)
+      {
+        msg (M_WARN, "CALLBACK: Cannot create BIO (for tls_serial_%d)", ctx->error_depth);
+      }
+    else
+      {
+        /* "prints" the serial number onto the BIO and read it back */
+        if ( ! ( ( (n1 = i2a_ASN1_INTEGER(bio, X509_get_serialNumber (ctx->current_cert))) >= 0 ) &&
+                 ( (n2 = BIO_read (bio, serial, sizeof (serial)-1)) >= 0 ) &&
+                 ( n1 == n2 ) ) )
+          {
+            msg (M_WARN, "CALLBACK: Error reading/writing BIO (for tls_serial_%d)", ctx->error_depth);
+            CLEAR (serial);     /* empty string */
+          }
+
+        openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", ctx->error_depth);
+        setenv_str (opt->es, envname, serial);
+        BIO_free(bio);
+      }
   }
 
   /* export current untrusted IP */
-- 
1.6.5.6


