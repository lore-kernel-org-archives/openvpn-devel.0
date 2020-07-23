From: Gert Doering <gert@...1296...>
Date: Thu, 23 Jul 2020 14:19:49 +0200
Message-Id: <20200723121949.78223-1-gert@...1296...>
In-Reply-To: <20200722132852.48508-1-gert@...1296...>
References: <20200722132852.48508-1-gert@...1296...>
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

This only happens if ipv6_activate_all_interfaces="YES" is not
set in /etc/rc.conf - but there might be reasons why this is not so.

As a workaround until this can be fixed on the FreeBSD side (or a
better workaround is found), sleep(1) after ifconfig, then call
"ifconfig $dev inet6 -ifdisable".

Yes, this is massively ugly but makes the problem completely go
away for my test systems.

(The same effect can be achieved with an --up script that does this,
but it's even less pretty - see trac ticket)

FreeBSD: https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=248172

v2: reword text, refer to FreeBSD bug with much more details

Trac: 1226
Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e96368ca..bbccc1cc 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1038,6 +1038,29 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
     openvpn_execve_check(&argv, es, S_FATAL,
                          "generic BSD ifconfig inet6 failed");
 
+#if defined(TARGET_FREEBSD) && __FreeBSD_version >= 1200000
+    /* On FreeBSD 12 and up, there is ipv6_activate_all_interfaces="YES"
+     * in rc.conf, which is not set by default.  If it is *not* set,
+     * "all new interfaces that are not already up" are configured by
+     * devd + /etc/pccard_ether as "inet6 ifdisabled".
+     *
+     * The "is this interface already up?" test is a non-zero time window
+     * which we manage to hit with our ifconfig often enough to cause 
+     * frequent fails in the openvpn test environment.
+     *
+     * Thus: assume that the system might interfere, wait for things to
+     * settle (it's a very short time window), and remove -ifdisable again.
+     *
+     * See: https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=248172
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


