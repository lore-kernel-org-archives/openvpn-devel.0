From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat,  5 May 2012 09:49:00 +0300
Message-Id: <1336200540-10327-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] build: cleanup: yet another forgotten
	brackets
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 926a270..6335fd8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -258,7 +258,7 @@ AC_ARG_WITH(
 	[with_crypto_library="openssl"]
 )
 
-AC_DEFINE_UNQUOTED(TARGET_ALIAS, "${host}", [A string representing our host])
+AC_DEFINE_UNQUOTED([TARGET_ALIAS], ["${host}"], [A string representing our host])
 case "$host" in
 	*-*-linux*)
 		AC_DEFINE([TARGET_LINUX], [1], [Are we running on Linux?])
-- 
1.7.3.4


