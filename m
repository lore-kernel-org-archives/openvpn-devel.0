From: Arne Schwabe <arne@...1227...>
Date: Wed, 17 Oct 2012 12:46:14 +0200
Message-Id: <1350470774-12511-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Options parsing demands unnecessary
	configuration if PKCS11 is used
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

In the old patch the if incorrectly closed the outer if condition.  (closes ticket #231)
---
 src/openvpn/options.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 05a0f54..8717b89 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2192,13 +2192,15 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
        }
       else
 #endif
-#ifdef ENABLE_CRYPTOAPI
 #ifdef MANAGMENT_EXTERNAL_KEY
 	 if((options->management_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
-		msg (M_USAGE, "--key and --management-external-key are mutually exclusive");
+	   {
+		 msg (M_USAGE, "--key and --management-external-key are mutually exclusive");
+	   } 
+	 else 
 #endif
-
-      if (options->cryptoapi_cert)
+#ifdef ENABLE_CRYPTOAPI
+     if (options->cryptoapi_cert)
 	{
 	  if ((!(options->ca_file)) && (!(options->ca_path)))
 	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
-- 
1.7.9.5


