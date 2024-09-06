From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  6 Sep 2024 19:21:12 +0200
Message-Id: <20240906172112.87148-1-frank@...2641...>
In-Reply-To: <gerrit.1720619824000.I9b7a3df012e7606ddb04a944e3fa33247180e8dd@...2715...>
References: <gerrit.1720619824000.I9b7a3df012e7606ddb04a944e3fa33247180e8dd@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] configure: Allow to detect git checkout
 if .git is not a directory
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
Cc: Arne Schwabe <arne-openvpn@...1227...>, Yuriy Darnobyt <yura.uddr@...277...>

E.g. if you use openvpn as a git submodule, it can be a
file that points to the parent's git directory.

The changes to Makefile.am are not strictly required, they
still work with that case, but I wanted to keep the usage
consistent.

Change-Id: I9b7a3df012e7606ddb04a944e3fa33247180e8dd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/675
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/Makefile.am b/Makefile.am
index 87230fe..84b7112 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -75,9 +75,9 @@
 	README.wolfssl
 
 config-version.h:
-	@CONFIGURE_GIT_CHFILES="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) diff-files --name-status -r --ignore-submodules --quiet -- || echo \"+\"`"; \
-	CONFIGURE_GIT_UNCOMMITTED="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) diff-index --cached  --quiet --ignore-submodules HEAD || echo \"*\"`"; \
-	CONFIGURE_GIT_REVISION="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) rev-parse --symbolic-full-name HEAD | cut -d/ -f3-`/`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) rev-parse --short=16 HEAD`"; \
+	@CONFIGURE_GIT_CHFILES="`$(GIT) -C \"$(top_srcdir)\" diff-files --name-status -r --ignore-submodules --quiet -- || echo \"+\"`"; \
+	CONFIGURE_GIT_UNCOMMITTED="`$(GIT) -C \"$(top_srcdir)\" diff-index --cached  --quiet --ignore-submodules HEAD || echo \"*\"`"; \
+	CONFIGURE_GIT_REVISION="`$(GIT) -C \"$(top_srcdir)\" rev-parse --symbolic-full-name HEAD | cut -d/ -f3-`/`$(GIT) -C \"$(top_srcdir)\" rev-parse --short=16 HEAD`"; \
 	echo "#define CONFIGURE_GIT_REVISION \"$${CONFIGURE_GIT_REVISION}\"" > config-version.h.tmp; \
 	echo "#define CONFIGURE_GIT_FLAGS \"$${CONFIGURE_GIT_CHFILES}$${CONFIGURE_GIT_UNCOMMITTED}\"" >> config-version.h.tmp
 
diff --git a/configure.ac b/configure.ac
index 9ce826c..ea0da1f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1308,9 +1308,11 @@
 
 AC_MSG_CHECKING([git checkout])
 GIT_CHECKOUT="no"
-if test -n "${GIT}" -a -d "${srcdir}/.git"; then
-	AC_DEFINE([HAVE_CONFIG_VERSION_H], [1], [extra version available in config-version.h])
-	GIT_CHECKOUT="yes"
+if test -n "${GIT}"; then
+	if ${GIT} -C "$srcdir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
+		AC_DEFINE([HAVE_CONFIG_VERSION_H], [1], [extra version available in config-version.h])
+		GIT_CHECKOUT="yes"
+	fi
 fi
 AC_MSG_RESULT([${GIT_CHECKOUT}])
 

