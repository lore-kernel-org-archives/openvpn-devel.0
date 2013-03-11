From: Arne Schwabe <arne@...1227...>
Date: Mon, 11 Mar 2013 21:10:51 +0100
Message-Id: <1363032651-23934-4-git-send-email-arne@...1227...>
In-Reply-To: <1363032651-23934-1-git-send-email-arne@...1227...>
References: <1363032651-23934-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/4] Remove unused function no_tap_ifconfig
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/tun.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9912b07..a361233 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -300,16 +300,6 @@ warn_on_use_of_common_subnets (void)
 }
 
 /*
- * Complain if --dev tap and --ifconfig is used on an OS for which
- * we don't have a custom tap ifconfig template below.
- */
-static void
-no_tap_ifconfig ()
-{
-  msg (M_FATAL, "Sorry but you cannot use --dev tap and --ifconfig together on this OS because I have not yet been programmed to understand the appropriate ifconfig syntax to use for TAP-style devices on this OS.  Your best alternative is to use an --up script and do the ifconfig command manually.");
-}
-
-/*
  * Return a string to be used for options compatibility check
  * between peers.
  */
-- 
1.7.9.5


