MIME-version: 1.0
From: David Sommerseth <davids@...1347...>
Date: Sun, 23 Oct 2011 12:35:13 +0200
Message-id: <1319366113-6891-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Fix PolarSSL and --pkcs12 option issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...1347...>

PolarSSL does not support PKCS#12 certificate/key bundles, but had a
typo where #ifdef USE_POLARSSL was used, and it should have been #ifndef
instead.

Also added a few extra exclusions of PKCS#12 messages where appropriate,
to avoid confusing users.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 options.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/options.c b/options.c
index 39e7a57..4fd6933 100644
--- a/options.c
+++ b/options.c
@@ -559,7 +559,9 @@ static const char usage_message[] =
   "                  by a Certificate Authority in --ca file.\n"
   "--extra-certs file : one or more PEM certs that complete the cert chain.\n"
   "--key file      : Local private key in .pem format.\n"
+#ifndef USE_POLARSSL
   "--pkcs12 file   : PKCS#12 file containing local private key, local certificate\n"
+#endif
   "                  and optionally the root CA certificate.\n"
 #ifdef ENABLE_X509ALTUSERNAME
   "--x509-username-field : Field used in x509 certificate to be username.\n"
@@ -1575,7 +1577,9 @@ show_settings (const struct options *o)
   SHOW_STR (dh_file);
   SHOW_STR (cert_file);
   SHOW_STR (priv_key_file);
+#ifndef USE_POLARSSL
   SHOW_STR (pkcs12_file);
+#endif
 #ifdef ENABLE_CRYPTOAPI
   SHOW_STR (cryptoapi_cert);
 #endif
@@ -2341,7 +2345,9 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       MUST_BE_UNDEF (dh_file);
       MUST_BE_UNDEF (cert_file);
       MUST_BE_UNDEF (priv_key_file);
+#ifndef USE_POLARSSL
       MUST_BE_UNDEF (pkcs12_file);
+#endif
       MUST_BE_UNDEF (cipher_list);
       MUST_BE_UNDEF (tls_verify);
       MUST_BE_UNDEF (tls_export_cert);
@@ -6262,7 +6268,7 @@ add_option (struct options *options,
 	}
 #endif
     }
-#ifdef USE_POLARSSL
+#ifndef USE_POLARSSL
   else if (streq (p[0], "pkcs12") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
-- 
1.7.4.4


