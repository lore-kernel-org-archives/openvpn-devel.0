From: Kristof Provost <kprovost@...2661...>
Date: Tue, 29 Jul 2025 11:39:07 +0200
Message-ID: <20250729093907.37849-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] dco-freebsd: always enable float
 notification support
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

If the kernel doesn't support it we'll simply never get the notification. In
other words, there's no downside to always enabling this, so let's do that.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 configure.ac              | 9 ---------
 src/openvpn/dco_freebsd.c | 4 ----
 2 files changed, 13 deletions(-)

diff --git a/configure.ac b/configure.ac
index 50697b8e..66cb79b1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -848,15 +848,6 @@ if test "$enable_dco" != "no"; then
 				else
 					AC_MSG_ERROR([DCO support can't be enabled])
 				fi
-			else
-				AC_CHECK_DECLS(
-					[OVPN_NOTIF_FLOAT],
-					[AC_DEFINE([ENABLE_DCO_FLOAT_FREEBSD], [1], [We have DCO float notifications on FreeBSD])],
-					,
-					[[
-						#include <net/if_ovpn.h>
-					]]
-				)
 			fi
 			;;
 		*-mingw*)
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 306ecd31..488665fc 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -73,7 +73,6 @@ sockaddr_to_nvlist(const struct sockaddr *sa)
     return (nvl);
 }
 
-#ifdef ENABLE_DCO_FLOAT_FREEBSD
 static bool
 nvlist_to_sockaddr(const nvlist_t *nvl, struct sockaddr_storage *ss)
 {
@@ -133,7 +132,6 @@ nvlist_to_sockaddr(const nvlist_t *nvl, struct sockaddr_storage *ss)
 
     return (true);
 }
-#endif /* ifdef ENABLE_DCO_FLOAT_FREEBSD */
 
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
@@ -636,7 +634,6 @@ dco_do_read(dco_context_t *dco)
             dco->dco_message_type = OVPN_CMD_SWAP_KEYS;
             break;
 
-#ifdef ENABLE_DCO_FLOAT_FREEBSD
         case OVPN_NOTIF_FLOAT: {
             const nvlist_t *address;
 
@@ -655,7 +652,6 @@ dco_do_read(dco_context_t *dco)
             dco->dco_message_type = OVPN_CMD_FLOAT_PEER;
             break;
         }
-#endif
 
         default:
             msg(M_WARN, "Unknown kernel notification %d", type);
-- 
2.50.1


