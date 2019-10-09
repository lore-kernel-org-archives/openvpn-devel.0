From: Gert Doering <gert@...1296...>
Date: Wed,  9 Oct 2019 14:00:43 +0200
Message-Id: <20191009120043.22692-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] OpenSolaris/OpenIllumos: use /bin/bash if
 available for test scripts.
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

t_client.sh relies on "echo -e" and "echo -n" to produce nicely
looking output, which fails on Solaris /bin/sh - force SHELL=/bin/bash
on recent-enough Solaris variants that have it.

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index c7fd7a84..4159e450 100644
--- a/configure.ac
+++ b/configure.ac
@@ -306,6 +306,7 @@ case "$host" in
 		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solaris?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["S"], [Target prefix])
 		CPPFLAGS="$CPPFLAGS -D_XPG4_2"
+		test -x /bin/bash && SHELL="/bin/bash"
 		;;
 	*-*-openbsd*)
 		AC_DEFINE([TARGET_OPENBSD], [1], [Are we running on OpenBSD?])
-- 
2.23.0


