From: Gert Doering <gert@...1296...>
Date: Mon, 10 Oct 2016 09:39:31 +0200
Message-Id: <20161010073931.54469-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Enable -D_SVR4_2 for compilation on Solaris
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

Solaris' header files to not make necessary macros (like CMSG_SPACE)
available unless told "this is the API level we want" - thus, do so.

This fixes --multihome on OpenSolaris 11 (at least).

trac #750

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index a03abba..24b2e46 100644
--- a/configure.ac
+++ b/configure.ac
@@ -318,6 +318,7 @@ case "$host" in
 	*-*-solaris*)
 		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solaris?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["S"], [Target prefix])
+		CPPFLAGS="$CPPFLAGS -D_XPG4_2"
 		;;
 	*-*-openbsd*)
 		AC_DEFINE([TARGET_OPENBSD], [1], [Are we running on OpenBSD?])
-- 
1.5.6.5


