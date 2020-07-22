From: Gert Doering <gert@...1296...>
Date: Wed, 22 Jul 2020 15:28:52 +0200
Message-Id: <20200722132852.48508-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Workaround FreeBSD 12+ race condition on
 tun/tap open with IPv6.
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

On FreeBSD 12 (tested and verified on 12.1-RELEASE-p2), after "ifconfig
inet6" for a tun/tap interface, there sometimes is a race condition
where the "IFDISABLED" flag shows up after a short time frame, under
a second, and never clears itself.  This disables use of the configured
IPv6 address on the interface, breaking IPv6 over tun/tap operation.

As a workaround until this can be fixed on the FreeBSD side (or a
better workaround is found), sleep(1) after ifconfig, then call
"ifconfig $dev inet6 -ifdisable".

Yes, this is massively ugly but makes the problem completely go
away for my test systems.

(The same effect can be achieved with an --up script that does this,
but it's even less pretty - see trac ticket)

Trac: 1226
Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e96368ca..2d3ba623 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1038,6 +1038,23 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
     openvpn_execve_check(&argv, es, S_FATAL,
                          "generic BSD ifconfig inet6 failed");
 
+#if defined(TARGET_FREEBSD) && __FreeBSD_version >= 1200000
+    /* FreeBSD 12 grew some sort of race condition where sometimes
+     * the IPv6 side of a tun interface is stuck in "IFDISABLED"
+     * in "ifconfig tun0" output, and the assigned IPv6 address is not
+     * working ("tentative").  Workaround in here, for now.
+     *
+     * the sleep is needed because there is a race condition, so turning
+     * it off immediately can lead to "kernel turns it on again, stuck!!"
+     */
+    sleep(1);
+    argv_printf(&argv, "%s %s inet6 -ifdisabled", IFCONFIG_PATH, ifname);
+    argv_msg(M_INFO, &argv);
+
+    openvpn_execve_check(&argv, es, S_FATAL,
+                         "FreeBSD BSD 'ifconfig inet6 -ifdisabled' failed");
+#endif
+
 #if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
     || defined(TARGET_DARWIN)
     /* and, hooray, we explicitly need to add a route... */
-- 
2.27.0


