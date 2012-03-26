From: Alon Bar-Lev <alon.barlev@...277...>
Date: Mon, 26 Mar 2012 12:34:07 +0200
Message-Id: <1332758047-30774-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz1yULF1jkPRGOQriuetsdiUo5PbNVJybSURWPAKgQZMNA@...278...>
References: <CAOazyz1yULF1jkPRGOQriuetsdiUo5PbNVJybSURWPAKgQZMNA@...278...>
Subject: [Openvpn-devel] [PATCH] build: assume dlfcn is available on all
	supported platforms
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
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index bd84c0f..a30e873 100644
--- a/configure.ac
+++ b/configure.ac
@@ -840,7 +840,6 @@ if test "${enable_crypto}" = "yes"; then
 fi
 
 if test "${enable_plugins}" = "yes"; then
-	test "${WIN32}" != "yes" -a -z "${DL_LIBS}" && AC_MSG_ERROR([libdl is required for plugins])
 	OPTIONAL_DL_LIBS="${DL_LIBS}"
 	AC_DEFINE([ENABLE_PLUGIN], [1], [Enable systemd support])
 	test "${enable_eurephia}" = "yes" && AC_DEFINE([ENABLE_EUREPHIA], [1], [Enable support for the eurephia plug-in])
-- 
1.7.3.4


