From: "cron2 (Code Review)" <gerrit@...515...>
In-Reply-To: <gerrit.1756396351000.I7393459b975fb9b3e0a42743f58645f769d1be5a@...2715...>
References: <gerrit.1756396351000.I7393459b975fb9b3e0a42743f58645f769d1be5a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <bee138e053eada2e4d29b1579433f0c37091a01e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FKc/jWy5tLY="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: socket: Create
 socket_util with non-socket functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Date: Sun, 31 Aug 2025 16:27:52 -0000
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FKc/jWy5tLY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1159?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: socket: Create socket_util with non-socket functions
......................................................................

socket: Create socket_util with non-socket functions

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
Message-Id: <20250831155939.29240-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
727.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M src/openvpn/Makefile.am
M src/openvpn/clinat.c
M src/openvpn/dhcp.c
M src/openvpn/dns.c
M src/openvpn/manage.h
M src/openvpn/misc.c
M src/openvpn/misc.h
M src/openvpn/mroute.c
M src/openvpn/mss.h
M src/openvpn/networking_iproute2.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/pool.c
M src/openvpn/socket.c
M src/openvpn/socket.h
A src/openvpn/socket_util.c
A src/openvpn/socket_util.h
M src/openvpn/ssl_common.h
M src/openvpn/tun.c
20 files changed, 1,443 insertions(+), 1,380 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/1159/2

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
=20
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
- * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.go=
v.
- * Of course, this requires explicit support in the DNS server (wildcard).
- */
-const char *
-hostname_randomize(const char *hostname, struct gc_arena *gc)
-{
-#define n_rnd_bytes 6
-
-    uint8_t rnd_bytes[n_rnd_bytes];
-    const char *rnd_str;
-    struct buffer hname =3D alloc_buf_gc(strlen(hostname) + sizeof(rnd_byt=
es) * 2 + 4, gc);
-
-    prng_bytes(rnd_bytes, sizeof(rnd_bytes));
-    rnd_str =3D format_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, g=
c);
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

 const char **make_extended_arg_array(char **p, bool is_inline, struct gc_a=
rena *gc);

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
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_ipr=
oute2.c
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
-openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *=
servname,
-                    int resolve_retry_seconds, struct signal_info *sig_inf=
o, int ai_family,
-                    struct addrinfo **res)
-{
-    struct addrinfo hints;
-    int status;
-    struct signal_info sigrec =3D { 0 };
-    int msglevel =3D (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
-    struct gc_arena gc =3D gc_new();
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
-        print_servname =3D servname;
-    }
-    else
-    {
-        print_servname =3D "";
-    }
-
-    if (flags & GETADDR_MSG_VIRT_OUT)
-    {
-        msglevel |=3D M_MSG_VIRT_OUT;
-    }
-
-    if ((flags & (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) && !s=
ig_info)
-    {
-        sig_info =3D &sigrec;
-    }
-
-    /* try numeric ip addr first */
-    CLEAR(hints);
-    hints.ai_flags =3D AI_NUMERICHOST;
-
-    if (flags & GETADDR_PASSIVE)
-    {
-        hints.ai_flags |=3D AI_PASSIVE;
-    }
-
-    if (flags & GETADDR_DATAGRAM)
-    {
-        hints.ai_socktype =3D SOCK_DGRAM;
-    }
-    else
-    {
-        hints.ai_socktype =3D SOCK_STREAM;
-    }
-
-    /* if hostname is not set, we want to bind to 'ANY', with
-     * the correct address family - v4-only or v6/v6-dual-stack */
-    if (!hostname)
-    {
-        hints.ai_family =3D ai_family;
-    }
-
-    status =3D getaddrinfo(hostname, servname, &hints, res);
-
-    if (status !=3D 0)                      /* parse as numeric address fa=
iled? */
-    {
-        const int fail_wait_interval =3D 5; /* seconds */
-        /* Add +4 to cause integer division rounding up (1 + 4) =3D 5, (0+=
4)/5=3D0 */
-        int resolve_retries =3D
-            (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) =
/ fail_wait_interval);
-        const char *fmt;
-        int level =3D 0;
-
-        /* this is not a numeric IP, therefore force resolution using the
-         * provided ai_family */
-        hints.ai_family =3D ai_family;
-
-        if (hostname && (flags & GETADDR_RANDOMIZE))
-        {
-            hostname =3D hostname_randomize(hostname, &gc);
-        }
-
-        if (hostname)
-        {
-            print_hostname =3D hostname;
-        }
-        else
-        {
-            print_hostname =3D "undefined";
-        }
-
-        fmt =3D "RESOLVE: Cannot resolve host address: %s:%s%s (%s)";
-        if ((flags & GETADDR_MENTION_RESOLVE_RETRY) && !resolve_retry_seco=
nds)
-        {
-            fmt =3D "RESOLVE: Cannot resolve host address: %s:%s%s (%s)"
-                  "(I would have retried this name query if you had "
-                  "specified the --resolv-retry option.)";
-        }
-
-        if (!(flags & GETADDR_RESOLVE) || status =3D=3D EAI_FAIL)
-        {
-            msg(msglevel, "RESOLVE: Cannot parse IP address: %s:%s (%s)", =
print_hostname,
-                print_servname, gai_strerror(status));
-            goto done;
-        }
-
-#ifdef ENABLE_MANAGEMENT
-        if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
-        {
-            if (management)
-            {
-                management_set_state(management, OPENVPN_STATE_RESOLVE, NU=
LL, NULL, NULL, NULL,
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
-            hints.ai_flags &=3D ~AI_NUMERICHOST;
-            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=3D0x%04x ai_family=3D%=
d ai_socktype=3D%d", flags,
-                 hints.ai_family, hints.ai_socktype);
-            status =3D getaddrinfo(hostname, servname, &hints, res);
-
-            if (sig_info)
-            {
-                get_signal(&sig_info->signal_received);
-                if (sig_info->signal_received) /* were we interrupted by a=
 signal? */
-                {
-                    /* why are we overwriting SIGUSR1 ? */
-                    if (signal_reset(sig_info, SIGUSR1) =3D=3D SIGUSR1) /*=
 ignore SIGUSR1 */
-                    {
-                        msg(level, "RESOLVE: Ignored SIGUSR1 signal receiv=
ed during "
-                                   "DNS resolution attempt");
-                    }
-                    else
-                    {
-                        /* turn success into failure (interrupted syscall)=
 */
-                        if (0 =3D=3D status)
-                        {
-                            ASSERT(res);
-                            freeaddrinfo(*res);
-                            *res =3D NULL;
-                            status =3D EAI_AGAIN; /* =3D temporary failure=
 */
-                            errno =3D EINTR;
-                        }
-                        goto done;
-                    }
-                }
-            }
-
-            /* success? */
-            if (0 =3D=3D status)
-            {
-                break;
-            }
-
-            /* resolve lookup failed, should we
-             * continue or fail? */
-            level =3D msglevel;
-            if (resolve_retries > 0)
-            {
-                level =3D D_RESOLVE_ERRORS;
-            }
-
-            msg(level, fmt, print_hostname, print_servname, getaddrinfo_ad=
dr_family_name(ai_family),
-                gai_strerror(status));
-
-            if (--resolve_retries <=3D 0)
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
-         * of IP addresses, doing so will break RFC 3484 address selection=
 *
-         */
-    }
-    else
-    {
-        /* IP address parse succeeded */
-        if (flags & GETADDR_RANDOMIZE)
-        {
-            msg(M_WARN, "WARNING: ignoring --remote-random-hostname becaus=
e the "
-                        "hostname is an IP address");
-        }
-    }
-
-done:
-    if (sig_info && sig_info->signal_received)
-    {
-        int level =3D 0;
-        if (flags & GETADDR_FATAL_ON_SIGNAL)
-        {
-            level =3D M_FATAL;
-        }
-        else if (flags & GETADDR_WARN_ON_SIGNAL)
-        {
-            level =3D M_WARN;
-        }
-        msg(level, "RESOLVE: signal received during DNS resolution attempt=
");
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
-    if (sscanf(dotted_quad, "%u.%u.%u.%u", &a, &b, &c, &d) =3D=3D 4)
-    {
-        if (a < 256 && b < 256 && c < 256 && d < 256)
-        {
-            addr->s_addr =3D htonl(a << 24 | b << 16 | c << 8 | d);
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
-        int nnum =3D 0;
-        const char *p =3D dotted_quad;
-        int c;
-
-        while ((c =3D *p++))
-        {
-            if (c >=3D '0' && c <=3D '9')
-            {
-                ++nnum;
-                if (nnum > 3)
-                {
-                    return false;
-                }
-            }
-            else if (c =3D=3D '.')
-            {
-                nnum =3D 0;
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
-        return openvpn_inet_aton(dotted_quad, &a) =3D=3D OIA_IP;
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
-        return inet_pton(AF_INET6, ipv6_text_addr, &a6) =3D=3D 1;
-    }
-}
-
-static bool
-dns_addr_safe(const char *addr)
-{
-    if (addr)
-    {
-        const size_t len =3D strlen(addr);
-        return len > 0 && len <=3D 255 && string_class(addr, CC_ALNUM | CC=
_DASH | CC_DOT, 0);
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
-        int nnum =3D 0;
-        const char *p =3D mac_addr;
-        int c;
-
-        while ((c =3D *p++))
-        {
-            if ((c >=3D '0' && c <=3D '9') || (c >=3D 'a' && c <=3D 'f') |=
| (c >=3D 'A' && c <=3D 'F'))
-            {
-                ++nnum;
-                if (nnum > 2)
-                {
-                    return false;
-                }
-            }
-            else if (c =3D=3D ':')
-            {
-                nnum =3D 0;
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
-print_sockaddr_ex(const struct sockaddr *sa, const char *separator, const =
unsigned int flags,
-                  struct gc_arena *gc)
-{
-    struct buffer out =3D alloc_buf_gc(128, gc);
-    bool addr_is_defined =3D false;
-    char hostaddr[NI_MAXHOST] =3D "";
-    char servname[NI_MAXSERV] =3D "";
-    int status;
-
-    socklen_t salen =3D 0;
-    switch (sa->sa_family)
-    {
-        case AF_INET:
-            if (!(flags & PS_DONT_SHOW_FAMILY))
-            {
-                buf_puts(&out, "[AF_INET]");
-            }
-            salen =3D sizeof(struct sockaddr_in);
-            addr_is_defined =3D ((struct sockaddr_in *)sa)->sin_addr.s_add=
r !=3D 0;
-            break;
-
-        case AF_INET6:
-            if (!(flags & PS_DONT_SHOW_FAMILY))
-            {
-                buf_puts(&out, "[AF_INET6]");
-            }
-            salen =3D sizeof(struct sockaddr_in6);
-            addr_is_defined =3D !IN6_IS_ADDR_UNSPECIFIED(&((struct sockadd=
r_in6 *)sa)->sin6_addr);
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
-    status =3D getnameinfo(sa, salen, hostaddr, sizeof(hostaddr), servname=
, sizeof(servname),
-                         NI_NUMERICHOST | NI_NUMERICSERV);
-
-    if (status !=3D 0)
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
-print_link_socket_actual(const struct link_socket_actual *act, struct gc_a=
rena *gc)
-{
-    return print_link_socket_actual_ex(act, ":", PS_SHOW_PORT | PS_SHOW_PK=
TINFO, gc);
-}
-
-#ifndef IF_NAMESIZE
-#define IF_NAMESIZE 16
-#endif
-
-const char *
-print_link_socket_actual_ex(const struct link_socket_actual *act, const ch=
ar *separator,
-                            const unsigned int flags, struct gc_arena *gc)
-{
-    if (act)
-    {
-        struct buffer out =3D alloc_buf_gc(128, gc);
-        buf_printf(&out, "%s", print_sockaddr_ex(&act->dest.addr.sa, separ=
ator, flags, gc));
-#if ENABLE_IP_PKTINFO
-        char ifname[IF_NAMESIZE] =3D "[undef]";
-
-        if ((flags & PS_SHOW_PKTINFO) && addr_defined_ipi(act))
-        {
-            switch (act->dest.addr.sa.sa_family)
-            {
-                case AF_INET:
-                {
-                    struct openvpn_sockaddr sa;
-                    CLEAR(sa);
-                    sa.addr.in4.sin_family =3D AF_INET;
-#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-                    sa.addr.in4.sin_addr =3D act->pi.in4.ipi_spec_dst;
-                    if_indextoname(act->pi.in4.ipi_ifindex, ifname);
-#elif defined(IP_RECVDSTADDR)
-                    sa.addr.in4.sin_addr =3D act->pi.in4;
-                    ifname[0] =3D 0;
-#else /* if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST) */
-#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix=
 syshead.h)
-#endif
-                    buf_printf(&out, " (via %s%%%s)",
-                               print_sockaddr_ex(&sa.addr.sa, separator, 0=
, gc), ifname);
-                }
-                break;
-
-                case AF_INET6:
-                {
-                    struct sockaddr_in6 sin6;
-                    char buf[INET6_ADDRSTRLEN] =3D "[undef]";
-                    CLEAR(sin6);
-                    sin6.sin6_family =3D AF_INET6;
-                    sin6.sin6_addr =3D act->pi.in6.ipi6_addr;
-                    if_indextoname(act->pi.in6.ipi6_ifindex, ifname);
-                    if (getnameinfo((struct sockaddr *)&sin6, sizeof(struc=
t sockaddr_in6), buf,
-                                    sizeof(buf), NULL, 0, NI_NUMERICHOST)
-                        =3D=3D 0)
-                    {
-                        buf_printf(&out, " (via %s%%%s)", buf, ifname);
-                    }
-                    else
-                    {
-                        buf_printf(&out, " (via [getnameinfo() err]%%%s)",=
 ifname);
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
-    char *out =3D gc_malloc(INET_ADDRSTRLEN, true, gc);
-
-    if (addr || !(flags & IA_EMPTY_IF_UNDEF))
-    {
-        CLEAR(ia);
-        ia.s_addr =3D (flags & IA_NET_ORDER) ? addr : htonl(addr);
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
-    char *out =3D gc_malloc(INET6_ADDRSTRLEN, true, gc);
-
-    if (memcmp(&a6, &in6addr_any, sizeof(a6)) !=3D 0 || !(flags & IA_EMPTY=
_IF_UNDEF))
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
-    struct buffer buffer =3D alloc_buf_gc(8, gc);
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
-    for (i =3D 15; i >=3D 0 && add > 0; i--)
-    {
-        register int carry;
-        register uint32_t h;
-
-        h =3D (unsigned char)base.s6_addr[i];
-        base.s6_addr[i] =3D (h + add) & UINT8_MAX;
-
-        /* using explicit carry for the 8-bit additions will catch
-         * 8-bit and(!) 32-bit overruns nicely
-         */
-        carry =3D ((h & 0xff) + (add & 0xff)) >> 8;
-        add =3D (add >> 8) + carry;
-    }
-    return base;
-}
-
-/* set environmental variables for ip/port in *addr */
-void
-setenv_sockaddr(struct env_set *es, const char *name_prefix, const struct =
openvpn_sockaddr *addr,
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
-                snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefi=
x);
-                setenv_int(es, name_buf, ntohs(addr->addr.in4.sin_port));
-            }
-            break;
-
-        case AF_INET6:
-            if (IN6_IS_ADDR_V4MAPPED(&addr->addr.in6.sin6_addr))
-            {
-                struct in_addr ia;
-                memcpy(&ia.s_addr, &addr->addr.in6.sin6_addr.s6_addr[12], =
sizeof(ia.s_addr));
-                snprintf(name_buf, sizeof(name_buf), "%s_ip", name_prefix);
-                inet_ntop(AF_INET, &ia, buf, sizeof(buf));
-            }
-            else
-            {
-                snprintf(name_buf, sizeof(name_buf), "%s_ip6", name_prefix=
);
-                inet_ntop(AF_INET6, &addr->addr.in6.sin6_addr, buf, sizeof=
(buf));
-            }
-            setenv_str(es, name_buf, buf);
-
-            if ((flags & SA_IP_PORT) && addr->addr.in6.sin6_port)
-            {
-                snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefi=
x);
-                setenv_int(es, name_buf, ntohs(addr->addr.in6.sin6_port));
-            }
-            break;
-    }
-}
-
-void
-setenv_in_addr_t(struct env_set *es, const char *name_prefix, in_addr_t ad=
dr,
-                 const unsigned int flags)
-{
-    if (addr || !(flags & SA_SET_IF_NONZERO))
-    {
-        struct openvpn_sockaddr si;
-        CLEAR(si);
-        si.addr.in4.sin_family =3D AF_INET;
-        si.addr.in4.sin_addr.s_addr =3D htonl(addr);
-        setenv_sockaddr(es, name_prefix, &si, flags);
-    }
-}
-
-void
-setenv_in6_addr(struct env_set *es, const char *name_prefix, const struct =
in6_addr *addr,
-                const unsigned int flags)
-{
-    if (!IN6_IS_ADDR_UNSPECIFIED(addr) || !(flags & SA_SET_IF_NONZERO))
-    {
-        struct openvpn_sockaddr si;
-        CLEAR(si);
-        si.addr.in6.sin6_family =3D AF_INET6;
-        si.addr.in6.sin6_addr =3D *addr;
-        setenv_sockaddr(es, name_prefix, &si, flags);
-    }
-}
-
-void
-setenv_link_socket_actual(struct env_set *es, const char *name_prefix,
-                          const struct link_socket_actual *act, const unsi=
gned int flags)
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
-static const struct proto_names proto_names[] =3D {
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
-    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
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
-    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
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
-    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
-    {
-        if (proto_names[i].proto_af =3D=3D af && proto_names[i].proto =3D=
=3D proto)
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
-    struct buffer out =3D alloc_buf_gc(256, gc);
-
-    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
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
-    ASSERT(proto >=3D 0 && proto < PROTO_N);
-    if (proto =3D=3D PROTO_UDP)
-    {
-        return "UDPv4";
-    }
-
-    if ((remote && proto =3D=3D PROTO_TCP_CLIENT) || (!remote && proto =3D=
=3D PROTO_TCP_SERVER))
-    {
-        return "TCPv4_SERVER";
-    }
-    if ((remote && proto =3D=3D PROTO_TCP_SERVER) || (!remote && proto =3D=
=3D PROTO_TCP_CLIENT))
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
-    /*int dummy;*/ /* add offset to force a bug if sa not explicitly deref=
erenced */
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
-    /*int dummy;*/ /* add offset to force a bug if dest not explicitly der=
eferenced */
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
-const char *print_sockaddr_ex(const struct sockaddr *addr, const char *sep=
arator,
-                              const unsigned int flags, struct gc_arena *g=
c);
-
-static inline const char *
-print_openvpn_sockaddr(const struct openvpn_sockaddr *addr, struct gc_aren=
a *gc)
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
-const char *print_link_socket_actual_ex(const struct link_socket_actual *a=
ct, const char *separator,
-                                        const unsigned int flags, struct g=
c_arena *gc);
-
-const char *print_link_socket_actual(const struct link_socket_actual *act,=
 struct gc_arena *gc);
-
-
-#define IA_EMPTY_IF_UNDEF (1 << 0)
-#define IA_NET_ORDER      (1 << 1)
-const char *print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_=
arena *gc);
-
-const char *print_in6_addr(struct in6_addr addr6, unsigned int flags, stru=
ct gc_arena *gc);
-
-const char *print_in_port_t(in_port_t port, struct gc_arena *gc);
-
-struct in6_addr add_in6_addr(struct in6_addr base, uint32_t add);
-
-#define SA_IP_PORT        (1 << 0)
-#define SA_SET_IF_NONZERO (1 << 1)
-void setenv_sockaddr(struct env_set *es, const char *name_prefix,
-                     const struct openvpn_sockaddr *addr, const unsigned i=
nt flags);
-
-void setenv_in_addr_t(struct env_set *es, const char *name_prefix, in_addr=
_t addr,
-                      const unsigned int flags);
-
-void setenv_in6_addr(struct env_set *es, const char *name_prefix, const st=
ruct in6_addr *addr,
-                     const unsigned int flags);
-
-void setenv_link_socket_actual(struct env_set *es, const char *name_prefix,
-                               const struct link_socket_actual *act, const=
 unsigned int flags);
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

 socket_descriptor_t socket_do_accept(socket_descriptor_t sd, struct link_s=
ocket_actual *act,
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
-in_addr_t getaddr(unsigned int flags, const char *hostname, int resolve_re=
try_seconds,
-                  bool *succeeded, struct signal_info *sig_info);
-
-/**
- * Translate an IPv6 addr or hostname from string form to in6_addr
- */
-bool get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigne=
d int *netbits,
-                   int msglevel);
-
-int openvpn_getaddrinfo(unsigned int flags, const char *hostname, const ch=
ar *servname,
-                        int resolve_retry_seconds, struct signal_info *sig=
_info, int ai_family,
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
-    ASSERT(proto >=3D 0 && proto < PROTO_N);
-    return proto !=3D PROTO_NONE;
-}
-
-/**
- * @brief Returns if the protocol being used is UDP
- */
-static inline bool
-proto_is_udp(int proto)
-{
-    ASSERT(proto >=3D 0 && proto < PROTO_N);
-    return proto =3D=3D PROTO_UDP;
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
- * @brief returns if the proto is a TCP variant (tcp-server, tcp-client or=
 tcp)
- */
-static inline bool
-proto_is_tcp(int proto)
-{
-    ASSERT(proto >=3D 0 && proto < PROTO_N);
-    return proto =3D=3D PROTO_TCP_CLIENT || proto =3D=3D PROTO_TCP_SERVER;
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
-    int overhead =3D 0;
-    overhead +=3D (proto =3D=3D PROTO_UDP) ? 8 : 20;
-    overhead +=3D (af =3D=3D AF_INET) ? 20 : 40;
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
-            return addr->addr.in4.sin_addr.s_addr !=3D 0;
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
-            return ((const struct sockaddr_in *)addr)->sin_addr.s_addr =3D=
=3D htonl(INADDR_LOOPBACK);
-
-        case AF_INET6:
-            return IN6_IS_ADDR_LOOPBACK(&((const struct sockaddr_in6 *)add=
r)->sin6_addr);
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
-            return lsa->pi.in4.ipi_spec_dst.s_addr !=3D 0;
-
-#elif defined(IP_RECVDSTADDR)
-        case AF_INET:
-            return lsa->pi.in4.s_addr !=3D 0;
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
-addr_match(const struct openvpn_sockaddr *a1, const struct openvpn_sockadd=
r *a2)
-{
-    switch (a1->addr.sa.sa_family)
-    {
-        case AF_INET:
-            return a1->addr.in4.sin_addr.s_addr =3D=3D a2->addr.in4.sin_ad=
dr.s_addr;
-
-        case AF_INET6:
-            return IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &a2->addr.i=
n6.sin6_addr);
-    }
-    ASSERT(0);
-    return false;
-}
-
-static inline bool
-addrlist_match(const struct openvpn_sockaddr *a1, const struct addrinfo *a=
ddrlist)
-{
-    const struct addrinfo *curele;
-    for (curele =3D addrlist; curele; curele =3D curele->ai_next)
-    {
-        switch (a1->addr.sa.sa_family)
-        {
-            case AF_INET:
-                if (a1->addr.in4.sin_addr.s_addr
-                    =3D=3D ((struct sockaddr_in *)curele->ai_addr)->sin_ad=
dr.s_addr)
-                {
-                    return true;
-                }
-                break;
-
-            case AF_INET6:
-                if (IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr,
-                                       &((struct sockaddr_in6 *)curele->ai=
_addr)->sin6_addr))
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
-addrlist_port_match(const struct openvpn_sockaddr *a1, const struct addrin=
fo *a2)
-{
-    const struct addrinfo *curele;
-    for (curele =3D a2; curele; curele =3D curele->ai_next)
-    {
-        switch (a1->addr.sa.sa_family)
-        {
-            case AF_INET:
-                if (curele->ai_family =3D=3D AF_INET
-                    && a1->addr.in4.sin_addr.s_addr
-                           =3D=3D ((struct sockaddr_in *)curele->ai_addr)-=
>sin_addr.s_addr
-                    && a1->addr.in4.sin_port =3D=3D ((struct sockaddr_in *=
)curele->ai_addr)->sin_port)
-                {
-                    return true;
-                }
-                break;
-
-            case AF_INET6:
-                if (curele->ai_family =3D=3D AF_INET6
-                    && IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr,
-                                          &((struct sockaddr_in6 *)curele-=
>ai_addr)->sin6_addr)
-                    && a1->addr.in6.sin6_port
-                           =3D=3D ((struct sockaddr_in6 *)curele->ai_addr)=
->sin6_port)
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
-addr_port_match(const struct openvpn_sockaddr *a1, const struct openvpn_so=
ckaddr *a2)
-{
-    switch (a1->addr.sa.sa_family)
-    {
-        case AF_INET:
-            return a1->addr.in4.sin_addr.s_addr =3D=3D a2->addr.in4.sin_ad=
dr.s_addr
-                   && a1->addr.in4.sin_port =3D=3D a2->addr.in4.sin_port;
-
-        case AF_INET6:
-            return IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &a2->addr.i=
n6.sin6_addr)
-                   && a1->addr.in6.sin6_port =3D=3D a2->addr.in6.sin6_port;
-    }
-    ASSERT(0);
-    return false;
-}
-
-static inline bool
-addr_match_proto(const struct openvpn_sockaddr *a1, const struct openvpn_s=
ockaddr *a2,
-                 const int proto)
-{
-    return link_socket_proto_connection_oriented(proto) ? addr_match(a1, a=
2)
-                                                        : addr_port_match(=
a1, a2);
-}
-
-
-static inline bool
-addrlist_match_proto(const struct openvpn_sockaddr *a1, struct addrinfo *a=
ddr_list, const int proto)
-{
-    return link_socket_proto_connection_oriented(proto) ? addrlist_match(a=
1, addr_list)
-                                                        : addrlist_port_ma=
tch(a1, addr_list);
-}
-
-static inline void
-addr_zero_host(struct openvpn_sockaddr *addr)
-{
-    switch (addr->addr.sa.sa_family)
-    {
-        case AF_INET:
-            addr->addr.in4.sin_addr.s_addr =3D 0;
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
-link_socket_actual_match(const struct link_socket_actual *a1, const struct=
 link_socket_actual *a2)
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
+print_sockaddr_ex(const struct sockaddr *sa, const char *separator, const =
unsigned int flags,
+                  struct gc_arena *gc)
+{
+    struct buffer out =3D alloc_buf_gc(128, gc);
+    bool addr_is_defined =3D false;
+    char hostaddr[NI_MAXHOST] =3D "";
+    char servname[NI_MAXSERV] =3D "";
+    int status;
+
+    socklen_t salen =3D 0;
+    switch (sa->sa_family)
+    {
+        case AF_INET:
+            if (!(flags & PS_DONT_SHOW_FAMILY))
+            {
+                buf_puts(&out, "[AF_INET]");
+            }
+            salen =3D sizeof(struct sockaddr_in);
+            addr_is_defined =3D ((struct sockaddr_in *)sa)->sin_addr.s_add=
r !=3D 0;
+            break;
+
+        case AF_INET6:
+            if (!(flags & PS_DONT_SHOW_FAMILY))
+            {
+                buf_puts(&out, "[AF_INET6]");
+            }
+            salen =3D sizeof(struct sockaddr_in6);
+            addr_is_defined =3D !IN6_IS_ADDR_UNSPECIFIED(&((struct sockadd=
r_in6 *)sa)->sin6_addr);
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
+    status =3D getnameinfo(sa, salen, hostaddr, sizeof(hostaddr), servname=
, sizeof(servname),
+                         NI_NUMERICHOST | NI_NUMERICSERV);
+
+    if (status !=3D 0)
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
+print_link_socket_actual(const struct link_socket_actual *act, struct gc_a=
rena *gc)
+{
+    return print_link_socket_actual_ex(act, ":", PS_SHOW_PORT | PS_SHOW_PK=
TINFO, gc);
+}
+
+#ifndef IF_NAMESIZE
+#define IF_NAMESIZE 16
+#endif
+
+const char *
+print_link_socket_actual_ex(const struct link_socket_actual *act, const ch=
ar *separator,
+                            const unsigned int flags, struct gc_arena *gc)
+{
+    if (act)
+    {
+        struct buffer out =3D alloc_buf_gc(128, gc);
+        buf_printf(&out, "%s", print_sockaddr_ex(&act->dest.addr.sa, separ=
ator, flags, gc));
+#if ENABLE_IP_PKTINFO
+        char ifname[IF_NAMESIZE] =3D "[undef]";
+
+        if ((flags & PS_SHOW_PKTINFO) && addr_defined_ipi(act))
+        {
+            switch (act->dest.addr.sa.sa_family)
+            {
+                case AF_INET:
+                {
+                    struct openvpn_sockaddr sa;
+                    CLEAR(sa);
+                    sa.addr.in4.sin_family =3D AF_INET;
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
+                    sa.addr.in4.sin_addr =3D act->pi.in4.ipi_spec_dst;
+                    if_indextoname(act->pi.in4.ipi_ifindex, ifname);
+#elif defined(IP_RECVDSTADDR)
+                    sa.addr.in4.sin_addr =3D act->pi.in4;
+                    ifname[0] =3D 0;
+#else /* if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST) */
+#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix=
 syshead.h)
+#endif
+                    buf_printf(&out, " (via %s%%%s)",
+                               print_sockaddr_ex(&sa.addr.sa, separator, 0=
, gc), ifname);
+                }
+                break;
+
+                case AF_INET6:
+                {
+                    struct sockaddr_in6 sin6;
+                    char buf[INET6_ADDRSTRLEN] =3D "[undef]";
+                    CLEAR(sin6);
+                    sin6.sin6_family =3D AF_INET6;
+                    sin6.sin6_addr =3D act->pi.in6.ipi6_addr;
+                    if_indextoname(act->pi.in6.ipi6_ifindex, ifname);
+                    if (getnameinfo((struct sockaddr *)&sin6, sizeof(struc=
t sockaddr_in6), buf,
+                                    sizeof(buf), NULL, 0, NI_NUMERICHOST)
+                        =3D=3D 0)
+                    {
+                        buf_printf(&out, " (via %s%%%s)", buf, ifname);
+                    }
+                    else
+                    {
+                        buf_printf(&out, " (via [getnameinfo() err]%%%s)",=
 ifname);
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
+    char *out =3D gc_malloc(INET_ADDRSTRLEN, true, gc);
+
+    if (addr || !(flags & IA_EMPTY_IF_UNDEF))
+    {
+        CLEAR(ia);
+        ia.s_addr =3D (flags & IA_NET_ORDER) ? addr : htonl(addr);
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
+    char *out =3D gc_malloc(INET6_ADDRSTRLEN, true, gc);
+
+    if (memcmp(&a6, &in6addr_any, sizeof(a6)) !=3D 0 || !(flags & IA_EMPTY=
_IF_UNDEF))
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
+    struct buffer buffer =3D alloc_buf_gc(8, gc);
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
+    for (i =3D 15; i >=3D 0 && add > 0; i--)
+    {
+        register int carry;
+        register uint32_t h;
+
+        h =3D (unsigned char)base.s6_addr[i];
+        base.s6_addr[i] =3D (h + add) & UINT8_MAX;
+
+        /* using explicit carry for the 8-bit additions will catch
+         * 8-bit and(!) 32-bit overruns nicely
+         */
+        carry =3D ((h & 0xff) + (add & 0xff)) >> 8;
+        add =3D (add >> 8) + carry;
+    }
+    return base;
+}
+
+/* set environmental variables for ip/port in *addr */
+void
+setenv_sockaddr(struct env_set *es, const char *name_prefix, const struct =
openvpn_sockaddr *addr,
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
+                snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefi=
x);
+                setenv_int(es, name_buf, ntohs(addr->addr.in4.sin_port));
+            }
+            break;
+
+        case AF_INET6:
+            if (IN6_IS_ADDR_V4MAPPED(&addr->addr.in6.sin6_addr))
+            {
+                struct in_addr ia;
+                memcpy(&ia.s_addr, &addr->addr.in6.sin6_addr.s6_addr[12], =
sizeof(ia.s_addr));
+                snprintf(name_buf, sizeof(name_buf), "%s_ip", name_prefix);
+                inet_ntop(AF_INET, &ia, buf, sizeof(buf));
+            }
+            else
+            {
+                snprintf(name_buf, sizeof(name_buf), "%s_ip6", name_prefix=
);
+                inet_ntop(AF_INET6, &addr->addr.in6.sin6_addr, buf, sizeof=
(buf));
+            }
+            setenv_str(es, name_buf, buf);
+
+            if ((flags & SA_IP_PORT) && addr->addr.in6.sin6_port)
+            {
+                snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefi=
x);
+                setenv_int(es, name_buf, ntohs(addr->addr.in6.sin6_port));
+            }
+            break;
+    }
+}
+
+void
+setenv_in_addr_t(struct env_set *es, const char *name_prefix, in_addr_t ad=
dr,
+                 const unsigned int flags)
+{
+    if (addr || !(flags & SA_SET_IF_NONZERO))
+    {
+        struct openvpn_sockaddr si;
+        CLEAR(si);
+        si.addr.in4.sin_family =3D AF_INET;
+        si.addr.in4.sin_addr.s_addr =3D htonl(addr);
+        setenv_sockaddr(es, name_prefix, &si, flags);
+    }
+}
+
+void
+setenv_in6_addr(struct env_set *es, const char *name_prefix, const struct =
in6_addr *addr,
+                const unsigned int flags)
+{
+    if (!IN6_IS_ADDR_UNSPECIFIED(addr) || !(flags & SA_SET_IF_NONZERO))
+    {
+        struct openvpn_sockaddr si;
+        CLEAR(si);
+        si.addr.in6.sin6_family =3D AF_INET6;
+        si.addr.in6.sin6_addr =3D *addr;
+        setenv_sockaddr(es, name_prefix, &si, flags);
+    }
+}
+
+void
+setenv_link_socket_actual(struct env_set *es, const char *name_prefix,
+                          const struct link_socket_actual *act, const unsi=
gned int flags)
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
+static const struct proto_names proto_names[] =3D {
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
+    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
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
+    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
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
+    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
+    {
+        if (proto_names[i].proto_af =3D=3D af && proto_names[i].proto =3D=
=3D proto)
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
+    struct buffer out =3D alloc_buf_gc(256, gc);
+
+    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
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
+    ASSERT(proto >=3D 0 && proto < PROTO_N);
+    if (proto =3D=3D PROTO_UDP)
+    {
+        return "UDPv4";
+    }
+
+    if ((remote && proto =3D=3D PROTO_TCP_CLIENT) || (!remote && proto =3D=
=3D PROTO_TCP_SERVER))
+    {
+        return "TCPv4_SERVER";
+    }
+    if ((remote && proto =3D=3D PROTO_TCP_SERVER) || (!remote && proto =3D=
=3D PROTO_TCP_CLIENT))
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
+ * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.go=
v.
+ * Of course, this requires explicit support in the DNS server (wildcard).
+ */
+static const char *
+hostname_randomize(const char *hostname, struct gc_arena *gc)
+{
+#define n_rnd_bytes 6
+
+    uint8_t rnd_bytes[n_rnd_bytes];
+    const char *rnd_str;
+    struct buffer hname =3D alloc_buf_gc(strlen(hostname) + sizeof(rnd_byt=
es) * 2 + 4, gc);
+
+    prng_bytes(rnd_bytes, sizeof(rnd_bytes));
+    rnd_str =3D format_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, g=
c);
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
+openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *=
servname,
+                    int resolve_retry_seconds, struct signal_info *sig_inf=
o, int ai_family,
+                    struct addrinfo **res)
+{
+    struct addrinfo hints;
+    int status;
+    struct signal_info sigrec =3D { 0 };
+    int msglevel =3D (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
+    struct gc_arena gc =3D gc_new();
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
+        print_servname =3D servname;
+    }
+    else
+    {
+        print_servname =3D "";
+    }
+
+    if (flags & GETADDR_MSG_VIRT_OUT)
+    {
+        msglevel |=3D M_MSG_VIRT_OUT;
+    }
+
+    if ((flags & (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) && !s=
ig_info)
+    {
+        sig_info =3D &sigrec;
+    }
+
+    /* try numeric ip addr first */
+    CLEAR(hints);
+    hints.ai_flags =3D AI_NUMERICHOST;
+
+    if (flags & GETADDR_PASSIVE)
+    {
+        hints.ai_flags |=3D AI_PASSIVE;
+    }
+
+    if (flags & GETADDR_DATAGRAM)
+    {
+        hints.ai_socktype =3D SOCK_DGRAM;
+    }
+    else
+    {
+        hints.ai_socktype =3D SOCK_STREAM;
+    }
+
+    /* if hostname is not set, we want to bind to 'ANY', with
+     * the correct address family - v4-only or v6/v6-dual-stack */
+    if (!hostname)
+    {
+        hints.ai_family =3D ai_family;
+    }
+
+    status =3D getaddrinfo(hostname, servname, &hints, res);
+
+    if (status !=3D 0)                      /* parse as numeric address fa=
iled? */
+    {
+        const int fail_wait_interval =3D 5; /* seconds */
+        /* Add +4 to cause integer division rounding up (1 + 4) =3D 5, (0+=
4)/5=3D0 */
+        int resolve_retries =3D
+            (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) =
/ fail_wait_interval);
+        const char *fmt;
+        int level =3D 0;
+
+        /* this is not a numeric IP, therefore force resolution using the
+         * provided ai_family */
+        hints.ai_family =3D ai_family;
+
+        if (hostname && (flags & GETADDR_RANDOMIZE))
+        {
+            hostname =3D hostname_randomize(hostname, &gc);
+        }
+
+        if (hostname)
+        {
+            print_hostname =3D hostname;
+        }
+        else
+        {
+            print_hostname =3D "undefined";
+        }
+
+        fmt =3D "RESOLVE: Cannot resolve host address: %s:%s%s (%s)";
+        if ((flags & GETADDR_MENTION_RESOLVE_RETRY) && !resolve_retry_seco=
nds)
+        {
+            fmt =3D "RESOLVE: Cannot resolve host address: %s:%s%s (%s)"
+                  "(I would have retried this name query if you had "
+                  "specified the --resolv-retry option.)";
+        }
+
+        if (!(flags & GETADDR_RESOLVE) || status =3D=3D EAI_FAIL)
+        {
+            msg(msglevel, "RESOLVE: Cannot parse IP address: %s:%s (%s)", =
print_hostname,
+                print_servname, gai_strerror(status));
+            goto done;
+        }
+
+#ifdef ENABLE_MANAGEMENT
+        if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
+        {
+            if (management)
+            {
+                management_set_state(management, OPENVPN_STATE_RESOLVE, NU=
LL, NULL, NULL, NULL,
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
+            hints.ai_flags &=3D ~AI_NUMERICHOST;
+            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=3D0x%04x ai_family=3D%=
d ai_socktype=3D%d", flags,
+                 hints.ai_family, hints.ai_socktype);
+            status =3D getaddrinfo(hostname, servname, &hints, res);
+
+            if (sig_info)
+            {
+                get_signal(&sig_info->signal_received);
+                if (sig_info->signal_received) /* were we interrupted by a=
 signal? */
+                {
+                    /* why are we overwriting SIGUSR1 ? */
+                    if (signal_reset(sig_info, SIGUSR1) =3D=3D SIGUSR1) /*=
 ignore SIGUSR1 */
+                    {
+                        msg(level, "RESOLVE: Ignored SIGUSR1 signal receiv=
ed during "
+                                   "DNS resolution attempt");
+                    }
+                    else
+                    {
+                        /* turn success into failure (interrupted syscall)=
 */
+                        if (0 =3D=3D status)
+                        {
+                            ASSERT(res);
+                            freeaddrinfo(*res);
+                            *res =3D NULL;
+                            status =3D EAI_AGAIN; /* =3D temporary failure=
 */
+                            errno =3D EINTR;
+                        }
+                        goto done;
+                    }
+                }
+            }
+
+            /* success? */
+            if (0 =3D=3D status)
+            {
+                break;
+            }
+
+            /* resolve lookup failed, should we
+             * continue or fail? */
+            level =3D msglevel;
+            if (resolve_retries > 0)
+            {
+                level =3D D_RESOLVE_ERRORS;
+            }
+
+            msg(level, fmt, print_hostname, print_servname, getaddrinfo_ad=
dr_family_name(ai_family),
+                gai_strerror(status));
+
+            if (--resolve_retries <=3D 0)
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
+         * of IP addresses, doing so will break RFC 3484 address selection=
 *
+         */
+    }
+    else
+    {
+        /* IP address parse succeeded */
+        if (flags & GETADDR_RANDOMIZE)
+        {
+            msg(M_WARN, "WARNING: ignoring --remote-random-hostname becaus=
e the "
+                        "hostname is an IP address");
+        }
+    }
+
+done:
+    if (sig_info && sig_info->signal_received)
+    {
+        int level =3D 0;
+        if (flags & GETADDR_FATAL_ON_SIGNAL)
+        {
+            level =3D M_FATAL;
+        }
+        else if (flags & GETADDR_WARN_ON_SIGNAL)
+        {
+            level =3D M_WARN;
+        }
+        msg(level, "RESOLVE: signal received during DNS resolution attempt=
");
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
+    if (sscanf(dotted_quad, "%u.%u.%u.%u", &a, &b, &c, &d) =3D=3D 4)
+    {
+        if (a < 256 && b < 256 && c < 256 && d < 256)
+        {
+            addr->s_addr =3D htonl(a << 24 | b << 16 | c << 8 | d);
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
+        int nnum =3D 0;
+        const char *p =3D dotted_quad;
+        int c;
+
+        while ((c =3D *p++))
+        {
+            if (c >=3D '0' && c <=3D '9')
+            {
+                ++nnum;
+                if (nnum > 3)
+                {
+                    return false;
+                }
+            }
+            else if (c =3D=3D '.')
+            {
+                nnum =3D 0;
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
+        return openvpn_inet_aton(dotted_quad, &a) =3D=3D OIA_IP;
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
+        return inet_pton(AF_INET6, ipv6_text_addr, &a6) =3D=3D 1;
+    }
+}
+
+static bool
+dns_addr_safe(const char *addr)
+{
+    if (addr)
+    {
+        const size_t len =3D strlen(addr);
+        return len > 0 && len <=3D 255 && string_class(addr, CC_ALNUM | CC=
_DASH | CC_DOT, 0);
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
+        int nnum =3D 0;
+        const char *p =3D mac_addr;
+        int c;
+
+        while ((c =3D *p++))
+        {
+            if ((c >=3D '0' && c <=3D '9') || (c >=3D 'a' && c <=3D 'f') |=
| (c >=3D 'A' && c <=3D 'F'))
+            {
+                ++nnum;
+                if (nnum > 2)
+                {
+                    return false;
+                }
+            }
+            else if (c =3D=3D ':')
+            {
+                nnum =3D 0;
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
+    /*int dummy;*/ /* add offset to force a bug if sa not explicitly deref=
erenced */
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
+    /*int dummy;*/ /* add offset to force a bug if dest not explicitly der=
eferenced */
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
+const char *print_sockaddr_ex(const struct sockaddr *addr, const char *sep=
arator,
+                              const unsigned int flags, struct gc_arena *g=
c);
+
+static inline const char *
+print_openvpn_sockaddr(const struct openvpn_sockaddr *addr, struct gc_aren=
a *gc)
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
+const char *print_link_socket_actual_ex(const struct link_socket_actual *a=
ct, const char *separator,
+                                        const unsigned int flags, struct g=
c_arena *gc);
+
+const char *print_link_socket_actual(const struct link_socket_actual *act,=
 struct gc_arena *gc);
+
+
+#define IA_EMPTY_IF_UNDEF (1 << 0)
+#define IA_NET_ORDER      (1 << 1)
+const char *print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_=
arena *gc);
+
+const char *print_in6_addr(struct in6_addr addr6, unsigned int flags, stru=
ct gc_arena *gc);
+
+const char *print_in_port_t(in_port_t port, struct gc_arena *gc);
+
+struct in6_addr add_in6_addr(struct in6_addr base, uint32_t add);
+
+#define SA_IP_PORT        (1 << 0)
+#define SA_SET_IF_NONZERO (1 << 1)
+void setenv_sockaddr(struct env_set *es, const char *name_prefix,
+                     const struct openvpn_sockaddr *addr, const unsigned i=
nt flags);
+
+void setenv_in_addr_t(struct env_set *es, const char *name_prefix, in_addr=
_t addr,
+                      const unsigned int flags);
+
+void setenv_in6_addr(struct env_set *es, const char *name_prefix, const st=
ruct in6_addr *addr,
+                     const unsigned int flags);
+
+void setenv_link_socket_actual(struct env_set *es, const char *name_prefix,
+                               const struct link_socket_actual *act, const=
 unsigned int flags);
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
+in_addr_t getaddr(unsigned int flags, const char *hostname, int resolve_re=
try_seconds,
+                  bool *succeeded, struct signal_info *sig_info);
+
+/**
+ * Translate an IPv6 addr or hostname from string form to in6_addr
+ */
+bool get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigne=
d int *netbits,
+                   int msglevel);
+
+int openvpn_getaddrinfo(unsigned int flags, const char *hostname, const ch=
ar *servname,
+                        int resolve_retry_seconds, struct signal_info *sig=
_info, int ai_family,
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
+    ASSERT(proto >=3D 0 && proto < PROTO_N);
+    return proto !=3D PROTO_NONE;
+}
+
+/**
+ * @brief Returns if the protocol being used is UDP
+ */
+static inline bool
+proto_is_udp(int proto)
+{
+    ASSERT(proto >=3D 0 && proto < PROTO_N);
+    return proto =3D=3D PROTO_UDP;
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
+ * @brief returns if the proto is a TCP variant (tcp-server, tcp-client or=
 tcp)
+ */
+static inline bool
+proto_is_tcp(int proto)
+{
+    ASSERT(proto >=3D 0 && proto < PROTO_N);
+    return proto =3D=3D PROTO_TCP_CLIENT || proto =3D=3D PROTO_TCP_SERVER;
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
+            return addr->addr.in4.sin_addr.s_addr !=3D 0;
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
+            return ((const struct sockaddr_in *)addr)->sin_addr.s_addr =3D=
=3D htonl(INADDR_LOOPBACK);
+
+        case AF_INET6:
+            return IN6_IS_ADDR_LOOPBACK(&((const struct sockaddr_in6 *)add=
r)->sin6_addr);
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
+            return lsa->pi.in4.ipi_spec_dst.s_addr !=3D 0;
+
+#elif defined(IP_RECVDSTADDR)
+        case AF_INET:
+            return lsa->pi.in4.s_addr !=3D 0;
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
+    int overhead =3D 0;
+    overhead +=3D (proto =3D=3D PROTO_UDP) ? 8 : 20;
+    overhead +=3D (af =3D=3D AF_INET) ? 20 : 40;
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
+addr_match(const struct openvpn_sockaddr *a1, const struct openvpn_sockadd=
r *a2)
+{
+    switch (a1->addr.sa.sa_family)
+    {
+        case AF_INET:
+            return a1->addr.in4.sin_addr.s_addr =3D=3D a2->addr.in4.sin_ad=
dr.s_addr;
+
+        case AF_INET6:
+            return IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &a2->addr.i=
n6.sin6_addr);
+    }
+    ASSERT(0);
+    return false;
+}
+
+static inline bool
+addrlist_match(const struct openvpn_sockaddr *a1, const struct addrinfo *a=
ddrlist)
+{
+    const struct addrinfo *curele;
+    for (curele =3D addrlist; curele; curele =3D curele->ai_next)
+    {
+        switch (a1->addr.sa.sa_family)
+        {
+            case AF_INET:
+                if (a1->addr.in4.sin_addr.s_addr
+                    =3D=3D ((struct sockaddr_in *)curele->ai_addr)->sin_ad=
dr.s_addr)
+                {
+                    return true;
+                }
+                break;
+
+            case AF_INET6:
+                if (IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr,
+                                       &((struct sockaddr_in6 *)curele->ai=
_addr)->sin6_addr))
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
+addrlist_port_match(const struct openvpn_sockaddr *a1, const struct addrin=
fo *a2)
+{
+    const struct addrinfo *curele;
+    for (curele =3D a2; curele; curele =3D curele->ai_next)
+    {
+        switch (a1->addr.sa.sa_family)
+        {
+            case AF_INET:
+                if (curele->ai_family =3D=3D AF_INET
+                    && a1->addr.in4.sin_addr.s_addr
+                           =3D=3D ((struct sockaddr_in *)curele->ai_addr)-=
>sin_addr.s_addr
+                    && a1->addr.in4.sin_port =3D=3D ((struct sockaddr_in *=
)curele->ai_addr)->sin_port)
+                {
+                    return true;
+                }
+                break;
+
+            case AF_INET6:
+                if (curele->ai_family =3D=3D AF_INET6
+                    && IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr,
+                                          &((struct sockaddr_in6 *)curele-=
>ai_addr)->sin6_addr)
+                    && a1->addr.in6.sin6_port
+                           =3D=3D ((struct sockaddr_in6 *)curele->ai_addr)=
->sin6_port)
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
+addr_port_match(const struct openvpn_sockaddr *a1, const struct openvpn_so=
ckaddr *a2)
+{
+    switch (a1->addr.sa.sa_family)
+    {
+        case AF_INET:
+            return a1->addr.in4.sin_addr.s_addr =3D=3D a2->addr.in4.sin_ad=
dr.s_addr
+                   && a1->addr.in4.sin_port =3D=3D a2->addr.in4.sin_port;
+
+        case AF_INET6:
+            return IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &a2->addr.i=
n6.sin6_addr)
+                   && a1->addr.in6.sin6_port =3D=3D a2->addr.in6.sin6_port;
+    }
+    ASSERT(0);
+    return false;
+}
+
+static inline bool
+addr_match_proto(const struct openvpn_sockaddr *a1, const struct openvpn_s=
ockaddr *a2,
+                 const int proto)
+{
+    return link_socket_proto_connection_oriented(proto) ? addr_match(a1, a=
2)
+                                                        : addr_port_match(=
a1, a2);
+}
+
+
+static inline bool
+addrlist_match_proto(const struct openvpn_sockaddr *a1, struct addrinfo *a=
ddr_list, const int proto)
+{
+    return link_socket_proto_connection_oriented(proto) ? addrlist_match(a=
1, addr_list)
+                                                        : addrlist_port_ma=
tch(a1, addr_list);
+}
+
+static inline void
+addr_zero_host(struct openvpn_sockaddr *addr)
+{
+    switch (addr->addr.sa.sa_family)
+    {
+        case AF_INET:
+            addr->addr.in4.sin_addr.s_addr =3D 0;
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
+link_socket_actual_match(const struct link_socket_actual *a1, const struct=
 link_socket_actual *a2)
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1159?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7393459b975fb9b3e0a42743f58645f769d1be5a
Gerrit-Change-Number: 1159
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--FKc/jWy5tLY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1159?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">socket: Create socket_util with non-socket functions=
<br><br>This extracts a lot of the helper functions that do not<br>actually=
 work on sockets, but instead on addresses or<br>similar.<br><br>This inclu=
des<br><br>- openvpn_getaddrinfo and related functions<br>- print_*<br>- se=
tenv_*<br><br>And lots of the inline functions.<br><br>This move will make =
it easier to add unit tests<br>for these moved functions.<br><br>Change-Id:=
 I7393459b975fb9b3e0a42743f58645f769d1be5a<br>Signed-off-by: Frank Lichtenh=
eld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&=
gt;<br>Message-Id: &lt;20250831155939.29240-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32727.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMake=
Lists.txt<br>M src/openvpn/Makefile.am<br>M src/openvpn/clinat.c<br>M src/o=
penvpn/dhcp.c<br>M src/openvpn/dns.c<br>M src/openvpn/manage.h<br>M src/ope=
nvpn/misc.c<br>M src/openvpn/misc.h<br>M src/openvpn/mroute.c<br>M src/open=
vpn/mss.h<br>M src/openvpn/networking_iproute2.c<br>M src/openvpn/options.c=
<br>M src/openvpn/options.h<br>M src/openvpn/pool.c<br>M src/openvpn/socket=
.c<br>M src/openvpn/socket.h<br>A src/openvpn/socket_util.c<br>A src/openvp=
n/socket_util.h<br>M src/openvpn/ssl_common.h<br>M src/openvpn/tun.c<br>20 =
files changed, 1,443 insertions(+), 1,380 deletions(-)<br><br></pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit.openvpn.net:29418/openvpn refs/changes/59/1159/2</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 3866e21..45044=
af 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeL=
ists.txt</span><br><span>@@ -555,6 +555,8 @@</span><br><span>     src/openv=
pn/sig.h</span><br><span>     src/openvpn/socket.c</span><br><span>     src=
/openvpn/socket.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  src/openvpn/socket_util.c</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    src/openvpn/socket_util.h</span><br><span>     src/openvpn/sock=
s.c</span><br><span>     src/openvpn/socks.h</span><br><span>     src/openv=
pn/ssl.c</span><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn=
/Makefile.am</span><br><span>index 1e17c3f..217f897 100644</span><br><span>=
--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am=
</span><br><span>@@ -128,6 +128,7 @@</span><br><span> 	shaper.c shaper.h \<=
/span><br><span> 	sig.c sig.h \</span><br><span> 	socket.c socket.h \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	socket_util.c socket_uti=
l.h \</span><br><span> 	socks.c socks.h \</span><br><span> 	ssl.c ssl.h  ss=
l_backend.h \</span><br><span> 	ssl_openssl.c ssl_openssl.h \</span><br><sp=
an>diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c</span><br><span=
>index a303285..48a2057 100644</span><br><span>--- a/src/openvpn/clinat.c</=
span><br><span>+++ b/src/openvpn/clinat.c</span><br><span>@@ -28,7 +28,7 @@=
</span><br><span> </span><br><span> #include &quot;clinat.h&quot;</span><br=
><span> #include &quot;proto.h&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#include &quot;socket.h&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;socket_util.h&quot;</span><br><span=
> #include &quot;memdbg.h&quot;</span><br><span> </span><br><span> static b=
ool</span><br><span>diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c</s=
pan><br><span>index 0a7689f..7abade5 100644</span><br><span>--- a/src/openv=
pn/dhcp.c</span><br><span>+++ b/src/openvpn/dhcp.c</span><br><span>@@ -27,7=
 +27,7 @@</span><br><span> #include &quot;syshead.h&quot;</span><br><span> =
</span><br><span> #include &quot;dhcp.h&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#include &quot;socket.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket_util.h&quot;</span>=
<br><span> #include &quot;error.h&quot;</span><br><span> </span><br><span> =
#include &quot;memdbg.h&quot;</span><br><span>diff --git a/src/openvpn/dns.=
c b/src/openvpn/dns.c</span><br><span>index 8e28c2b..8554089 100644</span><=
br><span>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</s=
pan><br><span>@@ -27,7 +27,7 @@</span><br><span> #include &quot;syshead.h&q=
uot;</span><br><span> </span><br><span> #include &quot;dns.h&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;socket.h&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socke=
t_util.h&quot;</span><br><span> #include &quot;options.h&quot;</span><br><s=
pan> #include &quot;run_command.h&quot;</span><br><span> </span><br><span>d=
iff --git a/src/openvpn/manage.h b/src/openvpn/manage.h</span><br><span>ind=
ex 083caf5..b8892c8 100644</span><br><span>--- a/src/openvpn/manage.h</span=
><br><span>+++ b/src/openvpn/manage.h</span><br><span>@@ -48,7 +48,7 @@</sp=
an><br><span> </span><br><span> #include &quot;misc.h&quot;</span><br><span=
> #include &quot;event.h&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#include &quot;socket.h&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;socket_util.h&quot;</span><br><span> #inc=
lude &quot;mroute.h&quot;</span><br><span> </span><br><span> #define MANAGE=
MENT_VERSION                  5</span><br><span>diff --git a/src/openvpn/mi=
sc.c b/src/openvpn/misc.c</span><br><span>index 17f7706..59bf52b 100644</sp=
an><br><span>--- a/src/openvpn/misc.c</span><br><span>+++ b/src/openvpn/mis=
c.c</span><br><span>@@ -72,27 +72,6 @@</span><br><span> #endif</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Prepend a ran=
dom string to hostname to prevent DNS caching.</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * For example, foo.bar.gov would be modified to &=
lt;random-chars&gt;.foo.bar.gov.</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * Of course, this requires explicit support in the DNS server (=
wildcard).</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-const char *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-hostname_randomize(const char *hostnam=
e, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define n_rnd_byte=
s 6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    uint8_t rnd_bytes[n_rnd_bytes];</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *rnd_str;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer hnam=
e =3D alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    prng_bytes(rnd_bytes, sizeof(rnd_bytes));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    rnd_str =3D format_h=
ex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;hname, &quot;%s.%s&quot=
;, rnd_str, hostname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return BSTR(&amp;hname);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#undef n_rnd_bytes</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> #ifdef ENABLE_MANAGEMENT</span><br><span> /* Get username/password from =
the management interface */</span><br><span> static bool</span><br><span>di=
ff --git a/src/openvpn/misc.h b/src/openvpn/misc.h</span><br><span>index 1b=
10cd9..e87fd85 100644</span><br><span>--- a/src/openvpn/misc.h</span><br><s=
pan>+++ b/src/openvpn/misc.h</span><br><span>@@ -44,9 +44,6 @@</span><br><s=
pan> </span><br><span> const char **make_extended_arg_array(char **p, bool =
is_inline, struct gc_arena *gc);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/* prepend a random prefix to hostname */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *hostname_rando=
mize(const char *hostname, struct gc_arena *gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Get and=
 store a username/password</span><br><span>  */</span><br><span>diff --git =
a/src/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><span>index a598037=
..ab01874 100644</span><br><span>--- a/src/openvpn/mroute.c</span><br><span=
>+++ b/src/openvpn/mroute.c</span><br><span>@@ -30,7 +30,7 @@</span><br><sp=
an> #include &quot;mroute.h&quot;</span><br><span> #include &quot;proto.h&q=
uot;</span><br><span> #include &quot;error.h&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#include &quot;socket.h&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket_util.h&quot;</=
span><br><span> </span><br><span> #include &quot;memdbg.h&quot;</span><br><=
span> </span><br><span>diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h</=
span><br><span>index 05f12a7..bcbb5a8 100644</span><br><span>--- a/src/open=
vpn/mss.h</span><br><span>+++ b/src/openvpn/mss.h</span><br><span>@@ -26,6 =
+26,7 @@</span><br><span> #include &quot;proto.h&quot;</span><br><span> #in=
clude &quot;error.h&quot;</span><br><span> #include &quot;mtu.h&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket.h&q=
uot;</span><br><span> #include &quot;ssl_common.h&quot;</span><br><span> </=
span><br><span> void mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss);</=
span><br><span>diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn=
/networking_iproute2.c</span><br><span>index 0635b5d..e9be3a4 100644</span>=
<br><span>--- a/src/openvpn/networking_iproute2.c</span><br><span>+++ b/src=
/openvpn/networking_iproute2.c</span><br><span>@@ -30,7 +30,7 @@</span><br>=
<span> #include &quot;misc.h&quot;</span><br><span> #include &quot;openvpn.=
h&quot;</span><br><span> #include &quot;run_command.h&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#include &quot;socket.h&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket_util.=
h&quot;</span><br><span> </span><br><span> #include &lt;stdbool.h&gt;</span=
><br><span> #include &lt;netinet/in.h&gt;</span><br><span>diff --git a/src/=
openvpn/options.c b/src/openvpn/options.c</span><br><span>index 648d526..74=
946a4 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>++=
+ b/src/openvpn/options.c</span><br><span>@@ -45,7 +45,7 @@</span><br><span=
> #include &quot;ssl_ncp.h&quot;</span><br><span> #include &quot;options.h&=
quot;</span><br><span> #include &quot;misc.h&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#include &quot;socket.h&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket_util.h&quot;</=
span><br><span> #include &quot;packet_id.h&quot;</span><br><span> #include =
&quot;pkcs11.h&quot;</span><br><span> #include &quot;win32.h&quot;</span><b=
r><span>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><b=
r><span>index 4fa6800..44f3fc9 100644</span><br><span>--- a/src/openvpn/opt=
ions.h</span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -33,7=
 +33,7 @@</span><br><span> #include &quot;mtu.h&quot;</span><br><span> #inc=
lude &quot;route.h&quot;</span><br><span> #include &quot;tun.h&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;socket.h&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;soc=
ket_util.h&quot;</span><br><span> #include &quot;plugin.h&quot;</span><br><=
span> #include &quot;manage.h&quot;</span><br><span> #include &quot;proxy.h=
&quot;</span><br><span>diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c=
</span><br><span>index a41364a..fde6cea 100644</span><br><span>--- a/src/op=
envpn/pool.c</span><br><span>+++ b/src/openvpn/pool.c</span><br><span>@@ -2=
9,7 +29,7 @@</span><br><span> #include &quot;pool.h&quot;</span><br><span> =
#include &quot;buffer.h&quot;</span><br><span> #include &quot;error.h&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;socket=
.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &q=
uot;socket_util.h&quot;</span><br><span> #include &quot;otime.h&quot;</span=
><br><span> </span><br><span> #include &quot;memdbg.h&quot;</span><br><span=
>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>i=
ndex 8fc10bc..306170c 100644</span><br><span>--- a/src/openvpn/socket.c</sp=
an><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -405,428 +405,6 =
@@</span><br><span>     throw_signal_soft(SIGHUP, &quot;Preresolving failed=
&quot;);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * Small helper function for openvpn_getaddrinfo to print the address=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * family when resolv=
ing fails</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-getaddrinfo_addr_family_name(int=
 af)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    switch (af)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case AF_INET:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            return &quot;[AF_INET]&quot;;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        case AF_INET6:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            return &quot;[AF_INET6]&quot;;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return &quot;&quot;;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * Translate IPv4/IPv6 addr or hostn=
ame into struct addrinfo</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * If resolve error, try again for resolve_retry_seconds seconds.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-openvpn_getaddrinfo(unsigned int flags, const char *hostname, co=
nst char *servname,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  int resolve_retry_seconds, struct signal_info *sig_info, =
int ai_family,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             struct addrinfo **res)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct addrinfo hints;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct signal_info sigrec =3D { 0 };</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int msglevel =3D (flags &amp; GETADDR_FATAL) ? M_FATAL : D_=
RESOLVE_ERRORS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const char *print_hostname;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const char *print_servname;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ASSERT(res);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(hostnam=
e || servname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    AS=
SERT(!(flags &amp; GETADDR_HOST_ORDER));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (servname)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        print_servname=
 =3D servname;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        print_servname =3D &quot;&quot;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (flags &amp; GETADDR_MSG_VIRT_OUT)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msglevel |=3D M_MSG_VIRT_OUT;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((fla=
gs &amp; (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) &amp;&amp; !si=
g_info)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        sig_info =3D &amp;sigr=
ec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* try numeric ip addr first */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    CLEAR(hints);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    hints.ai_flags =3D AI_NUMERICHOST;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (flags &amp; GETADDR_PASSIVE)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        hints.ai_flags |=3D AI_PASSIVE;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (flags &amp; GETADDR_DATAGRAM)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        hints.ai_socktype =3D SOCK_DGRAM;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        hints.ai_=
socktype =3D SOCK_STREAM;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* if hostname is not set, we=
 want to bind to &#39;ANY&#39;, with</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * the correct address family - v4-only or v6/v6-dual-st=
ack */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!hostna=
me)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        hints.ai_family =3D ai_fam=
ily;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    status =3D getaddrinfo(hostname, servname, &amp;hi=
nts, res);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (status !=3D 0)          =
            /* parse as numeric address failed? */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        const int fail_wait_interval =3D 5; /* seconds */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Add +4 to cause=
 integer division rounding up (1 + 4) =3D 5, (0+4)/5=3D0 */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        int resolve_retries =3D</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            (flags &amp; GE=
TADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *fmt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int level =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        /* this is not a numeric IP,=
 therefore force resolution using the</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-         * provided ai_family */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        hints.ai_family =3D ai_family;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (hostname &amp;&amp; (flags &amp; GETADDR=
_RANDOMIZE))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            hostname =
=3D hostname_randomize(hostname, &amp;gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
hostname)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            print_hostna=
me =3D hostname;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            print_hostname =3D &quot;u=
ndefined&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        fmt =3D &quot;RESOLVE: Cannot r=
esolve host address: %s:%s%s (%s)&quot;;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if ((flags &amp; GETADDR_MENTION_RESOLVE_RETRY) =
&amp;&amp; !resolve_retry_seconds)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            fmt =3D &quot;RESOLVE: Cannot resolve host address: %s:%s%s (%=
s)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
     &quot;(I would have retried this name query if you had &quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                  &quot;specif=
ied the --resolv-retry option.)&quot;;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!(fl=
ags &amp; GETADDR_RESOLVE) || status =3D=3D EAI_FAIL)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(msglevel, &quot;RESOLVE: Cannot parse I=
P address: %s:%s (%s)&quot;, print_hostname,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                print_servname, gai_strerror(status)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto do=
ne;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (flags &amp; GETADDR_UPDATE_MANAGEMEN=
T_STATE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (managemen=
t)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                management_=
set_state(management, OPENVPN_STATE_RESOLVE, NULL, NULL, NULL, NULL,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
         NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-         * Resolve hostname</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      while (true)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef _WIN32<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* force r=
esolv.conf reload */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           res_init();</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*=
 try hostname lookup */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            hints.ai_flags &amp;=3D ~AI_NUMERICHOST;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_SOCKET_DEBUG, &quot;GET=
ADDRINFO flags=3D0x%04x ai_family=3D%d ai_socktype=3D%d&quot;, flags,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                 hints.ai_f=
amily, hints.ai_socktype);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            status =3D getaddrinfo(hostname, servname, &amp;hints, res=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (sig_info)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                get_signal(&amp;sig_info-&g=
t;signal_received);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              if (sig_info-&gt;signal_received) /* were we interrupted by a=
 signal? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      /* why are we overwriting SIGUSR1 ? */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    if (signal_reset(sig_info, SIGUS=
R1) =3D=3D SIGUSR1) /* ignore SIGUSR1 */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                        msg(level, &quot;RESOLVE: Ignore=
d SIGUSR1 signal received during &quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                   &quot;DNS resolution a=
ttempt&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    /* turn success into failure (interrupted syscall) */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 if (0 =3D=3D status)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                            ASSERT(res);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                            freeaddrinfo(*res);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
  *res =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                       status =3D EAI_AGAIN; /* =3D temporary failure */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
    errno =3D EINTR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        goto done;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* su=
ccess? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
if (0 =3D=3D status)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            /* resolve lookup failed,=
 should we</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
  * continue or fail? */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            level =3D msglevel;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            if (resolve_retries &gt; 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                level =3D D_RESOLVE_ERRORS;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            msg(level, fmt, print_hostname, print_servname=
, getaddrinfo_addr_family_name(ai_family),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                gai_strerror(status));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            if (--resolve_retries &lt;=3D 0)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                goto done;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            management_sleep(fail_wait_interval);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        ASSERT(res);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* hostname=
 resolve succeeded */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-         * Do not choose an IP A=
ddresse by random or change the order *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-         * of IP addresses, doing so will break RFC 3484 =
address selection *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
       */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        /* IP address parse succeeded */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (flags &amp; GETADDR_RANDOM=
IZE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot=
;WARNING: ignoring --remote-random-hostname because the &quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        &quot;host=
name is an IP address&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-done:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (sig_info &amp;&amp; sig_info-&gt;signal_received)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        int level =3D 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (flags &amp; GETADDR_FA=
TAL_ON_SIGNAL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            level =
=3D M_FATAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (flag=
s &amp; GETADDR_WARN_ON_SIGNAL)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          level =3D M_WARN;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  msg(level, &quot;RESOLVE: signal received during DNS resolution attempt&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return status;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * We do our own inet_aton because the g=
libc function</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * isn&#=
39;t very good about error checking.</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn_inet_aton(con=
st char *dotted_quad, struct in_addr *addr)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    unsigned int a, b, c, d;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(*a=
ddr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sscanf(d=
otted_quad, &quot;%u.%u.%u.%u&quot;, &amp;a, &amp;b, &amp;c, &amp;d) =3D=3D=
 4)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (a &lt; 256 &amp;&amp; =
b &lt; 256 &amp;&amp; c &lt; 256 &amp;&amp; d &lt; 256)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            addr-&gt;s_addr =3D htonl(a &lt;&lt; 24 |=
 b &lt;&lt; 16 | c &lt;&lt; 8 | d);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            return OIA_IP; /* good dotted quad */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (string_class(dotted_quad, CC_DIGIT | CC_DOT, 0))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return OIA_ERROR; /* probably a =
badly formatted dotted quad */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        return OIA_HOSTNAME; /* prob=
ably a hostname */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ip=
_addr_dotted_quad_safe(const char *dotted_quad)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* verify non-NULL */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (!dotted_quad)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* verify length is within limits */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (strlen(dotted_qu=
ad) &gt; 15)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* verify that all chars are either numeric or &#39;.&#39;=
 and that no numeric</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    * substring is greater than 3 chars */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        int nnum =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        const char *p =3D dotted_quad;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        int c;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    while ((c =3D *p++))</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (c &gt;=3D &#39;0&#39; &amp;&amp; c &lt;=3D &#39;9&#39;)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                ++nnum;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                if (nnum &gt; 3)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    return false;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            else if (c =3D=3D &#3=
9;.&#39;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                nnum=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                return false;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ve=
rify that string will convert to IP address */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        struct in_addr a;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        return openvpn_inet_aton(dotted_quad, &amp;a) =3D=3D O=
IA_IP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ipv6_addr_safe=
(const char *ipv6_text_addr)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* verify=
 non-NULL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
ipv6_text_addr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    /* verify length is within limits */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (strlen(ipv6_text_addr) &gt; INET=
6_ADDRSTRLEN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* verify that string will convert to IPv6 address */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        struct in6_addr a6;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return inet_pton(AF_INET6, =
ipv6_text_addr, &amp;a6) =3D=3D 1;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-dns_addr_safe(const char *addr)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (addr)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cons=
t size_t len =3D strlen(addr);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        return len &gt; 0 &amp;&amp; len &lt;=3D 255 &amp;&amp; st=
ring_class(addr, CC_ALNUM | CC_DASH | CC_DOT, 0);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return fa=
lse;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ip_or_dns_addr_s=
afe(const char *addr, const bool allow_fqdn)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (ip_addr_dotted_quad_safe(addr))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return true;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if =
(allow_fqdn)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return dns_addr_s=
afe(addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return false;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-mac_addr_safe(const char *mac_addr)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* verify non-NULL */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (!mac_addr)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* verify length is within limits =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (strlen(mac_=
addr) &gt; 17)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* verify that all chars are either alphanumeric or &#39=
;:&#39; and that no</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   * alphanumeric substring is greater than 2 chars */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        int nnum =3D 0;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        const char *p =3D mac_addr;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        int c;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        while ((c =3D *p++))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if ((c &gt;=3D &#39;0&#39; &amp;&amp; c &lt;=3D &#39;9&#39;) ||=
 (c &gt;=3D &#39;a&#39; &amp;&amp; c &lt;=3D &#39;f&#39;) || (c &gt;=3D &#3=
9;A&#39; &amp;&amp; c &lt;=3D &#39;F&#39;))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                ++nnum;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                if (nnum &gt; 2)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    return false;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            else if (c =3D=3D &#39;:&#39;)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                nnum =3D 0;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                return false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* error-checking is =
left to script invoked in lladdr.c */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return true;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> static int</span><br><span> socket_get_sndbuf(socket_descriptor_t =
sd)</span><br><span> {</span><br><span>@@ -2670,467 +2248,6 @@</span><br><s=
pan> #endif</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Format IP addresses in ascii</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-print_sockaddr_ex(const struct=
 sockaddr *sa, const char *separator, const unsigned int flags,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                  struct gc_arena=
 *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct buffer out =3D alloc_buf_=
gc(128, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool =
addr_is_defined =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    char hostaddr[NI_MAXHOST] =3D &quot;&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    char servname[NI_MAXSERV] =3D &quot;&qu=
ot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int status;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    socklen_t salen =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    switch (sa-&gt;sa_family)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        case AF_INET:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            if (!(flags &amp; PS_DONT_SHOW_FAM=
ILY))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                buf_puts=
(&amp;out, &quot;[AF_INET]&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            salen =3D sizeof(struct sockaddr_in);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            addr_is_defined =3D ((struct s=
ockaddr_in *)sa)-&gt;sin_addr.s_addr !=3D 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       case AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if (!(flags &amp; PS_DONT_SHOW_FAMILY))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                buf_puts(&amp;out, &quot;[AF_INET6]=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            salen =3D=
 sizeof(struct sockaddr_in6);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            addr_is_defined =3D !IN6_IS_ADDR_UNSPECIFIED(&amp;((str=
uct sockaddr_in6 *)sa)-&gt;sin6_addr);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 case AF_UNSPEC:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (!(flags &amp; PS_DONT_SHOW_FAMILY))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                return &quot;[AF_UNSPEC]&quot;;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                return &quot;&quot;;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            ASSERT(0);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D getnameinfo(sa,=
 salen, hostaddr, sizeof(hostaddr), servname, sizeof(servname),</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                         NI_NUMER=
ICHOST | NI_NUMERICSERV);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (status !=
=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &q=
uot;[nameinfo() err: %s]&quot;, gai_strerror(status));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return BSTR(&amp;out);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!(flags &amp; PS_DONT_SHOW_ADDR))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (addr_is_defined)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            buf_puts(&amp;out, hostaddr);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   buf_puts(&amp;out, &quot;[undef]&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((flags &amp; PS_SHO=
W_PORT) || (flags &amp; PS_SHOW_PORT_IF_DEFINED))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (separator)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            buf_puts(&amp;out, separator);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf=
_puts(&amp;out, servname);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return BSTR(&amp;out);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pr=
int_link_socket_actual(const struct link_socket_actual *act, struct gc_aren=
a *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return print_link_socket_actual=
_ex(act, &quot;:&quot;, PS_SHOW_PORT | PS_SHOW_PKTINFO, gc);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fndef IF_NAMESIZE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine IF_NAMESIZE 16</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-const char *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-print_link_socket_actual_ex(const struct link_so=
cket_actual *act, const char *separator,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                            const unsigned int flags, st=
ruct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (act)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        struct buffer out =3D alloc_buf_gc(128, =
gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_print=
f(&amp;out, &quot;%s&quot;, print_sockaddr_ex(&amp;act-&gt;dest.addr.sa, se=
parator, flags, gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if ENABLE_IP_PKTINFO</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        char ifname[IF_NAMESIZE] =3D &quot;[undef]&quot;;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if ((flags &amp; PS_SHOW_PKTINFO) &amp;&amp; addr_de=
fined_ipi(act))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            switch=
 (act-&gt;dest.addr.sa.sa_family)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                case AF_INET:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    struct openvpn_sockaddr sa;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    CLEAR(sa);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    sa.addr.in4.=
sin_family =3D AF_INET;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    sa.addr.=
in4.sin_addr =3D act-&gt;pi.in4.ipi_spec_dst;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    if_indextoname(act-&gt;pi.in4.i=
pi_ifindex, ifname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
elif defined(IP_RECVDSTADDR)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    sa.addr.in4.sin_addr =3D act-&gt;pi.in4;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    ifname[0]=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* if de=
fined(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST) */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#error ENABLE_IP_PKTINFO is set w=
ithout IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    buf_printf(&amp;out, &quot; (via %s%%%=
s)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                   print_sockaddr_ex(&amp;sa.addr.sa, separator, 0, gc), if=
name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                bre=
ak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                case AF_INET6:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    struct sockadd=
r_in6 sin6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          char buf[INET6_ADDRSTRLEN] =3D &quot;[undef]&quot;;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    CLEAR(sin6);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    sin6=
.sin6_family =3D AF_INET6;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    sin6.sin6_addr =3D act-&gt;pi.in6.ipi6_addr;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    if_inde=
xtoname(act-&gt;pi.in6.ipi6_ifindex, ifname);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    if (getnameinfo((struct sockadd=
r *)&amp;sin6, sizeof(struct sockaddr_in6), buf,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                    sizeof(buf),=
 NULL, 0, NI_NUMERICHOST)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        =3D=3D 0)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        buf_printf(&amp;out, &quot; (via %s=
%%%s)&quot;, buf, ifname);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    else</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                        buf_printf(&amp;out, &quot; (via [getnamein=
fo() err]%%%s)&quot;, ifname);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                break;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if E=
NABLE_IP_PKTINFO */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return BSTR(&amp;out);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return &quot;[NULL]&quot;;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * Convert an in_addr_t in=
 host byte order</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * to=
 an ascii dotted quad.</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-print_in_addr_t(in_addr_t =
addr, unsigned int flags, struct gc_arena *gc)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct in_addr ia;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    char *out =3D gc_malloc(INET_ADDRSTRLEN, true, gc);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (addr || !(flags &amp; IA_EMPTY_IF_UNDEF))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        CLEAR(ia);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        ia.s_addr =3D (flags &amp; IA_NET_ORDE=
R) ? addr : htonl(addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        inet_ntop(=
AF_INET, &amp;ia, out, INET_ADDRSTRLEN);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * Convert an in6_addr in host byte order</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * to an ascii representation of an IPv6 a=
ddress</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-const char *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-print_in6_addr(struct in6_addr a6, unsigne=
d int flags, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char=
 *out =3D gc_malloc(INET6_ADDRSTRLEN, true, gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (memcmp(&amp;a6, &amp;in6addr_any, sizeof(a6)) !=3D 0 || !(fla=
gs &amp; IA_EMPTY_IF_UNDEF))</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
net_ntop(AF_INET6, &amp;a6, out, INET6_ADDRSTRLEN);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return out;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Convert an in_port_t in host byte order to a st=
ring</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-const char *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-print_in_port_t(in_port_t port, struct gc_a=
rena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buffer =3D all=
oc_buf_gc(8, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
buf_printf(&amp;buffer, &quot;%hu&quot;, port);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return BSTR(&amp;buffer);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* add =
some offset to an ipv6 address</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * (add in steps of 8 bits, taking overflow into next round)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-struct in6_addr</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-add_in6_addr(struct in6_addr base, uint32_t add)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    for (i =3D 15; i &gt;=3D 0 &amp;&amp; add &gt; 0; i--)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        register int carry;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        register uint32_t h;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        h =3D (unsigned char)base.s6_addr[i];</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        base.s6_addr[i] =3D (h + add)=
 &amp; UINT8_MAX;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* using explicit=
 carry for the 8-bit additions will catch</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-         * 8-bit and(!) 32-bit overruns nicely</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        carry =3D ((h &amp; 0xff) + (add=
 &amp; 0xff)) &gt;&gt; 8;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        add =3D (add &gt;&gt; 8) + carry;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return base;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-/* set environmental variables for ip/=
port in *addr */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-setenv_sockaddr(struct=
 env_set *es, const char *name_prefix, const struct openvpn_sockaddr *addr,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                const=
 unsigned int flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char name_buf[256=
];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    char buf[INET6_ADDRSTRLEN];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    switch (addr-&gt;addr.sa.s=
a_family)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            if (flags &amp; =
SA_IP_PORT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                sn=
printf(name_buf, sizeof(name_buf), &quot;%s_ip&quot;, name_prefix);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                snprintf(name_buf, sizeof(name_buf=
), &quot;%s&quot;, name_prefix);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            inet_n=
top(AF_INET, &amp;addr-&gt;addr.in4.sin_addr, buf, sizeof(buf));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            setenv_str(es, name_=
buf, buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            if ((flags &amp; SA_=
IP_PORT) &amp;&amp; addr-&gt;addr.in4.sin_port)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                snprintf(name_buf, sizeof(name_buf), &quo=
t;%s_port&quot;, name_prefix);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                setenv_int(es, name_buf, ntohs(addr-&gt;addr.in4.s=
in_port));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (IN6_IS_ADDR_V4MAPPED(&amp;=
addr-&gt;addr.in6.sin6_addr))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                struct in_addr ia;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                memcpy(&amp;ia.s_addr, &amp;addr-&gt;addr.in6.=
sin6_addr.s6_addr[12], sizeof(ia.s_addr));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                snprintf(name_buf, sizeof(name_buf), &=
quot;%s_ip&quot;, name_prefix);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                inet_ntop(AF_INET, &amp;ia, buf, sizeof(buf));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                snprintf(name_buf, sizeof(n=
ame_buf), &quot;%s_ip6&quot;, name_prefix);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                inet_ntop(AF_INET6, &amp;addr-&gt;add=
r.in6.sin6_addr, buf, sizeof(buf));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            setenv_str(es, name_buf, buf);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if ((flags &amp; SA_IP_PORT) &amp;&amp; addr-&gt;addr.in6=
.sin6_port)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                sn=
printf(name_buf, sizeof(name_buf), &quot;%s_port&quot;, name_prefix);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                setenv_int(=
es, name_buf, ntohs(addr-&gt;addr.in6.sin6_port));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-setenv_in_addr_t(struct env_set *es, const char *name_pr=
efix, in_addr_t addr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                 const unsigned int flags)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (addr || !(flags &amp; SA_SET_IF_NONZERO))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        struct openvpn_sockaddr si;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        CLEAR(si);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        si.addr.in4.sin_family =3D AF_INET;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        si.addr.in4.sin_addr.=
s_addr =3D htonl(addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        setenv_sockaddr(es, name_prefix, &amp;si, flags);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-setenv_in6_addr(struct env_set *es, =
const char *name_prefix, const struct in6_addr *addr,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                const unsigned int flags)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!IN6_IS_ADDR_UNSPECIFIED(addr) || !=
(flags &amp; SA_SET_IF_NONZERO))</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct openvpn_sockaddr si;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        CLEAR(si);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        si.addr.in6.sin6_family =3D AF_INET6;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        si.addr.in6.sin6_addr =3D *addr;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_sockaddr(=
es, name_prefix, &amp;si, flags);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-setenv_link_socket_actual(struct env_set *es, const char *na=
me_prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
               const struct link_socket_actual *act, const unsigned int fla=
gs)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    setenv_sockaddr(es, name_prefix, &=
amp;act-&gt;dest, flags);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * Convert protocol names between index and ascii form.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-struct proto_names</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 char *short_form;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 const char *display_form;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    sa_family_t proto_af;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int proto;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-/* Indexed by PROTO_x */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-static const struct proto_names pro=
to_names[] =3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
 &quot;proto-uninitialized&quot;, &quot;proto-NONE&quot;, AF_UNSPEC, PROTO_=
NONE },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* try IPv=
4 and IPv6 (client), bind dual-stack (server) */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    { &quot;udp&quot;, &quot;UDP&quot;, AF_UNSPE=
C, PROTO_UDP },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { =
&quot;tcp-server&quot;, &quot;TCP_SERVER&quot;, AF_UNSPEC, PROTO_TCP_SERVER=
 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;tcp-cl=
ient&quot;, &quot;TCP_CLIENT&quot;, AF_UNSPEC, PROTO_TCP_CLIENT },</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;tcp&quot;, &quot;T=
CP&quot;, AF_UNSPEC, PROTO_TCP },</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* force IPv4 */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    { &quot;udp4&quot;, &quot;UDPv4&quot;, AF_INET, PROTO_UDP },=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;tcp4-serv=
er&quot;, &quot;TCPv4_SERVER&quot;, AF_INET, PROTO_TCP_SERVER },</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;tcp4-client&quot;, &=
quot;TCPv4_CLIENT&quot;, AF_INET, PROTO_TCP_CLIENT },</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    { &quot;tcp4&quot;, &quot;TCPv4&quot;, =
AF_INET, PROTO_TCP },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* force IPv6 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   { &quot;udp6&quot;, &quot;UDPv6&quot;, AF_INET6, PROTO_UDP },</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;tcp6-server&quot;, &=
quot;TCPv6_SERVER&quot;, AF_INET6, PROTO_TCP_SERVER },</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    { &quot;tcp6-client&quot;, &quot;TCPv6=
_CLIENT&quot;, AF_INET6, PROTO_TCP_CLIENT },</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    { &quot;tcp6&quot;, &quot;TCPv6&quot;, AF_INET6,=
 PROTO_TCP },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-ascii2proto(const char *proto_name)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    for (size_t i =3D 0; i &lt; SIZE(proto_names); ++i)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (!strcmp(proto_name, proto_names[i].short_f=
orm))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            return proto_nam=
es[i].proto;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return -1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sa_family=
_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ascii2af(const char=
 *proto_name)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    for (size_t i =3D 0; i &=
lt; SIZE(proto_names); ++i)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (!strcmp(proto_name, proto_names[i].short_form))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            return proto_names[i].proto_af;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-const char *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-proto2ascii(int proto, sa_family_t af, bool disp=
lay_form)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    for (size_t i =3D 0; i &lt; =
SIZE(proto_names); ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (pr=
oto_names[i].proto_af =3D=3D af &amp;&amp; proto_names[i].proto =3D=3D prot=
o)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            if (display_form)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                return proto_na=
mes[i].display_form;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                return=
 proto_names[i].short_form;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return &quot;[unknown protocol]&quot;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-proto=
2ascii_all(struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 buffer out =3D alloc_buf_gc(256, gc);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
for (size_t i =3D 0; i &lt; SIZE(proto_names); ++i)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (i)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         buf_printf(&amp;out, &quot; &quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        buf_printf(&amp;out, &quot;[%s]&quot;, proto_names[i].s=
hort_form);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return BSTR(&amp;out);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-const char *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-addr_family_name(int af)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (a=
f)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            return &quot;AF_INET&qu=
ot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            return &quot;AF_INET6&quo=
t;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return &quot;AF_UNSPEC&quot;;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Give=
n a local proto, return local proto</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * if !remote, or compatible remote proto</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * if remote.</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * This is used for options compatibility</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * checking.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* IPv6 and IPv4 protocols are comptabile but OpenVPN</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * has always sent UDPv4, TCPv4 over the wi=
re. Keep these</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * stri=
ngs for backward compatibility</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const cha=
r *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-proto_remote(int p=
roto, bool remote)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(proto &gt;=
=3D 0 &amp;&amp; proto &lt; PROTO_N);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (proto =3D=3D PROTO_UDP)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return &quot;UDPv4&quot;;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((remote=
 &amp;&amp; proto =3D=3D PROTO_TCP_CLIENT) || (!remote &amp;&amp; proto =3D=
=3D PROTO_TCP_SERVER))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return =
&quot;TCPv4_SERVER&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((rem=
ote &amp;&amp; proto =3D=3D PROTO_TCP_SERVER) || (!remote &amp;&amp; proto =
=3D=3D PROTO_TCP_CLIENT))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn &quot;TCPv4_CLIENT&quot;;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return &quot;&quot;; /* Make the =
compiler happy */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span> </span><br><span> /*</span><br><span>  * Bad incoming addres=
s lengths that differ from what</span><br><span>diff --git a/src/openvpn/so=
cket.h b/src/openvpn/socket.h</span><br><span>index ed37590..cce9183 100644=
</span><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openv=
pn/socket.h</span><br><span>@@ -34,6 +34,7 @@</span><br><span> #include &qu=
ot;socks.h&quot;</span><br><span> #include &quot;misc.h&quot;</span><br><sp=
an> #include &quot;tun.h&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;socket_util.h&quot;</span><br><span> </span><br><=
span> /*</span><br><span>  * OpenVPN&#39;s default port number as assigned =
by IANA.</span><br><span>@@ -60,18 +61,6 @@</span><br><span> /* convert a p=
acket_size_type from network to host order */</span><br><span> #define ntoh=
ps(x) ntohs(x)</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/* OpenVPN sockaddr struct */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-struct openvpn_sockaddr</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /*int dummy;*/ /* add offset to force a bug if sa not explicitly deref=
erenced */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    union</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        struct sockaddr sa;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        struct sockaddr_in in4;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct sockaddr=
_in6 in6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    } addr;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* struct to hold prere=
solved host names */</span><br><span> struct cached_dns_entry</span><br><sp=
an> {</span><br><span>@@ -83,25 +72,6 @@</span><br><span>     struct cached=
_dns_entry *next;</span><br><span> };</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/* actual address of remote, based on sou=
rce address of received packets */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-struct link_socket_actual</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /*int dummy;*/ /* add offset to force a bug if dest not explicitly derefer=
enced */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct openvpn_sockaddr dest;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if ENABLE_IP_PKTINFO<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    union</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(HAVE_IN_PKTINFO) &amp;&amp; defined(HA=
VE_IPI_SPEC_DST)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct in_pktinfo in4;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#elif defined(IP_RECVDSTADDR)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        struct in_addr in4;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        struct in6_pktinfo in6;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    } pi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* IP addresses=
 which are persistent across SIGUSR1s */</span><br><span> struct link_socke=
t_addr</span><br><span> {</span><br><span>@@ -349,58 +319,6 @@</span><br><s=
pan> </span><br><span> void sd_close(socket_descriptor_t *sd);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PS_SHOW_=
PORT_IF_DEFINED (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define PS_SHOW_PORT            (1 &lt;&lt; 1)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define PS_SHOW_PKTINFO         (1 &lt;&l=
t; 2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PS_DONT_=
SHOW_ADDR       (1 &lt;&lt; 3)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define PS_DONT_SHOW_FAMILY     (1 &lt;&lt; 4)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-const char *print_sockaddr_ex(const struct sockaddr *addr, con=
st char *separator,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                            const unsigned int flags, struct gc_arena *gc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static inline const char *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-print_openvpn_sockaddr(const struct o=
penvpn_sockaddr *addr, struct gc_arena *gc)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    return print_sockaddr_ex(&amp;addr-&gt;addr.sa, &quot;:&quot;, PS_SHO=
W_PORT, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-static inline const char *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-print_sockaddr(const struct sockaddr *addr,=
 struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return print_soc=
kaddr_ex(addr, &quot;:&quot;, PS_SHOW_PORT, gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-const char *print_link_socket_actua=
l_ex(const struct link_socket_actual *act, const char *separator,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
         const unsigned int flags, struct gc_arena *gc);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-const char *print_link_socket_actual(const struct link_socket=
_actual *act, struct gc_arena *gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define IA_EMPTY_IF_UNDEF (1=
 &lt;&lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define I=
A_NET_ORDER      (1 &lt;&lt; 1)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-const char *print_in_addr_t(in_addr_t addr, unsigned int flags, s=
truct gc_arena *gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *print_in6_=
addr(struct in6_addr addr6, unsigned int flags, struct gc_arena *gc);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-const char *print_in_port_t(in_port_t port, stru=
ct gc_arena *gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-struct in6_addr add_in6_a=
ddr(struct in6_addr base, uint32_t add);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine SA_IP_PORT        (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define SA_SET_IF_NONZERO (1 &lt;&lt; 1)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void setenv_sockaddr(struct env_set *es=
, const char *name_prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                     const struct openvpn_sockaddr *addr, const unsign=
ed int flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void setenv_in_addr_t(struct=
 env_set *es, const char *name_prefix, in_addr_t addr,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                      const unsigned int f=
lags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void setenv_in6_addr(struct env_set =
*es, const char *name_prefix, const struct in6_addr *addr,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                     const unsigned in=
t flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void setenv_link_socket_actual(st=
ruct env_set *es, const char *name_prefix,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                               const struct link_socke=
t_actual *act, const unsigned int flags);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> void bad_address_length(int actual, i=
nt expected);</span><br><span> </span><br><span> /* IPV4_INVALID_ADDR: retu=
rned by link_socket_current_remote()</span><br><span>@@ -432,21 +350,6 @@</=
span><br><span>  * Low-level functions</span><br><span>  */</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* return values of=
 openvpn_inet_aton */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define OIA_HOSTNAME 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define OIA_IP       1</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define OIA_ERROR    -1</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-int openvpn_inet_aton(const char *dotted_quad, struct in_addr *addr);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* integrity validation on pulled options *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool ip_addr_dotted_=
quad_safe(const char *dotted_quad);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool ip=
_or_dns_addr_safe(const char *addr, const bool allow_fqdn);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-bool mac_addr_safe(const char *mac_addr);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-bool ipv6_addr_safe(const char *ipv6_text_addr);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> socket_descrip=
tor_t create_socket_tcp(struct addrinfo *);</span><br><span> </span><br><sp=
an> socket_descriptor_t socket_do_accept(socket_descriptor_t sd, struct lin=
k_socket_actual *act,</span><br><span>@@ -472,134 +375,6 @@</span><br><span=
> </span><br><span> #endif /* if UNIX_SOCK_SUPPORT */</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * DNS resolution</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GET=
ADDR_RESOLVE                 (1 &lt;&lt; 0)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define GETADDR_FATAL                   (1 &lt;&lt; 1=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_HOST=
_ORDER              (1 &lt;&lt; 2)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define GETADDR_MENTION_RESOLVE_RETRY   (1 &lt;&lt; 3)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_FATAL_ON_SIGN=
AL         (1 &lt;&lt; 4)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define GETADDR_WARN_ON_SIGNAL          (1 &lt;&lt; 5)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_MSG_VIRT_OUT          =
  (1 &lt;&lt; 6)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne GETADDR_TRY_ONCE                (1 &lt;&lt; 7)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define GETADDR_UPDATE_MANAGEMENT_STATE (1 &lt;=
&lt; 8)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADD=
R_RANDOMIZE               (1 &lt;&lt; 9)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define GETADDR_PASSIVE                 (1 &lt;&lt; 10)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_DATAGR=
AM                (1 &lt;&lt; 11)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define G=
ETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Tra=
nslate an IPv4 addr or hostname from string form to in_addr_t</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * In case of resolve error, it will try again for</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * resolve_retry_seconds =
seconds.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-in_addr_t getaddr(unsigned int =
flags, const char *hostname, int resolve_retry_seconds,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                  bool *succeeded, struct=
 signal_info *sig_info);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * Translate an IPv6 addr or hostnam=
e from string form to in6_addr</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool get_=
ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int *net=
bits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
   int msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-int openvpn_getaddrinfo(u=
nsigned int flags, const char *hostname, const char *servname,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        int resolv=
e_retry_seconds, struct signal_info *sig_info, int ai_family,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        struct addr=
info **res);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * Transport protocol naming and other details.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Use=
 enum&#39;s instead of #define to allow for easier</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * optional proto support</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-enum proto_num</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    PROTO_NO=
NE, /* catch for uninitialized */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    PROTO_UDP,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    PROTO_TCP,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  PROTO_TCP_SERVER,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  PROTO_TCP_CLIENT,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  PROTO_N</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-proto_is_net(int proto)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ASSERT(proto &gt;=3D 0 &amp;&amp; proto &lt; PROTO_N);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return proto !=3D PROTO_NONE;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @bri=
ef Returns if the protocol being used is UDP</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-proto_is_udp(int proto)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(proto=
 &gt;=3D 0 &amp;&amp; proto &lt; PROTO_N);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return proto =3D=3D PROTO_UDP;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * @brief Return if the p=
rotocol is datagram (UDP)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-proto_is_dgram(int proto)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return proto_is_udp(proto);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * @brief returns if the p=
roto is a TCP variant (tcp-server, tcp-client or tcp)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-proto_is_tcp(int proto)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASS=
ERT(proto &gt;=3D 0 &amp;&amp; proto &lt; PROTO_N);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return proto =3D=3D PROTO_TCP_CLIENT ||=
 proto =3D=3D PROTO_TCP_SERVER;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-int ascii2proto(const char *proto_name);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-sa_family_t ascii2af(const char *proto_name);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-const char *proto2ascii(int proto, sa_family_t af, =
bool display_form);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *proto2ascii=
_all(struct gc_arena *gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *prot=
o_remote(int proto, bool remote);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const cha=
r *addr_family_name(int af);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * Overhead added to packets by v=
arious protocols.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-datagram_overhead(sa_famil=
y_t af, int proto)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int overhead =3D 0;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    overhead +=3D (pr=
oto =3D=3D PROTO_UDP) ? 8 : 20;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    overhead +=3D (af =3D=3D AF_INET) ? 20 : 40;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return overhead;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * Misc inline functions=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-link_socket_proto_connection_oriented(int proto)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return !proto_is_dgram(proto);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> static inline bool</span><br><span> link_sock=
et_connection_oriented(const struct link_socket *sock)</span><br><span> {</=
span><br><span>@@ -613,242 +388,6 @@</span><br><span>     }</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add=
r_defined(const struct openvpn_sockaddr *addr)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!addr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    switch (addr-&gt;addr.sa.sa_family=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            return addr-&gt;addr.in4=
.sin_addr.s_addr !=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_IN=
ET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            retur=
n !IN6_IS_ADDR_UNSPECIFIED(&amp;addr-&gt;addr.in6.sin6_addr);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            return 0;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-addr_local(const struct sockaddr *addr)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (!addr)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (=
addr-&gt;sa_family)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_IN=
ET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return=
 ((const struct sockaddr_in *)addr)-&gt;sin_addr.s_addr =3D=3D htonl(INADDR=
_LOOPBACK);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            return IN6_IS_ADDR=
_LOOPBACK(&amp;((const struct sockaddr_in6 *)addr)-&gt;sin6_addr);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        default:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            return false;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-addr_defined_ipi(const struct link_socket_actual *lsa)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if ENABLE_IP_PKTINFO</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!lsa)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (=
lsa-&gt;dest.addr.sa.sa_family)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            return lsa-&gt;pi.in4.ip=
i_spec_dst.s_addr !=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(IP_=
RECVDSTADDR)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
ase AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   return lsa-&gt;pi.in4.s_addr !=3D 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_IN=
ET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            retur=
n !IN6_IS_ADDR_UNSPECIFIED(&amp;lsa-&gt;pi.in6.ipi6_addr);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            return 0;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else=
 /* if ENABLE_IP_PKTINFO */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ASSERT(0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return false=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-link_socket_actual_defined(const struct link_socket_actual *act)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return act &amp;&amp; addr_defined(&a=
mp;act-&gt;dest);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-addr_match(const struct openvpn_sockaddr *a1, =
const struct openvpn_sockaddr *a2)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    swi=
tch (a1-&gt;addr.sa.sa_family)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 case AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     return a1-&gt;addr.in4.sin_addr.s_addr =3D=3D a2-&gt;addr.in4.sin_addr=
.s_addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6:</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            return IN6_ARE_ADDR_E=
QUAL(&amp;a1-&gt;addr.in6.sin6_addr, &amp;a2-&gt;addr.in6.sin6_addr);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    return false;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-addrlist_match(const st=
ruct openvpn_sockaddr *a1, const struct addrinfo *addrlist)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    const struct addrinfo *curele;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    for (curele =3D addrlist; curele; curel=
e =3D curele-&gt;ai_next)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        swit=
ch (a1-&gt;addr.sa.sa_family)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        case AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                if (a1-&gt;addr.in4.sin_addr.s_addr</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    =3D=3D ((struct sockadd=
r_in *)curele-&gt;ai_addr)-&gt;sin_addr.s_addr)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    return true;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            case AF_INET6:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                if (IN6_ARE_ADDR_EQUAL(&amp;a1-&gt;addr.in6=
.sin6_addr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                             &amp;((struct sockaddr_in6 *)curele-&gt;ai_add=
r)-&gt;sin6_addr))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             return true;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            default:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ASSER=
T(0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return false;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-addrlist_port_ma=
tch(const struct openvpn_sockaddr *a1, const struct addrinfo *a2)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    const struct addrinfo *curele;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    for (curele =3D a2; curele; curele=
 =3D curele-&gt;ai_next)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        switc=
h (a1-&gt;addr.sa.sa_family)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       case AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               if (curele-&gt;ai_family =3D=3D AF_INET</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    &amp;&amp; a1-&gt;addr=
.in4.sin_addr.s_addr</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                          =3D=3D ((struct sockaddr_in *)curele-&gt;ai_addr)=
-&gt;sin_addr.s_addr</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   &amp;&amp; a1-&gt;addr.in4.sin_port =3D=3D ((struct sock=
addr_in *)curele-&gt;ai_addr)-&gt;sin_port)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    return true;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                break;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            case AF_INET6:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                if (curele-&gt;ai_family =3D=3D AF_INET6</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    &amp;&amp;=
 IN6_ARE_ADDR_EQUAL(&amp;a1-&gt;addr.in6.sin6_addr,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                          &=
amp;((struct sockaddr_in6 *)curele-&gt;ai_addr)-&gt;sin6_addr)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    &amp;&amp; a1-=
&gt;addr.in6.sin6_port</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                           =3D=3D ((struct sockaddr_in6 *)curele-&gt;ai_ad=
dr)-&gt;sin6_port)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             return true;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            default:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ASSER=
T(0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return false;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-addr_port_match(const struct openvpn_=
sockaddr *a1, const struct openvpn_sockaddr *a2)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    switch (a1-&gt;addr.sa.sa_family)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        case AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            return a1-&gt;addr.in4.sin_addr.s_addr =3D=3D a2-&gt;add=
r.in4.sin_addr.s_addr</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                   &amp;&amp; a1-&gt;addr.in4.sin_port =3D=3D a2-&gt;addr.i=
n4.sin_port;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            return IN6_ARE_AD=
DR_EQUAL(&amp;a1-&gt;addr.in6.sin6_addr, &amp;a2-&gt;addr.in6.sin6_addr)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                   &amp;=
&amp; a1-&gt;addr.in6.sin6_port =3D=3D a2-&gt;addr.in6.sin6_port;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    ASSERT(0);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return false;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-addr_match_proto(const stru=
ct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                 const int proto)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return link_socket_proto_connection_ori=
ented(proto) ? addr_match(a1, a2)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                                        : addr_=
port_match(a1, a2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-addrlist_match_proto(const struct openvpn_sockaddr *a1, struct addr=
info *addr_list, const int proto)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn link_socket_proto_connection_oriented(proto) ? addrlist_match(a1, addr_l=
ist)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                                       : addrlist_port_match(a1, addr_list)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-addr_zero_host(struct openvpn_sockaddr *addr)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    switch (addr-&gt;addr.sa.sa_family)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        case AF_INET:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            addr-&gt;addr.in4.sin_addr.s_addr =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        case AF_INET6:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            memset(&amp;addr-&gt;addr.in6.sin6_add=
r, 0, sizeof(struct in6_addr));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-af_addr_size(sa_family_t af)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    switch (af)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case A=
F_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            re=
turn sizeof(struct sockaddr_in);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ca=
se AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   return sizeof(struct sockaddr_in6);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if 0</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* could be c=
alled from socket_do_accept() with empty addr */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(M_ERR, &quot;Bad address family:=
 %d\n&quot;, af);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        ASSERT(0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-lin=
k_socket_actual_match(const struct link_socket_actual *a1, const struct lin=
k_socket_actual *a2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return addr_port_=
match(&amp;a1-&gt;dest, &amp;a2-&gt;dest);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> #if PORT_SHARE</span><br><span> </span><br><span> static=
 inline bool</span><br><span>diff --git a/src/openvpn/socket_util.c b/src/o=
penvpn/socket_util.c</span><br><span>new file mode 100644</span><br><span>i=
ndex 0000000..13f8c32</span><br><span>--- /dev/null</span><br><span>+++ b/s=
rc/openvpn/socket_util.c</span><br><span>@@ -0,0 +1,936 @@</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP n=
etworks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   over a single TCP/UDP port, with support for SSL/TLS-based</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             session authentica=
tion and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             packet encryption, packet authentication, and</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compressi=
on.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2025 OpenV=
PN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Th=
is program is free software; you can redistribute it and/or modify</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of th=
e GNU General Public License version 2</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  as published by the Free Software Foundation.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.or=
g/licenses/&gt;.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;socket_util.h&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;crypto.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;manage.h&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Format IP addresses in ascii</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+print_sockaddr_ex(cons=
t struct sockaddr *sa, const char *separator, const unsigned int flags,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                  struc=
t gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer out =
=3D alloc_buf_gc(128, gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    bool addr_is_defined =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    char hostaddr[NI_MAXHOST] =3D &quot;&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char servname[NI_MAX=
SERV] =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socklen_t salen=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (=
sa-&gt;sa_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_=
INET:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (!(flags &amp; PS_DONT_SHOW_FAMILY))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                buf_puts(&amp;out, &quot;[AF_INET]&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            salen =3D sizeof(s=
truct sockaddr_in);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            addr_is_defined =3D ((struct sockaddr_in *)sa)-&gt;sin_addr.s_a=
ddr !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET6:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!(flags &=
amp; PS_DONT_SHOW_FAMILY))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                buf_puts(&amp;out, &quot;[AF_INET6]&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            salen =3D sizeof(struct sock=
addr_in6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   addr_is_defined =3D !IN6_IS_ADDR_UNSPECIFIED(&amp;((struct sockaddr_in6 =
*)sa)-&gt;sin6_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_UN=
SPEC:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (!(flags &amp; PS_DONT_SHOW_FAMILY))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                return &quot;[AF_UNSPEC]&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                return &quot;&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        default:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            ASSERT(0);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D g=
etnameinfo(sa, salen, hostaddr, sizeof(hostaddr), servname, sizeof(servname=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
        NI_NUMERICHOST | NI_NUMERICSERV);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (status !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
buf_printf(&amp;out, &quot;[nameinfo() err: %s]&quot;, gai_strerror(status)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return BS=
TR(&amp;out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!(flags &amp; PS_DONT_SHOW_ADDR=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (addr_is_defined)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            buf_puts(&amp;out, h=
ostaddr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            buf_puts(&amp;out, &quot;=
[undef]&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if ((flags &amp; PS_SHOW_PORT) || (flags &a=
mp; PS_SHOW_PORT_IF_DEFINED))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (separator)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 buf_puts(&amp;out, separator);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_puts(=
&amp;out, servname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return BSTR(&amp;out);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+print_link_socket_actual(const struct link_socket_actual *act, stru=
ct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return print_link=
_socket_actual_ex(act, &quot;:&quot;, PS_SHOW_PORT | PS_SHOW_PKTINFO, gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef IF_NAMESIZE</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define IF_NAMESIZE 16</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_link_socket_=
actual_ex(const struct link_socket_actual *act, const char *separator,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
    const unsigned int flags, struct gc_arena *gc)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (act)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
struct buffer out =3D alloc_buf_gc(128, gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;%s&quot;, print=
_sockaddr_ex(&amp;act-&gt;dest.addr.sa, separator, flags, gc));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if ENABLE_IP_PKTINFO</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        char ifname[IF_NAMESI=
ZE] =3D &quot;[undef]&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 ((flags &amp; PS_SHOW_PKTINFO) &amp;&amp; addr_defined_ipi(act))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            switch (act-&gt;dest.addr.s=
a.sa_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   case AF_INET:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               struct openvpn_sockaddr sa;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    CLEAR(sa);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    sa.addr.in4.sin_famil=
y =3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    sa.addr.in4.s=
in_addr =3D act-&gt;pi.in4.ipi_spec_dst;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    if_indextoname(act-&gt;pi.in4.ipi_=
ifindex, ifname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
lif defined(IP_RECVDSTADDR)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    sa.addr.in4.sin_addr =3D act-&gt;pi.in4;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    ifname=
[0] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* =
if defined(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST) */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#error ENABLE_IP_PKTINFO i=
s set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    buf_printf(&amp;out, &quot; =
(via %s%%%s)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                               print_sockaddr_ex(&amp;sa.addr.sa, separator=
, 0, gc), ifname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                cas=
e AF_INET6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          struct sockaddr_in6 sin6;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    char buf[INET6_ADDRSTRLEN] =3D &quot;[u=
ndef]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             CLEAR(sin6);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    sin6.sin6_family =3D AF_INET6;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    sin6.sin6_addr =3D=
 act-&gt;pi.in6.ipi6_addr;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    if_indextoname(act-&gt;pi.in6.ipi6_ifindex, ifna=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     if (getnameinfo((struct sockaddr *)&amp;sin6, sizeof(struct sockaddr_i=
n6), buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                          sizeof(buf), NULL, 0, NI_NUMERICHOST)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        =3D=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         buf_printf(&amp;out, &quot; (via %s%%%s)&quot;, buf, ifname);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         buf_printf(&amp;out, &quot; (via [getnameinfo() err]%%%s)&quot;, i=
fname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if ENABLE_IP_PK=
TINFO */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn BSTR(&amp;out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return &quot;[NULL]&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Convert an in_=
addr_t in host byte order</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * to an ascii dotted quad.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
nst char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_in_=
addr_t(in_addr_t addr, unsigned int flags, struct gc_arena *gc)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct in_addr ia;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    char *out =3D gc_malloc(INET_ADDRSTRLEN, t=
rue, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (addr || !(flags &amp;=
 IA_EMPTY_IF_UNDEF))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR=
(ia);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ia.s_a=
ddr =3D (flags &amp; IA_NET_ORDER) ? addr : htonl(addr);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        inet_ntop(AF_INET, &amp;ia, out, INET_ADDRSTRLEN)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return out;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Convert an i=
n6_addr in host byte order</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * to an ascii representation of an IPv6 address</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+print_in6_addr(struct in6_addr a6, unsigned int flags, struct =
gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *out =3D gc_mal=
loc(INET6_ADDRSTRLEN, true, gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (memcmp(&amp;a6, &amp;in6addr_any, sizeof(a6)) !=3D 0 || !(flags &amp; IA_=
EMPTY_IF_UNDEF))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        inet_ntop=
(AF_INET6, &amp;a6, out, INET6_ADDRSTRLEN);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return out;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Convert an in_port_t in host byte order to a =
string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+print_in_port_t(in_port_t port, stru=
ct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
fer =3D alloc_buf_gc(8, gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_printf(&amp;buffer, &quot;%hu&quot;, port);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return BSTR(&amp;buffer);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* add some offset to an ipv6 address</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * (add in steps of 8 bits, taking overfl=
ow into next round)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct in6_addr<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_in6_addr(struct =
in6_addr base, uint32_t add)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 15; i &gt;=3D 0 &amp;&=
amp; add &gt; 0; i--)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        regi=
ster int carry;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    register uint32_t h;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        h =3D =
(unsigned char)base.s6_addr[i];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        base.s6_addr[i] =3D (h + add) &amp; UINT8_MAX;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* using explicit carry for the 8-bit a=
dditions will catch</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         * 8-bit and(!) 32-bit overruns nicely</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        carry =3D ((h &amp; 0xff) + (add &amp; 0xff)) &g=
t;&gt; 8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ad=
d =3D (add &gt;&gt; 8) + carry;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return base;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* set environmental variables for ip/por=
t in *addr */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+setenv_sockaddr(struc=
t env_set *es, const char *name_prefix, const struct openvpn_sockaddr *addr=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                co=
nst unsigned int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char name_=
buf[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    char buf[INET6_ADDRSTRLEN=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (addr-=
&gt;addr.sa.sa_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cas=
e AF_INET:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (flags &amp; SA_IP_PORT)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                snprintf(name_buf, sizeof(name_buf), &quot;%s_ip&quot;=
, name_prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                snp=
rintf(name_buf, sizeof(name_buf), &quot;%s&quot;, name_prefix);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            inet_ntop(AF_INET, &amp;addr-&gt;addr.in4.si=
n_addr, buf, sizeof(buf));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            setenv_str(es, name_buf, buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if ((flags &amp; SA_IP_PORT) &amp;&amp; addr-&gt;add=
r.in4.sin_port)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      snprintf(name_buf, sizeof(name_buf), &quot;%s_port&quot;, name_prefix=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                s=
etenv_int(es, name_buf, ntohs(addr-&gt;addr.in4.sin_port));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        case AF_INET6:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (IN6_IS_ADDR_V4MAPPED(&amp;addr-&gt;addr.i=
n6.sin6_addr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     struct in_addr ia;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                memcpy(&amp;ia.s_addr, &amp;addr-&gt;addr.in6.sin6_addr=
.s6_addr[12], sizeof(ia.s_addr));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                snprintf(name_buf, sizeof(name_buf), &quot;%s=
_ip&quot;, name_prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                inet_ntop(AF_INET, &amp;ia, buf, sizeof(buf));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                snprintf(name_buf, sizeof=
(name_buf), &quot;%s_ip6&quot;, name_prefix);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                inet_ntop(AF_INET6, &amp;addr-&gt=
;addr.in6.sin6_addr, buf, sizeof(buf));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            setenv_str(es, name_buf, buf);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if ((flags &amp; SA_IP_PORT) &amp;&amp; addr-=
&gt;addr.in6.sin6_port)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              snprintf(name_buf, sizeof(name_buf), &quot;%s_port&quot;, nam=
e_prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       setenv_int(es, name_buf, ntohs(addr-&gt;addr.in6.sin6_port));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+setenv_in_addr_t(struct =
env_set *es, const char *name_prefix, in_addr_t addr,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 const unsigned int flags=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (addr || !(flags &amp; SA_SET=
_IF_NONZERO))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct openv=
pn_sockaddr si;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    CLEAR(si);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   si.addr.in4.sin_family =3D AF_INET;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        si.addr.in4.sin_addr.s_addr =3D htonl(addr);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        setenv_sockaddr=
(es, name_prefix, &amp;si, flags);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+setenv_in6_addr(struct env_set *es, const char *nam=
e_prefix, const struct in6_addr *addr,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                const unsigned int flags)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!IN6_IS_ADDR_UNSPECIFIED(addr) || !(flags &a=
mp; SA_SET_IF_NONZERO))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct openvpn_sockaddr si;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        CLEAR(si);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        si.addr.in6.sin6_family =3D AF_INET6;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        si.addr.in6.sin6_addr =3D *addr;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        setenv_sockaddr=
(es, name_prefix, &amp;si, flags);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+setenv_link_socket_actual(struct env_set *es, const=
 char *name_prefix,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                          const struct link_socket_actual *act, const unsig=
ned int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_sockaddr(es,=
 name_prefix, &amp;act-&gt;dest, flags);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Convert protocol names between=
 index and ascii form.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+struct proto_names</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *short_form;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *display_form;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    sa_family_t proto_af;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int proto;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Indexed by PROTO_x */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static const struct proto_names proto_names[] =3D {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;proto-uninitializ=
ed&quot;, &quot;proto-NONE&quot;, AF_UNSPEC, PROTO_NONE },</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* try IPv4 and IPv6 (client), b=
ind dual-stack (server) */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    { &quot;udp&quot;, &quot;UDP&quot;, AF_UNSPEC, PROTO_UDP },</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;tcp-server&q=
uot;, &quot;TCP_SERVER&quot;, AF_UNSPEC, PROTO_TCP_SERVER },</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    { &quot;tcp-client&quot;, &quo=
t;TCP_CLIENT&quot;, AF_UNSPEC, PROTO_TCP_CLIENT },</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    { &quot;tcp&quot;, &quot;TCP&quot;, AF_U=
NSPEC, PROTO_TCP },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* force IPv4 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    { &quot;udp4&quot;, &quot;UDPv4&quot;, AF_INET, PROTO_UDP },</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;tcp4-server&quot;=
, &quot;TCPv4_SERVER&quot;, AF_INET, PROTO_TCP_SERVER },</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    { &quot;tcp4-client&quot;, &quot;T=
CPv4_CLIENT&quot;, AF_INET, PROTO_TCP_CLIENT },</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    { &quot;tcp4&quot;, &quot;TCPv4&quot;, AF_I=
NET, PROTO_TCP },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* force IPv6 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   { &quot;udp6&quot;, &quot;UDPv6&quot;, AF_INET6, PROTO_UDP },</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;tcp6-server&quot;,=
 &quot;TCPv6_SERVER&quot;, AF_INET6, PROTO_TCP_SERVER },</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    { &quot;tcp6-client&quot;, &quot;T=
CPv6_CLIENT&quot;, AF_INET6, PROTO_TCP_CLIENT },</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    { &quot;tcp6&quot;, &quot;TCPv6&quot;, AF_=
INET6, PROTO_TCP },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ascii2proto(const char *proto_name)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(proto_names); ++i=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(proto_name, =
proto_names[i].short_form))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return proto_names[i].proto;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+sa_family_t</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ascii2af(const char *proto_name)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(proto_names); ++i)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(proto_name, proto=
_names[i].short_form))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return proto_names[i].proto_af;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+proto2ascii(int proto, sa_family_t af, bool display_form)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(=
proto_names); ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (pro=
to_names[i].proto_af =3D=3D af &amp;&amp; proto_names[i].proto =3D=3D proto=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (display_form=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                return p=
roto_names[i].display_form;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         return proto_names[i].short_form;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return &quot;[unknown =
protocol]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+const char *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+proto2ascii_all(struct gc_arena *gc)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct buffer out =3D alloc_buf_gc(256, gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(p=
roto_names); ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (i)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out=
, &quot; &quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_=
printf(&amp;out, &quot;[%s]&quot;, proto_names[i].short_form);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return BSTR(&amp;out);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
onst char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+addr_fam=
ily_name(int af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (af)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        case AF_INET:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return &quot;AF_INET&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET6:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return &quot;AF_INET6=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return &quot;AF_UNSPEC=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Given a local proto, return local proto</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * if !remote, or compatible remote proto=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * if remote.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * This is used for options compatibility=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * checking.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * IPv6 and IPv4 protocols are comptabile=
 but OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * has =
always sent UDPv4, TCPv4 over the wire. Keep these</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * strings for backward compatibility</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+const char *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+proto_remote(int proto, bool remote)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(proto &gt;=3D 0 &amp;&amp; proto &lt; =
PROTO_N);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pr=
oto =3D=3D PROTO_UDP)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn &quot;UDPv4&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if ((remote &amp;&amp; prot=
o =3D=3D PROTO_TCP_CLIENT) || (!remote &amp;&amp; proto =3D=3D PROTO_TCP_SE=
RVER))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return &quot;TCPv4_=
SERVER&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((remote &amp=
;&amp; proto =3D=3D PROTO_TCP_SERVER) || (!remote &amp;&amp; proto =3D=3D P=
ROTO_TCP_CLIENT))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return &=
quot;TCPv4_CLIENT&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return &quot;&quot;; /* Make =
the compiler happy */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Small helper function for openvpn_getaddrinfo to=
 print the address</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* family when resolving fails</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+getadd=
rinfo_addr_family_name(int af)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swi=
tch (af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return &quo=
t;[AF_INET]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET=
6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n &quot;[AF_INET6]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Prepend a random string to hostname to prevent DNS cac=
hing.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * For example=
, foo.bar.gov would be modified to &lt;random-chars&gt;.foo.bar.gov.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Of course, this require=
s explicit support in the DNS server (wildcard).</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static const char *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+hostname_randomize(const char *hostname, struct gc_arena *gc)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define n_rnd_bytes 6</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uint8_t rnd_bytes[n_rnd_bytes];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *rnd_str;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer hname =3D alloc_=
buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    prng_bytes(rnd_bytes, sizeof(rnd_bytes));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    rnd_str =3D format_hex_ex(=
rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    buf_printf(&amp;hname, &quot;%s.%s&quot;, r=
nd_str, hostname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return BSTR(&amp;hname);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#undef n_rnd_bytes</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Translate IPv4/IPv6 addr or hostname into st=
ruct addrinfo</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If =
resolve error, try again for resolve_retry_seconds seconds.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+openvpn_getaddrinfo(unsigned int flags, const char *hostname, const=
 char *servname,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 int resolve_retry_seconds, struct signal_info *sig_info, i=
nt ai_family,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              struct addrinfo **res)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct addrinfo hints;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int status;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct signal_info sigrec =3D { 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int msglevel =3D (flags &amp; GETADDR_FATAL) ? M=
_FATAL : D_RESOLVE_ERRORS;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *print_hostname;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *print_servname;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ASSERT(res);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ASSERT(hostname || servname);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ASSERT(!(flags &amp; GETADDR_HOST_ORDER));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (servname)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        print_servname =3D servname;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p=
rint_servname =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; G=
ETADDR_MSG_VIRT_OUT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msgle=
vel |=3D M_MSG_VIRT_OUT;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if ((flags &amp; (GETADD=
R_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) &amp;&amp; !sig_info)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sig_info =3D &amp;sigrec;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* try numeric ip addr first */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    CLEAR(hints);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    hints.ai_flags =3D AI_NUMERICHOST;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (flags &amp; GETADDR_PASSIVE)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        hints.ai_flags |=3D AI_PASSIVE;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (flags &amp; GETADDR_DATAGRAM)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        hints.ai_socktype =3D SOCK_DGRAM;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        hints.ai_socktype =3D SOCK_STREAM;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* if hostname is not set, we want to bind to &#39;ANY&#39;, with</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the correct addre=
ss family - v4-only or v6/v6-dual-stack */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!hostname)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        hints.ai_family =3D ai_family;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
atus =3D getaddrinfo(hostname, servname, &amp;hints, res);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (status !=3D 0)                      /* parse as=
 numeric address failed? */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  const int fail_wait_interval =3D 5; /* seconds */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Add +4 to cause integer divisi=
on rounding up (1 + 4) =3D 5, (0+4)/5=3D0 */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        int resolve_retries =3D</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            (flags &amp; GETADDR_TRY_O=
NCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        const char *fmt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        int level =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* this is not a numeric IP, ther=
efore force resolution using the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * provided ai_family */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        hints.ai_family =3D ai_family;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (hostname &amp;&amp; (flags &amp; GETA=
DDR_RANDOMIZE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ho=
stname =3D hostname_randomize(hostname, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (hostname)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     print_hostname =3D hostname;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            p=
rint_hostname =3D &quot;undefined&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
fmt =3D &quot;RESOLVE: Cannot resolve host address: %s:%s%s (%s)&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((flags &amp=
; GETADDR_MENTION_RESOLVE_RETRY) &amp;&amp; !resolve_retry_seconds)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            fmt =3D &quot;RESOLVE: Ca=
nnot resolve host address: %s:%s%s (%s)&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                  &quot;(I would have retried thi=
s name query if you had &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                  &quot;specified the --resolv-retry option.)&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (!(flags &amp; GETADDR_RESOLVE) |=
| status =3D=3D EAI_FAIL)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(msglevel, &quot;RESOLVE: Cannot parse IP address: %s:%s (%s)&qu=
ot;, print_hostname,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                print_servname, gai_strerror(status));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (flags &amp; GETADDR_UPDATE_MANAGEMENT_STATE)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (management)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                management_set_=
state(management, OPENVPN_STATE_RESOLVE, NULL, NULL, NULL, NULL,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
       NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /*</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * Resolve hostname</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        while (true)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          /* force resolv.conf reload */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            res_init();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            /* try hostname lookup */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            hints.ai_flags &amp;=3D ~AI_NUMER=
ICHOST;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
dmsg(D_SOCKET_DEBUG, &quot;GETADDRINFO flags=3D0x%04x ai_family=3D%d ai_soc=
ktype=3D%d&quot;, flags,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                 hints.ai_family, hints.ai_socktype);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            status =3D getaddrinfo(h=
ostname, servname, &amp;hints, res);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (sig_info)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              get_signal(&amp;sig_info-&gt;signal_received);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                if (sig_info-&gt;s=
ignal_received) /* were we interrupted by a signal? */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    /* why are we overwri=
ting SIGUSR1 ? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  if (signal_reset(sig_info, SIGUSR1) =3D=3D SIGUSR1) /* ig=
nore SIGUSR1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      msg(level, &quot;RESOLVE: Ignored SIGUSR1 signal rece=
ived during &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                  &quot;DNS resolution attempt&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         /* turn success into failure (interrupted syscall) */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        if (0 =
=3D=3D status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                            ASSERT(res);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                            freeaddrinfo(*res);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
   *res =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                          status =3D EAI_AGAIN; /* =3D temporary failure */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
         errno =3D EINTR;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        goto done;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            /* success? */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (0 =3D=3D status)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                break;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      /* resolve lookup failed, should we</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+             * continue or fail? */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            level =3D msglevel;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (resolve_r=
etries &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     level =3D D_RESOLVE_ERRORS;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(level, fmt, print_hostname, print_servname, getaddrinfo_addr_family_nam=
e(ai_family),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          gai_strerror(status));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (--resolve_retries &lt;=3D 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                goto done;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       management_sleep(fail_wait_interval);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ASSERT(res);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* hostname re=
solve succeeded */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * Do not choose an I=
P Addresse by random or change the order *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * of IP addresses, doing so will break RFC =
3484 address selection *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* IP address parse succeeded */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &a=
mp; GETADDR_RANDOMIZE)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(M_WARN, &quot;WARNING: ignoring --remote-random-hostname because t=
he &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              &quot;hostname is an IP address&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+done:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sig_info &amp;&=
amp; sig_info-&gt;signal_received)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        int level =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (flags &amp; GETADDR_FATAL_ON_SIGNAL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            level =3D M_FATAL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else if (flags &amp; GETADDR_WARN_ON_SIGN=
AL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            level =3D M_WA=
RN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(level, &quot;R=
ESOLVE: signal received during DNS resolution attempt&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return status;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * We do our own inet_aton because the glibc=
 function</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * isn&#39=
;t very good about error checking.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_inet_aton=
(const char *dotted_quad, struct in_addr *addr)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    unsigned int a, b, c, d;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    CLEAR(*addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (sscanf(dotted_quad, &quot;%u.%u.%u.%u&quot;, &amp;a, &amp;b, &amp;c, =
&amp;d) =3D=3D 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (a &l=
t; 256 &amp;&amp; b &lt; 256 &amp;&amp; c &lt; 256 &amp;&amp; d &lt; 256)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            addr-&gt;s_addr =3D=
 htonl(a &lt;&lt; 24 | b &lt;&lt; 16 | c &lt;&lt; 8 | d);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return OIA_IP; /* good do=
tted quad */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (string_class(dotted_qua=
d, CC_DIGIT | CC_DOT, 0))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return OIA_ERROR; /* probably a badly formatted dotted quad */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return OIA_HOSTNAME; /* probably a hostname */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ip_addr_dotted_quad_safe(co=
nst char *dotted_quad)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* verify n=
on-NULL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
dotted_quad)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* verify length is within limits */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (strlen(dotted_quad) &gt=
; 15)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* verify that all chars are either numeric or &#39;.&#=
39; and that no numeric</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * substring is greater than 3 chars */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        int nnum =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const char *p =3D dotted_quad;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        int c;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        while ((c =3D *p++))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (c &gt;=3D &#39;0&#39; &amp;&amp; c &lt;=3D &#=
39;9&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 ++nnum;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     if (nnum &gt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            else if (c =3D=3D &#39;.&#39;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                nnum =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* verify that stri=
ng will convert to IP address */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct in_addr a;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return openvpn_inet_aton(dotted_quad, &amp;a) =3D=3D OIA_IP;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ipv6_addr_sa=
fe(const char *ipv6_text_addr)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
verify non-NULL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!ipv6_text_addr)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* verify length is within limits */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strlen(ipv6_=
text_addr) &gt; INET6_ADDRSTRLEN)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* verify that string will =
convert to IPv6 address */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 struct in6_addr a6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return inet_pton(AF_INET6, ipv6_text_addr, &amp;a6) =3D=3D 1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_addr=
_safe(const char *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (addr)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const size_t len =3D strle=
n(addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn len &gt; 0 &amp;&amp; len &lt;=3D 255 &amp;&amp; string_class(addr, CC_=
ALNUM | CC_DASH | CC_DOT, 0);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ip_or_dns_addr_saf=
e(const char *addr, const bool allow_fqdn)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (ip_addr_dotted_quad_safe(addr))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else if (allow_fqdn)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn dns_addr_safe(addr);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+mac_addr_safe(const cha=
r *mac_addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* verify non-NULL */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mac_addr)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* verify length is within limits */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (strlen(mac_addr) &gt; 17)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* verify that all chars are either alphanumeric or &#39;:&#39; and th=
at no</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * alphanu=
meric substring is greater than 2 chars */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        int nnum =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        const char *p =3D mac_addr;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        int c;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        while ((c =3D *p++))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if ((c &gt;=3D &#39;0&#39; &amp;&amp; c &lt;=3D &#39;9&#39;=
) || (c &gt;=3D &#39;a&#39; &amp;&amp; c &lt;=3D &#39;f&#39;) || (c &gt;=3D=
 &#39;A&#39; &amp;&amp; c &lt;=3D &#39;F&#39;))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                ++nnum;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                if (nnum &gt; 2)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            else if (c =3D=3D &#=
39;:&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 nnum =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* error-checking is left to script invoked in lladdr.c =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>di=
ff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h</span><br>=
<span>new file mode 100644</span><br><span>index 0000000..5ea37dd</span><br=
><span>--- /dev/null</span><br><span>+++ b/src/openvpn/socket_util.h</span>=
<br><span>@@ -0,0 +1,491 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenV=
PN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; =
you can redistribute it and/or modify</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  it under the terms of the GNU General Public License =
version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as pub=
lished by the Free Software Foundation.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is distributed in the hope that it will be useful,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARR=
ANTY; without even the implied warranty of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GN=
U General Public License for more details.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  You should have received a copy of the GNU General Public License=
 along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this=
 program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifndef SOCKET_UTIL_H</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define SOCKET_UTIL_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;buffer.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;env_set.h&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;sig.h&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define PS_SHOW_PORT_IF_DEFINED (1 &lt;&lt; 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define PS_SHOW_PORT            (1 &lt;&lt; 1)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PS_SHOW_PKTIN=
FO         (1 &lt;&lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define PS_DONT_SHOW_ADDR       (1 &lt;&lt; 3)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define PS_DONT_SHOW_FAMILY     (1 &lt;&l=
t; 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* OpenVPN sockaddr struct */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+struct openvpn_sockaddr=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /*int dummy;*/ /* add offset to f=
orce a bug if sa not explicitly dereferenced */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    union</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct sockaddr sa;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct sockaddr_in in4;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct sockaddr_in6 in6;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    } addr;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* actu=
al address of remote, based on source address of received packets */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+struct link_socket_actual<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /*int dummy;*/ /* add offset to fo=
rce a bug if dest not explicitly dereferenced */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct openvpn_sockaddr dest;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if ENABLE_IP_PKTINFO</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    union</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct in_pktinfo =
in4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(I=
P_RECVDSTADDR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   struct in_addr in4;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct in6_pktinfo in6;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    } pi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+const char *print_sockaddr_ex(const struct sockaddr *addr=
, const char *separator,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                              const unsigned int flags, struct gc_aren=
a *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static inline const char *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+print_openvpn_sockaddr(c=
onst struct openvpn_sockaddr *addr, struct gc_arena *gc)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return print_sockaddr_ex(&amp;addr-&gt;addr.sa, &quo=
t;:&quot;, PS_SHOW_PORT, gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static inline const char *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_sockaddr(const=
 struct sockaddr *addr, struct gc_arena *gc)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return print_sockaddr_ex(addr, &quot;:&quot;, PS_SHOW_PORT, gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
const char *print_link_socket_actual_ex(const struct link_socket_actual *ac=
t, const char *separator,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                        const unsigned int flags, str=
uct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *print_li=
nk_socket_actual(const struct link_socket_actual *act, struct gc_arena *gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define IA_EMPTY_IF_UNDEF (1 &lt;&lt; 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define IA_NET_ORDER      (1 &lt;&l=
t; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *pr=
int_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_arena *gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+const char *print_in6_addr(struct in6_add=
r addr6, unsigned int flags, struct gc_arena *gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+const char *print_in_port_t(in_port_t port, struct gc_arena *gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+struct in6_addr add_in6_addr(struct =
in6_addr base, uint32_t add);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define S=
A_IP_PORT        (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define SA_SET_IF_NONZERO (1 &lt;&lt; 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void setenv_sockaddr(struct env_set *es, =
const char *name_prefix,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                     const struct openvpn_sockaddr *addr, const unsign=
ed int flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void setenv_in_addr_t(st=
ruct env_set *es, const char *name_prefix, in_addr_t addr,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                      const unsigned=
 int flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void setenv_in6_addr(struc=
t env_set *es, const char *name_prefix, const struct in6_addr *addr,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                     const=
 unsigned int flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void setenv_link_=
socket_actual(struct env_set *es, const char *name_prefix,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                               const=
 struct link_socket_actual *act, const unsigned int flags);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * DNS resolution</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_RESOLVE          =
       (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define GETADDR_FATAL                   (1 &lt;&lt; 1)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_HOST_ORDER            =
  (1 &lt;&lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine GETADDR_MENTION_RESOLVE_RETRY   (1 &lt;&lt; 3)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_FATAL_ON_SIGNAL         (=
1 &lt;&lt; 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e GETADDR_WARN_ON_SIGNAL          (1 &lt;&lt; 5)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define GETADDR_MSG_VIRT_OUT            (1 &lt=
;&lt; 6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GET=
ADDR_TRY_ONCE                (1 &lt;&lt; 7)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define GETADDR_UPDATE_MANAGEMENT_STATE (1 &lt;&lt;=
 8)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_=
RANDOMIZE               (1 &lt;&lt; 9)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define GETADDR_PASSIVE                 (1 &lt;&lt; 10)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_DATA=
GRAM                (1 &lt;&lt; 11)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Translate an IPv4 addr or hostname from string form to in_addr_t</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * In case of resolve error, it will t=
ry again for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reso=
lve_retry_seconds seconds.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in_addr_t=
 getaddr(unsigned int flags, const char *hostname, int resolve_retry_second=
s,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
 bool *succeeded, struct signal_info *sig_info);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Tra=
nslate an IPv6 addr or hostname from string form to in6_addr</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool get_ipv6_addr(const char *hostname, struct in=
6_addr *network, unsigned int *netbits,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                   int msglevel);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int openvpn_getaddrinfo(unsigned int flags, const char *host=
name, const char *servname,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        int resolve_retry_seconds, struct signal_in=
fo *sig_info, int ai_family,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        struct addrinfo **res);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* return values of openvpn_inet_aton */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define OIA_HOSTNAME 0</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define OIA_IP       1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define OIA_ERROR    -1</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+int openvpn_inet_aton(cons=
t char *dotted_quad, struct in_addr *addr);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* integrity validation on pulled options */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool ip_addr_dotted_quad_safe(const char *dot=
ted_quad);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool ip_or_dns_addr_safe(con=
st char *addr, const bool allow_fqdn);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool mac_addr_safe(const char *mac_addr);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool ipv6_addr_safe(const char *ipv6_text_addr);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Transport protocol naming and other details.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Use enum&#39;s instead =
of #define to allow for easier</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * optional proto support</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+enum proto_num</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    PROTO_NONE, /* cat=
ch for uninitialized */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    PROTO_UDP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   PROTO_TCP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PR=
OTO_TCP_SERVER,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
PROTO_TCP_CLIENT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  PROTO_N</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+proto_is_net(int proto)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ASSERT(proto &gt;=3D 0 &amp;&amp; proto &lt; PROTO_N);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return proto !=
=3D PROTO_NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @brief Returns if the protocol being used is UDP</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+proto_is_udp(int proto)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ASSERT(proto &gt;=3D 0 &amp;&amp; proto &lt; PROTO_=
N);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return proto=
 =3D=3D PROTO_UDP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @brief Return if the protocol is datagram (UDP)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+proto_is_dgram(int proto)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return proto_is_udp(proto);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @brief returns if the proto is a=
 TCP variant (tcp-server, tcp-client or tcp)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static inline bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+proto_is_tcp(int proto)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AS=
SERT(proto &gt;=3D 0 &amp;&amp; proto &lt; PROTO_N);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return proto =3D=3D PROTO_TCP_CLIENT =
|| proto =3D=3D PROTO_TCP_SERVER;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+int ascii2proto(const c=
har *proto_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+sa_family_t ascii2af(=
const char *proto_name);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *pr=
oto2ascii(int proto, sa_family_t af, bool display_form);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+const char *proto2ascii_all(struct gc_arena *gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+const char *proto_remote(int proto, bool remot=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+const char *addr_family_name(int af=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+addr_defined(const struct openvpn_soc=
kaddr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!addr)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    switch (addr-&gt;addr.sa.sa_family)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        case AF_INET:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            return addr-&gt;addr.in4.sin_addr.s_addr=
 !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET6:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return !IN6_IS_=
ADDR_UNSPECIFIED(&amp;addr-&gt;addr.in6.sin6_addr);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        default:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+addr_local(const struct sockaddr *addr=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!addr)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    switch (addr-&gt;sa_family)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        case AF_INET:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            return ((const struct sockaddr_in *)addr)-&gt;sin_addr.=
s_addr =3D=3D htonl(INADDR_LOOPBACK);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       case AF_INET6:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return IN6_IS_ADDR_LOOPBACK(&amp;((const struct sockaddr_in6 =
*)addr)-&gt;sin6_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        default=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+addr_def=
ined_ipi(const struct link_socket_actual *lsa)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if ENABLE_IP_PKTINFO</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!lsa)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (lsa-&gt;dest.=
addr.sa.sa_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(HAV=
E_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case AF_INET:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            return lsa-&gt;pi.in4.ipi_s=
pec_dst.s_addr !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(IP=
_RECVDSTADDR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  case AF_INET:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return lsa-&gt;pi.in4.s_addr !=3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 case AF_INET6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return !IN6_IS_ADDR_UNSPECIFIED(&amp;lsa-&gt;pi.in6.ipi6_addr);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#else /* if ENABLE_IP_PKTINFO */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Overhead added to packets by various =
protocols.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline int</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+datagram_overhead(sa_family=
_t af, int proto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int overhead =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    overhead +=
=3D (proto =3D=3D PROTO_UDP) ? 8 : 20;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    overhead +=3D (af =3D=3D AF_INET) ? 20 : 40;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return overhead;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Mi=
sc inline functions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+link_socket_proto_connection_oriente=
d(int proto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return !proto_is_dgra=
m(proto);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+link_socket_actual_defined(const struct link_soc=
ket_actual *act)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return act &amp;&=
amp; addr_defined(&amp;act-&gt;dest);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline bool<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+addr_match(const str=
uct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    switch (a1-&gt;addr.sa.sa_family)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        case AF_INET:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return a1-&gt;addr.in4.sin_addr.s_=
addr =3D=3D a2-&gt;addr.in4.sin_addr.s_addr;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        case AF_INET6:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return IN6_ARE_ADDR_EQUAL(&amp;a1-&gt;addr.in6.sin6_ad=
dr, &amp;a2-&gt;addr.in6.sin6_addr);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ASSERT(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+addrlist_match(const struct openvpn_socka=
ddr *a1, const struct addrinfo *addrlist)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const struct addrinfo *curele;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (curele =3D addrlist; curele; curele =3D curele-=
&gt;ai_next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        switch (a1-&g=
t;addr.sa.sa_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   case AF_INET:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             if (a1-&gt;addr.in4.sin_addr.s_addr</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    =3D=3D ((struct sockaddr_i=
n *)curele-&gt;ai_addr)-&gt;sin_addr.s_addr)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    return true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            case AF_INET6:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                if (IN6_ARE_ADDR_EQUAL(&amp;a1-&gt=
;addr.in6.sin6_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                       &amp;((struct sockaddr_in6 *)curele=
-&gt;ai_addr)-&gt;sin6_addr))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    return true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                break;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            default:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                ASSERT(0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+addrlist_port_match(const struct openvpn_sockaddr *a1=
, const struct addrinfo *a2)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 struct addrinfo *curele;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (curele =3D a2; curele; curele =3D curele-&gt;ai_next)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        switch (a1-&gt;addr.sa.sa_family=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            case AF_INET:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (cu=
rele-&gt;ai_family =3D=3D AF_INET</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    &amp;&amp; a1-&gt;addr.in4.sin_addr.s_add=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
         =3D=3D ((struct sockaddr_in *)curele-&gt;ai_addr)-&gt;sin_addr.s_a=
ddr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    &amp;&amp; a1-&gt;addr.in4.sin_port =3D=3D ((struct sockaddr_in *)curel=
e-&gt;ai_addr)-&gt;sin_port)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    return true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                break;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            case AF_INET6:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                if (curele-&gt;ai_family =3D=3D AF_INET6</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    &amp;&amp=
; IN6_ARE_ADDR_EQUAL(&amp;a1-&gt;addr.in6.sin6_addr,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
 &amp;((struct sockaddr_in6 *)curele-&gt;ai_addr)-&gt;sin6_addr)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    &amp;&amp;=
 a1-&gt;addr.in6.sin6_port</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                           =3D=3D ((struct sockaddr_in6 *)curele-&gt=
;ai_addr)-&gt;sin6_port)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    return true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                break;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          default:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               ASSERT(0);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ad=
dr_port_match(const struct openvpn_sockaddr *a1, const struct openvpn_socka=
ddr *a2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    switch (a1-&gt;addr.sa.sa=
_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return a1-&=
gt;addr.in4.sin_addr.s_addr =3D=3D a2-&gt;addr.in4.sin_addr.s_addr</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                   &amp;&amp=
; a1-&gt;addr.in4.sin_port =3D=3D a2-&gt;addr.in4.sin_port;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        case AF_INET6:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return IN6_ARE_ADDR_EQUAL(&amp;a1-&gt;a=
ddr.in6.sin6_addr, &amp;a2-&gt;addr.in6.sin6_addr)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                   &amp;&amp; a1-&gt;addr.in=
6.sin6_port =3D=3D a2-&gt;addr.in6.sin6_port;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ASSERT(0);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+addr_match_proto(const struct ope=
nvpn_sockaddr *a1, const struct openvpn_sockaddr *a2,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 const int proto)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return link_socket_proto_connection_orien=
ted(proto) ? addr_match(a1, a2)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                                        : addr_=
port_match(a1, a2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+addrlist_match_proto(const struct openvpn_sockaddr *a1, s=
truct addrinfo *addr_list, const int proto)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return link_socket_proto_connection_oriented(proto) ? addrlist_ma=
tch(a1, addr_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                                       : addrlist_port_matc=
h(a1, addr_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+addr_zero_host(struct openvpn_sockaddr *=
addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    switch (addr-&gt;addr.sa.sa_=
family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            addr-&gt;add=
r.in4.sin_addr.s_addr =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cas=
e AF_INET6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    memset(&amp;addr-&gt;addr.in6.sin6_addr, 0, sizeof(struct in6_addr));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
af_addr_size(sa_family_t af)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switc=
h (af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return sizeof=
(struct sockaddr_in);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_I=
NET6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn sizeof(struct sockaddr_in6);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   default:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if 0</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* could b=
e called from socket_do_accept() with empty addr */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_ERR, &quot;Bad address =
family: %d\n&quot;, af);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ASSERT(0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+link_socket_actual_match(const struct link_socket_actua=
l *a1, const struct link_socket_actual *a2)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return addr_port_match(&amp;a1-&gt;dest, &amp;a2-&gt;dest);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/ssl_common.h=
 b/src/openvpn/ssl_common.h</span><br><span>index e8fde86..428bf5a 100644</=
span><br><span>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/ope=
nvpn/ssl_common.h</span><br><span>@@ -30,7 +30,7 @@</span><br><span> #defin=
e SSL_COMMON_H_</span><br><span> </span><br><span> #include &quot;session_i=
d.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &qu=
ot;socket.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;socket_util.h&quot;</span><br><span> #include &quot;packet_id.=
h&quot;</span><br><span> #include &quot;crypto.h&quot;</span><br><span> #in=
clude &quot;options.h&quot;</span><br><span>diff --git a/src/openvpn/tun.c =
b/src/openvpn/tun.c</span><br><span>index f54b608..6c3096b 100644</span><br=
><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</spa=
n><br><span>@@ -39,7 +39,7 @@</span><br><span> #include &quot;fdmisc.h&quot=
;</span><br><span> #include &quot;common.h&quot;</span><br><span> #include =
&quot;run_command.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#include &quot;socket.h&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;socket_util.h&quot;</span><br><span> #include =
&quot;manage.h&quot;</span><br><span> #include &quot;route.h&quot;</span><b=
r><span> #include &quot;win32.h&quot;</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1159?usp=3De=
mail">change 1159</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1159?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7393459b975fb9b3e0a42743f58=
645f769d1be5a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1159 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--FKc/jWy5tLY=--

