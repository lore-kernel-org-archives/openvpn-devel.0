From: Selva Nair <selva.nair@...277...>
Date: Wed, 16 Nov 2016 13:23:13 -0500
Message-Id: <1479320593-27099-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Unbreak windows build
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

S_IRWXG, S_IRWXO are not defined in mingw headers. Anyway these bits
are not defined in st_mode on Windows, so just skip the test.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e88aa95..44402a9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2738,11 +2738,13 @@ check_file_access(const int type, const char *file, const int mode, const char *
 	{
 	  msg (M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", file);
 	}
+#ifndef _WIN32
       else
 	{
 	  if (st.st_mode & (S_IRWXG|S_IRWXO))
 	    msg (M_WARN, "WARNING: file '%s' is group or others accessible", file);
 	}
+#endif
     }
 
   /* Scream if an error is found */
-- 
2.1.4


