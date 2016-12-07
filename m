From: David Sommerseth <davids@...515...>
Date: Wed,  7 Dec 2016 03:51:52 +0100
Message-Id: <1481079112-22990-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] systemd: Intermediate --chroot fix with the
	new sd_notify() implementation
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

Commit c5931897ae8d663e7e introduced support for talking directly
to the systemd service manager about the situation for the OpenVPN
tunnel. This approach makes a lot of sense and is mostly the proper
way to do it.  But it was discovered that it breaks OpenVPN
configurations using --chroot.

The reason sd_notify() calls fails when using chroot() is that
sd_notify() expects to have access to a file as declared in the
$NOTIFY_SOCKET environment variable.  It is the main systemd
instance which is responsible to provide both the environment variable
as well as the socket file sd_nodify() should use.  When --chroot
comes into play, the $NOTIFY_SOCKET file will not be available
for OpenVPN any more.

As things are getting close to the 2.4_rc2 release we will not dare
to bring a too invasive fix.  As well we need some time to discuss
an approrpriate solution.  So this intermediate fix will only
provide a "successful start" message to the systemd service manager
right before chroot() happens.  This will at least resolve the issue
in a safe and non-intrusive way.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/init.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 74f1139..e47f0d4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -967,7 +967,27 @@ do_uid_gid_chroot (struct context *c, bool no_delay)
       if (c->options.chroot_dir)
 	{
 	  if (no_delay)
-	    platform_chroot (c->options.chroot_dir);
+            {
+#ifdef ENABLE_SYSTEMD
+              /* If OpenVPN is started by systemd, the OpenVPN process needs
+               * to provide a preliminary status report to systemd.  This is
+               * needed as $NOTIFY_SOCKET will not be available inside the
+               * chroot, which sd_notify()/sd_notifyf() depends on.
+               *
+               * This approach is the simplest and the most non-intrusive
+               * solution right before the 2.4_rc2 release.
+               *
+               * TODO: Consider altnernative solutions - bind mount?
+               * systemd does not grok OpenVPN configuration files, thus cannot
+               * have a sane way to know if OpenVPN will chroot or not and to
+               * which subdirectory it will chroot into.
+               */
+              sd_notifyf(0, "READY=1\n"
+                "STATUS=Entering chroot, most of the init completed successfully\n"
+                "MAINPID=%lu", (unsigned long) getpid());
+#endif
+              platform_chroot (c->options.chroot_dir);
+            }
 	  else if (c->first_time)
 	    msg (M_INFO, "NOTE: chroot %s", why_not);
 	}
-- 
1.8.3.1


