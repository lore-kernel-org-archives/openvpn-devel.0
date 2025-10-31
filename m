From: Gert Doering <gert@...1296...>
Date: Fri, 31 Oct 2025 10:23:52 +0100
Message-ID: <20251031092427.19824-1-gert@...1296...>
In-Reply-To: <gerrit.1761870762000.Ifea896e722635a471cc01f930bc1e5d0f2c165be@...2715...>
References: <gerrit.1761870762000.Ifea896e722635a471cc01f930bc1e5d0f2c165be@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Add -lpathcch for mingw32 builds using
 autotools
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

From: Selva Nair <selva.nair@...277...>

This was missed in commit 05a8ba8

Note: the check for PATHCCH_ENSURE_TRAILING_SLASH in
configure.ac may be omitted if we build only using latest
mingw32-w64 toolchain. Ubuntu 24.04 is not new enough.

Github: closes OpenVPN/openvpn#885

Change-Id: Ifea896e722635a471cc01f930bc1e5d0f2c165be
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1334
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1334
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/configure.ac b/configure.ac
index 8f3c01d..3117e13 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1383,6 +1383,17 @@
 	fi
 fi
 
+if test "${WIN32}" == "yes"; then
+	AC_CHECK_DECLS(
+		[PATHCCH_ENSURE_TRAILING_SLASH],
+		[AC_DEFINE([HAVE_PATHCCH_ENSURE_TRAILING_SLASH], [1], [PATHCCH_ENSURE_TRAILING_SLASH is defined])],
+		,
+		[[
+			#include <pathcch.h>
+		]]
+	)
+fi
+
 # When testing a compiler option, we add -Werror to force
 # an error when the option is unsupported. This is not
 # required for gcc, but some compilers such as clang need it.
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index a27fbbf..f45d770 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -27,7 +27,7 @@
 	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
 openvpnserv_LDADD = \
 	-ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \
-	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32
+	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32 -lpathcch
 noinst_DATA = \
 	MSG00409.bin eventmsg.h eventmsg.rc openvpnservmsg.dll
 BUILT_SOURCES = \

