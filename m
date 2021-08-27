From: Antonio Quartulli <a@...2181...>
Date: Fri, 27 Aug 2021 16:48:07 +0200
Message-Id: <20210827144807.27004-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] configure: search also for rst2{man,
 html}.py
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
Cc: Antonio Quartulli <a@...2181...>, David Sommerseth <davids@...515...>

On some systems the rst2{man,html} executables may have a slightly
different name, like rst2{man,html}.py.

Add this name variation to the Generic Programs check.

This specific variation is found on Gentoo Linux.

Cc: David Sommerseth <davids@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5d378962..7c2ead6a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -362,8 +362,8 @@ AC_DEFINE_UNQUOTED([SYSTEMD_ASK_PASSWORD_PATH], ["$SYSTEMD_ASK_PASSWORD"], [Path
 #
 AC_ARG_VAR([RST2MAN], [path to rst2man utility])
 AC_ARG_VAR([RST2HTML], [path to rst2html utility])
-AC_CHECK_PROGS([RST2MAN], [rst2man])
-AC_CHECK_PROGS([RST2HTML], [rst2html])
+AC_CHECK_PROGS([RST2MAN], [rst2man rst2man.py])
+AC_CHECK_PROGS([RST2HTML], [rst2html rst2html.py])
 AM_CONDITIONAL([HAVE_PYDOCUTILS], [test "${RST2MAN}" -a "${RST2HTML}"])
 
 # Set -std=c99 unless user already specified a -std=
-- 
2.31.1


