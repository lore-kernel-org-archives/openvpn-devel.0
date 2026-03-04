From: Gert Doering <gert@...1296...>
Date: Wed,  4 Mar 2026 17:49:22 +0100
Message-ID: <20260304164928.15819-1-gert@...1296...>
In-Reply-To: <gerrit.1769513463000.I4ff7983a33426fda9a138fe6e56a1c03522836d3@...2715...>
References: <gerrit.1769513463000.I4ff7983a33426fda9a138fe6e56a1c03522836d3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] win32-util: Handle return value from
 WideCharToMultiByte better
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

Handle the case where the return value is zero
and avoid sign-compare warning.

Change-Id: I4ff7983a33426fda9a138fe6e56a1c03522836d3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1495
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1495
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index e60cbac..6fc3be4 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -146,11 +146,6 @@
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 const char *
 win_get_tempdir(void)
 {
@@ -162,7 +157,14 @@
         return NULL;
     }
 
-    if (WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) > sizeof(tmpdir))
+    int ret = WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL);
+    /* According to documentation ret is never < 0, but include it here just in case */
+    if (ret <= 0)
+    {
+        msg(M_WARN | M_ERRNO, "Conversion of path name failed.");
+        return NULL;
+    }
+    if ((unsigned int)ret > sizeof(tmpdir))
     {
         msg(M_WARN, "Could not get temporary directory. Path is too long."
                     "  Consider using --tmp-dir");
@@ -173,7 +175,4 @@
     return tmpdir;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
 #endif /* _WIN32 */

