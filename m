From: Gert Doering <gert@...1296...>
Date: Sat, 11 Nov 2023 09:18:08 +0100
Message-ID: <20231111081808.30967-1-gert@...1296...>
In-Reply-To: <gerrit.1699637918000.I0c78ce452135fe2c80275da449215ba926471018@...2715...>
References: <gerrit.1699637918000.I0c78ce452135fe2c80275da449215ba926471018@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] platform.c: Do not depend Windows build
 on HAVE_CHDIR
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

This broke in the CMake build since previously we
just always set HAVE_CHDIR to 1 in the MSVC build.
But actually the code should just not check HAVE_CHDIR
on Windows.

Change-Id: I0c78ce452135fe2c80275da449215ba926471018
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/425
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 32c4fe6..62acabe 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -392,7 +392,6 @@
 int
 platform_chdir(const char *dir)
 {
-#ifdef HAVE_CHDIR
 #ifdef _WIN32
     int res;
     struct gc_arena gc = gc_new();
@@ -400,11 +399,12 @@
     gc_free(&gc);
     return res;
 #else  /* ifdef _WIN32 */
+#ifdef HAVE_CHDIR
     return chdir(dir);
-#endif
 #else  /* ifdef HAVE_CHDIR */
     return -1;
 #endif
+#endif
 }
 
 /*

