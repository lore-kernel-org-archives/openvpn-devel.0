From: Gert Doering <gert@...1296...>
Date: Mon,  6 Mar 2023 09:07:44 +0100
Message-Id: <20230306080744.66069-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] FreeBSD 12.x workaround for IPv6 ifconfig
 is needed on 12.4 as well
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

Commit 16d7f2cd4d90 tried to remove an FreeBSD 12.x ifconfig inet6
workaround based on the understanding that the upstream fix for
bug 248172 went into 12.4, but that was a misread of the code - 12.4
needs the workaround as well, fixed in 13.0.

Also extend comment to point to /etc/network.subr, which is the real
source of the problematic code

        if checkyesno ipv6_activate_all_interfaces; then
                _ipv6_opts="-ifdisabled"
        elif [ "$1" != "lo0" ]; then                   <<<<
                _ipv6_opts="ifdisabled"                <<<<
        fi

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index a1414d23..ca5c3b38 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1105,11 +1105,11 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
                          "generic BSD ifconfig inet6 failed");
 
 #if defined(TARGET_FREEBSD) && __FreeBSD_version >= 1200000 \
-    && __FreeBSD_version < 1204000
-    /* On FreeBSD 12.0-12.3, there is ipv6_activate_all_interfaces="YES"
+    && __FreeBSD_version < 1300000
+    /* On FreeBSD 12.0-12.4, there is ipv6_activate_all_interfaces="YES"
      * in rc.conf, which is not set by default.  If it is *not* set,
      * "all new interfaces that are not already up" are configured by
-     * devd + /etc/pccard_ether as "inet6 ifdisabled".
+     * devd -> /etc/pccard_ether -> /etc/network.subr as "inet6 ifdisabled".
      *
      * The "is this interface already up?" test is a non-zero time window
      * which we manage to hit with our ifconfig often enough to cause
-- 
2.39.2


