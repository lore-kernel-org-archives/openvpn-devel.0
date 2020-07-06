From: Gert Doering <gert@...1296...>
Date: Mon,  6 Jul 2020 21:00:30 +0200
Message-Id: <20200706190030.49301-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove --writepid file on program exit.
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

For whatever reason, we never removed the pid file on program exit.

Not only this is unclean, but it also makes testing for "I want this
test case to FAIL" in t_client.sh more annoying to code for "is the
OpenVPN process still around?"...

Do not unlink the file if chroot() is active (might be outside the
chroot arena - testing for realpath etc. is left for someone else).

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/openvpn.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index dc7001dc..65029e86 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -335,6 +335,12 @@ openvpn_main(int argc, char *argv[])
         while (c.sig->signal_received == SIGHUP);
     }
 
+    /* if we opened a PID file and did not chroot(), unlink() it again */
+    if (c.options.writepid && !c.options.chroot_dir)
+    {
+        platform_unlink(c.options.writepid);
+    }
+
     context_gc_free(&c);
 
 #ifdef ENABLE_MANAGEMENT
-- 
2.27.0


