Date: Fri, 9 Jul 2010 10:31:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100709083102.GZ361@...1296...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Patch for compile-time problems on NetBSD and
	OpenBSD (trac #17)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

the following patch fixes the IFF_MULTICAST compile-time problems on NetBSD,
and it should also fix them on OpenBSD (trac entry #17).

** important: after applying the patch to configure.ac, you MUST run
** "autoreconf" - otherwise the patch won't do anything

If it still doesn't work for OpenBSD, I need to see the parts from your
config.log relating to <net/if.h>

gert

-------------- snip ----------------

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4626e46..b91a41c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -371,6 +371,9 @@ if test "${WIN32}" != "yes"; then
 		 [#ifdef HAVE_SYS_SOCKET_H 
 		  # include <sys/socket.h>
 		  #endif
+	          #ifdef HAVE_SYS_TYPES_H
+		  # include <sys/types.h>
+		  #endif
 		 ])
    AC_CHECK_HEADERS(netinet/ip.h,,,
 		 [#ifdef HAVE_SYS_TYPES_H
-- 
1.6.4.4

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

