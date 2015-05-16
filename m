Date: Sat, 16 May 2015 15:59:50 +0200
From: Felix Janda <felix.janda@...2031...>
Message-ID: <20150516134604.GA2302@...2032...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Use OPENVPN_ETH_P_* so that
 <netinet/if_ether.h> is unecessary
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Fixes compilation error on linux with musl libc because of
conflicting ethhdr declarations in <netinet/if_ether.h> and
<linux/if_ether.h> which is included from <linux/if_tun.h>

Signed-off-by: Felix Janda <felix.janda@...2031...>
---
 configure.ac          | 2 +-
 src/openvpn/syshead.h | 4 ----
 src/openvpn/tun.c     | 4 ++--
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9132468..5dccfbb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -461,7 +461,7 @@ SOCKET_INCLUDES="
 "
 
 AC_CHECK_HEADERS(
-	[net/if.h netinet/ip.h netinet/if_ether.h resolv.h sys/un.h net/if_utun.h sys/kern_control.h],
+	[net/if.h netinet/ip.h resolv.h sys/un.h net/if_utun.h sys/kern_control.h],
 	,
 	,
 	[[${SOCKET_INCLUDES}]]
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index b898bf2..cf29131 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -214,10 +214,6 @@
 
 #if defined(TARGET_LINUX) || defined (TARGET_ANDROID)
 
-#if defined(HAVE_NETINET_IF_ETHER_H)
-#include <netinet/if_ether.h>
-#endif
-
 #ifdef HAVE_LINUX_IF_TUN_H
 #include <linux/if_tun.h>
 #endif
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 11a6d71..ce3ed85 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1856,9 +1856,9 @@ write_tun (struct tuntap* tt, uint8_t *buf, int len)
       pi.flags = 0;
 
       if(iph->version == 6)
-	pi.proto = htons(ETH_P_IPV6);
+	pi.proto = htons(OPENVPN_ETH_P_IPV6);
       else
-	pi.proto = htons(ETH_P_IP);
+	pi.proto = htons(OPENVPN_ETH_P_IPV4);
 
       vect[0].iov_len = sizeof(pi);
       vect[0].iov_base = &pi;
-- 
2.3.6

