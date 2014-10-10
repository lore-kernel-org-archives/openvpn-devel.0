Sender: Fabian Knittel <fabian@...1547...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Sat, 11 Oct 2014 00:09:20 +0200
Message-Id: <1412978966-15392-4-git-send-email-fabian.knittel@...1547...>
In-Reply-To: <1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
References: <5437B156.1020408@...1114...>
	<1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
Subject: [Openvpn-devel] [PATCH 3/9] client-connect: Refactor
	multi_client_connect_source_ccd
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

Refactor multi_client_connect_source_ccd(), so that options_server_import() (or
the success path in general) is only entered in one place within the function.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/multi.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 23b86a5..757e687 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1721,7 +1721,19 @@ multi_client_connect_source_ccd (struct multi_context *m,
 			   &gc);
 
       /* try common-name file */
-      if (test_file (ccd_file))
+      if (!test_file (ccd_file))
+	ccd_file = NULL;
+
+      if (!ccd_file)
+	{
+	  ccd_file = gen_path (mi->context.options.client_config_dir,
+			       CCD_DEFAULT, &gc);
+	  /* try default file */
+	  if (!test_file (ccd_file))
+	    ccd_file = NULL;
+	}
+
+      if (ccd_file)
 	{
 	  options_server_import (&mi->context.options,
 				 ccd_file,
@@ -1729,22 +1741,7 @@ multi_client_connect_source_ccd (struct multi_context *m,
 				 CLIENT_CONNECT_OPT_MASK,
 				 option_types_found,
 				 mi->context.c2.es);
-	}
-      else /* try default file */
-	{
-	  ccd_file = gen_path (mi->context.options.client_config_dir,
-			       CCD_DEFAULT,
-			       &gc);
 
-	  if (test_file (ccd_file))
-	    {
-	      options_server_import (&mi->context.options,
-				     ccd_file,
-				     D_IMPORT_ERRORS|M_OPTERR,
-				     CLIENT_CONNECT_OPT_MASK,
-				     option_types_found,
-				     mi->context.c2.es);
-	    }
 	}
 
       gc_free (&gc);
-- 
2.1.1


