MIME-version: 1.0
From: David Sommerseth <davids@...1347...>
Date: Thu, 24 Nov 2011 22:54:43 +0100
Message-id: <1322171683-17358-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Fix bug after removing Linux 2.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

In commit ce637abdafdc19547fc97192033a4d1703ecaf23 the Linux 2.2 support
was removed.  When this happened an extra error check was avoided which
would normally kicked in if the tun/tap device would not be available.
Instead the following line was filling the log continously:

   Thu Nov 24 22:33:15 2011 read from TUN/TAP : File descriptor in bad state (code=77)

This patch changes the msg() declarations to use the M_FATAL *) flag,
which will halt the execution of the program in these error sitauations.
As the program will really halt, the return declarations was also removed.

*) #define M_ERR   (M_FATAL | M_ERRNO)  (from error.h)

Signed-off-by: David Sommerseth <dazo@...384...>
---
 tun.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tun.c b/tun.c
index 7a3b2e9..1defe58 100644
--- a/tun.c
+++ b/tun.c
@@ -1397,8 +1397,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
        */
       if ((tt->fd = open (node, O_RDWR)) < 0)
 	{
-	  msg (M_WARN | M_ERRNO, "Note: Cannot open TUN/TAP dev %s", node);
-	  return;
+	  msg (M_ERR, "Note: Cannot open TUN/TAP dev %s", node);
 	}
 
       /*
@@ -1441,8 +1440,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
        */
       if (ioctl (tt->fd, TUNSETIFF, (void *) &ifr) < 0)
 	{
-	  msg (M_WARN | M_ERRNO, "Note: Cannot ioctl TUNSETIFF %s", dev);
-	  return;
+	  msg (M_ERR, "Note: Cannot ioctl TUNSETIFF %s", dev);
 	}
 
       msg (M_INFO, "TUN/TAP device %s opened", ifr.ifr_name);
-- 
1.7.4.4


