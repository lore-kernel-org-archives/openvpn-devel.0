From: Gert Doering <gert@...1296...>
Date: Sun, 31 Aug 2025 17:59:32 +0200
Message-ID: <20250831155939.29240-1-gert@...1296...>
In-Reply-To: <gerrit.1756396351000.I7393459b975fb9b3e0a42743f58645f769d1be5a@...2715...>
References: <gerrit.1756396351000.I7393459b975fb9b3e0a42743f58645f769d1be5a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] socket: Create socket_util with
 non-socket functions
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

From: Frank Lichtenheld <frank@...2641...>

This extracts a lot of the helper functions that do not
actually work on sockets, but instead on addresses or
similar.

This includes

- openvpn_getaddrinfo and related functions
- print_*
- setenv_*

And lots of the inline functions.

This move will make it easier to add unit tests
for these moved functions.

Change-Id: I7393459b975fb9b3e0a42743f58645f769d1be5a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1159
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 3866e21..45044af 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -555,6 +555,8 @@
     src/openvpn/sig.h
     src/openvpn/socket.c
     src/openvpn/socket.h
+    src/openvpn/socket_util.c
+    src/openvpn/socket_util.h
     src/openvpn/socks.c
     src/openvpn/socks.h
     src/openvpn/ssl.c
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 1e17c3f..217f897 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -128,6 +128,7 @@
 	shaper.c shaper.h \
 	sig.c sig.h \
 	socket.c socket.h \
+	socket_util.c socket_util.h \
 	socks.c socks.h \
 	ssl.c ssl.h  ssl_backend.h \
 	ssl_openssl.c ssl_openssl.h \
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index a303285..48a2057 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -28,7 +28,7 @@
 
 #include "clinat.h"
 #include "proto.h"
-#include "socket.h"
+#include "socket_util.h"
 #include "memdbg.h"
 
 static bool
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 0a7689f..7abade5 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -27,7 +27,7 @@
 #include "syshead.h"
 
 #include "dhcp.h"
-#include "socket.h"
+#include "socket_util.h"
 #include "error.h"
 
 #include "memdbg.h"
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 8e28c2b..8554089 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -27,7 +27,7 @@
 #include "syshead.h"
 
 #include "dns.h"
-#include "socket.h"
+#include "socket_util.h"
 #include "options.h"
 #include "run_command.h"
 
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 083caf5..b8892c8 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -48,7 +48,7 @@
 
 #include "misc.h"
 #include "event.h"
-#include "socket.h"
+#include "socket_util.h"
 #include "mroute.h"
 
 #define MANAGEMENT_VERSION                  5
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 17f7706..59bf52b 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -72,27 +72,6 @@
 #endif
 }
 
-/*
- * Prepend a random string to hostname to prevent DNS caching.
- * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.gov.
- * Of course, this requires explicit support in the DNS server (wildcard).
- */
-const char *
-hostname_randomize(const char *hostname, struct gc_arena *gc)
-{
-#define n_rnd_bytes 6
-
-    uint8_t rnd_bytes[n_rnd_bytes];
-    const char *rnd_str;
-    struct buffer hname = alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);
-
-    prng_bytes(rnd_bytes, sizeof(rnd_bytes));
-    rnd_str = format_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);
-    buf_printf(&hname, "%s.%s", rnd_str, hostname);
-    return BSTR(&hname);
-#undef n_rnd_bytes
-}
-
 #ifdef ENABLE_MANAGEMENT
 /* Get username/password from the management interface */
 static bool
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 1b10cd9..e87fd85 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -44,9 +44,6 @@
 
 const char **make_extended_arg_array(char **p, bool is_inline, struct gc_arena *gc);
 
-/* prepend a random prefix to hostname */
-const char *hostname_randomize(const char *hostname, struct gc_arena *gc);
-
 /*
  * Get and store a username/password
  */
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index a598037..ab01874 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -30,7 +30,7 @@
 #include "mroute.h"
 #include "proto.h"
 #include "error.h"
-#include "socket.h"
+#include "socket_util.h"
 
 #include "memdbg.h"
 
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 05f12a7..bcbb5a8 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -26,6 +26,7 @@
 #include "proto.h"
 #include "error.h"
 #include "mtu.h"
+#include "socket.h"
 #include "ssl_common.h"
 
 void mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss);
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 0635b5d..e9be3a4 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -30,7 +30,7 @@
 #include "misc.h"
 #include "openvpn.h"
 #include "run_command.h"
-#include "socket.h"
+#include "socket_util.h"
 
 #include <stdbool.h>
 #include <netinet/in.h>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 648d526..74946a4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -45,7 +45,7 @@
 #include "ssl_ncp.h"
 #include "options.h"
 #include "misc.h"
-#include "socket.h"
+#include "socket_util.h"
 #include "packet_id.h"
 #include "pkcs11.h"
 #include "win32.h"
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 4fa6800..44f3fc9 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -33,7 +33,7 @@
 #include "mtu.h"
 #include "route.h"
 #include "tun.h"
-#include "socket.h"
+#include "socket_util.h"
 #include "plugin.h"
 #include "manage.h"
 #include "proxy.h"
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index a41364a..fde6cea 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -29,7 +29,7 @@
 #include "pool.h"
 #include "buffer.h"
 #include "error.h"
-#include "socket.h"
+#include "socket_util.h"
 #include "otime.h"
 
 #include "memdbg.h"
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8fc10bc..306170c 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -405,428 +405,6 @@
     throw_signal_soft(SIGHUP, "Preresolving failed");
 }
 
-/**
- * Small helper function for openvpn_getaddrinfo to print the address
- * family when resolving fails
- */
-static const char *
-getaddrinfo_addr_family_name(int af)
-{
-    switch (af)
-    {
-        case AF_INET:
-            return "[AF_INET]";
-
-        case AF_INET6:
-            return "[AF_INET6]";
-    }
-    return "";
-}
-
-/*
- * Translate IPv4/IPv6 addr or hostname into struct addrinfo
- * If resolve error, try again for resolve_retry_seconds seconds.
- */
-int
-openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *servname,
-                    int resolve_retry_seconds, struct signal_info *sig_info, int ai_family,
-                    struct addrinfo **res)
-{
-    struct addrinfo hints;
-    int status;
-    struct signal_info sigrec = { 0 };
-    int msglevel = (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
-    struct gc_arena gc = gc_new();
-    const char *print_hostname;
-    const char *print_servname;
-
-    ASSERT(res);
-
-    ASSERT(hostname || servname);
-    ASSERT(!(flags & GETADDR_HOST_ORDER));
-
-    if (servname)
-    {
-        print_servname = servname;
-    }
-    else
-    {
-        print_servname = "";
-    }
-
-    if (flags & GETADDR_MSG_VIRT_OUT)
-    {
-        msglevel |= M_MSG_VIRT_OUT;
-    }
-
-    if ((flags & (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) && !sig_info)
-    {
-        sig_info = &sigrec;
-    }
-
-    /* try numeric ip addr first */
-    CLEAR(hints);
-    hints.ai_flags = AI_NUMERICHOST;
-
-    if (flags & GETADDR_PASSIVE)
-    {
-        hints.ai_flags |= AI_PASSIVE;
-    }
-
-    if (flags & GETADDR_DATAGRAM)
-    {
-        hints.ai_socktype = SOCK_DGRAM;
-    }
-    else
-    {
-        hints.ai_socktype = SOCK_STREAM;
-    }
-
-    /* if hostname is not set, we want to bind to 'ANY', with
-     * the correct address family - v4-only or v6/v6-dual-stack */
-    if (!hostname)
-    {
-        hints.ai_family = ai_family;
-    }
-
-    status = getaddrinfo(hostname, servname, &hints, res);
-
-    if (status != 0)                      /* parse as numeric address failed? */
-    {
-        const int fail_wait_interval = 5; /* seconds */
-        /* Add +4 to cause integer division rounding up (1 + 4) = 5, (0+4)/5=0 */
-        int resolve_retries =
-            (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);
-        const char *fmt;
-        int level = 0;
-
-        /* this is not a numeric IP, therefore force resolution using the
-         * provided ai_family */
-        hints.ai_family = ai_family;
-
-        if (hostname && (flags & GETADDR_RANDOMIZE))
-        {
-            hostname = hostname_randomize(hostname, &gc);
-        }
-
-        if (hostname)
-        {
-            print_hostname = hostname;
-        }
-        else
-        {
-            print_hostname = "undefined";
-        }
-
-        fmt = "RESOLVE: Cannot resolve host address: %s:%s%s (%s)";
-        if ((flags & GETADDR_MENTION_RESOLVE_RETRY) && !resolve_retry_seconds)
-        {
-            fmt = "RESOLVE: Cannot resolve host address: %s:%s%s (%s)"
-                  "(I would have retried this name query if you had "
-                  "specified the --resolv-retry option.)";
-        }
-
-        if (!(flags & GETADDR_RESOLVE) || status == EAI_FAIL)
-        {
-            msg(msglevel, "RESOLVE: Cannot parse IP address: %s:%s (%s)", print_hostname,
-                print_servname, gai_strerror(status));
-            goto done;
-        }
-
-#ifdef ENABLE_MANAGEMENT
-        if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
-        {
-            if (management)
-            {
-                management_set_state(management, OPENVPN_STATE_RESOLVE, NULL, NULL, NULL, NULL,
-                                     NULL);
-            }
-        }
-#endif
-
-        /*
-         * Resolve hostname
-         */
-        while (true)
-        {
-#ifndef _WIN32
-            /* force resolv.conf reload */
-            res_init();
-#endif
-            /* try hostname lookup */
-            hints.ai_flags &= ~AI_NUMERICHOST;
-            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d", flags,
-                 hints.ai_family, hints.ai_socktype);
-            status = getaddrinfo(hostname, servname, &hints, res);
-
-            if (sig_info)
-            {
-                get_signal(&sig_info->signal_received);
-                if (sig_info->signal_received) /* were we interrupted by a signal? */
-                {
-                    /* why are we overwriting SIGUSR1 ? */
-                    if (signal_reset(sig_info, SIGUSR1) == SIGUSR1) /* ignore SIGUSR1 */
-                    {
-                        msg(level, "RESOLVE: Ignored SIGUSR1 signal received during "
-                                   "DNS resolution attempt");
-                    }
-                    else
-                    {
-                        /* turn success into failure (interrupted syscall) */
-                        if (0 == status)
-                        {
-                            ASSERT(res);
-                            freeaddrinfo(*res);
-                            *res = NULL;
-                            status = EAI_AGAIN; /* = temporary failure */
-                            errno = EINTR;
-                        }
-                        goto done;
-                    }
-                }
-            }
-
-            /* success? */
-            if (0 == status)
-            {
-                break;
-            }
-
-            /* resolve lookup failed, should we
-             * continue or fail? */
-            level = msglevel;
-            if (resolve_retries > 0)
-            {
-                level = D_RESOLVE_ERRORS;
-            }
-
-            msg(level, fmt, print_hostname, print_servname, getaddrinfo_addr_family_name(ai_family),
-                gai_strerror(status));
-
-            if (--resolve_retries <= 0)
-            {
-                goto done;
-            }
-
-            management_sleep(fail_wait_interval);
-        }
-
-        ASSERT(res);
-
-        /* hostname resolve succeeded */
-
-        /*
-         * Do not choose an IP Addresse by random or change the order *
-         * of IP addresses, doing so will break RFC 3484 address selection *
-         */
-    }
-    else
-    {
-        /* IP address parse succeeded */
-        if (flags & GETADDR_RANDOMIZE)
-        {
-            msg(M_WARN, "WARNING: ignoring --remote-random-hostname because the "
-                        "hostname is an IP address");
-        }
-    }
-
-done:
-    if (sig_info && sig_info->signal_received)
-    {
-        int level = 0;
-        if (flags & GETADDR_FATAL_ON_SIGNAL)
-        {
-            level = M_FATAL;
-        }
-        else if (flags & GETADDR_WARN_ON_SIGNAL)
-        {
-            level = M_WARN;
-        }
-        msg(level, "RESOLVE: signal received during DNS resolution attempt");
-    }
-
-    gc_free(&gc);
-    return status;
-}
-
-/*
- * We do our own inet_aton because the glibc function
- * isn't very good about error checking.
- */
-int
-openvpn_inet_aton(const char *dotted_quad, struct in_addr *addr)
-{
-    unsigned int a, b, c, d;
-
-    CLEAR(*addr);
-    if (sscanf(dotted_quad, "%u.%u.%u.%u", &a, &b, &c, &d) == 4)
-    {
-        if (a < 256 && b < 256 && c < 256 && d < 256)
-        {
-            addr->s_addr = htonl(a << 24 | b << 16 | c << 8 | d);
-            return OIA_IP; /* good dotted quad */
-        }
-    }
-    if (string_class(dotted_quad, CC_DIGIT | CC_DOT, 0))
-    {
-        return OIA_ERROR; /* probably a badly formatted dotted quad */
-    }
-    else
-    {
-        return OIA_HOSTNAME; /* probably a hostname */
-    }
-}
-
-bool
-ip_addr_dotted_quad_safe(const char *dotted_quad)
-{
-    /* verify non-NULL */
-    if (!dotted_quad)
-    {
-        return false;
-    }
-
-    /* verify length is within limits */
-    if (strlen(dotted_quad) > 15)
-    {
-        return false;
-    }
-
-    /* verify that all chars are either numeric or '.' and that no numeric
-     * substring is greater than 3 chars */
-    {
-        int nnum = 0;
-        const char *p = dotted_quad;
-        int c;
-
-        while ((c = *p++))
-        {
-            if (c >= '0' && c <= '9')
-            {
-                ++nnum;
-                if (nnum > 3)
-                {
-                    return false;
-                }
-            }
-            else if (c == '.')
-            {
-                nnum = 0;
-            }
-            else
-            {
-                return false;
-            }
-        }
-    }
-
-    /* verify that string will convert to IP address */
-    {
-        struct in_addr a;
-        return openvpn_inet_aton(dotted_quad, &a) == OIA_IP;
-    }
-}
-
-bool
-ipv6_addr_safe(const char *ipv6_text_addr)
-{
-    /* verify non-NULL */
-    if (!ipv6_text_addr)
-    {
-        return false;
-    }
-
-    /* verify length is within limits */
-    if (strlen(ipv6_text_addr) > INET6_ADDRSTRLEN)
-    {
-        return false;
-    }
-
-    /* verify that string will convert to IPv6 address */
-    {
-        struct in6_addr a6;
-        return inet_pton(AF_INET6, ipv6_text_addr, &a6) == 1;
-    }
-}
-
-static bool
-dns_addr_safe(const char *addr)
-{
-    if (addr)
-    {
-        const size_t len = strlen(addr);
-        return len > 0 && len <= 255 && string_class(addr, CC_ALNUM | CC_DASH | CC_DOT, 0);
-    }
-    else
-    {
-        return false;
-    }
-}
-
-bool
-ip_or_dns_addr_safe(const char *addr, const bool allow_fqdn)
-{
-    if (ip_addr_dotted_quad_safe(addr))
-    {
-        return true;
-    }
-    else if (allow_fqdn)
-    {
-        return dns_addr_safe(addr);
-    }
-    else
-    {
-        return false;
-    }
-}
-
-bool
-mac_addr_safe(const char *mac_addr)
-{
-    /* verify non-NULL */
-    if (!mac_addr)
-    {
-        return false;
-    }
-
-    /* verify length is within limits */
-    if (strlen(mac_addr) > 17)
-    {
-        return false;
-    }
-
-    /* verify that all chars are either alphanumeric or ':' and that no
-     * alphanumeric substring is greater than 2 chars */
-    {
-        int nnum = 0;
-        const char *p = mac_addr;
-        int c;
-
-        while ((c = *p++))
-        {
-            if ((c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'))
-            {
-                ++nnum;
-                if (nnum > 2)
-                {
-                    return false;
-                }
-            }
-            else if (c == ':')
-            {
-                nnum = 0;
-            }
-            else
-            {
-                return false;
-            }
-        }
-    }
-
-    /* error-checking is left to script invoked in lladdr.c */
-    return true;
-}
-
 static int
 socket_get_sndbuf(socket_descriptor_t sd)
 {
@@ -2670,467 +2248,6 @@
 #endif
 }
 
-/*
- * Format IP addresses in ascii
- */
-
-const char *
-print_sockaddr_ex(const struct sockaddr *sa, const char *separator, const unsigned int flags,
-                  struct gc_arena *gc)
-{
-    struct buffer out = alloc_buf_gc(128, gc);
-    bool addr_is_defined = false;
-    char hostaddr[NI_MAXHOST] = "";
-    char servname[NI_MAXSERV] = "";
-    int status;
-
-    socklen_t salen = 0;
-    switch (sa->sa_family)
-    {
-        case AF_INET:
-            if (!(flags & PS_DONT_SHOW_FAMILY))
-            {
-                buf_puts(&out, "[AF_INET]");
-            }
-            salen = sizeof(struct sockaddr_in);
-            addr_is_defined = ((struct sockaddr_in *)sa)->sin_addr.s_addr != 0;
-            break;
-
-        case AF_INET6:
-            if (!(flags & PS_DONT_SHOW_FAMILY))
-            {
-                buf_puts(&out, "[AF_INET6]");
-            }
-            salen = sizeof(struct sockaddr_in6);
-            addr_is_defined = !IN6_IS_ADDR_UNSPECIFIED(&((struct sockaddr_in6 *)sa)->sin6_addr);
-            break;
-
-        case AF_UNSPEC:
-            if (!(flags & PS_DONT_SHOW_FAMILY))
-            {
-                return "[AF_UNSPEC]";
-            }
-            else
-            {
-                return "";
-            }
-
-        default:
-            ASSERT(0);
-    }
-
-    status = getnameinfo(sa, salen, hostaddr, sizeof(hostaddr), servname, sizeof(servname),
-                         NI_NUMERICHOST | NI_NUMERICSERV);
-
-    if (status != 0)
-    {
-        buf_printf(&out, "[nameinfo() err: %s]", gai_strerror(status));
-        return BSTR(&out);
-    }
-
-    if (!(flags & PS_DONT_SHOW_ADDR))
-    {
-        if (addr_is_defined)
-        {
-            buf_puts(&out, hostaddr);
-        }
-        else
-        {
-            buf_puts(&out, "[undef]");
-        }
-    }
-
-    if ((flags & PS_SHOW_PORT) || (flags & PS_SHOW_PORT_IF_DEFINED))
-    {
-        if (separator)
-        {
-            buf_puts(&out, separator);
-        }
-
-        buf_puts(&out, servname);
-    }
-
-    return BSTR(&out);
-}
-
-const char *
-print_link_socket_actual(const struct link_socket_actual *act, struct gc_arena *gc)
-{
-    return print_link_socket_actual_ex(act, ":", PS_SHOW_PORT | PS_SHOW_PKTINFO, gc);
-}
-
-#ifndef IF_NAMESIZE
-#define IF_NAMESIZE 16
-#endif
-
-const char *
-print_link_socket_actual_ex(const struct link_socket_actual *act, const char *separator,
-                            const unsigned int flags, struct gc_arena *gc)
-{
-    if (act)
-    {
-        struct buffer out = alloc_buf_gc(128, gc);
-        buf_printf(&out, "%s", print_sockaddr_ex(&act->dest.addr.sa, separator, flags, gc));
-#if ENABLE_IP_PKTINFO
-        char ifname[IF_NAMESIZE] = "[undef]";
-
-        if ((flags & PS_SHOW_PKTINFO) && addr_defined_ipi(act))
-        {
-            switch (act->dest.addr.sa.sa_family)
-            {
-                case AF_INET:
-                {
-                    struct openvpn_sockaddr sa;
-                    CLEAR(sa);
-                    sa.addr.in4.sin_family = AF_INET;
-#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-                    sa.addr.in4.sin_addr = act->pi.in4.ipi_spec_dst;
-                    if_indextoname(act->pi.in4.ipi_ifindex, ifname);
-#elif defined(IP_RECVDSTADDR)
-                    sa.addr.in4.sin_addr = act->pi.in4;
-                    ifname[0] = 0;
-#else /* if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST) */
-#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)
-#endif
-                    buf_printf(&out, " (via %s%%%s)",
-                               print_sockaddr_ex(&sa.addr.sa, separator, 0, gc), ifname);
-                }
-                break;
-
-                case AF_INET6:
-                {
-                    struct sockaddr_in6 sin6;
-                    char buf[INET6_ADDRSTRLEN] = "[undef]";
-                    CLEAR(sin6);
-                    sin6.sin6_family = AF_INET6;
-                    sin6.sin6_addr = act->pi.in6.ipi6_addr;
-                    if_indextoname(act->pi.in6.ipi6_ifindex, ifname);
-                    if (getnameinfo((struct sockaddr *)&sin6, sizeof(struct sockaddr_in6), buf,
-                                    sizeof(buf), NULL, 0, NI_NUMERICHOST)
-                        == 0)
-                    {
-                        buf_printf(&out, " (via %s%%%s)", buf, ifname);
-                    }
-                    else
-                    {
-                        buf_printf(&out, " (via [getnameinfo() err]%%%s)", ifname);
-                    }
-                }
-                break;
-            }
-        }
-#endif /* if ENABLE_IP_PKTINFO */
-        return BSTR(&out);
-    }
-    else
-    {
-        return "[NULL]";
-    }
-}
-
-/*
- * Convert an in_addr_t in host byte order
- * to an ascii dotted quad.
- */
-const char *
-print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_arena *gc)
-{
-    struct in_addr ia;
-    char *out = gc_malloc(INET_ADDRSTRLEN, true, gc);
-
-    if (addr || !(flags & IA_EMPTY_IF_UNDEF))
-    {
-        CLEAR(ia);
-        ia.s_addr = (flags & IA_NET_ORDER) ? addr : htonl(addr);
-
-        inet_ntop(AF_INET, &ia, out, INET_ADDRSTRLEN);
-    }
-    return out;
-}
-
-/*
- * Convert an in6_addr in host byte order
- * to an ascii representation of an IPv6 address
- */
-const char *
-print_in6_addr(struct in6_addr a6, unsigned int flags, struct gc_arena *gc)
-{
-    char *out = gc_malloc(INET6_ADDRSTRLEN, true, gc);
-
-    if (memcmp(&a6, &in6addr_any, sizeof(a6)) != 0 || !(flags & IA_EMPTY_IF_UNDEF))
-    {
-        inet_ntop(AF_INET6, &a6, out, INET6_ADDRSTRLEN);
-    }
-    return out;
-}
-
-/*
- * Convert an in_port_t in host byte order to a string
- */
-const char *
-print_in_port_t(in_port_t port, struct gc_arena *gc)
-{
-    struct buffer buffer = alloc_buf_gc(8, gc);
-    buf_printf(&buffer, "%hu", port);
-    return BSTR(&buffer);
-}
-
-/* add some offset to an ipv6 address
- * (add in steps of 8 bits, taking overflow into next round)
- */
-struct in6_addr
-add_in6_addr(struct in6_addr base, uint32_t add)
-{
-    int i;
-
-    for (i = 15; i >= 0 && add > 0; i--)
-    {
-        register int carry;
-        register uint32_t h;
-
-        h = (unsigned char)base.s6_addr[i];
-        base.s6_addr[i] = (h + add) & UINT8_MAX;
-
-        /* using explicit carry for the 8-bit additions will catch
-         * 8-bit and(!) 32-bit overruns nicely
-         */
-        carry = ((h & 0xff) + (add & 0xff)) >> 8;
-        add = (add >> 8) + carry;
-    }
-    return base;
-}
-
-/* set environmental variables for ip/port in *addr */
-void
-setenv_sockaddr(struct env_set *es, const char *name_prefix, const struct openvpn_sockaddr *addr,
-                const unsigned int flags)
-{
-    char name_buf[256];
-
-    char buf[INET6_ADDRSTRLEN];
-    switch (addr->addr.sa.sa_family)
-    {
-        case AF_INET:
-            if (flags & SA_IP_PORT)
-            {
-                snprintf(name_buf, sizeof(name_buf), "%s_ip", name_prefix);
-            }
-            else
-            {
-                snprintf(name_buf, sizeof(name_buf), "%s", name_prefix);
-            }
-
-            inet_ntop(AF_INET, &addr->addr.in4.sin_addr, buf, sizeof(buf));
-            setenv_str(es, name_buf, buf);
-
-            if ((flags & SA_IP_PORT) && addr->addr.in4.sin_port)
-            {
-                snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefix);
-                setenv_int(es, name_buf, ntohs(addr->addr.in4.sin_port));
-            }
-            break;
-
-        case AF_INET6:
-            if (IN6_IS_ADDR_V4MAPPED(&addr->addr.in6.sin6_addr))
-            {
-                struct in_addr ia;
-                memcpy(&ia.s_addr, &addr->addr.in6.sin6_addr.s6_addr[12], sizeof(ia.s_addr));
-                snprintf(name_buf, sizeof(name_buf), "%s_ip", name_prefix);
-                inet_ntop(AF_INET, &ia, buf, sizeof(buf));
-            }
-            else
-            {
-                snprintf(name_buf, sizeof(name_buf), "%s_ip6", name_prefix);
-                inet_ntop(AF_INET6, &addr->addr.in6.sin6_addr, buf, sizeof(buf));
-            }
-            setenv_str(es, name_buf, buf);
-
-            if ((flags & SA_IP_PORT) && addr->addr.in6.sin6_port)
-            {
-                snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefix);
-                setenv_int(es, name_buf, ntohs(addr->addr.in6.sin6_port));
-            }
-            break;
-    }
-}
-
-void
-setenv_in_addr_t(struct env_set *es, const char *name_prefix, in_addr_t addr,
-                 const unsigned int flags)
-{
-    if (addr || !(flags & SA_SET_IF_NONZERO))
-    {
-        struct openvpn_sockaddr si;
-        CLEAR(si);
-        si.addr.in4.sin_family = AF_INET;
-        si.addr.in4.sin_addr.s_addr = htonl(addr);
-        setenv_sockaddr(es, name_prefix, &si, flags);
-    }
-}
-
-void
-setenv_in6_addr(struct env_set *es, const char *name_prefix, const struct in6_addr *addr,
-                const unsigned int flags)
-{
-    if (!IN6_IS_ADDR_UNSPECIFIED(addr) || !(flags & SA_SET_IF_NONZERO))
-    {
-        struct openvpn_sockaddr si;
-        CLEAR(si);
-        si.addr.in6.sin6_family = AF_INET6;
-        si.addr.in6.sin6_addr = *addr;
-        setenv_sockaddr(es, name_prefix, &si, flags);
-    }
-}
-
-void
-setenv_link_socket_actual(struct env_set *es, const char *name_prefix,
-                          const struct link_socket_actual *act, const unsigned int flags)
-{
-    setenv_sockaddr(es, name_prefix, &act->dest, flags);
-}
-
-/*
- * Convert protocol names between index and ascii form.
- */
-
-struct proto_names
-{
-    const char *short_form;
-    const char *display_form;
-    sa_family_t proto_af;
-    int proto;
-};
-
-/* Indexed by PROTO_x */
-static const struct proto_names proto_names[] = {
-    { "proto-uninitialized", "proto-NONE", AF_UNSPEC, PROTO_NONE },
-    /* try IPv4 and IPv6 (client), bind dual-stack (server) */
-    { "udp", "UDP", AF_UNSPEC, PROTO_UDP },
-    { "tcp-server", "TCP_SERVER", AF_UNSPEC, PROTO_TCP_SERVER },
-    { "tcp-client", "TCP_CLIENT", AF_UNSPEC, PROTO_TCP_CLIENT },
-    { "tcp", "TCP", AF_UNSPEC, PROTO_TCP },
-    /* force IPv4 */
-    { "udp4", "UDPv4", AF_INET, PROTO_UDP },
-    { "tcp4-server", "TCPv4_SERVER", AF_INET, PROTO_TCP_SERVER },
-    { "tcp4-client", "TCPv4_CLIENT", AF_INET, PROTO_TCP_CLIENT },
-    { "tcp4", "TCPv4", AF_INET, PROTO_TCP },
-    /* force IPv6 */
-    { "udp6", "UDPv6", AF_INET6, PROTO_UDP },
-    { "tcp6-server", "TCPv6_SERVER", AF_INET6, PROTO_TCP_SERVER },
-    { "tcp6-client", "TCPv6_CLIENT", AF_INET6, PROTO_TCP_CLIENT },
-    { "tcp6", "TCPv6", AF_INET6, PROTO_TCP },
-};
-
-int
-ascii2proto(const char *proto_name)
-{
-    for (size_t i = 0; i < SIZE(proto_names); ++i)
-    {
-        if (!strcmp(proto_name, proto_names[i].short_form))
-        {
-            return proto_names[i].proto;
-        }
-    }
-    return -1;
-}
-
-sa_family_t
-ascii2af(const char *proto_name)
-{
-    for (size_t i = 0; i < SIZE(proto_names); ++i)
-    {
-        if (!strcmp(proto_name, proto_names[i].short_form))
-        {
-            return proto_names[i].proto_af;
-        }
-    }
-    return 0;
-}
-
-const char *
-proto2ascii(int proto, sa_family_t af, bool display_form)
-{
-    for (size_t i = 0; i < SIZE(proto_names); ++i)
-    {
-        if (proto_names[i].proto_af == af && proto_names[i].proto == proto)
-        {
-            if (display_form)
-            {
-                return proto_names[i].display_form;
-            }
-            else
-            {
-                return proto_names[i].short_form;
-            }
-        }
-    }
-
-    return "[unknown protocol]";
-}
-
-const char *
-proto2ascii_all(struct gc_arena *gc)
-{
-    struct buffer out = alloc_buf_gc(256, gc);
-
-    for (size_t i = 0; i < SIZE(proto_names); ++i)
-    {
-        if (i)
-        {
-            buf_printf(&out, " ");
-        }
-        buf_printf(&out, "[%s]", proto_names[i].short_form);
-    }
-    return BSTR(&out);
-}
-
-const char *
-addr_family_name(int af)
-{
-    switch (af)
-    {
-        case AF_INET:
-            return "AF_INET";
-
-        case AF_INET6:
-            return "AF_INET6";
-    }
-    return "AF_UNSPEC";
-}
-
-/*
- * Given a local proto, return local proto
- * if !remote, or compatible remote proto
- * if remote.
- *
- * This is used for options compatibility
- * checking.
- *
- * IPv6 and IPv4 protocols are comptabile but OpenVPN
- * has always sent UDPv4, TCPv4 over the wire. Keep these
- * strings for backward compatibility
- */
-const char *
-proto_remote(int proto, bool remote)
-{
-    ASSERT(proto >= 0 && proto < PROTO_N);
-    if (proto == PROTO_UDP)
-    {
-        return "UDPv4";
-    }
-
-    if ((remote && proto == PROTO_TCP_CLIENT) || (!remote && proto == PROTO_TCP_SERVER))
-    {
-        return "TCPv4_SERVER";
-    }
-    if ((remote && proto == PROTO_TCP_SERVER) || (!remote && proto == PROTO_TCP_CLIENT))
-    {
-        return "TCPv4_CLIENT";
-    }
-
-    ASSERT(0);
-    return ""; /* Make the compiler happy */
-}
 
 /*
  * Bad incoming address lengths that differ from what
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index ed37590..cce9183 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -34,6 +34,7 @@
 #include "socks.h"
 #include "misc.h"
 #include "tun.h"
+#include "socket_util.h"
 
 /*
  * OpenVPN's default port number as assigned by IANA.
@@ -60,18 +61,6 @@
 /* convert a packet_size_type from network to host order */
 #define ntohps(x) ntohs(x)
 
-/* OpenVPN sockaddr struct */
-struct openvpn_sockaddr
-{
-    /*int dummy;*/ /* add offset to force a bug if sa not explicitly dereferenced */
-    union
-    {
-        struct sockaddr sa;
-        struct sockaddr_in in4;
-        struct sockaddr_in6 in6;
-    } addr;
-};
-
 /* struct to hold preresolved host names */
 struct cached_dns_entry
 {
@@ -83,25 +72,6 @@
     struct cached_dns_entry *next;
 };
 
-/* actual address of remote, based on source address of received packets */
-struct link_socket_actual
-{
-    /*int dummy;*/ /* add offset to force a bug if dest not explicitly dereferenced */
-
-    struct openvpn_sockaddr dest;
-#if ENABLE_IP_PKTINFO
-    union
-    {
-#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-        struct in_pktinfo in4;
-#elif defined(IP_RECVDSTADDR)
-        struct in_addr in4;
-#endif
-        struct in6_pktinfo in6;
-    } pi;
-#endif
-};
-
 /* IP addresses which are persistent across SIGUSR1s */
 struct link_socket_addr
 {
@@ -349,58 +319,6 @@
 
 void sd_close(socket_descriptor_t *sd);
 
-#define PS_SHOW_PORT_IF_DEFINED (1 << 0)
-#define PS_SHOW_PORT            (1 << 1)
-#define PS_SHOW_PKTINFO         (1 << 2)
-#define PS_DONT_SHOW_ADDR       (1 << 3)
-#define PS_DONT_SHOW_FAMILY     (1 << 4)
-
-const char *print_sockaddr_ex(const struct sockaddr *addr, const char *separator,
-                              const unsigned int flags, struct gc_arena *gc);
-
-static inline const char *
-print_openvpn_sockaddr(const struct openvpn_sockaddr *addr, struct gc_arena *gc)
-{
-    return print_sockaddr_ex(&addr->addr.sa, ":", PS_SHOW_PORT, gc);
-}
-
-static inline const char *
-print_sockaddr(const struct sockaddr *addr, struct gc_arena *gc)
-{
-    return print_sockaddr_ex(addr, ":", PS_SHOW_PORT, gc);
-}
-
-
-const char *print_link_socket_actual_ex(const struct link_socket_actual *act, const char *separator,
-                                        const unsigned int flags, struct gc_arena *gc);
-
-const char *print_link_socket_actual(const struct link_socket_actual *act, struct gc_arena *gc);
-
-
-#define IA_EMPTY_IF_UNDEF (1 << 0)
-#define IA_NET_ORDER      (1 << 1)
-const char *print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_arena *gc);
-
-const char *print_in6_addr(struct in6_addr addr6, unsigned int flags, struct gc_arena *gc);
-
-const char *print_in_port_t(in_port_t port, struct gc_arena *gc);
-
-struct in6_addr add_in6_addr(struct in6_addr base, uint32_t add);
-
-#define SA_IP_PORT        (1 << 0)
-#define SA_SET_IF_NONZERO (1 << 1)
-void setenv_sockaddr(struct env_set *es, const char *name_prefix,
-                     const struct openvpn_sockaddr *addr, const unsigned int flags);
-
-void setenv_in_addr_t(struct env_set *es, const char *name_prefix, in_addr_t addr,
-                      const unsigned int flags);
-
-void setenv_in6_addr(struct env_set *es, const char *name_prefix, const struct in6_addr *addr,
-                     const unsigned int flags);
-
-void setenv_link_socket_actual(struct env_set *es, const char *name_prefix,
-                               const struct link_socket_actual *act, const unsigned int flags);
-
 void bad_address_length(int actual, int expected);
 
 /* IPV4_INVALID_ADDR: returned by link_socket_current_remote()
@@ -432,21 +350,6 @@
  * Low-level functions
  */
 
-/* return values of openvpn_inet_aton */
-#define OIA_HOSTNAME 0
-#define OIA_IP       1
-#define OIA_ERROR    -1
-int openvpn_inet_aton(const char *dotted_quad, struct in_addr *addr);
-
-/* integrity validation on pulled options */
-bool ip_addr_dotted_quad_safe(const char *dotted_quad);
-
-bool ip_or_dns_addr_safe(const char *addr, const bool allow_fqdn);
-
-bool mac_addr_safe(const char *mac_addr);
-
-bool ipv6_addr_safe(const char *ipv6_text_addr);
-
 socket_descriptor_t create_socket_tcp(struct addrinfo *);
 
 socket_descriptor_t socket_do_accept(socket_descriptor_t sd, struct link_socket_actual *act,
@@ -472,134 +375,6 @@
 
 #endif /* if UNIX_SOCK_SUPPORT */
 
-/*
- * DNS resolution
- */
-
-#define GETADDR_RESOLVE                 (1 << 0)
-#define GETADDR_FATAL                   (1 << 1)
-#define GETADDR_HOST_ORDER              (1 << 2)
-#define GETADDR_MENTION_RESOLVE_RETRY   (1 << 3)
-#define GETADDR_FATAL_ON_SIGNAL         (1 << 4)
-#define GETADDR_WARN_ON_SIGNAL          (1 << 5)
-#define GETADDR_MSG_VIRT_OUT            (1 << 6)
-#define GETADDR_TRY_ONCE                (1 << 7)
-#define GETADDR_UPDATE_MANAGEMENT_STATE (1 << 8)
-#define GETADDR_RANDOMIZE               (1 << 9)
-#define GETADDR_PASSIVE                 (1 << 10)
-#define GETADDR_DATAGRAM                (1 << 11)
-
-#define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)
-
-/**
- * Translate an IPv4 addr or hostname from string form to in_addr_t
- *
- * In case of resolve error, it will try again for
- * resolve_retry_seconds seconds.
- */
-in_addr_t getaddr(unsigned int flags, const char *hostname, int resolve_retry_seconds,
-                  bool *succeeded, struct signal_info *sig_info);
-
-/**
- * Translate an IPv6 addr or hostname from string form to in6_addr
- */
-bool get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int *netbits,
-                   int msglevel);
-
-int openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *servname,
-                        int resolve_retry_seconds, struct signal_info *sig_info, int ai_family,
-                        struct addrinfo **res);
-
-/*
- * Transport protocol naming and other details.
- */
-
-/*
- * Use enum's instead of #define to allow for easier
- * optional proto support
- */
-enum proto_num
-{
-    PROTO_NONE, /* catch for uninitialized */
-    PROTO_UDP,
-    PROTO_TCP,
-    PROTO_TCP_SERVER,
-    PROTO_TCP_CLIENT,
-    PROTO_N
-};
-
-static inline bool
-proto_is_net(int proto)
-{
-    ASSERT(proto >= 0 && proto < PROTO_N);
-    return proto != PROTO_NONE;
-}
-
-/**
- * @brief Returns if the protocol being used is UDP
- */
-static inline bool
-proto_is_udp(int proto)
-{
-    ASSERT(proto >= 0 && proto < PROTO_N);
-    return proto == PROTO_UDP;
-}
-
-/**
- * @brief Return if the protocol is datagram (UDP)
- *
- */
-static inline bool
-proto_is_dgram(int proto)
-{
-    return proto_is_udp(proto);
-}
-
-/**
- * @brief returns if the proto is a TCP variant (tcp-server, tcp-client or tcp)
- */
-static inline bool
-proto_is_tcp(int proto)
-{
-    ASSERT(proto >= 0 && proto < PROTO_N);
-    return proto == PROTO_TCP_CLIENT || proto == PROTO_TCP_SERVER;
-}
-
-
-int ascii2proto(const char *proto_name);
-
-sa_family_t ascii2af(const char *proto_name);
-
-const char *proto2ascii(int proto, sa_family_t af, bool display_form);
-
-const char *proto2ascii_all(struct gc_arena *gc);
-
-const char *proto_remote(int proto, bool remote);
-
-const char *addr_family_name(int af);
-
-/*
- * Overhead added to packets by various protocols.
- */
-static inline int
-datagram_overhead(sa_family_t af, int proto)
-{
-    int overhead = 0;
-    overhead += (proto == PROTO_UDP) ? 8 : 20;
-    overhead += (af == AF_INET) ? 20 : 40;
-    return overhead;
-}
-
-/*
- * Misc inline functions
- */
-
-static inline bool
-link_socket_proto_connection_oriented(int proto)
-{
-    return !proto_is_dgram(proto);
-}
-
 static inline bool
 link_socket_connection_oriented(const struct link_socket *sock)
 {
@@ -613,242 +388,6 @@
     }
 }
 
-static inline bool
-addr_defined(const struct openvpn_sockaddr *addr)
-{
-    if (!addr)
-    {
-        return 0;
-    }
-    switch (addr->addr.sa.sa_family)
-    {
-        case AF_INET:
-            return addr->addr.in4.sin_addr.s_addr != 0;
-
-        case AF_INET6:
-            return !IN6_IS_ADDR_UNSPECIFIED(&addr->addr.in6.sin6_addr);
-
-        default:
-            return 0;
-    }
-}
-
-static inline bool
-addr_local(const struct sockaddr *addr)
-{
-    if (!addr)
-    {
-        return false;
-    }
-    switch (addr->sa_family)
-    {
-        case AF_INET:
-            return ((const struct sockaddr_in *)addr)->sin_addr.s_addr == htonl(INADDR_LOOPBACK);
-
-        case AF_INET6:
-            return IN6_IS_ADDR_LOOPBACK(&((const struct sockaddr_in6 *)addr)->sin6_addr);
-
-        default:
-            return false;
-    }
-}
-
-
-static inline bool
-addr_defined_ipi(const struct link_socket_actual *lsa)
-{
-#if ENABLE_IP_PKTINFO
-    if (!lsa)
-    {
-        return 0;
-    }
-    switch (lsa->dest.addr.sa.sa_family)
-    {
-#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-        case AF_INET:
-            return lsa->pi.in4.ipi_spec_dst.s_addr != 0;
-
-#elif defined(IP_RECVDSTADDR)
-        case AF_INET:
-            return lsa->pi.in4.s_addr != 0;
-
-#endif
-        case AF_INET6:
-            return !IN6_IS_ADDR_UNSPECIFIED(&lsa->pi.in6.ipi6_addr);
-
-        default:
-            return 0;
-    }
-#else /* if ENABLE_IP_PKTINFO */
-    ASSERT(0);
-#endif
-    return false;
-}
-
-static inline bool
-link_socket_actual_defined(const struct link_socket_actual *act)
-{
-    return act && addr_defined(&act->dest);
-}
-
-static inline bool
-addr_match(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)
-{
-    switch (a1->addr.sa.sa_family)
-    {
-        case AF_INET:
-            return a1->addr.in4.sin_addr.s_addr == a2->addr.in4.sin_addr.s_addr;
-
-        case AF_INET6:
-            return IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &a2->addr.in6.sin6_addr);
-    }
-    ASSERT(0);
-    return false;
-}
-
-static inline bool
-addrlist_match(const struct openvpn_sockaddr *a1, const struct addrinfo *addrlist)
-{
-    const struct addrinfo *curele;
-    for (curele = addrlist; curele; curele = curele->ai_next)
-    {
-        switch (a1->addr.sa.sa_family)
-        {
-            case AF_INET:
-                if (a1->addr.in4.sin_addr.s_addr
-                    == ((struct sockaddr_in *)curele->ai_addr)->sin_addr.s_addr)
-                {
-                    return true;
-                }
-                break;
-
-            case AF_INET6:
-                if (IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr,
-                                       &((struct sockaddr_in6 *)curele->ai_addr)->sin6_addr))
-                {
-                    return true;
-                }
-                break;
-
-            default:
-                ASSERT(0);
-        }
-    }
-    return false;
-}
-
-static inline bool
-addrlist_port_match(const struct openvpn_sockaddr *a1, const struct addrinfo *a2)
-{
-    const struct addrinfo *curele;
-    for (curele = a2; curele; curele = curele->ai_next)
-    {
-        switch (a1->addr.sa.sa_family)
-        {
-            case AF_INET:
-                if (curele->ai_family == AF_INET
-                    && a1->addr.in4.sin_addr.s_addr
-                           == ((struct sockaddr_in *)curele->ai_addr)->sin_addr.s_addr
-                    && a1->addr.in4.sin_port == ((struct sockaddr_in *)curele->ai_addr)->sin_port)
-                {
-                    return true;
-                }
-                break;
-
-            case AF_INET6:
-                if (curele->ai_family == AF_INET6
-                    && IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr,
-                                          &((struct sockaddr_in6 *)curele->ai_addr)->sin6_addr)
-                    && a1->addr.in6.sin6_port
-                           == ((struct sockaddr_in6 *)curele->ai_addr)->sin6_port)
-                {
-                    return true;
-                }
-                break;
-
-            default:
-                ASSERT(0);
-        }
-    }
-    return false;
-}
-
-
-static inline bool
-addr_port_match(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)
-{
-    switch (a1->addr.sa.sa_family)
-    {
-        case AF_INET:
-            return a1->addr.in4.sin_addr.s_addr == a2->addr.in4.sin_addr.s_addr
-                   && a1->addr.in4.sin_port == a2->addr.in4.sin_port;
-
-        case AF_INET6:
-            return IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &a2->addr.in6.sin6_addr)
-                   && a1->addr.in6.sin6_port == a2->addr.in6.sin6_port;
-    }
-    ASSERT(0);
-    return false;
-}
-
-static inline bool
-addr_match_proto(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2,
-                 const int proto)
-{
-    return link_socket_proto_connection_oriented(proto) ? addr_match(a1, a2)
-                                                        : addr_port_match(a1, a2);
-}
-
-
-static inline bool
-addrlist_match_proto(const struct openvpn_sockaddr *a1, struct addrinfo *addr_list, const int proto)
-{
-    return link_socket_proto_connection_oriented(proto) ? addrlist_match(a1, addr_list)
-                                                        : addrlist_port_match(a1, addr_list);
-}
-
-static inline void
-addr_zero_host(struct openvpn_sockaddr *addr)
-{
-    switch (addr->addr.sa.sa_family)
-    {
-        case AF_INET:
-            addr->addr.in4.sin_addr.s_addr = 0;
-            break;
-
-        case AF_INET6:
-            memset(&addr->addr.in6.sin6_addr, 0, sizeof(struct in6_addr));
-            break;
-    }
-}
-
-static inline int
-af_addr_size(sa_family_t af)
-{
-    switch (af)
-    {
-        case AF_INET:
-            return sizeof(struct sockaddr_in);
-
-        case AF_INET6:
-            return sizeof(struct sockaddr_in6);
-
-        default:
-#if 0
-            /* could be called from socket_do_accept() with empty addr */
-            msg(M_ERR, "Bad address family: %d\n", af);
-            ASSERT(0);
-#endif
-            return 0;
-    }
-}
-
-static inline bool
-link_socket_actual_match(const struct link_socket_actual *a1, const struct link_socket_actual *a2)
-{
-    return addr_port_match(&a1->dest, &a2->dest);
-}
-
 #if PORT_SHARE
 
 static inline bool
diff --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c
new file mode 100644
index 0000000..13f8c32
--- /dev/null
+++ b/src/openvpn/socket_util.c
@@ -0,0 +1,936 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include "socket_util.h"
+#include "crypto.h"
+#include "manage.h"
+
+/*
+ * Format IP addresses in ascii
+ */
+
+const char *
+print_sockaddr_ex(const struct sockaddr *sa, const char *separator, const unsigned int flags,
+                  struct gc_arena *gc)
+{
+    struct buffer out = alloc_buf_gc(128, gc);
+    bool addr_is_defined = false;
+    char hostaddr[NI_MAXHOST] = "";
+    char servname[NI_MAXSERV] = "";
+    int status;
+
+    socklen_t salen = 0;
+    switch (sa->sa_family)
+    {
+        case AF_INET:
+            if (!(flags & PS_DONT_SHOW_FAMILY))
+            {
+                buf_puts(&out, "[AF_INET]");
+            }
+            salen = sizeof(struct sockaddr_in);
+            addr_is_defined = ((struct sockaddr_in *)sa)->sin_addr.s_addr != 0;
+            break;
+
+        case AF_INET6:
+            if (!(flags & PS_DONT_SHOW_FAMILY))
+            {
+                buf_puts(&out, "[AF_INET6]");
+            }
+            salen = sizeof(struct sockaddr_in6);
+            addr_is_defined = !IN6_IS_ADDR_UNSPECIFIED(&((struct sockaddr_in6 *)sa)->sin6_addr);
+            break;
+
+        case AF_UNSPEC:
+            if (!(flags & PS_DONT_SHOW_FAMILY))
+            {
+                return "[AF_UNSPEC]";
+            }
+            else
+            {
+                return "";
+            }
+
+        default:
+            ASSERT(0);
+    }
+
+    status = getnameinfo(sa, salen, hostaddr, sizeof(hostaddr), servname, sizeof(servname),
+                         NI_NUMERICHOST | NI_NUMERICSERV);
+
+    if (status != 0)
+    {
+        buf_printf(&out, "[nameinfo() err: %s]", gai_strerror(status));
+        return BSTR(&out);
+    }
+
+    if (!(flags & PS_DONT_SHOW_ADDR))
+    {
+        if (addr_is_defined)
+        {
+            buf_puts(&out, hostaddr);
+        }
+        else
+        {
+            buf_puts(&out, "[undef]");
+        }
+    }
+
+    if ((flags & PS_SHOW_PORT) || (flags & PS_SHOW_PORT_IF_DEFINED))
+    {
+        if (separator)
+        {
+            buf_puts(&out, separator);
+        }
+
+        buf_puts(&out, servname);
+    }
+
+    return BSTR(&out);
+}
+
+const char *
+print_link_socket_actual(const struct link_socket_actual *act, struct gc_arena *gc)
+{
+    return print_link_socket_actual_ex(act, ":", PS_SHOW_PORT | PS_SHOW_PKTINFO, gc);
+}
+
+#ifndef IF_NAMESIZE
+#define IF_NAMESIZE 16
+#endif
+
+const char *
+print_link_socket_actual_ex(const struct link_socket_actual *act, const char *separator,
+                            const unsigned int flags, struct gc_arena *gc)
+{
+    if (act)
+    {
+        struct buffer out = alloc_buf_gc(128, gc);
+        buf_printf(&out, "%s", print_sockaddr_ex(&act->dest.addr.sa, separator, flags, gc));
+#if ENABLE_IP_PKTINFO
+        char ifname[IF_NAMESIZE] = "[undef]";
+
+        if ((flags & PS_SHOW_PKTINFO) && addr_defined_ipi(act))
+        {
+            switch (act->dest.addr.sa.sa_family)
+            {
+                case AF_INET:
+                {
+                    struct openvpn_sockaddr sa;
+                    CLEAR(sa);
+                    sa.addr.in4.sin_family = AF_INET;
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
+                    sa.addr.in4.sin_addr = act->pi.in4.ipi_spec_dst;
+                    if_indextoname(act->pi.in4.ipi_ifindex, ifname);
+#elif defined(IP_RECVDSTADDR)
+                    sa.addr.in4.sin_addr = act->pi.in4;
+                    ifname[0] = 0;
+#else /* if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST) */
+#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)
+#endif
+                    buf_printf(&out, " (via %s%%%s)",
+                               print_sockaddr_ex(&sa.addr.sa, separator, 0, gc), ifname);
+                }
+                break;
+
+                case AF_INET6:
+                {
+                    struct sockaddr_in6 sin6;
+                    char buf[INET6_ADDRSTRLEN] = "[undef]";
+                    CLEAR(sin6);
+                    sin6.sin6_family = AF_INET6;
+                    sin6.sin6_addr = act->pi.in6.ipi6_addr;
+                    if_indextoname(act->pi.in6.ipi6_ifindex, ifname);
+                    if (getnameinfo((struct sockaddr *)&sin6, sizeof(struct sockaddr_in6), buf,
+                                    sizeof(buf), NULL, 0, NI_NUMERICHOST)
+                        == 0)
+                    {
+                        buf_printf(&out, " (via %s%%%s)", buf, ifname);
+                    }
+                    else
+                    {
+                        buf_printf(&out, " (via [getnameinfo() err]%%%s)", ifname);
+                    }
+                }
+                break;
+            }
+        }
+#endif /* if ENABLE_IP_PKTINFO */
+        return BSTR(&out);
+    }
+    else
+    {
+        return "[NULL]";
+    }
+}
+
+/*
+ * Convert an in_addr_t in host byte order
+ * to an ascii dotted quad.
+ */
+const char *
+print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_arena *gc)
+{
+    struct in_addr ia;
+    char *out = gc_malloc(INET_ADDRSTRLEN, true, gc);
+
+    if (addr || !(flags & IA_EMPTY_IF_UNDEF))
+    {
+        CLEAR(ia);
+        ia.s_addr = (flags & IA_NET_ORDER) ? addr : htonl(addr);
+
+        inet_ntop(AF_INET, &ia, out, INET_ADDRSTRLEN);
+    }
+    return out;
+}
+
+/*
+ * Convert an in6_addr in host byte order
+ * to an ascii representation of an IPv6 address
+ */
+const char *
+print_in6_addr(struct in6_addr a6, unsigned int flags, struct gc_arena *gc)
+{
+    char *out = gc_malloc(INET6_ADDRSTRLEN, true, gc);
+
+    if (memcmp(&a6, &in6addr_any, sizeof(a6)) != 0 || !(flags & IA_EMPTY_IF_UNDEF))
+    {
+        inet_ntop(AF_INET6, &a6, out, INET6_ADDRSTRLEN);
+    }
+    return out;
+}
+
+/*
+ * Convert an in_port_t in host byte order to a string
+ */
+const char *
+print_in_port_t(in_port_t port, struct gc_arena *gc)
+{
+    struct buffer buffer = alloc_buf_gc(8, gc);
+    buf_printf(&buffer, "%hu", port);
+    return BSTR(&buffer);
+}
+
+/* add some offset to an ipv6 address
+ * (add in steps of 8 bits, taking overflow into next round)
+ */
+struct in6_addr
+add_in6_addr(struct in6_addr base, uint32_t add)
+{
+    int i;
+
+    for (i = 15; i >= 0 && add > 0; i--)
+    {
+        register int carry;
+        register uint32_t h;
+
+        h = (unsigned char)base.s6_addr[i];
+        base.s6_addr[i] = (h + add) & UINT8_MAX;
+
+        /* using explicit carry for the 8-bit additions will catch
+         * 8-bit and(!) 32-bit overruns nicely
+         */
+        carry = ((h & 0xff) + (add & 0xff)) >> 8;
+        add = (add >> 8) + carry;
+    }
+    return base;
+}
+
+/* set environmental variables for ip/port in *addr */
+void
+setenv_sockaddr(struct env_set *es, const char *name_prefix, const struct openvpn_sockaddr *addr,
+                const unsigned int flags)
+{
+    char name_buf[256];
+
+    char buf[INET6_ADDRSTRLEN];
+    switch (addr->addr.sa.sa_family)
+    {
+        case AF_INET:
+            if (flags & SA_IP_PORT)
+            {
+                snprintf(name_buf, sizeof(name_buf), "%s_ip", name_prefix);
+            }
+            else
+            {
+                snprintf(name_buf, sizeof(name_buf), "%s", name_prefix);
+            }
+
+            inet_ntop(AF_INET, &addr->addr.in4.sin_addr, buf, sizeof(buf));
+            setenv_str(es, name_buf, buf);
+
+            if ((flags & SA_IP_PORT) && addr->addr.in4.sin_port)
+            {
+                snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefix);
+                setenv_int(es, name_buf, ntohs(addr->addr.in4.sin_port));
+            }
+            break;
+
+        case AF_INET6:
+            if (IN6_IS_ADDR_V4MAPPED(&addr->addr.in6.sin6_addr))
+            {
+                struct in_addr ia;
+                memcpy(&ia.s_addr, &addr->addr.in6.sin6_addr.s6_addr[12], sizeof(ia.s_addr));
+                snprintf(name_buf, sizeof(name_buf), "%s_ip", name_prefix);
+                inet_ntop(AF_INET, &ia, buf, sizeof(buf));
+            }
+            else
+            {
+                snprintf(name_buf, sizeof(name_buf), "%s_ip6", name_prefix);
+                inet_ntop(AF_INET6, &addr->addr.in6.sin6_addr, buf, sizeof(buf));
+            }
+            setenv_str(es, name_buf, buf);
+
+            if ((flags & SA_IP_PORT) && addr->addr.in6.sin6_port)
+            {
+                snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefix);
+                setenv_int(es, name_buf, ntohs(addr->addr.in6.sin6_port));
+            }
+            break;
+    }
+}
+
+void
+setenv_in_addr_t(struct env_set *es, const char *name_prefix, in_addr_t addr,
+                 const unsigned int flags)
+{
+    if (addr || !(flags & SA_SET_IF_NONZERO))
+    {
+        struct openvpn_sockaddr si;
+        CLEAR(si);
+        si.addr.in4.sin_family = AF_INET;
+        si.addr.in4.sin_addr.s_addr = htonl(addr);
+        setenv_sockaddr(es, name_prefix, &si, flags);
+    }
+}
+
+void
+setenv_in6_addr(struct env_set *es, const char *name_prefix, const struct in6_addr *addr,
+                const unsigned int flags)
+{
+    if (!IN6_IS_ADDR_UNSPECIFIED(addr) || !(flags & SA_SET_IF_NONZERO))
+    {
+        struct openvpn_sockaddr si;
+        CLEAR(si);
+        si.addr.in6.sin6_family = AF_INET6;
+        si.addr.in6.sin6_addr = *addr;
+        setenv_sockaddr(es, name_prefix, &si, flags);
+    }
+}
+
+void
+setenv_link_socket_actual(struct env_set *es, const char *name_prefix,
+                          const struct link_socket_actual *act, const unsigned int flags)
+{
+    setenv_sockaddr(es, name_prefix, &act->dest, flags);
+}
+
+/*
+ * Convert protocol names between index and ascii form.
+ */
+
+struct proto_names
+{
+    const char *short_form;
+    const char *display_form;
+    sa_family_t proto_af;
+    int proto;
+};
+
+/* Indexed by PROTO_x */
+static const struct proto_names proto_names[] = {
+    { "proto-uninitialized", "proto-NONE", AF_UNSPEC, PROTO_NONE },
+    /* try IPv4 and IPv6 (client), bind dual-stack (server) */
+    { "udp", "UDP", AF_UNSPEC, PROTO_UDP },
+    { "tcp-server", "TCP_SERVER", AF_UNSPEC, PROTO_TCP_SERVER },
+    { "tcp-client", "TCP_CLIENT", AF_UNSPEC, PROTO_TCP_CLIENT },
+    { "tcp", "TCP", AF_UNSPEC, PROTO_TCP },
+    /* force IPv4 */
+    { "udp4", "UDPv4", AF_INET, PROTO_UDP },
+    { "tcp4-server", "TCPv4_SERVER", AF_INET, PROTO_TCP_SERVER },
+    { "tcp4-client", "TCPv4_CLIENT", AF_INET, PROTO_TCP_CLIENT },
+    { "tcp4", "TCPv4", AF_INET, PROTO_TCP },
+    /* force IPv6 */
+    { "udp6", "UDPv6", AF_INET6, PROTO_UDP },
+    { "tcp6-server", "TCPv6_SERVER", AF_INET6, PROTO_TCP_SERVER },
+    { "tcp6-client", "TCPv6_CLIENT", AF_INET6, PROTO_TCP_CLIENT },
+    { "tcp6", "TCPv6", AF_INET6, PROTO_TCP },
+};
+
+int
+ascii2proto(const char *proto_name)
+{
+    for (size_t i = 0; i < SIZE(proto_names); ++i)
+    {
+        if (!strcmp(proto_name, proto_names[i].short_form))
+        {
+            return proto_names[i].proto;
+        }
+    }
+    return -1;
+}
+
+sa_family_t
+ascii2af(const char *proto_name)
+{
+    for (size_t i = 0; i < SIZE(proto_names); ++i)
+    {
+        if (!strcmp(proto_name, proto_names[i].short_form))
+        {
+            return proto_names[i].proto_af;
+        }
+    }
+    return 0;
+}
+
+const char *
+proto2ascii(int proto, sa_family_t af, bool display_form)
+{
+    for (size_t i = 0; i < SIZE(proto_names); ++i)
+    {
+        if (proto_names[i].proto_af == af && proto_names[i].proto == proto)
+        {
+            if (display_form)
+            {
+                return proto_names[i].display_form;
+            }
+            else
+            {
+                return proto_names[i].short_form;
+            }
+        }
+    }
+
+    return "[unknown protocol]";
+}
+
+const char *
+proto2ascii_all(struct gc_arena *gc)
+{
+    struct buffer out = alloc_buf_gc(256, gc);
+
+    for (size_t i = 0; i < SIZE(proto_names); ++i)
+    {
+        if (i)
+        {
+            buf_printf(&out, " ");
+        }
+        buf_printf(&out, "[%s]", proto_names[i].short_form);
+    }
+    return BSTR(&out);
+}
+
+const char *
+addr_family_name(int af)
+{
+    switch (af)
+    {
+        case AF_INET:
+            return "AF_INET";
+
+        case AF_INET6:
+            return "AF_INET6";
+    }
+    return "AF_UNSPEC";
+}
+
+/*
+ * Given a local proto, return local proto
+ * if !remote, or compatible remote proto
+ * if remote.
+ *
+ * This is used for options compatibility
+ * checking.
+ *
+ * IPv6 and IPv4 protocols are comptabile but OpenVPN
+ * has always sent UDPv4, TCPv4 over the wire. Keep these
+ * strings for backward compatibility
+ */
+const char *
+proto_remote(int proto, bool remote)
+{
+    ASSERT(proto >= 0 && proto < PROTO_N);
+    if (proto == PROTO_UDP)
+    {
+        return "UDPv4";
+    }
+
+    if ((remote && proto == PROTO_TCP_CLIENT) || (!remote && proto == PROTO_TCP_SERVER))
+    {
+        return "TCPv4_SERVER";
+    }
+    if ((remote && proto == PROTO_TCP_SERVER) || (!remote && proto == PROTO_TCP_CLIENT))
+    {
+        return "TCPv4_CLIENT";
+    }
+
+    ASSERT(0);
+    return ""; /* Make the compiler happy */
+}
+
+/**
+ * Small helper function for openvpn_getaddrinfo to print the address
+ * family when resolving fails
+ */
+static const char *
+getaddrinfo_addr_family_name(int af)
+{
+    switch (af)
+    {
+        case AF_INET:
+            return "[AF_INET]";
+
+        case AF_INET6:
+            return "[AF_INET6]";
+    }
+    return "";
+}
+
+/*
+ * Prepend a random string to hostname to prevent DNS caching.
+ * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.gov.
+ * Of course, this requires explicit support in the DNS server (wildcard).
+ */
+static const char *
+hostname_randomize(const char *hostname, struct gc_arena *gc)
+{
+#define n_rnd_bytes 6
+
+    uint8_t rnd_bytes[n_rnd_bytes];
+    const char *rnd_str;
+    struct buffer hname = alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);
+
+    prng_bytes(rnd_bytes, sizeof(rnd_bytes));
+    rnd_str = format_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);
+    buf_printf(&hname, "%s.%s", rnd_str, hostname);
+    return BSTR(&hname);
+#undef n_rnd_bytes
+}
+
+/*
+ * Translate IPv4/IPv6 addr or hostname into struct addrinfo
+ * If resolve error, try again for resolve_retry_seconds seconds.
+ */
+int
+openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *servname,
+                    int resolve_retry_seconds, struct signal_info *sig_info, int ai_family,
+                    struct addrinfo **res)
+{
+    struct addrinfo hints;
+    int status;
+    struct signal_info sigrec = { 0 };
+    int msglevel = (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
+    struct gc_arena gc = gc_new();
+    const char *print_hostname;
+    const char *print_servname;
+
+    ASSERT(res);
+
+    ASSERT(hostname || servname);
+    ASSERT(!(flags & GETADDR_HOST_ORDER));
+
+    if (servname)
+    {
+        print_servname = servname;
+    }
+    else
+    {
+        print_servname = "";
+    }
+
+    if (flags & GETADDR_MSG_VIRT_OUT)
+    {
+        msglevel |= M_MSG_VIRT_OUT;
+    }
+
+    if ((flags & (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) && !sig_info)
+    {
+        sig_info = &sigrec;
+    }
+
+    /* try numeric ip addr first */
+    CLEAR(hints);
+    hints.ai_flags = AI_NUMERICHOST;
+
+    if (flags & GETADDR_PASSIVE)
+    {
+        hints.ai_flags |= AI_PASSIVE;
+    }
+
+    if (flags & GETADDR_DATAGRAM)
+    {
+        hints.ai_socktype = SOCK_DGRAM;
+    }
+    else
+    {
+        hints.ai_socktype = SOCK_STREAM;
+    }
+
+    /* if hostname is not set, we want to bind to 'ANY', with
+     * the correct address family - v4-only or v6/v6-dual-stack */
+    if (!hostname)
+    {
+        hints.ai_family = ai_family;
+    }
+
+    status = getaddrinfo(hostname, servname, &hints, res);
+
+    if (status != 0)                      /* parse as numeric address failed? */
+    {
+        const int fail_wait_interval = 5; /* seconds */
+        /* Add +4 to cause integer division rounding up (1 + 4) = 5, (0+4)/5=0 */
+        int resolve_retries =
+            (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);
+        const char *fmt;
+        int level = 0;
+
+        /* this is not a numeric IP, therefore force resolution using the
+         * provided ai_family */
+        hints.ai_family = ai_family;
+
+        if (hostname && (flags & GETADDR_RANDOMIZE))
+        {
+            hostname = hostname_randomize(hostname, &gc);
+        }
+
+        if (hostname)
+        {
+            print_hostname = hostname;
+        }
+        else
+        {
+            print_hostname = "undefined";
+        }
+
+        fmt = "RESOLVE: Cannot resolve host address: %s:%s%s (%s)";
+        if ((flags & GETADDR_MENTION_RESOLVE_RETRY) && !resolve_retry_seconds)
+        {
+            fmt = "RESOLVE: Cannot resolve host address: %s:%s%s (%s)"
+                  "(I would have retried this name query if you had "
+                  "specified the --resolv-retry option.)";
+        }
+
+        if (!(flags & GETADDR_RESOLVE) || status == EAI_FAIL)
+        {
+            msg(msglevel, "RESOLVE: Cannot parse IP address: %s:%s (%s)", print_hostname,
+                print_servname, gai_strerror(status));
+            goto done;
+        }
+
+#ifdef ENABLE_MANAGEMENT
+        if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
+        {
+            if (management)
+            {
+                management_set_state(management, OPENVPN_STATE_RESOLVE, NULL, NULL, NULL, NULL,
+                                     NULL);
+            }
+        }
+#endif
+
+        /*
+         * Resolve hostname
+         */
+        while (true)
+        {
+#ifndef _WIN32
+            /* force resolv.conf reload */
+            res_init();
+#endif
+            /* try hostname lookup */
+            hints.ai_flags &= ~AI_NUMERICHOST;
+            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d", flags,
+                 hints.ai_family, hints.ai_socktype);
+            status = getaddrinfo(hostname, servname, &hints, res);
+
+            if (sig_info)
+            {
+                get_signal(&sig_info->signal_received);
+                if (sig_info->signal_received) /* were we interrupted by a signal? */
+                {
+                    /* why are we overwriting SIGUSR1 ? */
+                    if (signal_reset(sig_info, SIGUSR1) == SIGUSR1) /* ignore SIGUSR1 */
+                    {
+                        msg(level, "RESOLVE: Ignored SIGUSR1 signal received during "
+                                   "DNS resolution attempt");
+                    }
+                    else
+                    {
+                        /* turn success into failure (interrupted syscall) */
+                        if (0 == status)
+                        {
+                            ASSERT(res);
+                            freeaddrinfo(*res);
+                            *res = NULL;
+                            status = EAI_AGAIN; /* = temporary failure */
+                            errno = EINTR;
+                        }
+                        goto done;
+                    }
+                }
+            }
+
+            /* success? */
+            if (0 == status)
+            {
+                break;
+            }
+
+            /* resolve lookup failed, should we
+             * continue or fail? */
+            level = msglevel;
+            if (resolve_retries > 0)
+            {
+                level = D_RESOLVE_ERRORS;
+            }
+
+            msg(level, fmt, print_hostname, print_servname, getaddrinfo_addr_family_name(ai_family),
+                gai_strerror(status));
+
+            if (--resolve_retries <= 0)
+            {
+                goto done;
+            }
+
+            management_sleep(fail_wait_interval);
+        }
+
+        ASSERT(res);
+
+        /* hostname resolve succeeded */
+
+        /*
+         * Do not choose an IP Addresse by random or change the order *
+         * of IP addresses, doing so will break RFC 3484 address selection *
+         */
+    }
+    else
+    {
+        /* IP address parse succeeded */
+        if (flags & GETADDR_RANDOMIZE)
+        {
+            msg(M_WARN, "WARNING: ignoring --remote-random-hostname because the "
+                        "hostname is an IP address");
+        }
+    }
+
+done:
+    if (sig_info && sig_info->signal_received)
+    {
+        int level = 0;
+        if (flags & GETADDR_FATAL_ON_SIGNAL)
+        {
+            level = M_FATAL;
+        }
+        else if (flags & GETADDR_WARN_ON_SIGNAL)
+        {
+            level = M_WARN;
+        }
+        msg(level, "RESOLVE: signal received during DNS resolution attempt");
+    }
+
+    gc_free(&gc);
+    return status;
+}
+
+/*
+ * We do our own inet_aton because the glibc function
+ * isn't very good about error checking.
+ */
+int
+openvpn_inet_aton(const char *dotted_quad, struct in_addr *addr)
+{
+    unsigned int a, b, c, d;
+
+    CLEAR(*addr);
+    if (sscanf(dotted_quad, "%u.%u.%u.%u", &a, &b, &c, &d) == 4)
+    {
+        if (a < 256 && b < 256 && c < 256 && d < 256)
+        {
+            addr->s_addr = htonl(a << 24 | b << 16 | c << 8 | d);
+            return OIA_IP; /* good dotted quad */
+        }
+    }
+    if (string_class(dotted_quad, CC_DIGIT | CC_DOT, 0))
+    {
+        return OIA_ERROR; /* probably a badly formatted dotted quad */
+    }
+    else
+    {
+        return OIA_HOSTNAME; /* probably a hostname */
+    }
+}
+
+bool
+ip_addr_dotted_quad_safe(const char *dotted_quad)
+{
+    /* verify non-NULL */
+    if (!dotted_quad)
+    {
+        return false;
+    }
+
+    /* verify length is within limits */
+    if (strlen(dotted_quad) > 15)
+    {
+        return false;
+    }
+
+    /* verify that all chars are either numeric or '.' and that no numeric
+     * substring is greater than 3 chars */
+    {
+        int nnum = 0;
+        const char *p = dotted_quad;
+        int c;
+
+        while ((c = *p++))
+        {
+            if (c >= '0' && c <= '9')
+            {
+                ++nnum;
+                if (nnum > 3)
+                {
+                    return false;
+                }
+            }
+            else if (c == '.')
+            {
+                nnum = 0;
+            }
+            else
+            {
+                return false;
+            }
+        }
+    }
+
+    /* verify that string will convert to IP address */
+    {
+        struct in_addr a;
+        return openvpn_inet_aton(dotted_quad, &a) == OIA_IP;
+    }
+}
+
+bool
+ipv6_addr_safe(const char *ipv6_text_addr)
+{
+    /* verify non-NULL */
+    if (!ipv6_text_addr)
+    {
+        return false;
+    }
+
+    /* verify length is within limits */
+    if (strlen(ipv6_text_addr) > INET6_ADDRSTRLEN)
+    {
+        return false;
+    }
+
+    /* verify that string will convert to IPv6 address */
+    {
+        struct in6_addr a6;
+        return inet_pton(AF_INET6, ipv6_text_addr, &a6) == 1;
+    }
+}
+
+static bool
+dns_addr_safe(const char *addr)
+{
+    if (addr)
+    {
+        const size_t len = strlen(addr);
+        return len > 0 && len <= 255 && string_class(addr, CC_ALNUM | CC_DASH | CC_DOT, 0);
+    }
+    else
+    {
+        return false;
+    }
+}
+
+bool
+ip_or_dns_addr_safe(const char *addr, const bool allow_fqdn)
+{
+    if (ip_addr_dotted_quad_safe(addr))
+    {
+        return true;
+    }
+    else if (allow_fqdn)
+    {
+        return dns_addr_safe(addr);
+    }
+    else
+    {
+        return false;
+    }
+}
+
+bool
+mac_addr_safe(const char *mac_addr)
+{
+    /* verify non-NULL */
+    if (!mac_addr)
+    {
+        return false;
+    }
+
+    /* verify length is within limits */
+    if (strlen(mac_addr) > 17)
+    {
+        return false;
+    }
+
+    /* verify that all chars are either alphanumeric or ':' and that no
+     * alphanumeric substring is greater than 2 chars */
+    {
+        int nnum = 0;
+        const char *p = mac_addr;
+        int c;
+
+        while ((c = *p++))
+        {
+            if ((c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'))
+            {
+                ++nnum;
+                if (nnum > 2)
+                {
+                    return false;
+                }
+            }
+            else if (c == ':')
+            {
+                nnum = 0;
+            }
+            else
+            {
+                return false;
+            }
+        }
+    }
+
+    /* error-checking is left to script invoked in lladdr.c */
+    return true;
+}
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
new file mode 100644
index 0000000..5ea37dd
--- /dev/null
+++ b/src/openvpn/socket_util.h
@@ -0,0 +1,491 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifndef SOCKET_UTIL_H
+#define SOCKET_UTIL_H
+
+#include "buffer.h"
+#include "env_set.h"
+#include "sig.h"
+
+#define PS_SHOW_PORT_IF_DEFINED (1 << 0)
+#define PS_SHOW_PORT            (1 << 1)
+#define PS_SHOW_PKTINFO         (1 << 2)
+#define PS_DONT_SHOW_ADDR       (1 << 3)
+#define PS_DONT_SHOW_FAMILY     (1 << 4)
+
+/* OpenVPN sockaddr struct */
+struct openvpn_sockaddr
+{
+    /*int dummy;*/ /* add offset to force a bug if sa not explicitly dereferenced */
+    union
+    {
+        struct sockaddr sa;
+        struct sockaddr_in in4;
+        struct sockaddr_in6 in6;
+    } addr;
+};
+
+/* actual address of remote, based on source address of received packets */
+struct link_socket_actual
+{
+    /*int dummy;*/ /* add offset to force a bug if dest not explicitly dereferenced */
+
+    struct openvpn_sockaddr dest;
+#if ENABLE_IP_PKTINFO
+    union
+    {
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
+        struct in_pktinfo in4;
+#elif defined(IP_RECVDSTADDR)
+        struct in_addr in4;
+#endif
+        struct in6_pktinfo in6;
+    } pi;
+#endif
+};
+
+const char *print_sockaddr_ex(const struct sockaddr *addr, const char *separator,
+                              const unsigned int flags, struct gc_arena *gc);
+
+static inline const char *
+print_openvpn_sockaddr(const struct openvpn_sockaddr *addr, struct gc_arena *gc)
+{
+    return print_sockaddr_ex(&addr->addr.sa, ":", PS_SHOW_PORT, gc);
+}
+
+static inline const char *
+print_sockaddr(const struct sockaddr *addr, struct gc_arena *gc)
+{
+    return print_sockaddr_ex(addr, ":", PS_SHOW_PORT, gc);
+}
+
+
+const char *print_link_socket_actual_ex(const struct link_socket_actual *act, const char *separator,
+                                        const unsigned int flags, struct gc_arena *gc);
+
+const char *print_link_socket_actual(const struct link_socket_actual *act, struct gc_arena *gc);
+
+
+#define IA_EMPTY_IF_UNDEF (1 << 0)
+#define IA_NET_ORDER      (1 << 1)
+const char *print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_arena *gc);
+
+const char *print_in6_addr(struct in6_addr addr6, unsigned int flags, struct gc_arena *gc);
+
+const char *print_in_port_t(in_port_t port, struct gc_arena *gc);
+
+struct in6_addr add_in6_addr(struct in6_addr base, uint32_t add);
+
+#define SA_IP_PORT        (1 << 0)
+#define SA_SET_IF_NONZERO (1 << 1)
+void setenv_sockaddr(struct env_set *es, const char *name_prefix,
+                     const struct openvpn_sockaddr *addr, const unsigned int flags);
+
+void setenv_in_addr_t(struct env_set *es, const char *name_prefix, in_addr_t addr,
+                      const unsigned int flags);
+
+void setenv_in6_addr(struct env_set *es, const char *name_prefix, const struct in6_addr *addr,
+                     const unsigned int flags);
+
+void setenv_link_socket_actual(struct env_set *es, const char *name_prefix,
+                               const struct link_socket_actual *act, const unsigned int flags);
+
+/*
+ * DNS resolution
+ */
+
+#define GETADDR_RESOLVE                 (1 << 0)
+#define GETADDR_FATAL                   (1 << 1)
+#define GETADDR_HOST_ORDER              (1 << 2)
+#define GETADDR_MENTION_RESOLVE_RETRY   (1 << 3)
+#define GETADDR_FATAL_ON_SIGNAL         (1 << 4)
+#define GETADDR_WARN_ON_SIGNAL          (1 << 5)
+#define GETADDR_MSG_VIRT_OUT            (1 << 6)
+#define GETADDR_TRY_ONCE                (1 << 7)
+#define GETADDR_UPDATE_MANAGEMENT_STATE (1 << 8)
+#define GETADDR_RANDOMIZE               (1 << 9)
+#define GETADDR_PASSIVE                 (1 << 10)
+#define GETADDR_DATAGRAM                (1 << 11)
+
+#define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)
+
+/**
+ * Translate an IPv4 addr or hostname from string form to in_addr_t
+ *
+ * In case of resolve error, it will try again for
+ * resolve_retry_seconds seconds.
+ */
+in_addr_t getaddr(unsigned int flags, const char *hostname, int resolve_retry_seconds,
+                  bool *succeeded, struct signal_info *sig_info);
+
+/**
+ * Translate an IPv6 addr or hostname from string form to in6_addr
+ */
+bool get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int *netbits,
+                   int msglevel);
+
+int openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *servname,
+                        int resolve_retry_seconds, struct signal_info *sig_info, int ai_family,
+                        struct addrinfo **res);
+
+/* return values of openvpn_inet_aton */
+#define OIA_HOSTNAME 0
+#define OIA_IP       1
+#define OIA_ERROR    -1
+int openvpn_inet_aton(const char *dotted_quad, struct in_addr *addr);
+
+/* integrity validation on pulled options */
+bool ip_addr_dotted_quad_safe(const char *dotted_quad);
+
+bool ip_or_dns_addr_safe(const char *addr, const bool allow_fqdn);
+
+bool mac_addr_safe(const char *mac_addr);
+
+bool ipv6_addr_safe(const char *ipv6_text_addr);
+
+/*
+ * Transport protocol naming and other details.
+ */
+
+/*
+ * Use enum's instead of #define to allow for easier
+ * optional proto support
+ */
+enum proto_num
+{
+    PROTO_NONE, /* catch for uninitialized */
+    PROTO_UDP,
+    PROTO_TCP,
+    PROTO_TCP_SERVER,
+    PROTO_TCP_CLIENT,
+    PROTO_N
+};
+
+static inline bool
+proto_is_net(int proto)
+{
+    ASSERT(proto >= 0 && proto < PROTO_N);
+    return proto != PROTO_NONE;
+}
+
+/**
+ * @brief Returns if the protocol being used is UDP
+ */
+static inline bool
+proto_is_udp(int proto)
+{
+    ASSERT(proto >= 0 && proto < PROTO_N);
+    return proto == PROTO_UDP;
+}
+
+/**
+ * @brief Return if the protocol is datagram (UDP)
+ *
+ */
+static inline bool
+proto_is_dgram(int proto)
+{
+    return proto_is_udp(proto);
+}
+
+/**
+ * @brief returns if the proto is a TCP variant (tcp-server, tcp-client or tcp)
+ */
+static inline bool
+proto_is_tcp(int proto)
+{
+    ASSERT(proto >= 0 && proto < PROTO_N);
+    return proto == PROTO_TCP_CLIENT || proto == PROTO_TCP_SERVER;
+}
+
+int ascii2proto(const char *proto_name);
+
+sa_family_t ascii2af(const char *proto_name);
+
+const char *proto2ascii(int proto, sa_family_t af, bool display_form);
+
+const char *proto2ascii_all(struct gc_arena *gc);
+
+const char *proto_remote(int proto, bool remote);
+
+const char *addr_family_name(int af);
+
+static inline bool
+addr_defined(const struct openvpn_sockaddr *addr)
+{
+    if (!addr)
+    {
+        return 0;
+    }
+    switch (addr->addr.sa.sa_family)
+    {
+        case AF_INET:
+            return addr->addr.in4.sin_addr.s_addr != 0;
+
+        case AF_INET6:
+            return !IN6_IS_ADDR_UNSPECIFIED(&addr->addr.in6.sin6_addr);
+
+        default:
+            return 0;
+    }
+}
+
+static inline bool
+addr_local(const struct sockaddr *addr)
+{
+    if (!addr)
+    {
+        return false;
+    }
+    switch (addr->sa_family)
+    {
+        case AF_INET:
+            return ((const struct sockaddr_in *)addr)->sin_addr.s_addr == htonl(INADDR_LOOPBACK);
+
+        case AF_INET6:
+            return IN6_IS_ADDR_LOOPBACK(&((const struct sockaddr_in6 *)addr)->sin6_addr);
+
+        default:
+            return false;
+    }
+}
+
+
+static inline bool
+addr_defined_ipi(const struct link_socket_actual *lsa)
+{
+#if ENABLE_IP_PKTINFO
+    if (!lsa)
+    {
+        return 0;
+    }
+    switch (lsa->dest.addr.sa.sa_family)
+    {
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
+        case AF_INET:
+            return lsa->pi.in4.ipi_spec_dst.s_addr != 0;
+
+#elif defined(IP_RECVDSTADDR)
+        case AF_INET:
+            return lsa->pi.in4.s_addr != 0;
+
+#endif
+        case AF_INET6:
+            return !IN6_IS_ADDR_UNSPECIFIED(&lsa->pi.in6.ipi6_addr);
+
+        default:
+            return 0;
+    }
+#else /* if ENABLE_IP_PKTINFO */
+    ASSERT(0);
+#endif
+    return false;
+}
+
+/*
+ * Overhead added to packets by various protocols.
+ */
+static inline int
+datagram_overhead(sa_family_t af, int proto)
+{
+    int overhead = 0;
+    overhead += (proto == PROTO_UDP) ? 8 : 20;
+    overhead += (af == AF_INET) ? 20 : 40;
+    return overhead;
+}
+
+/*
+ * Misc inline functions
+ */
+
+static inline bool
+link_socket_proto_connection_oriented(int proto)
+{
+    return !proto_is_dgram(proto);
+}
+
+static inline bool
+link_socket_actual_defined(const struct link_socket_actual *act)
+{
+    return act && addr_defined(&act->dest);
+}
+
+static inline bool
+addr_match(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)
+{
+    switch (a1->addr.sa.sa_family)
+    {
+        case AF_INET:
+            return a1->addr.in4.sin_addr.s_addr == a2->addr.in4.sin_addr.s_addr;
+
+        case AF_INET6:
+            return IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &a2->addr.in6.sin6_addr);
+    }
+    ASSERT(0);
+    return false;
+}
+
+static inline bool
+addrlist_match(const struct openvpn_sockaddr *a1, const struct addrinfo *addrlist)
+{
+    const struct addrinfo *curele;
+    for (curele = addrlist; curele; curele = curele->ai_next)
+    {
+        switch (a1->addr.sa.sa_family)
+        {
+            case AF_INET:
+                if (a1->addr.in4.sin_addr.s_addr
+                    == ((struct sockaddr_in *)curele->ai_addr)->sin_addr.s_addr)
+                {
+                    return true;
+                }
+                break;
+
+            case AF_INET6:
+                if (IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr,
+                                       &((struct sockaddr_in6 *)curele->ai_addr)->sin6_addr))
+                {
+                    return true;
+                }
+                break;
+
+            default:
+                ASSERT(0);
+        }
+    }
+    return false;
+}
+
+static inline bool
+addrlist_port_match(const struct openvpn_sockaddr *a1, const struct addrinfo *a2)
+{
+    const struct addrinfo *curele;
+    for (curele = a2; curele; curele = curele->ai_next)
+    {
+        switch (a1->addr.sa.sa_family)
+        {
+            case AF_INET:
+                if (curele->ai_family == AF_INET
+                    && a1->addr.in4.sin_addr.s_addr
+                           == ((struct sockaddr_in *)curele->ai_addr)->sin_addr.s_addr
+                    && a1->addr.in4.sin_port == ((struct sockaddr_in *)curele->ai_addr)->sin_port)
+                {
+                    return true;
+                }
+                break;
+
+            case AF_INET6:
+                if (curele->ai_family == AF_INET6
+                    && IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr,
+                                          &((struct sockaddr_in6 *)curele->ai_addr)->sin6_addr)
+                    && a1->addr.in6.sin6_port
+                           == ((struct sockaddr_in6 *)curele->ai_addr)->sin6_port)
+                {
+                    return true;
+                }
+                break;
+
+            default:
+                ASSERT(0);
+        }
+    }
+    return false;
+}
+
+
+static inline bool
+addr_port_match(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)
+{
+    switch (a1->addr.sa.sa_family)
+    {
+        case AF_INET:
+            return a1->addr.in4.sin_addr.s_addr == a2->addr.in4.sin_addr.s_addr
+                   && a1->addr.in4.sin_port == a2->addr.in4.sin_port;
+
+        case AF_INET6:
+            return IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &a2->addr.in6.sin6_addr)
+                   && a1->addr.in6.sin6_port == a2->addr.in6.sin6_port;
+    }
+    ASSERT(0);
+    return false;
+}
+
+static inline bool
+addr_match_proto(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2,
+                 const int proto)
+{
+    return link_socket_proto_connection_oriented(proto) ? addr_match(a1, a2)
+                                                        : addr_port_match(a1, a2);
+}
+
+
+static inline bool
+addrlist_match_proto(const struct openvpn_sockaddr *a1, struct addrinfo *addr_list, const int proto)
+{
+    return link_socket_proto_connection_oriented(proto) ? addrlist_match(a1, addr_list)
+                                                        : addrlist_port_match(a1, addr_list);
+}
+
+static inline void
+addr_zero_host(struct openvpn_sockaddr *addr)
+{
+    switch (addr->addr.sa.sa_family)
+    {
+        case AF_INET:
+            addr->addr.in4.sin_addr.s_addr = 0;
+            break;
+
+        case AF_INET6:
+            memset(&addr->addr.in6.sin6_addr, 0, sizeof(struct in6_addr));
+            break;
+    }
+}
+
+static inline int
+af_addr_size(sa_family_t af)
+{
+    switch (af)
+    {
+        case AF_INET:
+            return sizeof(struct sockaddr_in);
+
+        case AF_INET6:
+            return sizeof(struct sockaddr_in6);
+
+        default:
+#if 0
+            /* could be called from socket_do_accept() with empty addr */
+            msg(M_ERR, "Bad address family: %d\n", af);
+            ASSERT(0);
+#endif
+            return 0;
+    }
+}
+
+static inline bool
+link_socket_actual_match(const struct link_socket_actual *a1, const struct link_socket_actual *a2)
+{
+    return addr_port_match(&a1->dest, &a2->dest);
+}
+
+#endif
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e8fde86..428bf5a 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -30,7 +30,7 @@
 #define SSL_COMMON_H_
 
 #include "session_id.h"
-#include "socket.h"
+#include "socket_util.h"
 #include "packet_id.h"
 #include "crypto.h"
 #include "options.h"
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f54b608..6c3096b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -39,7 +39,7 @@
 #include "fdmisc.h"
 #include "common.h"
 #include "run_command.h"
-#include "socket.h"
+#include "socket_util.h"
 #include "manage.h"
 #include "route.h"
 #include "win32.h"

