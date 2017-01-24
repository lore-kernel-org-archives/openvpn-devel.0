From: David Sommerseth <davids@...515...>
Date: Wed, 25 Jan 2017 00:23:44 +0100
Message-Id: <20170124232344.7825-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] systemd: Move the READY=1 signalling to an
	earlier point
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

Currently, OpenVPN will first tell systemd it is ready once the
log will be appended with "Initialization Sequence Completed".
This turns out to cause some issues several places.

First, it adds challenges if --chroot is used in the configuration;
this we already fixed.  Secondly, it will cause havoc on static key
p2p mode configurations where the log line above will not happen
before either sides have completed establishing a connection.  And
thirdly, if a client configuration fails to establish a connection
within 90 seconds it will also fail.  For the third case this may
not need to be a critical issue, as the host just needs to get
an Internet access established first - which in some scenarios may
take much longer than those 90 seconds after the OpenVPN client
configuration tries to start.

The approach this patch takes is to consider OpenVPN ready once
all the initial preparations and configurations have happened - but
before a connection to a remote side have been attempted.  This
also removes the need for specially handling the --chroot scenario.

The final "Initialization Sequence Completed" message update is
kept (though slightly simplified) to indicate we're in a good
state - even though that update will still not be visible
if --chroot is used (as before this patch).

Trac: #827, #801
Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/init.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 756bf36..ff1551e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -562,6 +562,15 @@ context_init_1(struct context *c)
     }
 #endif
 
+#ifdef ENABLE_SYSTEMD
+    /* We can report the PID via getpid() to systemd here as OpenVPN will not
+     * do any fork due to daemon() a future call.
+     * See possibly_become_daemon() [init.c] for more details.
+     */
+    sd_notifyf(0, "READY=1\nSTATUS=Pre-connection initialization succesfull\nMAINPID=%lu",
+               (unsigned long) getpid());
+#endif
+
 }
 
 void
@@ -1042,24 +1051,6 @@ do_uid_gid_chroot(struct context *c, bool no_delay)
         {
             if (no_delay)
             {
-#ifdef ENABLE_SYSTEMD
-                /* If OpenVPN is started by systemd, the OpenVPN process needs
-                 * to provide a preliminary status report to systemd.  This is
-                 * needed as $NOTIFY_SOCKET will not be available inside the
-                 * chroot, which sd_notify()/sd_notifyf() depends on.
-                 *
-                 * This approach is the simplest and the most non-intrusive
-                 * solution right before the 2.4_rc2 release.
-                 *
-                 * TODO: Consider altnernative solutions - bind mount?
-                 * systemd does not grok OpenVPN configuration files, thus cannot
-                 * have a sane way to know if OpenVPN will chroot or not and to
-                 * which subdirectory it will chroot into.
-                 */
-                sd_notifyf(0, "READY=1\n"
-                           "STATUS=Entering chroot, most of the init completed successfully\n"
-                           "MAINPID=%lu", (unsigned long) getpid());
-#endif
                 platform_chroot(c->options.chroot_dir);
             }
             else if (c->first_time)
@@ -1409,7 +1400,7 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
     else
     {
 #ifdef ENABLE_SYSTEMD
-        sd_notifyf(0, "READY=1\nSTATUS=%s\nMAINPID=%lu", message, (unsigned long) getpid());
+        sd_notifyf(0, "STATUS=%s", message);
 #endif
         msg(M_INFO, "%s", message);
     }
-- 
2.11.0


