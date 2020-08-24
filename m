From: Vladislav Grishenko <themiron@...2010...>
Date: Tue, 25 Aug 2020 03:15:59 +0500
Message-Id: <20200824221559.9553-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH] Add DNS SRV host discovery support
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

DNS SRV (rfc2782) support allows to use several OpenVPN servers for a single
domain w/o explicit profile enumerating, to move services from host to host
with little fuss, and to designate some hosts as primary servers for a service
and others as backups.
OpenVPN client ask for a specific service/protocol for a specific domain and
get back the names & ports of available servers to connect to, ordered by
priority and relative weight. Note, implemented server selection is intended
to express static information such as "this server has a faster CPU than that
one" or "this server has a much better network connection than that one" at
the moment client asks for a records.
Feature has been asked several times already, can be useful in case of for huge
ammounts of client & servers deployed.

For example, instead of multiple remotes in profile:
    remote server.example.com 1194 udp
    remote server1.example.com 1195 udp
    remote server2.example.org 1196 udp
    remote server.example.com 443 tcp
    remote server1.example.tld 8443 tcp

Now it's possible to specify just static domain(s) and enable discovery:
    remote server.example.com 1194 udp
    remote server.example.com 443 tcp
    remote-discovery

When discovery is enabled, OpenVPN will first try to resolve
_openvpn._udp.server.example.com SRV records and use resolved targets (see
example below) as servers for the subsequent connection attempts. If there's
no records or resolve error, OpenVPN will fallback to direct connection
using specified server.example.com host and 1194 port. Next connection
attempt will be done with next configures connection/remote entry - using
_openvpn._tcp.server.example.com records (if any) and server.example.com:443
as last resort.

DNS zone can look like below (arbitrary prio & weight values):
    _openvpn._udp.server.example.com IN SRV 10 70 1194 server.example.com
    _openvpn._udp.server.example.com IN SRV 10 30 1195 server1.example.com
    _openvpn._udp.server.example.com IN SRV 20 0 1196 server2.example.org
    _openvpn._tcp.server.example.com IN SRV 10 10 443 server.example.com
    _openvpn._tcp.server.example.com IN SRV 10 200 443 server.example.com

Currently only "openvpn" service is supported, usage of per-connection
service names is up to syntax decision (either intead of fallback port, or
as remote-discovery argument, etc), almost all the required mechanics
is implemented for that.

References:
 https://tools.ietf.org/html/rfc2782
 https://en.wikipedia.org/wiki/SRV_record
 https://sourceforge.net/p/openvpn/mailman/message/34364911/
 https://forums.openvpn.net/viewtopic.php?f=10&t=13660

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 configure.ac                        |   2 +-
 doc/man-sections/client-options.rst |  26 ++
 src/openvpn/Makefile.am             |   2 +-
 src/openvpn/buffer.h                |   5 -
 src/openvpn/init.c                  |   9 +-
 src/openvpn/manage.c                |   2 +-
 src/openvpn/openvpn.vcxproj         |   8 +-
 src/openvpn/options.c               |  11 +
 src/openvpn/options.h               |   1 +
 src/openvpn/ps.c                    |   2 +-
 src/openvpn/socket.c                | 530 ++++++++++++++++++++++++++--
 src/openvpn/socket.h                |  15 +
 src/openvpn/syshead.h               |   5 +
 13 files changed, 580 insertions(+), 38 deletions(-)

diff --git a/configure.ac b/configure.ac
index f8279924..67251bed 100644
--- a/configure.ac
+++ b/configure.ac
@@ -477,7 +477,7 @@ SOCKET_INCLUDES="
 "
 
 AC_CHECK_HEADERS(
-	[net/if.h netinet/ip.h resolv.h sys/un.h net/if_utun.h sys/kern_control.h],
+	[net/if.h netinet/ip.h arpa/nameser.h resolv.h sys/un.h net/if_utun.h sys/kern_control.h],
 	,
 	,
 	[[${SOCKET_INCLUDES}]]
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index ec1e3b11..53e6580e 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -299,6 +299,32 @@ configuration.
   specification (4/6 suffix), OpenVPN will try both IPv4 and IPv6
   addresses, in the order getaddrinfo() returns them.
 
+--remote-discovery
+  Perform rfc2782 remote host discovery using specified ``host`` and
+  ``proto`` values.
+  OpenVPN will try to resolve `` _openvpn._proto.host`` name via DNS
+  and use returned DNS SRV target and port records as OpenVPN servers
+  addresses in the order specified by Priority and Weight of that
+  records. If one record resolves to multiple IP addresses, OpenVPN
+  will try them in the order that the system getaddrinfo() presents
+  them. If discovery is failed, usual ``host`` and ``port`` connection
+  will be tried as a fallback.
+
+  Example:
+  ::
+
+     remote example.net 1194 udp
+     remote example.net 443 tcp
+     remote-discovery
+
+  DNS zone:
+  ::
+
+     _openvpn._udp.example.net IN SRV 10 60 1194 server1.example.net
+     _openvpn._udp.example.net IN SRV 10 40 1194 server2.example.net
+     _openvpn._udp.example.net IN SRV 20  0 1194 server3.example.net
+     _openvpn._tcp.example.net IN SRV 10  0  443 server4.example.net
+
 --remote-random
   When multiple ``--remote`` address/ports are specified, or if connection
   profiles are being used, initially randomize the order of the list as a
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 37b002c6..f7632047 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -143,5 +143,5 @@ openvpn_LDADD = \
 	$(OPTIONAL_INOTIFY_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h ring_buffer.h
-openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi
+openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -ldnsapi
 endif
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 1722ffd5..ae0cf0eb 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -198,11 +198,6 @@ bool buf_init_debug(struct buffer *buf, int offset, const char *file, int line);
 
 
 /* inline functions */
-inline static void
-gc_freeaddrinfo_callback(void *addr)
-{
-    freeaddrinfo((struct addrinfo *) addr);
-}
 
 /** Return an empty struct buffer */
 static inline struct buffer
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a785934a..043f4475 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -365,6 +365,7 @@ management_callback_remote_cmd(void *arg, const char **p)
 
                 ce->remote = rhs->host;
                 ce->remote_port = rhs->port;
+                ce->remote_discovery = false;
                 flags = CE_MAN_QUERY_REMOTE_MOD;
                 ret = true;
             }
@@ -458,7 +459,7 @@ clear_remote_addrlist(struct link_socket_addr *lsa, bool free)
 {
     if (lsa->remote_list && free)
     {
-        freeaddrinfo(lsa->remote_list);
+        openvpn_freeaddrinfo(lsa->remote_list);
     }
     lsa->remote_list = NULL;
     lsa->current_remote = NULL;
@@ -3411,6 +3412,10 @@ do_init_socket_1(struct context *c, const int mode)
         sockflags |= SF_PORT_SHARE;
     }
 #endif
+    if (c->options.ce.remote_discovery)
+    {
+        sockflags |= SF_HOST_DISCOVERY;
+    }
 
     link_socket_init_phase1(c->c2.link_socket,
                             c->options.ce.local,
@@ -3652,7 +3657,7 @@ do_close_link_socket(struct context *c)
     {
         if (c->c1.link_socket_addr.bind_local && !c->options.resolve_in_advance)
         {
-            freeaddrinfo(c->c1.link_socket_addr.bind_local);
+            openvpn_freeaddrinfo(c->c1.link_socket_addr.bind_local);
         }
 
         c->c1.link_socket_addr.bind_local = NULL;
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 898cb3b3..f0d1e76e 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2556,7 +2556,7 @@ man_settings_close(struct man_settings *ms)
 {
     if (ms->local)
     {
-        freeaddrinfo(ms->local);
+        openvpn_freeaddrinfo(ms->local);
     }
     free(ms->write_peer_info_file);
     CLEAR(*ms);
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 5367979d..996c0160 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -92,7 +92,7 @@
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;dnsapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
@@ -107,7 +107,7 @@
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;dnsapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
@@ -122,7 +122,7 @@
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;dnsapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
@@ -137,7 +137,7 @@
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;dnsapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8bf82c57..79e2a61f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -123,6 +123,7 @@ static const char usage_message[] =
     "--remote host [port] : Remote host name or ip address.\n"
     "--remote-random : If multiple --remote options specified, choose one randomly.\n"
     "--remote-random-hostname : Add a random string to remote DNS name.\n"
+    "--remote-discovery : Perform rfc2782 remote host discovery.\n"
     "--mode m        : Major mode, m = 'p2p' (default, point-to-point) or 'server'.\n"
     "--proto p       : Use protocol p for communicating with peer.\n"
     "                  p = udp (default), tcp-server, or tcp-client\n"
@@ -1446,6 +1447,7 @@ show_connection_entry(const struct connection_entry *o)
     SHOW_STR(local_port);
     SHOW_STR(remote);
     SHOW_STR(remote_port);
+    SHOW_BOOL(remote_discovery);
     SHOW_BOOL(remote_float);
     SHOW_BOOL(bind_defined);
     SHOW_BOOL(bind_local);
@@ -6672,6 +6674,11 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sockflags |= SF_HOST_RANDOMIZE;
     }
+    else if (streq(p[0], "remote-discovery") && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        options->ce.remote_discovery = true;
+    }
     else if (streq(p[0], "setenv") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
@@ -6679,6 +6686,10 @@ add_option(struct options *options,
         {
             options->sockflags |= SF_HOST_RANDOMIZE;
         }
+        if (streq(p[1], "REMOTE_DISCOVERY"))
+        {
+            options->ce.remote_discovery = true;
+        }
         else if (streq(p[1], "GENERIC_CONFIG"))
         {
             msg(msglevel, "this is a generic configuration and cannot directly be used");
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 877e9396..26f8e791 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -92,6 +92,7 @@ struct connection_entry
     const char *remote_port;
     const char *local;
     const char *remote;
+    bool remote_discovery;
     bool remote_float;
     bool bind_defined;
     bool bind_ipv6_only;
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 2089e6b9..40343fe0 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -841,7 +841,7 @@ port_share_open(const char *host,
                                  host, port,  0, NULL, AF_INET, &ai);
     ASSERT(status==0);
     hostaddr = *((struct sockaddr_in *) ai->ai_addr);
-    freeaddrinfo(ai);
+    openvpn_freeaddrinfo(ai);
 
     /*
      * Make a socket for foreground and background processes
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c486327b..8e9bf737 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -62,14 +62,17 @@ static unsigned int
 sf2gaf(const unsigned int getaddr_flags,
        const unsigned int sockflags)
 {
+    unsigned int flags = getaddr_flags;
+
     if (sockflags & SF_HOST_RANDOMIZE)
     {
-        return getaddr_flags | GETADDR_RANDOMIZE;
+        flags |= GETADDR_RANDOMIZE;
     }
-    else
+    if (sockflags & SF_HOST_DISCOVERY)
     {
-        return getaddr_flags;
+        flags |= GETADDR_DISCOVERY;
     }
+    return flags;
 }
 
 /*
@@ -183,7 +186,7 @@ get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,
         *sep = '/';
     }
 out:
-    freeaddrinfo(ai);
+    openvpn_freeaddrinfo(ai);
     free(var_host);
 
     return ret;
@@ -366,6 +369,11 @@ do_preresolve(struct context *c)
             flags |= GETADDR_RANDOMIZE;
         }
 
+        if (ce->remote_discovery)
+        {
+            flags |= GETADDR_DISCOVERY;
+        }
+
         if (c->options.ip_remote_hint)
         {
             remote = c->options.ip_remote_hint;
@@ -416,7 +424,7 @@ do_preresolve(struct context *c)
         if (ce->bind_local)
         {
             flags |= GETADDR_PASSIVE;
-            flags &= ~GETADDR_RANDOMIZE;
+            flags &= ~(GETADDR_RANDOMIZE|GETADDR_DISCOVERY);
             status = do_preresolve_host(c, ce->local, ce->local_port, ce->af, flags);
             if (status != 0)
             {
@@ -432,6 +440,363 @@ err:
     throw_signal_soft(SIGHUP, "Preresolving failed");
 }
 
+/* Struct to hold resolved srv records */
+struct srvinfo
+{
+    const char *hostname;
+    const char *servname;
+    unsigned short prio;
+    unsigned short weight;
+    int order;
+    struct srvinfo *next;
+};
+
+static int
+rfc2782_cmp(const void *a, const void *b)
+{
+    const struct srvinfo *ae = *(struct srvinfo **)a;
+    const struct srvinfo *be = *(struct srvinfo **)b;
+
+    /* lowest-numbered priority first */
+    if (ae->prio != be->prio)
+    {
+        return ae->prio < be->prio ? -1 : 1;
+    }
+
+    /* zero-weighted first */
+    if ((ae->weight == 0 && be->weight)
+        || (ae->weight && be->weight == 0))
+    {
+        return ae->weight < be->weight ? -1 : 1;
+    }
+
+    /* keep received order */
+    return ae->order < be->order ? -1 : 1;
+}
+
+static struct srvinfo *
+rfc2782_sort(struct srvinfo *list, int count)
+{
+    struct srvinfo head, *tail, **sorted;
+    struct gc_arena gc = gc_new();
+
+    ASSERT(list);
+    ASSERT(count);
+
+    head.next = NULL;
+    tail = &head;
+
+    /* sort records by priority and zero weight */
+    ALLOC_ARRAY_CLEAR_GC(sorted, struct srvinfo *, count, &gc);
+    for (struct srvinfo *e = list; e; e = e->next)
+    {
+        ASSERT(e->order < count);
+        sorted[e->order] = e;
+    }
+    qsort(sorted, count, sizeof(sorted[0]), rfc2782_cmp);
+
+    /* apply weighted selection mechanism */
+    for (int i = 0; i < count;)
+    {
+        struct srvinfo unordered;
+
+        /* compute the sum of the weights of records of the same
+         * priority and put them in the unordered list */
+        unordered.prio = sorted[i]->prio;
+        unordered.weight = 0;
+        unordered.next = NULL;
+        for (struct srvinfo *prev = &unordered; i < count && sorted[i]->prio == unordered.prio; i++)
+        {
+            struct srvinfo *e = sorted[i];
+
+            unordered.weight += e->weight;
+
+            /* add entry to the tail of unordered list */
+            e->next = NULL;
+            prev->next = e, prev = e;
+        }
+
+        /* process the unordered list */
+        while (unordered.next)
+        {
+            /* choose a uniform random number between 0 and the sum
+             * computed (inclusive) */
+            int weight = unordered.weight ? get_random() % unordered.weight : 0;
+
+            /* select the entries whose running sum value is the first
+             * in the selected order which is greater than or equal
+             * to the random number selected */
+            for (struct srvinfo *e = unordered.next, *prev = &unordered; e; prev = e, e = e->next)
+            {
+                /* selected entry is the next one to be contacted */
+                if (e->weight >= weight)
+                {
+                    unordered.weight -= e->weight;
+
+                    /* move entry to the ordered list */
+                    prev->next = e->next;
+                    e->next = NULL;
+                    tail->next = e, tail = e;
+
+                    /* in the presence of records containing weights greater
+                     * than 0, records with weight 0 should have a very small
+                     * chance of being selected, so skip them all after the
+                     * last weighted */
+                    if (unordered.weight == 0 && e->weight)
+                    {
+                        unordered.next = NULL;
+                    }
+                    break;
+                }
+                weight -= e->weight;
+            }
+        }
+    }
+
+    gc_free(&gc);
+    return head.next;
+}
+
+/*
+ * Translated hostname, service and protocol into struct srvinfo.
+ * Multiple records are ordered per rfc2782.
+ */
+static int
+openvpn_getsrvinfo(unsigned int flags,
+                   const char *hostname,
+                   const char *servname,
+                   struct srvinfo **res,
+                   struct gc_arena *gc)
+{
+    struct srvinfo *list = NULL;
+#ifdef _WIN32
+    char qname[DNS_MAX_NAME_BUFFER_LENGTH];
+#else
+    char qname[NS_MAXDNAME];
+#endif
+    int status;
+    int count = 0;
+
+    ASSERT(res);
+
+    ASSERT(hostname && servname);
+    ASSERT(!(flags & GETADDR_HOST_ORDER));
+
+    if (!openvpn_snprintf(qname, sizeof(qname), "_%s._%s.%s", servname,
+                          (flags & GETADDR_DATAGRAM) ? "udp" : "tcp", hostname))
+    {
+        return EAI_MEMORY;
+    }
+
+#ifdef _WIN32
+    PDNS_RECORD pDnsRecord;
+    DNS_STATUS DnsStatus = DnsQuery(qname, DNS_TYPE_SRV, DNS_QUERY_STANDARD, NULL, &pDnsRecord, NULL);
+    dmsg(D_SOCKET_DEBUG, "DNSQUERY type=%d dname=%s result=%d",
+         DNS_TYPE_SRV, qname, DnsStatus);
+    switch (DnsStatus)
+    {
+        case ERROR_SUCCESS:
+            break;
+
+        case DNS_ERROR_RCODE_NAME_ERROR:
+            return EAI_NONAME; /* HOST_NOT_FOUND */
+
+        case DNS_INFO_NO_RECORDS:
+            return EAI_NODATA; /* NO_DATA */
+
+        case DNS_ERROR_NO_DNS_SERVERS:
+        case DNS_ERROR_RCODE_FORMAT_ERROR:
+        case DNS_ERROR_RCODE_NOT_IMPLEMENTED:
+        case DNS_ERROR_RCODE_REFUSED:
+            return EAI_FAIL; /* NO_RECOVERY */
+
+        case ERROR_TIMEOUT:
+        case DNS_ERROR_RCODE_SERVER_FAILURE:
+        case DNS_ERROR_TRY_AGAIN_LATER:
+            return EAI_AGAIN; /* TRY_AGAIN */
+
+        default:
+            return EAI_NODATA;
+    }
+
+    for (PDNS_RECORD rr = pDnsRecord; rr; rr = rr->pNext)
+    {
+        if (rr->wType == DNS_TYPE_SRV)
+        {
+            PDNS_SRV_DATA rdata = &rr->Data.Srv;
+
+            if (rr->wDataLength >= sizeof(DNS_SRV_DATA) && *rdata->pNameTarget)
+            {
+                char port[sizeof("65535")];
+                openvpn_snprintf(port, sizeof(port), "%u", rdata->wPort);
+
+                struct srvinfo *e;
+                ALLOC_OBJ_CLEAR_GC(e, struct srvinfo, gc);
+                e->hostname = string_alloc(rdata->pNameTarget, gc);
+                e->servname = string_alloc(port, gc);
+                e->prio = rdata->wPriority;
+                e->weight = rdata->wWeight;
+                e->order = count++;
+                e->next = list, list = e;
+            }
+        }
+    }
+    DnsRecordListFree(pDnsRecord, DnsFreeParsedMessageFields);
+#else
+    unsigned char answer[NS_MAXMSG];
+    int n = res_query(qname, ns_c_in, ns_t_srv, answer, NS_MAXMSG);
+    dmsg(D_SOCKET_DEBUG, "RES_QUERY class=%d type=%d dname=%s result=%d",
+         ns_c_in, ns_t_srv, qname, n);
+    if (n < 0)
+    {
+        switch (h_errno)
+        {
+            case HOST_NOT_FOUND:
+                return EAI_NONAME;
+
+            case NO_ADDRESS:
+#if NO_ADDRESS != NO_DATA
+            case NO_DATA:
+#endif
+                return EAI_NODATA;
+
+            case NO_RECOVERY:
+                return EAI_FAIL;
+
+            case TRY_AGAIN:
+                return EAI_AGAIN;
+        }
+        return EAI_SYSTEM;
+    }
+
+    ns_msg msg;
+    if (ns_initparse(answer, n, &msg) < 0)
+    {
+        return EAI_FAIL;
+    }
+
+    for (int i = 0; i < ns_msg_count(msg, ns_s_an); i++)
+    {
+        ns_rr rr;
+
+        if (ns_parserr(&msg, ns_s_an, i, &rr) == 0 && ns_rr_type(rr) == ns_t_srv)
+        {
+            const unsigned char *rdata = ns_rr_rdata(rr);
+
+            if (ns_rr_rdlen(rr) > 6
+                && dn_expand(ns_msg_base(msg), ns_msg_end(msg),
+                             rdata + 6, qname, sizeof(qname)) > 0 && *qname)
+            {
+                char port[sizeof("65535")];
+                openvpn_snprintf(port, sizeof(port), "%u", ns_get16(rdata + 4));
+
+                struct srvinfo *e;
+                ALLOC_OBJ_CLEAR_GC(e, struct srvinfo, gc);
+                e->hostname = string_alloc(qname, gc);
+                e->servname = string_alloc(port, gc);
+                e->prio = ns_get16(rdata);
+                e->weight = ns_get16(rdata + 2);
+                e->order = count++;
+                e->next = list, list = e;
+            }
+        }
+    }
+#endif
+
+    if (list)
+    {
+        *res = rfc2782_sort(list, count);
+        status = *res ? 0 : EAI_NODATA;
+    }
+    else
+    {
+        status = EAI_NODATA;
+    }
+    return status;
+}
+
+/* 
+ * Struct to hold chainable copy of struct addinfo.
+ * Must be binary compatible (except size) with original.
+ */
+struct addrinfo_chained
+{
+    struct addrinfo ai;
+    struct openvpn_sockaddr addr;
+    char canonname[0];
+};
+
+/*
+ * System getaddrinfo() returns one or more addrinfo structures.
+ * openvpn_getaddinfo() chains them into one in case DNS SRV
+ * resolve is performed, but unfortunately it can't be safely done
+ * (freed) with musl libc, refer
+ * https://git.musl-libc.org/cgit/musl/commit/?id=d1395c43c019aec6b855cf3c656bf47c8a719e7f
+ * Use own copy of each addrinfo to workaround this and possibly
+ * other getaddrinfo()/freeaddrinfo() implementations.
+ */
+int
+getaddrinfo_chained(const char *node, const char *service,
+                    const struct addrinfo *hints,
+                    struct addrinfo **res)
+{
+    int status = getaddrinfo(node, service, hints, res);
+    if (status == 0 && res && *res)
+    {
+        struct addrinfo_chained head, *tail = &head;
+
+        head.ai.ai_next = NULL;
+        for (struct addrinfo *ai = *res; ai; ai = ai->ai_next)
+        {
+            socklen_t addrlen = ai->ai_addr ? ai->ai_addrlen : 0;
+            size_t namelen = ai->ai_canonname ? strlen(ai->ai_canonname) + 1 : 0;
+
+            /* allocate self-contained struct with enough space for optional data */
+            struct addrinfo_chained *ac = calloc(1, sizeof(*ac) + addrlen + namelen);
+            if (!ac)
+            {
+                openvpn_freeaddrinfo(head.ai.ai_next);
+                head.ai.ai_next = NULL;
+                status = EAI_MEMORY;
+                break;
+            }
+
+            /* deep clone the structure and its members */
+            memcpy(&ac->ai, ai, sizeof(ac->ai));
+            if (ai->ai_addr)
+            {
+                memcpy(&ac->addr.addr.sa, ai->ai_addr, addrlen);
+                ac->ai.ai_addr = &ac->addr.addr.sa;
+            }
+            if (ai->ai_canonname)
+            {
+                memcpy(ac->canonname, ai->ai_canonname, namelen);
+                ac->ai.ai_canonname = ac->canonname;
+            }
+
+            /* add clone to the tail */
+            ac->ai.ai_next = NULL;
+            tail->ai.ai_next = &ac->ai, tail = ac;
+        }
+
+        /* original list is cloned, can be freed now */
+        freeaddrinfo(*res);
+        *res = head.ai.ai_next;
+    }
+    return status;
+}
+
+void
+openvpn_freeaddrinfo(struct addrinfo *res)
+{
+    while (res)
+    {
+        struct addrinfo_chained *ac = (struct addrinfo_chained *)res;
+        res = res->ai_next;
+        free(ac);
+    }
+}
+
 /*
  * Translate IPv4/IPv6 addr or hostname into struct addrinfo
  * If resolve error, try again for resolve_retry_seconds seconds.
@@ -497,7 +862,7 @@ openvpn_getaddrinfo(unsigned int flags,
         hints.ai_socktype = SOCK_STREAM;
     }
 
-    status = getaddrinfo(hostname, servname, &hints, res);
+    status = getaddrinfo_chained(hostname, servname, &hints, res);
 
     if (status != 0) /* parse as numeric address failed? */
     {
@@ -555,16 +920,17 @@ openvpn_getaddrinfo(unsigned int flags,
         /*
          * Resolve hostname
          */
-        while (true)
-        {
+        struct srvinfo *targets = NULL;
 #ifndef _WIN32
-            res_init();
+        res_init();
 #endif
-            /* try hostname lookup */
-            hints.ai_flags &= ~AI_NUMERICHOST;
-            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d",
-                 flags, hints.ai_family, hints.ai_socktype);
-            status = getaddrinfo(hostname, servname, &hints, res);
+
+        /* try srv lookup */
+        while (flags & GETADDR_DISCOVERY)
+        {
+            dmsg(D_SOCKET_DEBUG, "GETSRVINFO flags=0x%04x hostname=%s",
+                 flags, np(hostname));
+            status = openvpn_getsrvinfo(flags, hostname, OPENVPN_SERVICE, &targets, &gc);
 
             if (signal_received)
             {
@@ -581,9 +947,6 @@ openvpn_getaddrinfo(unsigned int flags,
                         /* turn success into failure (interrupted syscall) */
                         if (0 == status)
                         {
-                            ASSERT(res);
-                            freeaddrinfo(*res);
-                            *res = NULL;
                             status = EAI_AGAIN; /* = temporary failure */
                             errno = EINTR;
                         }
@@ -592,8 +955,8 @@ openvpn_getaddrinfo(unsigned int flags,
                 }
             }
 
-            /* success? */
-            if (0 == status)
+            /* success and fails are expected, fallback to usual resolve */
+            if (EAI_AGAIN != status)
             {
                 break;
             }
@@ -614,10 +977,127 @@ openvpn_getaddrinfo(unsigned int flags,
 
             if (--resolve_retries <= 0)
             {
-                goto done;
+                /* can't retry, fallback to usual resolve */
+                break;
             }
 
             management_sleep(fail_wait_interval);
+#ifndef _WIN32
+            res_init();
+#endif
+        }
+
+        /* no targets due not discovering or discovery fail,
+         * use specified hostname/sername as target instead */
+        if (!targets)
+        {
+            ALLOC_OBJ_CLEAR_GC(targets, struct srvinfo, &gc);
+            targets->hostname = hostname;
+            targets->servname = servname;
+        }
+
+        /* try to resolve all collected targets */
+        struct addrinfo **res_tail = res;
+        while (targets)
+        {
+            /* Add +4 to cause integer division rounding up (1 + 4) = 5, (0+4)/5=0 */
+            int resolve_retries = (flags & GETADDR_TRY_ONCE) ? 1 :
+                                  ((resolve_retry_seconds + 4)/ fail_wait_interval);
+            level = 0;
+
+            if (targets->hostname)
+            {
+                print_hostname = targets->hostname;
+            }
+            else
+            {
+                print_hostname = "undefined";
+            }
+
+            /* try hostname lookup */
+            while (true)
+            {
+                hints.ai_flags &= ~AI_NUMERICHOST;
+                dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d hostname=%s:%s",
+                     flags, hints.ai_family, hints.ai_socktype,
+                     np(targets->hostname), np(targets->servname));
+                status = getaddrinfo_chained(targets->hostname, targets->servname, &hints, res_tail);
+
+                if (signal_received)
+                {
+                    get_signal(signal_received);
+                    if (*signal_received) /* were we interrupted by a signal? */
+                    {
+                        if (*signal_received == SIGUSR1) /* ignore SIGUSR1 */
+                        {
+                            msg(level, "RESOLVE: Ignored SIGUSR1 signal received during DNS resolution attempt");
+                            *signal_received = 0;
+                        }
+                        else
+                        {
+                            /* turn success into failure (interrupted syscall) */
+                            if (0 == status)
+                            {
+                                ASSERT(res);
+                                openvpn_freeaddrinfo(*res);
+                                *res = NULL;
+                                status = EAI_AGAIN; /* = temporary failure */
+                                errno = EINTR;
+                            }
+                            goto done;
+                        }
+                    }
+                }
+
+                /* success? */
+                if (0 == status)
+                {
+                    /* handle next target if possible */
+                    targets = targets->next;
+
+                    /* add subsequent results to the tail */
+                    while (*res_tail)
+                    {
+                        res_tail = &(*res_tail)->ai_next;
+                    }
+                    break;
+                }
+
+                /* resolve lookup failed, should we
+                 * continue or fail? */
+                level = msglevel;
+                if (resolve_retries > 0)
+                {
+                    level = D_RESOLVE_ERRORS;
+                }
+
+                msg(level,
+                    fmt,
+                    print_hostname,
+                    print_servname,
+                    gai_strerror(status));
+
+                if (--resolve_retries <= 0)
+                {
+                    /* can't retry, handle next target if possible */
+                    targets = targets->next;
+
+                    /* error makes no sense for the next target
+                     * or reset error if there're accumulated results */
+                    if (targets || res_tail != res)
+                    {
+                        status = 0;
+                        break;
+                    }
+
+                    goto done;
+                }
+
+                management_sleep(fail_wait_interval);
+#ifndef _WIN32
+                res_init();
+#endif
+            }
         }
 
         ASSERT(res);
@@ -636,6 +1116,10 @@ openvpn_getaddrinfo(unsigned int flags,
         {
             msg(M_WARN, "WARNING: ignoring --remote-random-hostname because the hostname is an IP address");
         }
+        if (flags & GETADDR_DISCOVERY)
+        {
+            msg(M_WARN, "WARNING: ignoring --remote-discovery because the hostname is an IP address");
+        }
     }
 
 done:
@@ -1350,13 +1834,13 @@ socket_listen_accept(socket_descriptor_t sd,
                 {
                     msg(M_ERR, "TCP: close socket failed (new_sd)");
                 }
-                freeaddrinfo(ai);
+                openvpn_freeaddrinfo(ai);
             }
             else
             {
                 if (ai)
                 {
-                    freeaddrinfo(ai);
+                    openvpn_freeaddrinfo(ai);
                 }
                 break;
             }
@@ -2232,7 +2716,7 @@ phase2_socks_client(struct link_socket *sock, struct signal_info *sig_info)
     addr_zero_host(&sock->info.lsa->actual.dest);
     if (sock->info.lsa->remote_list)
     {
-        freeaddrinfo(sock->info.lsa->remote_list);
+        openvpn_freeaddrinfo(sock->info.lsa->remote_list);
         sock->info.lsa->current_remote = NULL;
         sock->info.lsa->remote_list = NULL;
     }
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 7aeae527..7e70c481 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -40,6 +40,11 @@
  */
 #define OPENVPN_PORT "1194"
 
+/*
+ * OpenVPN's default service name for rfc2782 discovery.
+ */
+#define OPENVPN_SERVICE "openvpn"
+
 /*
  * Number of seconds that "resolv-retry infinite"
  * represents.
@@ -210,6 +215,7 @@ struct link_socket
 #define SF_PORT_SHARE (1<<2)
 #define SF_HOST_RANDOMIZE (1<<3)
 #define SF_GETADDRINFO_DGRAM (1<<4)
+#define SF_HOST_DISCOVERY (1<<5)
     unsigned int sockflags;
     int mark;
     const char *bind_dev;
@@ -532,6 +538,7 @@ bool unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, int *uid, int *g
 #define GETADDR_RANDOMIZE             (1<<9)
 #define GETADDR_PASSIVE               (1<<10)
 #define GETADDR_DATAGRAM              (1<<11)
+#define GETADDR_DISCOVERY             (1<<12)
 
 #define GETADDR_CACHE_MASK              (GETADDR_DATAGRAM|GETADDR_PASSIVE)
 
@@ -561,6 +568,14 @@ int openvpn_getaddrinfo(unsigned int flags,
                         int ai_family,
                         struct addrinfo **res);
 
+void openvpn_freeaddrinfo(struct addrinfo *res);
+
+inline static void
+gc_freeaddrinfo_callback(void *addr)
+{
+    openvpn_freeaddrinfo((struct addrinfo *) addr);
+}
+
 /*
  * Transport protocol naming and other details.
  */
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 8342eae0..e5852753 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -38,6 +38,7 @@
 
 #ifdef _WIN32
 #include <windows.h>
+#include <windns.h>
 #include <winsock2.h>
 #include <tlhelp32.h>
 #define sleep(x) Sleep((x)*1000)
@@ -176,6 +177,10 @@
 #include <netinet/in.h>
 #endif
 
+#ifdef HAVE_ARPA_NAMESER_H
+#include <arpa/nameser.h>
+#endif
+
 #ifdef HAVE_RESOLV_H
 #include <resolv.h>
 #endif
-- 
2.17.1


