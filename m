From: Vladislav Grishenko <themiron@...2010...>
Date: Wed, 26 Aug 2020 21:51:28 +0500
Message-Id: <20200826165128.23117-1-themiron@...2010...>
In-Reply-To: <de9db75e-98de-6a56-6f3c-6ba66f475cca@...1227...>
References: <de9db75e-98de-6a56-6f3c-6ba66f475cca@...1227...>
Subject: [Openvpn-devel] [PATCH v2] Add DNS SRV host discovery support
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

DNS SRV host discovery allows to have multiple OpenVPN servers for a single
domain w/o explicit profile enumeration, to move services from host to host
with little fuss, and to designate hosts as primary servers for a service
and others as backups.
Feature has been asked several times already, useful in case of huge
ammounts of client & servers deployed.

Patch introduces "--remote-service-discovery [service]" option, which
enables discovery and optionally allows to change "openvpn" default service
to user specified.
Client will try to resolve ``_service._proto.host`` name via DNS
and use returned DNS SRV records as OpenVPN remote server list
ordered by server selection mechanism defined in RFC 2782:

    A client MUST attempt to contact the target host with the
    lowest-numbered priority field value it can reach, target hosts
    with the same priority SHOULD be tried in an order defined by the
    weight field.
    The weight field specifies a relative weight for entries with the
    same priority. Larger weights SHOULD be given a proportionately
    higher probability of being selected.
    Domain administrators SHOULD use Weight 0 when there isn't any
    server selection to do. In the presence of records containing
    weights greater than 0, records with weight 0 SHOULD have a very
    small chance of being selected.

Example: instead of multiple remotes on order in profile:
    remote s1.example.com 1194 udp
    remote s2.example.com 1194 udp
    remote s3.example.com 1194 udp
    remote s4.example.com 1194 udp
    remote example.com 1194 udp

now it's possible to specify one remote with discovery:
    remote example.net 1194 udp
    remote-service-discovery

and addconfigure following DNS SRV records, for examle:
     _openvpn._udp.example.net IN SRV 10 60 1194 s1.example.net
     _openvpn._udp.example.net IN SRV 10 40 1194 s2.example.net
     _openvpn._udp.example.net IN SRV 10  0 1194 s3.example.net
     _openvpn._udp.example.net IN SRV 20  0 1194 s4.example.net

Client will try to resolve "_openvpn._udp.example.net".
Next, "s1.example.net", "s2.example.net" and "s3.example.net" will be
ordered before "s4.example.net" as their priority 10 is smaller than 20.
Next, "s1.example.net", "s2.example.net" and "s3.example.net" will be
randomly ordered with weight probability - first will be either
"s1.example.net" with probability 60% or "s2.example.net" with 40% or
"s3.example.net" with almost zero probability.
Next, if "s1.example.net" is picked as first, second server will be either
"s2.example.net" with almost 100% probability or "s3.example.net" instead.
Next, if "s2.example.net" is picked as second, "s3.example.net" will be
skipped due zero weight.
"s4.example.net" will be the last one as the only server with priority 20.
Finally, servers will be resolved and accessed in this order.

If _openvpn._udp.example.net" can't be resolved or no valid records are
returned or they can't be resolved, client will try to access "example.net"
host at port 1194 as if no discovery is enabled.

v2: use DNS SRV for feature naming
    change option name to --remote-service-discovery
    add --remote-service-discovery [service] optional parameter support
    rewrite man, add algo/prio/weight description and examples
    fix random weight selection was not implicit
    remove pulled REMOTE_DISCOVERY support, not needed
    split windows/unix-specific parts into extra functions
    rename functions into servinfo scope, add doxygen comments when appropriate
    remove addrinfo hack, use servinfo containers of addrinfo list instead
    better proxy support (tcp mode not supported so far)
    log discovery attempts and results, if enabled

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 configure.ac                        |   2 +-
 doc/man-sections/client-options.rst |  63 +++
 src/openvpn/Makefile.am             |   2 +-
 src/openvpn/buffer.h                |   5 -
 src/openvpn/errlevel.h              |   1 +
 src/openvpn/init.c                  |  19 +-
 src/openvpn/openvpn.vcxproj         |   8 +-
 src/openvpn/options.c               |   8 +
 src/openvpn/options.h               |   1 +
 src/openvpn/socket.c                | 773 +++++++++++++++++++++++++---
 src/openvpn/socket.h                |  93 +++-
 src/openvpn/syshead.h               |   5 +
 src/openvpn/tun.c                   |  19 +-
 src/openvpn/tun.h                   |   3 +-
 14 files changed, 904 insertions(+), 98 deletions(-)

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
index ec1e3b11..ed7d2c3c 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -309,6 +309,69 @@ configuration.
   prevent DNS caching. For example, "foo.bar.gov" would be modified to
   "<random-chars>.foo.bar.gov".
 
+--remote-service-discovery [service]
+  Perform DNS SRV remote host discovery using ``host`` and ``proto``
+  defined by the ``--remote`` option and optional ``service`` value.
+  By default, ``service`` is :code:`openvpn`.
+
+  Client will try to resolve ``_service._proto.host`` name via DNS
+  and use returned DNS SRV records as OpenVPN remote server list
+  ordered by server selection mechanism defined in RFC 2782:
+  ::
+
+    A client MUST attempt to contact the target host with the
+    lowest-numbered priority field value it can reach, target hosts
+    with the same priority SHOULD be tried in an order defined by the
+    weight field.
+    The weight field specifies a relative weight for entries with the
+    same priority. Larger weights SHOULD be given a proportionately
+    higher probability of being selected.
+    Domain administrators SHOULD use Weight 0 when there isn't any
+    server selection to do. In the presence of records containing
+    weights greater than 0, records with weight 0 SHOULD have a very
+    small chance of being selected.
+
+  If one DNS SRV record resolves to multiple IP addresses, OpenVPN will
+  try them in the order that the system getaddrinfo() presents them.
+  If discovery has failed, direct ``host`` and ``port`` connection will
+  be tried as a fallback.
+
+  Example:
+  ::
+
+     remote example.net 1194 udp
+     remote-service-discovery
+
+  DNS SRV records example:
+  ::
+
+     _openvpn._udp.example.net IN SRV 10 60 1194 s1.example.net
+     _openvpn._udp.example.net IN SRV 10 40 1194 s2.example.net
+     _openvpn._udp.example.net IN SRV 10  0 1194 s3.example.net
+     _openvpn._udp.example.net IN SRV 20  0 1194 s4.example.net
+
+  For above, client will try to resolve ``_openvpn._udp.example.net``.
+  Next, ``s1.example.net``, ``s2.example.net`` and ``s3.example.net``
+  will be ordered before ``s4.example.net`` as their priority 10 is
+  smaller than 20.
+  Next, ``s1.example.net``, ``s2.example.net`` and ``s3.example.net``
+  will be randomly ordered with weight probability - first will be
+  either ``s1.example.net`` with probability 60% or ``s2.example.net``
+  with 40% or ``s3.example.net`` with almost zero probability.
+  Next, if ``s1.example.net`` is picked as first, second server will
+  be either ``s2.example.net`` with almost 100% probability or
+  ``s3.example.net`` instead.
+  Next, if ``s2.example.net`` is picked as second, ``s3.example.net``
+  will be skipped due zero weight.
+  ``s4.example.net`` will be the last one as the only server with
+  priority 20.
+  Finally, servers will be resolved and accessed in this order.
+
+  If ``_openvpn._udp.example.net`` can't be resolved or no valid
+  records are returned or they can't be resolved, client will try to
+  access ``example.net`` host at port ``1194`` as if no discovery is
+  enabled.
+
 --resolv-retry n
   If hostname resolve fails for ``--remote``, retry resolve for ``n``
   seconds before failing.
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
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index e448fc37..c77dc76c 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -91,6 +91,7 @@
 #define D_OSBUF              LOGLEV(3, 43, 0)        /* show socket/tun/tap buffer sizes */
 #define D_PS_PROXY           LOGLEV(3, 44, 0)        /* messages related to --port-share option */
 #define D_PF_INFO            LOGLEV(3, 45, 0)        /* packet filter informational messages */
+#define D_RESOLVE_INFO       LOGLEV(3, 46, 0)        /* show hostname resolve info */
 
 #define D_SHOW_PARMS         LOGLEV(4, 50, 0)        /* show all parameters on program initiation */
 #define D_SHOW_OCC           LOGLEV(4, 51, 0)        /* show options compatibility string */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a785934a..dafb999e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -365,6 +365,7 @@ management_callback_remote_cmd(void *arg, const char **p)
 
                 ce->remote = rhs->host;
                 ce->remote_port = rhs->port;
+                ce->remote_service = NULL; /* disable discovery */
                 flags = CE_MAN_QUERY_REMOTE_MOD;
                 ret = true;
             }
@@ -458,9 +459,10 @@ clear_remote_addrlist(struct link_socket_addr *lsa, bool free)
 {
     if (lsa->remote_list && free)
     {
-        freeaddrinfo(lsa->remote_list);
+        freeservinfo(lsa->remote_list);
     }
     lsa->remote_list = NULL;
+    lsa->current_service = NULL;
     lsa->current_remote = NULL;
 }
 
@@ -492,6 +494,14 @@ next_connection_entry(struct context *c)
                 c->c1.link_socket_addr.current_remote =
                     c->c1.link_socket_addr.current_remote->ai_next;
             }
+            else if (c->c1.link_socket_addr.current_service
+                && c->c1.link_socket_addr.current_service->next)
+            {
+                c->c1.link_socket_addr.current_service =
+                    c->c1.link_socket_addr.current_service->next;
+                c->c1.link_socket_addr.current_remote =
+                    c->c1.link_socket_addr.current_service->ai;
+            }
             else
             {
                 /* FIXME (schwabe) fix the persist-remote-ip option for real,
@@ -502,12 +512,15 @@ next_connection_entry(struct context *c)
                 {
                     /* close_instance should have cleared the addrinfo objects */
                     ASSERT(c->c1.link_socket_addr.current_remote == NULL);
+                    ASSERT(c->c1.link_socket_addr.current_service == NULL);
                     ASSERT(c->c1.link_socket_addr.remote_list == NULL);
                 }
                 else
                 {
-                    c->c1.link_socket_addr.current_remote =
+                    c->c1.link_socket_addr.current_service =
                         c->c1.link_socket_addr.remote_list;
+                    c->c1.link_socket_addr.current_remote =
+                        c->c1.link_socket_addr.current_service->ai;
                 }
 
                 /*
@@ -3417,6 +3430,7 @@ do_init_socket_1(struct context *c, const int mode)
                             c->options.ce.local_port,
                             c->options.ce.remote,
                             c->options.ce.remote_port,
+                            c->options.ce.remote_service,
                             c->c1.dns_cache,
                             c->options.ce.proto,
                             c->options.ce.af,
@@ -3636,6 +3650,7 @@ do_close_link_socket(struct context *c)
                ||
                ( c->sig->source != SIG_SOURCE_HARD
                  && ((c->c1.link_socket_addr.current_remote && c->c1.link_socket_addr.current_remote->ai_next)
+                     || (c->c1.link_socket_addr.current_service && c->c1.link_socket_addr.current_service->next)
                      || c->options.no_advance))
                )))
     {
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
index 8bf82c57..bd893072 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -123,6 +123,7 @@ static const char usage_message[] =
     "--remote host [port] : Remote host name or ip address.\n"
     "--remote-random : If multiple --remote options specified, choose one randomly.\n"
     "--remote-random-hostname : Add a random string to remote DNS name.\n"
+    "--remote-service-discovery [service]: Perform DNS SRV remote host discovery.\n"
     "--mode m        : Major mode, m = 'p2p' (default, point-to-point) or 'server'.\n"
     "--proto p       : Use protocol p for communicating with peer.\n"
     "                  p = udp (default), tcp-server, or tcp-client\n"
@@ -809,6 +810,7 @@ init_options(struct options *o, const bool init_gc)
     o->ce.connect_timeout = 120;
     o->connect_retry_max = 0;
     o->ce.local_port = o->ce.remote_port = OPENVPN_PORT;
+    o->ce.remote_service = NULL; /* OPENVPN_SERVICE */
     o->verbosity = 1;
     o->status_file_update_freq = 60;
     o->status_file_version = 1;
@@ -1446,6 +1448,7 @@ show_connection_entry(const struct connection_entry *o)
     SHOW_STR(local_port);
     SHOW_STR(remote);
     SHOW_STR(remote_port);
+    SHOW_STR(remote_service);
     SHOW_BOOL(remote_float);
     SHOW_BOOL(bind_defined);
     SHOW_BOOL(bind_local);
@@ -6672,6 +6675,11 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sockflags |= SF_HOST_RANDOMIZE;
     }
+    else if (streq(p[0], "remote-service-discovery") && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        options->ce.remote_service = p[1] ? p[1] : OPENVPN_SERVICE;
+    }
     else if (streq(p[0], "setenv") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 877e9396..b6504cd9 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -92,6 +92,7 @@ struct connection_entry
     const char *remote_port;
     const char *local;
     const char *remote;
+    const char *remote_service;
     bool remote_float;
     bool bind_defined;
     bool bind_ipv6_only;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c486327b..35146439 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -258,9 +258,10 @@ static int
 get_cached_dns_entry(struct cached_dns_entry *dns_cache,
                      const char *hostname,
                      const char *servname,
+                     const char *service,
                      int ai_family,
                      int resolve_flags,
-                     struct addrinfo **ai)
+                     struct servinfo **si)
 {
     struct cached_dns_entry *ph;
     int flags;
@@ -272,10 +273,11 @@ get_cached_dns_entry(struct cached_dns_entry *dns_cache,
     {
         if (streqnull(ph->hostname, hostname)
             && streqnull(ph->servname, servname)
+            && streqnull(ph->service, service)
             && ph->ai_family == ai_family
             && ph->flags == flags)
         {
-            *ai = ph->ai;
+            *si = ph->si;
             return 0;
         }
     }
@@ -287,34 +289,37 @@ static int
 do_preresolve_host(struct context *c,
                    const char *hostname,
                    const char *servname,
+                   const char *service,
                    const int af,
                    const int flags)
 {
-    struct addrinfo *ai;
+    struct servinfo *si;
     int status;
 
     if (get_cached_dns_entry(c->c1.dns_cache,
                              hostname,
                              servname,
+                             service,
                              af,
                              flags,
-                             &ai) == 0)
+                             &si) == 0)
     {
         /* entry already cached, return success */
         return 0;
     }
 
-    status = openvpn_getaddrinfo(flags, hostname, servname,
+    status = openvpn_getservinfo(flags, hostname, servname, service,
                                  c->options.resolve_retry_seconds, NULL,
-                                 af, &ai);
+                                 af, &si);
     if (status == 0)
     {
         struct cached_dns_entry *ph;
 
         ALLOC_OBJ_CLEAR_GC(ph, struct cached_dns_entry, &c->gc);
-        ph->ai = ai;
+        ph->si = si;
         ph->hostname = hostname;
         ph->servname = servname;
+        ph->service = service;
         ph->flags = flags & GETADDR_CACHE_MASK;
 
         if (!c->c1.dns_cache)
@@ -331,7 +336,7 @@ do_preresolve_host(struct context *c,
             prev->next = ph;
         }
 
-        gc_addspecial(ai, &gc_freeaddrinfo_callback, &c->gc);
+        gc_addspecial(si, &gc_freeservinfo_callback, &c->gc);
 
     }
     return status;
@@ -366,6 +371,11 @@ do_preresolve(struct context *c)
             flags |= GETADDR_RANDOMIZE;
         }
 
+        if (ce->remote_service)
+        {
+            flags |= GETADDR_DISCOVERY;
+        }
+
         if (c->options.ip_remote_hint)
         {
             remote = c->options.ip_remote_hint;
@@ -378,7 +388,8 @@ do_preresolve(struct context *c)
         /* HTTP remote hostname does not need to be resolved */
         if (!ce->http_proxy_options)
         {
-            status = do_preresolve_host(c, remote, ce->remote_port, ce->af, flags);
+            status = do_preresolve_host(c, remote, ce->remote_port,
+                                        ce->remote_service, ce->af, flags);
             if (status != 0)
             {
                 goto err;
@@ -391,6 +402,7 @@ do_preresolve(struct context *c)
             status = do_preresolve_host(c,
                                         ce->http_proxy_options->server,
                                         ce->http_proxy_options->port,
+                                        NULL,
                                         ce->af,
                                         preresolve_flags);
 
@@ -405,6 +417,7 @@ do_preresolve(struct context *c)
             status = do_preresolve_host(c,
                                         ce->socks_proxy_server,
                                         ce->socks_proxy_port,
+                                        NULL,
                                         ce->af,
                                         flags);
             if (status != 0)
@@ -417,7 +430,7 @@ do_preresolve(struct context *c)
         {
             flags |= GETADDR_PASSIVE;
             flags &= ~GETADDR_RANDOMIZE;
-            status = do_preresolve_host(c, ce->local, ce->local_port, ce->af, flags);
+            status = do_preresolve_host(c, ce->local, ce->local_port, NULL, ce->af, flags);
             if (status != 0)
             {
                 goto err;
@@ -433,31 +446,420 @@ err:
 }
 
 /*
- * Translate IPv4/IPv6 addr or hostname into struct addrinfo
+ * Allocates new service structure on heap and stores
+ * its initial host and port values.
+ */
+static struct servinfo *
+alloc_servinfo(const char *hostname,
+               const char *servname)
+{
+    size_t namesize = hostname ? strlen(hostname) + 1 : 0;
+    size_t servsize = servname ? strlen(servname) + 1 : 0;
+    struct servinfo *si = calloc(1, sizeof(*si) + namesize + servsize);
+    if (si)
+    {
+        if (hostname)
+        {
+            si->hostname = (char *)(si + 1);
+            memcpy((char *)si->hostname, hostname, namesize);
+        }
+        if (servname)
+        {
+            si->servname = (char *)(si + 1) + namesize;
+            memcpy((char *)si->servname, servname, servsize);
+        }
+    }
+    return si;
+}
+
+
+#ifdef _WIN32
+/*
+ * Queries DNS SRV records for specified DNS domain.
+ * Returns EAI_* status and service list on success in order of receive.
+ */
+static int
+query_servinfo(const char *domain, struct servinfo **res)
+{
+    PDNS_RECORD pDnsRecord;
+    int status;
+
+    ASSERT(res);
+
+    DNS_STATUS DnsStatus = DnsQuery(domain, DNS_TYPE_SRV, DNS_QUERY_STANDARD, NULL, &pDnsRecord, NULL);
+    dmsg(D_SOCKET_DEBUG, "DNSQUERY type=%d domain=%s result=%d",
+         DNS_TYPE_SRV, domain, DnsStatus);
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
+    struct servinfo *list = NULL;
+    int count = 0;
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
+                struct servinfo *si = alloc_servinfo(rdata->pNameTarget, port);
+                if (!si)
+                {
+                    freeservinfo(list);
+                    status = EAI_MEMORY;
+                    goto done;
+                }
+                si->prio = rdata->wPriority;
+                si->weight = rdata->wWeight;
+                si->order = count++;
+                si->next = list, list = si;
+
+                dmsg(D_SOCKET_DEBUG, "DNS SRV prio=%u weight=%u target=%s port=%s",
+                     si->prio, si->weight, si->hostname, si->servname);
+            }
+        }
+    }
+    if (count)
+    {
+        *res = list;
+        status = 0;
+    }
+    else
+    {
+        status = EAI_NODATA;
+    }
+
+done:
+    DnsRecordListFree(pDnsRecord, DnsFreeParsedMessageFields);
+    return status;
+}
+
+#else
+/*
+ * Queries DNS SRV records for specified DNS domain.
+ * Returns EAI_* status and service list on success in order of receive.
+ */
+static int
+query_servinfo(const char *domain, struct servinfo **res)
+{
+    unsigned char answer[NS_MAXMSG];
+    int status;
+
+    int n = res_query(domain, ns_c_in, ns_t_srv, answer, NS_MAXMSG);
+    dmsg(D_SOCKET_DEBUG, "RES_QUERY class=%d type=%d domain=%s result=%d",
+         ns_c_in, ns_t_srv, domain, n);
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
+    struct servinfo *list = NULL;
+    int count = 0;
+    for (int i = 0; i < ns_msg_count(msg, ns_s_an); i++)
+    {
+        ns_rr rr;
+
+        if (ns_parserr(&msg, ns_s_an, i, &rr) == 0 && ns_rr_type(rr) == ns_t_srv)
+        {
+            const unsigned char *rdata = ns_rr_rdata(rr);
+            char name[NS_MAXDNAME];
+
+            if (ns_rr_rdlen(rr) > 6
+                && dn_expand(ns_msg_base(msg), ns_msg_end(msg),
+                             rdata + 6, name, sizeof(name)) > 0 && *name)
+            {
+                char port[sizeof("65535")];
+                openvpn_snprintf(port, sizeof(port), "%u", ns_get16(rdata + 4));
+
+                struct servinfo *si = alloc_servinfo(name, port);
+                if (!si)
+                {
+                    freeservinfo(list);
+                    status = EAI_MEMORY;
+                    goto done;
+                }
+                si->prio = ns_get16(rdata);
+                si->weight = ns_get16(rdata + 2);
+                si->order = count++;
+                si->next = list, list = si;
+
+                dmsg(D_SOCKET_DEBUG, "DNS SRV prio=%u weight=%u target=%s port=%s",
+                     si->prio, si->weight, si->hostname, si->servname);
+            }
+        }
+    }
+    if (count)
+    {
+        *res = list;
+        status = 0;
+    }
+    else
+    {
+        status = EAI_NODATA;
+    }
+
+done:
+    return status;
+}
+#endif
+
+/*
+ * Service structure compare function for server selection
+ * mechanism, defined in RFC 2782.
+ */
+static int
+servinfo_cmp(const void *a, const void *b)
+{
+    const struct servinfo *ae = *(struct servinfo **)a;
+    const struct servinfo *be = *(struct servinfo **)b;
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
+    /* else keep received order, can't be equal */
+    return ae->order < be->order ? -1 : 1;
+}
+
+/*
+ * Sort & order service list according server selection mechanism,
+ * defined in RFC 2782.
+ * Returns service list. Although specific elements can be freed,
+ * non-empty list can never become empty.
+ */
+static struct servinfo *
+sort_servinfo(struct servinfo *list)
+{
+    struct servinfo ordered, *tail = &ordered;
+    int count = 0;
+    struct gc_arena gc = gc_new();
+
+    ASSERT(list);
+
+    for (struct servinfo *si = list; si; si = si->next)
+    {
+        count++;
+    }
+
+    struct servinfo **sorted;
+    ALLOC_ARRAY_CLEAR_GC(sorted, struct servinfo *, count, &gc);
+    for (struct servinfo *si = list; si; si = si->next)
+    {
+        ASSERT(si->order < count);
+        sorted[si->order] = si;
+    }
+
+    /* sort records by priority and zero weight */
+    qsort(sorted, count, sizeof(sorted[0]), servinfo_cmp);
+
+    /* apply weighted selection mechanism */
+    ordered.next = NULL;
+    for (int i = 0; i < count;)
+    {
+        struct servinfo unordered;
+
+        /* compute the sum of the weights of records of the same
+         * priority and put them in the unordered list */
+        unordered.prio = sorted[i]->prio;
+        unordered.weight = 0;
+        unordered.next = NULL;
+        for (struct servinfo *prev = &unordered;
+             i < count && sorted[i]->prio == unordered.prio; i++)
+        {
+            unordered.weight += sorted[i]->weight;
+
+            /* add entry to the tail of unordered list */
+            sorted[i]->next = NULL;
+            prev->next = sorted[i], prev = sorted[i];
+        }
+
+        /* process the unordered list */
+        while (unordered.next)
+        {
+            /* choose a uniform random number between 0 and the sum
+             * computed (inclusive) */
+            int weight = get_random() % (unordered.weight + 1);
+
+            /* select the entries whose running sum value is the first
+             * in the selected order which is greater than or equal
+             * to the random number selected */
+            for (struct servinfo *si = unordered.next, *prev = &unordered;
+                 si; prev = si, si = si->next)
+            {
+                /* selected entry is the next one to be contacted */
+                if (si->weight >= weight)
+                {
+                    unordered.weight -= si->weight;
+
+                    /* move entry to the ordered list */
+                    prev->next = si->next;
+                    si->next = NULL;
+                    tail->next = si, tail = si;
+
+                    /* in the presence of records containing weights greater
+                     * than 0, records with weight 0 should have a very small
+                     * chance of being selected, so skip them all after the
+                     * last weighted */
+                    if (unordered.weight == 0 && si->weight)
+                    {
+                        freeservinfo(unordered.next);
+                        unordered.next = NULL;
+                    }
+                    break;
+                }
+                weight -= si->weight;
+            }
+        }
+    }
+
+    gc_free(&gc);
+    return ordered.next;
+}
+
+
+/*
+ * Resolves DNS SRV records for specified domain, protocol and
+ * service.
+ * Returns EAI_* status (like getaddrinfo) and service list, ordered
+ * according server selection mechanism, defined in RFC 2782.
+ */
+static int
+getservinfo(const char *domain,
+            const char *protocol,
+            const char *service,
+            struct servinfo **res)
+{
+    struct servinfo *list = NULL;
+
+    ASSERT(res);
+
+    if (!domain || !protocol || !service)
+    {
+        return EAI_NONAME;
+    }
+
+    char qname[256];
+    if (!openvpn_snprintf(qname, sizeof(qname), "_%s._%s.%s",
+                          service, protocol, domain))
+    {
+        return EAI_MEMORY;
+    }
+
+    int status = query_servinfo(qname, &list);
+    if (status == 0)
+    {
+        *res = sort_servinfo(list);
+    }
+    return status;
+}
+
+void
+freeservinfo(struct servinfo *res)
+{
+    while (res)
+    {
+        struct servinfo *si = res;
+        res = res->next;
+        freeaddrinfo(si->ai);
+        free(si);
+    }
+}
+
+/*
+ * Translate IPv4/IPv6 addr or hostname into struct servinfo
  * If resolve error, try again for resolve_retry_seconds seconds.
  */
 int
-openvpn_getaddrinfo(unsigned int flags,
+openvpn_getservinfo(unsigned int flags,
                     const char *hostname,
                     const char *servname,
+                    const char *service,
                     int resolve_retry_seconds,
                     volatile int *signal_received,
                     int ai_family,
-                    struct addrinfo **res)
+                    struct servinfo **res)
 {
-    struct addrinfo hints;
+    struct addrinfo hints, *ai;
     int status;
     int sigrec = 0;
     int msglevel = (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
     struct gc_arena gc = gc_new();
     const char *print_hostname;
     const char *print_servname;
+    bool service_discovery;
 
     ASSERT(res);
 
     ASSERT(hostname || servname);
     ASSERT(!(flags & GETADDR_HOST_ORDER));
 
+    if (service && (flags & GETADDR_DISCOVERY))
+    {
+        service_discovery = true;
+    }
+    else
+    {
+        service_discovery = false;
+    }
+
     if (servname)
     {
         print_servname = servname;
@@ -486,6 +888,7 @@ openvpn_getaddrinfo(unsigned int flags,
     if (flags & GETADDR_PASSIVE)
     {
         hints.ai_flags |= AI_PASSIVE;
+        service_discovery = false;
     }
 
     if (flags & GETADDR_DATAGRAM)
@@ -497,7 +900,20 @@ openvpn_getaddrinfo(unsigned int flags,
         hints.ai_socktype = SOCK_STREAM;
     }
 
-    status = getaddrinfo(hostname, servname, &hints, res);
+    status = getaddrinfo(hostname, servname, &hints, &ai);
+    if (status == 0)
+    {
+        *res = alloc_servinfo(hostname, servname);
+        if (*res)
+        {
+            (*res)->ai = ai;
+        }
+        else
+        {
+            freeaddrinfo(ai);
+            status = EAI_MEMORY;
+        }
+    }
 
     if (status != 0) /* parse as numeric address failed? */
     {
@@ -532,7 +948,7 @@ openvpn_getaddrinfo(unsigned int flags,
         if (!(flags & GETADDR_RESOLVE) || status == EAI_FAIL)
         {
             msg(msglevel, "RESOLVE: Cannot parse IP address: %s:%s (%s)",
-                print_hostname,print_servname, gai_strerror(status));
+                print_hostname, print_servname, gai_strerror(status));
             goto done;
         }
 
@@ -555,69 +971,223 @@ openvpn_getaddrinfo(unsigned int flags,
         /*
          * Resolve hostname
          */
-        while (true)
+
+        if (service_discovery)
         {
-#ifndef _WIN32
-            res_init();
-#endif
-            /* try hostname lookup */
-            hints.ai_flags &= ~AI_NUMERICHOST;
-            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d",
-                 flags, hints.ai_family, hints.ai_socktype);
-            status = getaddrinfo(hostname, servname, &hints, res);
+            /* try service discovery lookup */
+            const char *protocol;
+            const char *print_service;
 
-            if (signal_received)
+            if (flags & GETADDR_DATAGRAM)
             {
-                get_signal(signal_received);
-                if (*signal_received) /* were we interrupted by a signal? */
+                protocol = "udp";
+            }
+            else
+            {
+                protocol = "tcp";
+            }
+
+            if (service)
+            {
+                print_service = service;
+            }
+            else
+            {
+                print_service = "undefined";
+            }
+
+            while (true)
+            {
+                dmsg(D_SOCKET_DEBUG, "GETSERVINFO flags=0x%04x hostname=%s protocol=%s service=%s",
+                     flags, print_hostname, protocol, print_service);
+                status = getservinfo(hostname, protocol, service, res);
+
+                if (signal_received)
                 {
-                    if (*signal_received == SIGUSR1) /* ignore SIGUSR1 */
-                    {
-                        msg(level, "RESOLVE: Ignored SIGUSR1 signal received during DNS resolution attempt");
-                        *signal_received = 0;
-                    }
-                    else
+                    get_signal(signal_received);
+                    if (*signal_received) /* were we interrupted by a signal? */
                     {
-                        /* turn success into failure (interrupted syscall) */
-                        if (0 == status)
+                        if (*signal_received == SIGUSR1) /* ignore SIGUSR1 */
+                        {
+                            msg(level, "RESOLVE: Ignored SIGUSR1 signal received during DNS resolution attempt");
+                            *signal_received = 0;
+                        }
+                        else
                         {
-                            ASSERT(res);
-                            freeaddrinfo(*res);
-                            *res = NULL;
-                            status = EAI_AGAIN; /* = temporary failure */
-                            errno = EINTR;
+                            /* turn success into failure (interrupted syscall) */
+                            if (0 == status)
+                            {
+                                ASSERT(res);
+                                freeservinfo(*res);
+                                *res = NULL;
+                                status = EAI_AGAIN; /* = temporary failure */
+                                errno = EINTR;
+                            }
+                            goto done;
                         }
-                        goto done;
                     }
                 }
+
+                /* success or permanent fail? fallback to host resolve */
+                if (0 == status || EAI_AGAIN != status)
+                {
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
+                    "RESOLVE: Cannot resolve service record: _%s._%s._%s (%s)",
+                    print_service,
+                    protocol,
+                    print_hostname,
+                    gai_strerror(status));
+
+                if (--resolve_retries <= 0)
+                {
+                    /* can't retry, fallback to host resolve */
+                    break;
+                }
+
+                management_sleep(fail_wait_interval);
+#ifndef _WIN32
+                /* resolve failed, force resolv.conf reread */
+                res_init();
+#endif
             }
 
-            /* success? */
-            if (0 == status)
+            /* inform about discovery results */
+            if (0 != status)
             {
-                break;
+                msg(D_RESOLVE_INFO, "No remote host has been discovered, fallback to %s:%s",
+                    print_hostname, print_servname);
             }
+            else for (struct servinfo *si = *res; si; si = si->next)
+            {
+                msg(D_RESOLVE_INFO, "Remote host been discovered: %s:%s",
+                    np(si->hostname), np(si->servname));
+            }
+        }
 
-            /* resolve lookup failed, should we
-             * continue or fail? */
-            level = msglevel;
-            if (resolve_retries > 0)
+        /* no service discovery requested or discovery fail,
+         * use specified hostname/sername as the only service instead */
+        if (!service_discovery || 0 != status)
+        {
+            *res = alloc_servinfo(hostname, servname);
+            if (*res == NULL)
             {
-                level = D_RESOLVE_ERRORS;
+                status = EAI_MEMORY;
+                goto done;
             }
+        }
 
-            msg(level,
-                fmt,
-                print_hostname,
-                print_servname,
-                gai_strerror(status));
+        /* try to resolve all collected services */
+        int success = 0;
+        for (struct servinfo *si = *res; si; si = si->next)
+        {
+            /* Add +4 to cause integer division rounding up (1 + 4) = 5, (0+4)/5=0 */
+            int resolve_retries = (flags & GETADDR_TRY_ONCE) ? 1 :
+                                  ((resolve_retry_seconds + 4)/ fail_wait_interval);
+            level = 0;
 
-            if (--resolve_retries <= 0)
+            if (si->hostname)
             {
-                goto done;
+                print_hostname = si->hostname;
+            }
+            else
+            {
+                print_hostname = "undefined";
+            }
+
+            if (si->servname)
+            {
+                print_servname = si->servname;
             }
+            else
+            {
+                print_servname = "";
+            }
+
+            /* try hostname & servname lookup */
+            while (true)
+            {
+                hints.ai_flags &= ~AI_NUMERICHOST;
+                dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d hostname=%s servname=%s",
+                     flags, hints.ai_family, hints.ai_socktype, print_hostname, print_servname);
+                status = getaddrinfo(si->hostname, si->servname, &hints, &si->ai);
 
-            management_sleep(fail_wait_interval);
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
+                                freeservinfo(*res);
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
+                    success++;
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
+                    /* error makes no sense for the next service try
+                     * or reset error if there're accumulated results */
+                    if (si->next || success)
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
+                /* resolve failed, force resolv.conf reread */
+                res_init();
+#endif
+            }
         }
 
         ASSERT(res);
@@ -636,6 +1206,10 @@ openvpn_getaddrinfo(unsigned int flags,
         {
             msg(M_WARN, "WARNING: ignoring --remote-random-hostname because the hostname is an IP address");
         }
+        if (service_discovery)
+        {
+            msg(M_WARN, "WARNING: ignoring --remote-service-discovery because the hostname is an IP address");
+        }
     }
 
 done:
@@ -657,6 +1231,33 @@ done:
     return status;
 }
 
+/*
+ * Translate IPv4/IPv6 addr or hostname into struct addrinfo
+ * If resolve error, try again for resolve_retry_seconds seconds.
+ */
+int
+openvpn_getaddrinfo(unsigned int flags,
+                    const char *hostname,
+                    const char *servname,
+                    int resolve_retry_seconds,
+                    volatile int *signal_received,
+                    int ai_family,
+                    struct addrinfo **res)
+{
+    struct servinfo *si;
+
+    int status = openvpn_getservinfo(flags, hostname, servname, NULL,
+                                     resolve_retry_seconds, signal_received,
+                                     ai_family, &si);
+    if (status == 0)
+    {
+        *res = si->ai;
+        si->ai = NULL;
+        freeservinfo(si);
+    }
+    return status;
+}
+
 /*
  * We do our own inet_aton because the glibc function
  * isn't very good about error checking.
@@ -1702,14 +2303,20 @@ resolve_bind_local(struct link_socket *sock, const sa_family_t af)
         }
 
         /* will return AF_{INET|INET6}from local_host */
+        struct servinfo *si;
         status = get_cached_dns_entry(sock->dns_cache,
                                       sock->local_host,
                                       sock->local_port,
+                                      NULL,
                                       af,
                                       flags,
-                                      &sock->info.lsa->bind_local);
+                                      &si);
 
-        if (status)
+        if (status == 0)
+        {
+            sock->info.lsa->bind_local = si->ai;
+        }
+        else
         {
             status = openvpn_getaddrinfo(flags, sock->local_host, sock->local_port, 0,
                                          NULL, af, &sock->info.lsa->bind_local);
@@ -1742,11 +2349,15 @@ resolve_remote(struct link_socket *sock,
             unsigned int flags = sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sock->sockflags);
             int retry = 0;
             int status = -1;
-            struct addrinfo *ai;
+            struct servinfo *si;
             if (proto_is_dgram(sock->info.proto))
             {
                 flags |= GETADDR_DATAGRAM;
             }
+            if (sock->remote_service)
+            {
+                flags |= GETADDR_DISCOVERY;
+            }
 
             if (sock->resolve_retry_seconds == RESOLV_RETRY_INFINITE)
             {
@@ -1789,18 +2400,21 @@ resolve_remote(struct link_socket *sock,
             status = get_cached_dns_entry(sock->dns_cache,
                                           sock->remote_host,
                                           sock->remote_port,
+                                          sock->remote_service,
                                           sock->info.af,
-                                          flags, &ai);
+                                          flags, &si);
             if (status)
             {
-                status = openvpn_getaddrinfo(flags, sock->remote_host, sock->remote_port,
-                                             retry, signal_received, sock->info.af, &ai);
+                status = openvpn_getservinfo(flags, sock->remote_host, sock->remote_port,
+                                             sock->remote_service, retry, signal_received,
+                                             sock->info.af, &si);
             }
 
             if (status == 0)
             {
-                sock->info.lsa->remote_list = ai;
-                sock->info.lsa->current_remote = ai;
+                sock->info.lsa->remote_list = si;
+                sock->info.lsa->current_service = si;
+                sock->info.lsa->current_remote = si->ai;
 
                 dmsg(D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=0x%04x phase=%d rrs=%d sig=%d status=%d",
                      flags,
@@ -1870,6 +2484,7 @@ link_socket_init_phase1(struct link_socket *sock,
                         const char *local_port,
                         const char *remote_host,
                         const char *remote_port,
+                        const char *remote_service,
                         struct cached_dns_entry *dns_cache,
                         int proto,
                         sa_family_t af,
@@ -1902,6 +2517,7 @@ link_socket_init_phase1(struct link_socket *sock,
     sock->local_port = local_port;
     sock->remote_host = remote_host;
     sock->remote_port = remote_port;
+    sock->remote_service = remote_service;
     sock->dns_cache = dns_cache;
     sock->http_proxy = http_proxy;
     sock->socks_proxy = socks_proxy;
@@ -1950,10 +2566,12 @@ link_socket_init_phase1(struct link_socket *sock,
         /* the proxy server */
         sock->remote_host = http_proxy->options.server;
         sock->remote_port = http_proxy->options.port;
+        sock->remote_service = NULL;
 
         /* the OpenVPN server we will use the proxy to connect to */
         sock->proxy_dest_host = remote_host;
         sock->proxy_dest_port = remote_port;
+        sock->proxy_dest_service = remote_service;
     }
     /* or in Socks proxy mode? */
     else if (sock->socks_proxy)
@@ -1963,15 +2581,18 @@ link_socket_init_phase1(struct link_socket *sock,
         /* the proxy server */
         sock->remote_host = socks_proxy->server;
         sock->remote_port = socks_proxy->port;
+        sock->remote_service = NULL;
 
         /* the OpenVPN server we will use the proxy to connect to */
         sock->proxy_dest_host = remote_host;
         sock->proxy_dest_port = remote_port;
+        sock->proxy_dest_service = remote_service;
     }
     else
     {
         sock->remote_host = remote_host;
         sock->remote_port = remote_port;
+        sock->remote_service = remote_service;
     }
 
     /* bind behavior for TCP server vs. client */
@@ -2176,6 +2797,7 @@ phase2_tcp_client(struct link_socket *sock, struct signal_info *sig_info)
 
         if (sock->http_proxy)
         {
+            /* TODO: loop over DNS SRV resolved host:port */
             proxy_retry = establish_http_proxy_passthru(sock->http_proxy,
                                                         sock->sd,
                                                         sock->proxy_dest_host,
@@ -2186,6 +2808,7 @@ phase2_tcp_client(struct link_socket *sock, struct signal_info *sig_info)
         }
         else if (sock->socks_proxy)
         {
+            /* TODO: loop over DNS SRV resolved host:port */
             establish_socks_proxy_passthru(sock->socks_proxy,
                                            sock->sd,
                                            sock->proxy_dest_host,
@@ -2228,11 +2851,13 @@ phase2_socks_client(struct link_socket *sock, struct signal_info *sig_info)
 
     sock->remote_host = sock->proxy_dest_host;
     sock->remote_port = sock->proxy_dest_port;
+    sock->remote_service = sock->proxy_dest_service;
 
     addr_zero_host(&sock->info.lsa->actual.dest);
     if (sock->info.lsa->remote_list)
     {
-        freeaddrinfo(sock->info.lsa->remote_list);
+        freeservinfo(sock->info.lsa->remote_list);
+        sock->info.lsa->current_service = NULL;
         sock->info.lsa->current_remote = NULL;
         sock->info.lsa->remote_list = NULL;
     }
@@ -2506,22 +3131,28 @@ link_socket_bad_incoming_addr(struct buffer *buf,
                               const struct link_socket_actual *from_addr)
 {
     struct gc_arena gc = gc_new();
+    struct servinfo *si;
     struct addrinfo *ai;
 
     switch (from_addr->dest.addr.sa.sa_family)
     {
         case AF_INET:
         case AF_INET6:
+            si = info->lsa->remote_list;
+            ai = si->ai;
             msg(D_LINK_ERRORS,
                 "TCP/UDP: Incoming packet rejected from %s[%d], expected peer address: %s (allow this incoming source address/port by removing --remote or adding --float)",
                 print_link_socket_actual(from_addr, &gc),
                 (int)from_addr->dest.addr.sa.sa_family,
-                print_sockaddr_ex(info->lsa->remote_list->ai_addr,":",PS_SHOW_PORT, &gc));
+                print_sockaddr_ex(ai->ai_addr,":",PS_SHOW_PORT, &gc));
             /* print additional remote addresses */
-            for (ai = info->lsa->remote_list->ai_next; ai; ai = ai->ai_next)
+            for (ai = ai->ai_next; si; si = si->next)
             {
-                msg(D_LINK_ERRORS,"or from peer address: %s",
-                    print_sockaddr_ex(ai->ai_addr,":",PS_SHOW_PORT, &gc));
+                for (; ai; ai = ai->ai_next)
+                {
+                    msg(D_LINK_ERRORS,"or from peer address: %s",
+                        print_sockaddr_ex(ai->ai_addr,":",PS_SHOW_PORT, &gc));
+                }
             }
             break;
     }
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 7aeae527..a7b5e87e 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -40,6 +40,11 @@
  */
 #define OPENVPN_PORT "1194"
 
+/*
+ * OpenVPN's default service name for DNS SRV discovery.
+ */
+#define OPENVPN_SERVICE "openvpn"
+
 /*
  * Number of seconds that "resolv-retry infinite"
  * represents.
@@ -71,13 +76,26 @@ struct openvpn_sockaddr
     } addr;
 };
 
+/* struct to hold resolved service records */
+struct servinfo
+{
+    const char *hostname;
+    const char *servname;
+    int order;
+    unsigned short prio;
+    unsigned short weight;
+    struct addrinfo *ai;
+    struct servinfo *next;
+};
+
 /* struct to hold preresolved host names */
 struct cached_dns_entry {
     const char *hostname;
     const char *servname;
+    const char *service;
     int ai_family;
     int flags;
-    struct addrinfo *ai;
+    struct servinfo *si;
     struct cached_dns_entry *next;
 };
 
@@ -103,7 +121,9 @@ struct link_socket_actual
 struct link_socket_addr
 {
     struct addrinfo *bind_local;
-    struct addrinfo *remote_list; /* complete remote list */
+    struct servinfo *remote_list; /* complete remote list */
+    struct servinfo *current_service; /* service used in the
+                                       * current connection attempt */
     struct addrinfo *current_remote; /* remote used in the
                                       * current connection attempt */
     struct link_socket_actual actual; /* reply to this address */
@@ -183,6 +203,7 @@ struct link_socket
 
     const char *remote_host;
     const char *remote_port;
+    const char *remote_service;
     const char *local_host;
     const char *local_port;
     struct cached_dns_entry *dns_cache;
@@ -229,6 +250,7 @@ struct link_socket
     /* The OpenVPN server we will use the proxy to connect to */
     const char *proxy_dest_host;
     const char *proxy_dest_port;
+    const char *proxy_dest_service;
 
     /* Pointer to the server-poll to trigger the timeout in function which have
      * their own loop instead of using the main oop */
@@ -305,6 +327,7 @@ link_socket_init_phase1(struct link_socket *sock,
                         const char *local_port,
                         const char *remote_host,
                         const char *remote_port,
+                        const char *remote_service,
                         struct cached_dns_entry *dns_cache,
                         int proto,
                         sa_family_t af,
@@ -532,6 +555,7 @@ bool unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, int *uid, int *g
 #define GETADDR_RANDOMIZE             (1<<9)
 #define GETADDR_PASSIVE               (1<<10)
 #define GETADDR_DATAGRAM              (1<<11)
+#define GETADDR_DISCOVERY             (1<<12)
 
 #define GETADDR_CACHE_MASK              (GETADDR_DATAGRAM|GETADDR_PASSIVE)
 
@@ -561,6 +585,29 @@ int openvpn_getaddrinfo(unsigned int flags,
                         int ai_family,
                         struct addrinfo **res);
 
+int openvpn_getservinfo(unsigned int flags,
+                        const char *hostname,
+                        const char *servname,
+                        const char *service,
+                        int resolve_retry_seconds,
+                        volatile int *signal_received,
+                        int ai_family,
+                        struct servinfo **res);
+
+void freeservinfo(struct servinfo *res);
+
+inline static void
+gc_freeaddrinfo_callback(void *addr)
+{
+    freeaddrinfo((struct addrinfo *) addr);
+}
+
+inline static void
+gc_freeservinfo_callback(void *addr)
+{
+    freeservinfo((struct servinfo *) addr);
+}
+
 /*
  * Transport protocol naming and other details.
  */
@@ -745,6 +792,20 @@ addrlist_match(const struct openvpn_sockaddr *a1, const struct addrinfo *addrlis
     return false;
 }
 
+static inline bool
+servlist_match(const struct openvpn_sockaddr *a1, const struct servinfo *servlist)
+{
+    const struct servinfo *curele;
+    for (curele = servlist; curele; curele = curele->next)
+    {
+        if (curele->ai && addrlist_match(a1, curele->ai))
+        {
+            return true;
+        }
+    }
+    return false;
+}
+
 static inline in_addr_t
 addr_host(const struct openvpn_sockaddr *addr)
 {
@@ -794,7 +855,19 @@ addrlist_port_match(const struct openvpn_sockaddr *a1, const struct addrinfo *a2
     return false;
 }
 
-
+static inline bool
+servlist_port_match(const struct openvpn_sockaddr *a1, const struct servinfo *a2)
+{
+    const struct servinfo *curele;
+    for (curele = a2; curele; curele = curele->next)
+    {
+        if (curele->ai && addrlist_port_match(a1, curele->ai))
+        {
+            return true;
+        }
+    }
+    return false;
+}
 
 static inline bool
 addr_port_match(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)
@@ -834,6 +907,16 @@ addrlist_match_proto(const struct openvpn_sockaddr *a1,
            : addrlist_port_match(a1, addr_list);
 }
 
+static inline bool
+servlist_match_proto(const struct openvpn_sockaddr *a1,
+                     struct servinfo *serv_list,
+                     const int proto)
+{
+    return link_socket_proto_connection_oriented(proto)
+           ? servlist_match(a1, serv_list)
+           : servlist_port_match(a1, serv_list);
+}
+
 static inline void
 addr_zero_host(struct openvpn_sockaddr *addr)
 {
@@ -952,7 +1035,7 @@ link_socket_verify_incoming_addr(struct buffer *buf,
                 {
                     return true;
                 }
-                if (addrlist_match_proto(&from_addr->dest, info->lsa->remote_list, info->proto))
+                if (servlist_match_proto(&from_addr->dest, info->lsa->remote_list, info->proto))
                 {
                     return true;
                 }
@@ -997,7 +1080,7 @@ link_socket_set_outgoing_addr(struct link_socket_info *info,
         &&
         /* address undef or address == remote or --float */
         (info->remote_float
-         || (!lsa->remote_list || addrlist_match_proto(&act->dest, lsa->remote_list, info->proto))
+         || (!lsa->remote_list || servlist_match_proto(&act->dest, lsa->remote_list, info->proto))
         )
         )
     {
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
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 923131ad..c4072133 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -680,7 +680,7 @@ init_tun(const char *dev,        /* --dev option */
          int ifconfig_ipv6_netbits_parm,
          const char *ifconfig_ipv6_remote_parm,     /* --ifconfig parm 2 IPv6 */
          struct addrinfo *local_public,
-         struct addrinfo *remote_public,
+         struct servinfo *remote_public,
          const bool strict_warn,
          struct env_set *es,
          openvpn_net_ctx_t *ctx)
@@ -752,15 +752,18 @@ init_tun(const char *dev,        /* --dev option */
                 }
             }
 
-            for (curele = remote_public; curele; curele = curele->ai_next)
+            for (struct servinfo *si = remote_public; si; si = si->next)
             {
-                if (curele->ai_family == AF_INET)
+                for (curele = si->ai; curele; curele = curele->ai_next)
                 {
-                    check_addr_clash("remote",
-                                     tt->type,
-                                     ((struct sockaddr_in *)curele->ai_addr)->sin_addr.s_addr,
-                                     tt->local,
-                                     tt->remote_netmask);
+                    if (curele->ai_family == AF_INET)
+                    {
+                        check_addr_clash("remote",
+                                         tt->type,
+                                         ((struct sockaddr_in *)curele->ai_addr)->sin_addr.s_addr,
+                                         tt->local,
+                                         tt->remote_netmask);
+                    }
                 }
             }
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 99826cf7..b969dbc1 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -38,6 +38,7 @@
 #include "event.h"
 #include "proto.h"
 #include "misc.h"
+#include "socket.h"
 #include "networking.h"
 #include "ring_buffer.h"
 
@@ -275,7 +276,7 @@ struct tuntap *init_tun(const char *dev,        /* --dev option */
                         int ifconfig_ipv6_netbits_parm,            /* --ifconfig parm 1 / bits */
                         const char *ifconfig_ipv6_remote_parm,     /* --ifconfig parm 2 / IPv6 */
                         struct addrinfo *local_public,
-                        struct addrinfo *remote_public,
+                        struct servinfo *remote_public,
                         const bool strict_warn,
                         struct env_set *es,
                         openvpn_net_ctx_t *ctx);
-- 
2.17.1


