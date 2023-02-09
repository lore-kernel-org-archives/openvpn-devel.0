From: =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@...2710...>
Date: Thu,  9 Feb 2023 18:26:51 +0100
Message-Id: <20230209172651.6237-1-ynezz@...2710...>
In-Reply-To: <20230209153658.24001-1-ynezz@...2710...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Fix server crash in freeaddrinfo on musl
 libc
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
passing it down to freeaddrinfo() and while at it add there a warning
comment as well.

References: https://github.com/openwrt/openwrt/issues/11890
Signed-off-by: Petr Štetiar <ynezz@...2710...>
---
 src/openvpn/buffer.h | 6 +++++-
 src/openvpn/dns.c    | 7 ++++++-
 src/openvpn/ps.c     | 7 ++++++-
 src/openvpn/socket.c | 8 +++++++-
 4 files changed, 24 insertions(+), 4 deletions(-)

Changes in v2:

 * handle freeaddrinfo in all places and add warning comment (Arne)

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 2461a20703aa..0f10bf00399e 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -214,7 +214,11 @@ bool buf_init_debug(struct buffer *buf, int offset, const char *file, int line);
 static inline void
 gc_freeaddrinfo_callback(void *addr)
 {
-    freeaddrinfo((struct addrinfo *) addr);
+    /* WARNING: musl libc needs valid pointer */
+    if (addr)
+    {
+        freeaddrinfo((struct addrinfo *) addr);
+    }
 }
 
 /** Return an empty struct buffer */
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 9f2a7d5ecaf8..05b87e983272 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -130,7 +130,12 @@ dns_server_addr_parse(struct dns_server *server, const char *addr)
         server->port6 = port;
     }
 
-    freeaddrinfo(ai);
+    /* WARNING: musl libc needs valid pointer */
+    if (ai)
+    {
+        freeaddrinfo(ai);
+    }
+
     return true;
 }
 
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 3609630af779..59f535bf2494 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -841,7 +841,12 @@ port_share_open(const char *host,
                                  host, port,  0, NULL, AF_INET, &ai);
     ASSERT(status==0);
     hostaddr = *((struct sockaddr_in *) ai->ai_addr);
-    freeaddrinfo(ai);
+
+    /* WARNING: musl libc needs valid pointer */
+    if (ai)
+    {
+        freeaddrinfo(ai);
+    }
 
     /*
      * Make a socket for foreground and background processes
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index a883ac4a156c..9f6442698ed1 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -172,7 +172,11 @@ get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,
         *sep = '/';
     }
 out:
-    freeaddrinfo(ai);
+    /* WARNING: musl libc needs valid pointer */
+    if (ai)
+    {
+        freeaddrinfo(ai);
+    }
     free(var_host);
 
     return ret;
@@ -1347,10 +1351,12 @@ socket_listen_accept(socket_descriptor_t sd,
                 {
                     msg(M_ERR, "TCP: close socket failed (new_sd)");
                 }
+                /* WARNING: musl libc needs valid pointer */
                 freeaddrinfo(ai);
             }
             else
             {
+                /* WARNING: musl libc needs valid pointer */
                 if (ai)
                 {
                     freeaddrinfo(ai);

