From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:12:20 +0200
Message-Id: <1330546342-17794-51-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 50/52] build: windows: install version.sh to
	allow installer read version
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 .gitignore    |    1 +
 Makefile.am   |    5 +++++
 configure.ac  |    1 +
 version.sh.in |    4 ++++
 4 files changed, 11 insertions(+), 0 deletions(-)
 create mode 100644 version.sh.in

diff --git a/.gitignore b/.gitignore
index e7232cf..2f72ed8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -39,6 +39,7 @@ m4/ltsugar.m4
 m4/ltversion.m4
 m4/lt~obsolete.m4
 
+version.sh
 msvc-env-local.bat
 config-msvc-local.h
 config-msvc-version.h
diff --git a/Makefile.am b/Makefile.am
index 5293518..68aa0a8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -69,3 +69,8 @@ endif
 dist_noinst_HEADERS = \
 	config-msvc.h \
 	config-msvc-version.h.in
+
+if WIN32
+rootdir=$(prefix)
+root_DATA = version.sh
+endif
diff --git a/configure.ac b/configure.ac
index d53a74a..0f2a62e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -904,6 +904,7 @@ AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
 AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 
 AC_CONFIG_FILES([
+	version.sh
 	Makefile
 	build/Makefile
 	build/msvc/Makefile
diff --git a/version.sh.in b/version.sh.in
new file mode 100644
index 0000000..2af5a36
--- /dev/null
+++ b/version.sh.in
@@ -0,0 +1,4 @@
+OPENVPN_PACKAGE_NAME="@PACKAGE_NAME@"
+OPENVPN_PACKAGE_TARNAME="@PACKAGE_TARNAME@"
+OPENVPN_PACKAGE_VERSION="@PACKAGE_VERSION@"
+OPENVPN_PACKAGE_HOST="@host@"
-- 
1.7.3.4


