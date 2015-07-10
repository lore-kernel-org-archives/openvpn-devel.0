From: David Sommerseth <openvpn.list@...1114...>
Date: Fri, 10 Jul 2015 15:22:27 +0200
Message-Id: <1436534548-21507-2-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1436534548-21507-1-git-send-email-openvpn.list@...1114...>
References: <1436534548-21507-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH 1/2] Provide compile time OpenVPN version
	information to plug-ins
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

From: David Sommerseth <davids@...1347...>

This is to provide more fine grained information to plug-ins
about the OpenVPN environment when OpenVPN was built.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 .gitignore                                        | 1 +
 configure.ac                                      | 4 ++++
 include/Makefile.am                               | 1 +
 include/{openvpn-plugin.h => openvpn-plugin.h.in} | 7 +++++++
 version.m4                                        | 7 ++++++-
 5 files changed, 19 insertions(+), 1 deletion(-)
 rename include/{openvpn-plugin.h => openvpn-plugin.h.in} (98%)

diff --git a/.gitignore b/.gitignore
index 06ff7c6..0403ae8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -54,6 +54,7 @@ distro/rpm/openvpn.spec
 tests/t_client.sh
 tests/t_client-*-20??????-??????/
 src/openvpn/openvpn
+include/openvpn-plugin.h
 config-version.h
 nbproject
 test-driver
diff --git a/configure.ac b/configure.ac
index cd450d3..c7354f6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -30,6 +30,9 @@ m4_include(version.m4)
 AC_INIT([PRODUCT_NAME], [PRODUCT_VERSION], [PRODUCT_BUGREPORT], [PRODUCT_TARNAME])
 m4_include(compat.m4)
 AC_DEFINE([OPENVPN_VERSION_RESOURCE], [PRODUCT_VERSION_RESOURCE], [Version in windows resource format])
+AC_SUBST([OPENVPN_VERSION_MAJOR], [PRODUCT_VERSION_MAJOR], [OpenVPN major version])
+AC_SUBST([OPENVPN_VERSION_MINOR], [PRODUCT_VERSION_MINOR], [OpenVPN minor version])
+AC_SUBST([OPENVPN_VERSION_PATCH], [PRODUCT_VERSION_PATCH], [OpenVPN patch level - may be a string or integer])
 
 AC_CONFIG_AUX_DIR([.])
 AC_CONFIG_HEADERS([config.h])
@@ -1223,6 +1226,7 @@ AC_CONFIG_FILES([
 	distro/rpm/Makefile
 	distro/rpm/openvpn.spec
 	include/Makefile
+	include/openvpn-plugin.h
 	src/Makefile
 	src/compat/Makefile
 	src/openvpn/Makefile
diff --git a/include/Makefile.am b/include/Makefile.am
index 13dee61..70f20e9 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -11,5 +11,6 @@
 
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
+	$(srcdir)/openvpn-plugin.h.in
 
 include_HEADERS = openvpn-plugin.h
diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h.in
similarity index 98%
rename from include/openvpn-plugin.h
rename to include/openvpn-plugin.h.in
index 080ffff..ddf3298 100644
--- a/include/openvpn-plugin.h
+++ b/include/openvpn-plugin.h.in
@@ -49,6 +49,13 @@ typedef X509 openvpn_x509_cert_t;
 extern "C" {
 #endif
 
+/* Provide some basic version information to plug-ins at OpenVPN compile time
+ * This is will not be the complete version
+ */
+#define OPENVPN_VERSION_MAJOR @OPENVPN_VERSION_MAJOR@
+#define OPENVPN_VERSION_MINOR @OPENVPN_VERSION_MINOR@
+#define OPENVPN_VERSION_PATCH "@OPENVPN_VERSION_PATCH@"
+
 /*
  * Plug-in types.  These types correspond to the set of script callbacks
  * supported by OpenVPN.
diff --git a/version.m4 b/version.m4
index 376661f..1157be4 100644
--- a/version.m4
+++ b/version.m4
@@ -1,7 +1,12 @@
 dnl define the OpenVPN version
 define([PRODUCT_NAME], [OpenVPN])
 define([PRODUCT_TARNAME], [openvpn])
-define([PRODUCT_VERSION], [2.3_git])
+define([PRODUCT_VERSION_MAJOR], [2])
+define([PRODUCT_VERSION_MINOR], [3])
+define([PRODUCT_VERSION_PATCH], [_git])
+m4_append([PRODUCT_VERSION], [PRODUCT_VERSION_MAJOR])
+m4_append([PRODUCT_VERSION], [PRODUCT_VERSION_MINOR], [[.]])
+m4_append([PRODUCT_VERSION], [PRODUCT_VERSION_PATCH], [[]])
 define([PRODUCT_BUGREPORT], [openvpn-users@lists.sourceforge.net])
 define([PRODUCT_VERSION_RESOURCE], [2,3,0,0])
 dnl define the TAP version
-- 
1.8.3.1


