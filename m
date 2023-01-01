From: selva.nair@...277...
Date: Sun,  1 Jan 2023 16:51:06 -0500
Message-Id: <20230101215109.1521549-3-selva.nair@...277...>
In-Reply-To: <20230101215109.1521549-1-selva.nair@...277...>
References: <20230101215109.1521549-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/5] Refactor signal handling in
 openvpn_getaddrinfo
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

From: Selva Nair <selva.nair@...277...>

Pass in sig_info struct to use register signal instead of
modifying signal_received.

No functional changes though some may be warranted.
Questions:
  - Why are we overwriting SIGUSR1 in this function?
  - Why the special interrupted syscall treatment for getaddrinfo?
    Its not a syscall, is it?

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/socket.c | 31 ++++++++++++++++---------------
 src/openvpn/socket.h |  4 ++--
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 273f378e..faaa2748 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -67,7 +67,7 @@ sf2gaf(const unsigned int getaddr_flags,
 static int
 get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,
                  void *network, unsigned int *netbits,
-                 int resolve_retry_seconds, volatile int *signal_received,
+                 int resolve_retry_seconds, struct signal_info *sig_info,
                  int msglevel)
 {
     char *endp, *sep, *var_host = NULL;
@@ -130,7 +130,7 @@ get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,
     }
 
     ret = openvpn_getaddrinfo(flags & ~GETADDR_HOST_ORDER, var_host, NULL,
-                              resolve_retry_seconds, signal_received, af, &ai);
+                              resolve_retry_seconds, sig_info, af, &ai);
     if ((ret == 0) && network)
     {
         struct in6_addr *ip6;
@@ -183,13 +183,13 @@ getaddr(unsigned int flags,
         const char *hostname,
         int resolve_retry_seconds,
         bool *succeeded,
-        volatile int *signal_received)
+        struct signal_info *sig_info)
 {
     in_addr_t addr;
     int status;
 
     status = get_addr_generic(AF_INET, flags, hostname, &addr, NULL,
-                              resolve_retry_seconds, signal_received,
+                              resolve_retry_seconds, sig_info,
                               M_WARN);
     if (status==0)
     {
@@ -432,13 +432,13 @@ openvpn_getaddrinfo(unsigned int flags,
                     const char *hostname,
                     const char *servname,
                     int resolve_retry_seconds,
-                    volatile int *signal_received,
+                    struct signal_info *sig_info,
                     int ai_family,
                     struct addrinfo **res)
 {
     struct addrinfo hints;
     int status;
-    int sigrec = 0;
+    struct signal_info sigrec = {0};
     int msglevel = (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
     struct gc_arena gc = gc_new();
     const char *print_hostname;
@@ -464,9 +464,9 @@ openvpn_getaddrinfo(unsigned int flags,
     }
 
     if ((flags & (GETADDR_FATAL_ON_SIGNAL|GETADDR_WARN_ON_SIGNAL))
-        && !signal_received)
+        && !sig_info)
     {
-        signal_received = &sigrec;
+        sig_info = &sigrec;
     }
 
     /* try numeric ipv6 addr first */
@@ -561,17 +561,18 @@ openvpn_getaddrinfo(unsigned int flags,
                  flags, hints.ai_family, hints.ai_socktype);
             status = getaddrinfo(hostname, servname, &hints, res);
 
-            if (signal_received)
+            if (sig_info)
             {
-                get_signal(signal_received);
-                if (*signal_received) /* were we interrupted by a signal? */
+                get_signal(&sig_info->signal_received);
+                if (sig_info->signal_received) /* were we interrupted by a signal? */
                 {
-                    if (*signal_received == SIGUSR1) /* ignore SIGUSR1 */
+                    /* why are we overwriting SIGUSR1 ? */
+                    if (sig_info->signal_received == SIGUSR1) /* ignore SIGUSR1 */
                     {
                         msg(level,
                             "RESOLVE: Ignored SIGUSR1 signal received during "
                             "DNS resolution attempt");
-                        *signal_received = 0;
+                        signal_reset(sig_info);
                     }
                     else
                     {
@@ -638,7 +639,7 @@ openvpn_getaddrinfo(unsigned int flags,
     }
 
 done:
-    if (signal_received && *signal_received)
+    if (sig_info && sig_info->signal_received)
     {
         int level = 0;
         if (flags & GETADDR_FATAL_ON_SIGNAL)
@@ -1759,7 +1760,7 @@ resolve_remote(struct link_socket *sock,
             if (status)
             {
                 status = openvpn_getaddrinfo(flags, sock->remote_host, sock->remote_port,
-                                             retry, signal_received, sock->info.af, &ai);
+                                             retry, sig_info, sock->info.af, &ai);
             }
 
             if (status == 0)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 05c31b10..92f1af77 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -526,7 +526,7 @@ in_addr_t getaddr(unsigned int flags,
                   const char *hostname,
                   int resolve_retry_seconds,
                   bool *succeeded,
-                  volatile int *signal_received);
+                  struct signal_info *sig_info);
 
 /**
  * Translate an IPv6 addr or hostname from string form to in6_addr
@@ -538,7 +538,7 @@ int openvpn_getaddrinfo(unsigned int flags,
                         const char *hostname,
                         const char *servname,
                         int resolve_retry_seconds,
-                        volatile int *signal_received,
+                        struct signal_info *sig_info,
                         int ai_family,
                         struct addrinfo **res);
 
-- 
2.34.1


