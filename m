From: David Sommerseth <davids@...1347...>
Date: Fri,  3 Jun 2011 13:53:45 +0200
Message-Id: <1307102025-18627-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Remove support for Linux 2.2 configuration
	fallback
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

When configuring OpenVPN nowadays, the TUN/TAP configuration can
sometimes jump into the Linux 2.2 fallback code paths, which will
also fails.  The reason it jumps into fallback mode is that the
tun/tap device already exists or that /dev/net/tun does not exist.
This can be very confusing, as /dev/tunX which the fallback mode tries
to use, does not exist on Linux 2.4 and newer.

Considering that the last Linux 2.2 update was released 25-Feb-2004
and the first Linux 2.4 release came 04-Jan-2001, there are no
reasonable reasons to help users to stay on outdated kernels.
I consider this extra code path just waste of bytes ... so lets make
the world simpler.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 openvpn.8 |   10 +---------
 tun.c     |   13 ++-----------
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index 5cbf4c5..b6ea9e4 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -5747,11 +5747,6 @@ Make device:
 
 Load driver:
 .B modprobe tun
-
-If you have Linux 2.2 or earlier, you should obtain version 1.1 of the
-TUN/TAP driver from
-.I http://vtun.sourceforge.net/tun/
-and follow the installation instructions.
 .\"*********************************************************
 .SH EXAMPLES
 Prior to running these examples, you should have OpenVPN installed on two
@@ -5772,10 +5767,7 @@ If you installed from RPM, the
 .B mknod
 step may be omitted, because the RPM install does that for you.
 
-If you have Linux 2.2, you should obtain version 1.1 of the
-TUN/TAP driver from
-.I http://vtun.sourceforge.net/tun/
-and follow the installation instructions.
+Only Linux 2.4 and newer are supported.
 
 For other platforms, consult the INSTALL file at
 .I http://openvpn.net/install.html
diff --git a/tun.c b/tun.c
index 8cdd248..1abcf6d 100644
--- a/tun.c
+++ b/tun.c
@@ -1369,7 +1369,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
       if ((tt->fd = open (node, O_RDWR)) < 0)
 	{
 	  msg (M_WARN | M_ERRNO, "Note: Cannot open TUN/TAP dev %s", node);
-	  goto linux_2_2_fallback;
+	  return;
 	}
 
       /*
@@ -1413,7 +1413,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
       if (ioctl (tt->fd, TUNSETIFF, (void *) &ifr) < 0)
 	{
 	  msg (M_WARN | M_ERRNO, "Note: Cannot ioctl TUNSETIFF %s", dev);
-	  goto linux_2_2_fallback;
+	  return;
 	}
 
       msg (M_INFO, "TUN/TAP device %s opened", ifr.ifr_name);
@@ -1449,15 +1449,6 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
       tt->actual_name = string_alloc (ifr.ifr_name, NULL);
     }
   return;
-
- linux_2_2_fallback:
-  msg (M_INFO, "Note: Attempting fallback to kernel 2.2 TUN/TAP interface");
-  if (tt->fd >= 0)
-    {
-      close (tt->fd);
-      tt->fd = -1;
-    }
-  open_tun_generic (dev, dev_type, dev_node, false, true, tt);
 }
 
 #else
-- 
1.7.4.4


