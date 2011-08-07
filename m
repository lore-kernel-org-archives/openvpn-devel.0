From: Bertrand Jacquin <beber@...1472...>
Date: Sun,  7 Aug 2011 12:59:14 +0200
Message-Id: <1312714757-10317-2-git-send-email-beber@...1472...>
In-Reply-To: <1312714757-10317-1-git-send-email-beber@...1472...>
References: <1312714757-10317-1-git-send-email-beber@...1472...>
Subject: [Openvpn-devel] [PATCH 1/4] WIN32: Check for windres tool
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

Signed-off-by: Bertrand Jacquin <beber@...1472...>
---
 configure.ac |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index a3789d9..2edb05e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -356,6 +356,7 @@ if test "${WIN32}" = "yes"; then
 	AC_ARG_VAR([MAN2HTML], [man2html utility])
 	AC_CHECK_PROGS([MAN2HTML], [man2html])
 	test -z "${MAN2HTML}" && AC_MSG_ERROR([man2html is required for win32])
+	AC_CHECK_TOOL(WINDRES, windres)
 fi
 
 dnl Checks for header files.
-- 
1.7.6


