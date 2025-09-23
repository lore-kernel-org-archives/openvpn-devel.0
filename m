From: Gert Doering <gert@...1296...>
Date: Tue, 23 Sep 2025 14:20:00 +0200
Message-ID: <20250923122006.12212-1-gert@...1296...>
In-Reply-To: <gerrit.1758544032000.I1ce408d4473874d88a348308503527ef7eb8c1ff@...2715...>
References: <gerrit.1758544032000.I1ce408d4473874d88a348308503527ef7eb8c1ff@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] configure.ac: Make
 ACL_CHECK_ADD_COMPILE_FLAGS append instead of prepend
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

The prepend behavior is surprising. If there is a difference
in behavior at least make it easy to understand what happens
why.

Change-Id: I1ce408d4473874d88a348308503527ef7eb8c1ff
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1204
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1204
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/configure.ac b/configure.ac
index a5485b0..c2feeea 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1388,9 +1388,9 @@
 # required for gcc, but some compilers such as clang need it.
 AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [
     old_cflags="$CFLAGS"
-    CFLAGS="$1 -Werror $CFLAGS"
+    CFLAGS="-Werror $CFLAGS $1"
     AC_MSG_CHECKING([whether the compiler accepts $1])
-    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])]; CFLAGS="$1 $old_cflags",
+    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])]; CFLAGS="$old_cflags $1",
         [AC_MSG_RESULT([no]); CFLAGS="$old_cflags"])]
 )
 

