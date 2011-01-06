From: Matthias Andree <matthias.andree@...68...>
Date: Thu,  6 Jan 2011 18:13:58 +0100
Message-Id: <1294334039-28892-2-git-send-email-matthias.andree@...68...>
In-Reply-To: <1294334039-28892-1-git-send-email-matthias.andree@...68...>
References: <1294334039-28892-1-git-send-email-matthias.andree@...68...>
Subject: [Openvpn-devel] [PATCH 1/2] Cleanup: move AC_GNU_SOURCE to quench
	autotools warnings.
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
Cc: Matthias Andree <matthias.andree@...68...>

---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index e30f990..e1ca65e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -32,6 +32,7 @@ AC_CONFIG_SRCDIR(syshead.h)
 
 dnl Guess host type.
 AC_CANONICAL_HOST
+AC_GNU_SOURCE
 AM_INIT_AUTOMAKE(openvpn, [$PACKAGE_VERSION])
 
 AC_ARG_WITH(cygwin-native,
@@ -337,7 +338,6 @@ dnl Checks for programs.
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_PROG_GCC_TRADITIONAL
-AC_GNU_SOURCE
 
 if test "${WIN32}" = "yes"; then
 	AC_ARG_VAR([MAN2HTML], [man2html utility])
-- 
1.7.1


