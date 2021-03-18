From: Juliusz Sosinowicz <juliusz@...2525...>
Date: Thu, 18 Mar 2021 17:16:09 +0100
Message-Id: <20210318161609.76073-1-juliusz@...2525...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add PKG_CHECK_VAR compatibility definition
 for old autoconf versions
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

Signed-off-by: Juliusz Sosinowicz <juliusz@...2525...>
---
 compat.m4 | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/compat.m4 b/compat.m4
index e54a7203..47650f6d 100644
--- a/compat.m4
+++ b/compat.m4
@@ -64,6 +64,22 @@ ifdef(
 		AC_DEFUN([AC_TYPE_UINT64_T], [])
 	]
 )
+ifdef(
+	[PKG_CHECK_VAR],
+	,
+	[
+		AC_DEFUN([PKG_CHECK_VAR],
+		[AC_REQUIRE([PKG_PROG_PKG_CONFIG])
+		AC_ARG_VAR([$1], [value of $3 for $2, overriding pkg-config])
+
+		_PKG_CONFIG([$1], [variable="][$3]["], [$2])
+		AS_VAR_COPY([$1], [pkg_cv_][$1])
+
+		AS_VAR_IF([$1], [""], [$5], [$4])
+		])
+	]
+)
+
 if test -z "${docdir}"; then
 	docdir="\$(datadir)/doc/\$(PACKAGE_NAME)"
 	AC_SUBST([docdir])
-- 
2.25.1


