From: Jeremie Courreges-Anglas <jca@...2272...>
Date: Fri, 26 May 2017 16:30:53 +0200
Message-ID: <8737brk7vm.fsf@...2274...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Alignement crash on sparc64
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
Cc: Stefan Sperling <stsp@...2273...>


Hi,

I am the maintainer of openvpn in the OpenBSD ports tree.  Here's
a report from Stefan Sperling (Cc'ed).

> An openvpn server running on OpenBSD/sparc64 6.1 crashes when a client
> connects and starts doing traffic. Is anyone else seeing this?
> 
> (gdb) run
> Starting program: /usr/local/sbin/openvpn /etc/openvpn/server.conf
> (no debugging symbols found)
> 
> Program received signal SIGBUS, Bus error.
> 0x000000a99df82664 in write_tun_header () from /usr/local/sbin/openvpn
> (gdb) bt
> #0  0x000000a99df82664 in write_tun_header () from /usr/local/sbin/openvpn
> #1  0x000000a99df136d4 in process_outgoing_tun () from /usr/local/sbin/openvpn
> #2  0x000000a99df31094 in tunnel_server_udp () from /usr/local/sbin/openvpn
> #3  0x000000a99df3a6ac in main () from /usr/local/sbin/openvpn

To work around this, the patch below (also written by Stefan) was
committed in our ports tree.  TARGET_FREEBSD and TARGET_DRAGONFLY seem
to be affected too.

Thoughts?


diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3504fbf4..51a7f82d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1654,11 +1654,11 @@ write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
     {
         u_int32_t type;
         struct iovec iv[2];
-        struct ip *iph;
+        struct ip iph;
 
-        iph = (struct ip *) buf;
+        memcpy(&iph, buf, sizeof(iph));
 
-        if (iph->ip_v == 6)
+        if (iph.ip_v == 6)
         {
             type = htonl(AF_INET6);
         }


-- 
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

