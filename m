From: Gert Doering <gert@...1296...>
Date: Sat,  7 Jan 2023 17:25:58 +0100
Message-Id: <20230107162558.59659-1-gert@...1296...>
In-Reply-To: <20221227223506.34136-1-gert@...1296...>
References: <20221227223506.34136-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Undo FreeBSD 12.x workaround on IPv6
 ifconfig for 12.4 and up
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

commit 5e19cc2c1bf22d introduced a workaround for a race condition
that showed itself on IPv6 ifconfig on FreeBSD 12.x - sometimes breaking
IPv6 connectivity on tun/tap interfaces.

This was fixed on the FreeBSD side in 12.4, 13.1 and up, and 13.0 is
no longer supported.  So conditionalize the workaround on "12.0..12.3",
to be fully removed later when 12.3 is also running out of support.

v2: fix version number comparison

Trac: 1226

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index a83ec9e6..8d884461 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1104,8 +1104,9 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
     openvpn_execve_check(&argv, es, S_FATAL,
                          "generic BSD ifconfig inet6 failed");
 
-#if defined(TARGET_FREEBSD) && __FreeBSD_version >= 1200000
-    /* On FreeBSD 12 and up, there is ipv6_activate_all_interfaces="YES"
+#if defined(TARGET_FREEBSD) && __FreeBSD_version >= 1200000 \
+	&& __FreeBSD_version < 1204000
+    /* On FreeBSD 12.0-12.3, there is ipv6_activate_all_interfaces="YES"
      * in rc.conf, which is not set by default.  If it is *not* set,
      * "all new interfaces that are not already up" are configured by
      * devd + /etc/pccard_ether as "inet6 ifdisabled".
-- 
2.38.1


