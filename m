Date: Fri, 12 Oct 2007 01:31:58 +0200
From: Maximilian Wilhelm <max@...1047...>
Message-ID: <20071011233158.GC1416@...1048...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
Subject: [Openvpn-devel] [Patch] Fix Null-Pointer bug in init_ssl() when no
	'--ca' is set but '--capath'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi!

This little patch fixes a silly bug in init_ssl() in ssl.c where
options->ca_file is accessed without prior check if it's not NULL.

The bug was introduced in revision 784.

Ciao
Max
-- 
	Follow the white penguin.

--FCuugMFkClbJLl1L
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-Fixed-NULL-pointer-bug-in-init_ssl.patch"

diff --git a/ssl.c b/ssl.c
index 85e9c6f..868edc2 100644
--- a/ssl.c
+++ b/ssl.c
@@ -1228,7 +1228,7 @@ init_ssl (const struct options *options)
       int status;
 
 #if ENABLE_INLINE_FILES
-      if (!strcmp (options->ca_file, INLINE_FILE_TAG) && options->ca_file_inline)
+      if (options->ca_file && !strcmp (options->ca_file, INLINE_FILE_TAG) && options->ca_file_inline)
 	{
 	  status = use_inline_load_verify_locations (ctx, options->ca_file_inline);
 	}

--FCuugMFkClbJLl1L--

