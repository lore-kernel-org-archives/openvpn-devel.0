From: Selva Nair <selva.nair@...277...>
Date: Thu, 16 Jun 2016 22:54:53 -0400
Message-Id: <1466132093-1178-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Fix management-external-cert option parsing
	error
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

 - Allow --management-external-cert as an alternative to --cert
 - Also make sure --cert and --management-external-cert are not
   both specified, and clarify in the man page that the latter
   must be used with --management-external-key.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/openvpn.8         |    1 +
 src/openvpn/options.c |   15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index f1a4361..0965b62 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2647,6 +2647,7 @@ option (client-only).
 .B certificate-hint
 is an arbitrary string which is passed to a management
 interface client as an argument of NEED-CERTIFICATE notification.
+Requires \-\-management\-external\-key.
 .\"*********************************************************
 .TP
 .B \-\-management\-forget\-disconnect
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 313fd94..dda0a2c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2263,6 +2263,13 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	   {
 		 msg (M_USAGE, "--key and --management-external-key are mutually exclusive");
 	   }
+	 else if((options->management_flags & MF_EXTERNAL_CERT))
+	   {
+		 if (options->cert_file)
+		   msg (M_USAGE, "--cert and --management-external-cert are mutually exclusive");
+		 else if(!(options->management_flags & MF_EXTERNAL_KEY))
+		   msg (M_USAGE, "--management-external-cert must be used with --management-external-key");
+	   }
 	 else
 #endif
 #ifdef ENABLE_CRYPTOAPI
@@ -2318,14 +2325,14 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	  if (pull)
 	    {
 
-	      const int sum = (options->cert_file != NULL) +
+	      const int sum =
 #ifdef MANAGMENT_EXTERNAL_KEY
-			((options->priv_key_file != NULL) || (options->management_flags & MF_EXTERNAL_KEY));
+		((options->cert_file != NULL) || (options->management_flags & MF_EXTERNAL_CERT))    +
+		((options->priv_key_file != NULL) || (options->management_flags & MF_EXTERNAL_KEY));
 #else
-		    (options->priv_key_file != NULL);
+		(options->cert_file != NULL) + (options->priv_key_file != NULL);
 #endif
 
-
 	      if (sum == 0)
 		{
 #if P2MP
-- 
1.7.10.4


