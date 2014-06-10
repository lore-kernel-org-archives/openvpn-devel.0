From: Gert Doering <gert@...1296...>
Date: Tue, 10 Jun 2014 16:04:30 +0200
Message-Id: <1402409073-54067216-2-git-send-email-gert@...1296...>
In-Reply-To: <1402409073-54067216-1-git-send-email-gert@...1296...>
References: <1402409073-54067216-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 1/4] Recognize AIX, define TARGET_AIX
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
Cc: Gert Doering <gd@...1505...>

From: Gert Doering <gd@...1505...>

force "have_tap_header=yes", as configure won't like AIX headers otherwise
(no tun related headers, just <net/if_tap.h>).

force ROUTE to be "/usr/sbin/route" - not executable by non-root users, so
configure testing for executables will not find it

force "ac_cv_header_net_if_h=no", because AIX' <net/if.h> pulls in AIX'
<net/route.h>, which #defines ROUTE_H, disabling our "route.h"... (and
we don't need <net/if.h> on AIX anyway)

Signed-off-by: Gert Doering <gd@...1505...>
---
 configure.ac |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index ea35d73..fe278e1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -342,6 +342,13 @@ case "$host" in
 		AC_DEFINE([TARGET_DRAGONFLY], [1], [Are we running on DragonFlyBSD?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["D"], [Target prefix])
 		;;
+	*-aix*)
+		AC_DEFINE([TARGET_AIX], [1], [Are we running AIX?])
+		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["A"], [Target prefix])
+		ROUTE="/usr/sbin/route"
+		have_tap_header="yes"
+		ac_cv_header_net_if_h="no"	# exists, but breaks things
+		;;
 	*)
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["X"], [Target prefix])
 		have_tap_header="yes"
-- 
1.6.4


