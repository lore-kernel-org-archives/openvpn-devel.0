From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Sep 2012 16:39:33 +0200
Message-Id: <1347287973-12398-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Add checks for external-key-managements
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

Commit 4806cc102655f1a829d656f6deb83e5953c5eab2 fixed only part of the problem. Since it removed the filename either the magic filename has to be resurrected or all checks against priv_key_file need to take to check for MF_EXTERNAL_KEY as well. This patch implements the extra checks

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 534e319..0f1dfc1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2173,6 +2173,10 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	  msg(M_USAGE, "Parameter --cert cannot be used when --pkcs11-provider is also specified.");
 	if (options->priv_key_file)
 	  msg(M_USAGE, "Parameter --key cannot be used when --pkcs11-provider is also specified.");
+#ifdef MANAGMENT_EXTERNAL_KEY
+	if (options->management_flags & MF_EXTERNAL_KEY)
+	  msg(M_USAGE, "Parameter --management-external-key cannot be used when --pkcs11-provider is also specified.");
+#endif
 	if (options->pkcs12_file)
 	  msg(M_USAGE, "Parameter --pkcs12 cannot be used when --pkcs11-provider is also specified.");
 #ifdef ENABLE_CRYPTOAPI
@@ -2198,6 +2202,10 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	    msg(M_USAGE, "Parameter --key cannot be used when --cryptoapicert is also specified.");
           if (options->pkcs12_file)
 	    msg(M_USAGE, "Parameter --pkcs12 cannot be used when --cryptoapicert is also specified.");
+#ifdef MANAGMENT_EXTERNAL_KEY
+          if (options->management_flags & MF_EXTERNAL_KEY)
+	    msg(M_USAGE, "Parameter --management-external-key cannot be used when --cryptoapicert is also specified.");
+#endif
 	}
       else
 #endif
@@ -2212,6 +2220,10 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	    msg(M_USAGE, "Parameter --cert cannot be used when --pkcs12 is also specified.");
           if (options->priv_key_file)
 	    msg(M_USAGE, "Parameter --key cannot be used when --pkcs12 is also specified.");
+#ifdef MANAGMENT_EXTERNAL_KEY
+          if (options->management_flags & MF_EXTERNAL_KEY)
+	    msg(M_USAGE, "Parameter --external-management-key cannot be used when --pkcs12 is also specified.");
+#endif
 #endif
         }
       else
@@ -2227,7 +2239,15 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 #endif
 	  if (pull)
 	    {
-	      const int sum = (options->cert_file != NULL) + (options->priv_key_file != NULL);
+
+	      const int sum = (options->cert_file != NULL) +
+#ifdef MANAGMENT_EXTERNAL_KEY
+			((options->priv_key_file != NULL) || (options->management_flags & MF_EXTERNAL_KEY));
+#else 
+		    (options->priv_key_file != NULL);
+#endif
+
+
 	      if (sum == 0)
 		{
 #if P2MP
@@ -2245,6 +2265,9 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	  else
 	    {
 	      notnull (options->cert_file, "certificate file (--cert) or PKCS#12 file (--pkcs12)");
+#ifdef MANAGMENT_EXTERNAL_KEY
+          if (!options->management_flags & MF_EXTERNAL_KEY)
+#endif
 	      notnull (options->priv_key_file, "private key file (--key) or PKCS#12 file (--pkcs12)");
 	    }
 	}
-- 
1.7.9.5


