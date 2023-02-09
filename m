From: =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@...2710...>
Date: Thu,  9 Feb 2023 16:36:58 +0100
Message-Id: <20230209153658.24001-1-ynezz@...2710...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] get_addr_generic: fix server crash in
 freeaddrinfo on musl libc
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

Server can crash on systems using musl libc when client with comma in
commonName tries to connect:

 ifconfig_pool_read(), in='VPN Client, abc,192.168.1.2,'
 RESOLVE: Cannot parse IP address:  abc: (Name does not resolve)

as this leads to NULL pointer dereference in freeaddrinfo():

 Program received signal SIGSEGV, Segmentation fault.
 0x00007ffff7fbf81a in freeaddrinfo (p=0x0) at src/network/freeaddrinfo.c:10
 (gdb) bt
 #0  0x00007ffff7fbf81a in freeaddrinfo (p=0x0) at src/network/freeaddrinfo.c:10
 #1  0x00000000004389ec in get_addr_generic (af=af@...1851...=2, flags=flags@...1851...=4, hostname=hostname@...1851...=0x7ffff7ee2988 " abc", network=network@...1851...=0x7fffffffcb7c, netbits=netbits@...1851...=0x0,
     resolve_retry_seconds=resolve_retry_seconds@...1851...=0, signal_received=0x0, msglevel=64) at openvpn-2.5.7/src/openvpn/socket.c:186
 #2  0x0000000000438a2d in getaddr (flags=flags@...1851...=4, hostname=hostname@...1851...=0x7ffff7ee2988 " abc", resolve_retry_seconds=resolve_retry_seconds@...1851...=0, succeeded=succeeded@...1851...=0x7fffffffcba7,
     signal_received=signal_received@...1851...=0x0) at openvpn-2.5.7/src/openvpn/socket.c:202
 #3  0x0000000000430ae5 in ifconfig_pool_read (persist=0x7ffff7ee4510, pool=0x7ffff7edd450) at openvpn-2.5.7/src/openvpn/pool.c:661

So fix it by checking if `struct addrinfo*` pointer is valid before
passing it down to freeaddrinfo().

References: https://github.com/openwrt/openwrt/issues/11890
Signed-off-by: Petr Štetiar <ynezz@...2710...>
---
 src/openvpn/socket.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index a883ac4a156c..d304554cefda 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -172,7 +172,10 @@ get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,
         *sep = '/';
     }
 out:
-    freeaddrinfo(ai);
+    if (ai)
+    {
+        freeaddrinfo(ai);
+    }
     free(var_host);
 
     return ret;

