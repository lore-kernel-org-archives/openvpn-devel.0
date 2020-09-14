From: Vladislav Grishenko <themiron@...2010...>
Date: Mon, 14 Sep 2020 22:11:34 +0500
Message-Id: <20200914171134.27490-1-themiron@...2010...>
In-Reply-To: <20200914010402.22715-1-themiron@...2010...>
References: <20200914010402.22715-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH v4] Add DNS SRV remote host discovery support
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

DNS SRV remote host discovery allows to have multiple OpenVPN servers for
a single domain w/o explicit profile enumeration, to move services from
host to host with little fuss, and to designate hosts as primary servers
for a service and others as backups.
Feature has been asked several times already, useful in case of huge
number of clients & servers deployed.

Patch introduces "--remote-srv domain [service] [proto]" option.
The "service" and "proto" arguments are optional. Client will try
to resolve DNS SRV record "_service._proto.domain" and use returned
DNS SRV records as remote server list ordered by server selection
mechanism defined in RFC2782 (https://tools.ietf.org/html/rfc2782):

    A client MUST attempt to contact the target host with the
    lowest-numbered priority field value it can reach, target hosts
    with the same priority SHOULD be tried in an order defined by the
    weight field.
    The weight field specifies a relative weight for entries with the
    same priority. Larger weights SHOULD be given a proportionately
    higher probability of being selected.
    Domain administrators SHOULD use Weight 0 when there isn't any
    server selection to do. In the presence of records containing
    weights greater than 0, records with Weight 0 SHOULD have a very
    small chance of being selected.

Note: OpenVPN server selection mechanism implementation indeed will
give records with weight of zero a very small chance of being selected
first, but never skip them.

Example: instead of multiple --remote in order:
    remote server1.example.net 1194 udp
    remote server2.example.net 1194 udp
    remote server3.example.net 1194 udp
    remote server4.example.net 443 tcp

now it's possible to specify just one --remote-srv:
    remote-srv example.net

and configure following DNS SRV records:
    name                             prio weight port target
    _openvpn._udp.example.net IN SRV 10   60     1194 server1.example.net
    _openvpn._udp.example.net IN SRV 10   40     1194 server2.example.net
    _openvpn._udp.example.net IN SRV 10   0      1194 server3.example.net
    _openvpn._tcp.example.net IN SRV 20   0       443 server4.example.net

For "--remote-srv example.net" following will happen in order:
1. The client will first try to resolve "_openvpn._udp.example.net"
   and "_openvpn._tcp.example.net".
2. Records "server1.example.net:1194", "server2.example.net:1194"
   and "server3.example.net:1194" will be selected before record
   "server4.example.net:443" as their priority 10 is smaller than 20.
3. Records "server1.example.net:1194", "server2.example.net:1194"
   and "server3.example.net:1194" will be randomly selected with
   weight probability: first will be either "server1.example.net:1194"
   with 60% probability or "server2.example.net:1194" with 40% or
   "server3.example.net:1194" with almost zero probability.
4. If "server1.example.net:1194" was selected, the second record will
   be either "server2.example.net:1194" with almost 100% probability
   or "server3.example.net:1194" with almost 0%.
5. If "server2.example.net:1194" was selected, the third record will
   be the only last record of priority 10 - "server3.example.net:1194".
6. Record "server4.example.net:443" will be the last one selected as
   the only record with priority 20.
7. Each of the resulting "target:port" remote hosts will be resolved
   and accessed if its protocol has no conflict with the rest of the
   OpenVPN options.

  If DNS SRV name can't be resolved or no valid records were returned,
  client will move on to the next connection entry.

Tested on Linux/Glibc & Windows 10.

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

v3: complete logic rewrite
    use separate --remote-srv [service] [proto] option
    remove fallback, same is achieved with additiona --remote/--remote-srv
    add "auto" protocol support to allow both udp & tcp hosts be discovered
    add support for tcp / http proxy (natively)
    man update

v4: due RFC 2782 ambiguity, prefer to use all resolved DNS SRV records, even
    ones with weight 0 after the records containing weights greater than 0
    were all selected, keep related code disabled for historical reasons.
    man update

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 configure.ac                        |   2 +-
 doc/man-sections/client-options.rst | 117 +++-
 doc/management-notes.txt            |   6 +
 src/openvpn/Makefile.am             |   2 +-
 src/openvpn/buffer.h                |   5 -
 src/openvpn/errlevel.h              |   1 +
 src/openvpn/init.c                  |  57 +-
 src/openvpn/openvpn.vcxproj         |   8 +-
 src/openvpn/options.c               | 238 ++++++--
 src/openvpn/options.h               |   4 +
 src/openvpn/socket.c                | 855 +++++++++++++++++++++++++++-
 src/openvpn/socket.h                |  56 +-
 src/openvpn/syshead.h               |   5 +
 13 files changed, 1279 insertions(+), 77 deletions(-)

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
index af21fbcd..ca2f27a5 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -307,10 +307,117 @@ configuration.
   specification (4/6 suffix), OpenVPN will try both IPv4 and IPv6
   addresses, in the order getaddrinfo() returns them.
 
+--remote-srv args
+  Remote DNS SRV domain, service name and protocol.
+
+  Valid syntaxes:
+  ::
+
+     remote-srv domain
+     remote-srv domain service
+     remote-srv domain service proto
+
+  The ``service`` and ``proto`` arguments are optional. Client will try
+  to resolve DNS SRV record ``_service._proto.domain`` and use returned
+  DNS SRV records as remote server list ordered by server selection
+  mechanism defined in `RFC 2782 <https://tools.ietf.org/html/rfc2782>`_:
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
+    weights greater than 0, records with Weight 0 SHOULD have a very
+    small chance of being selected.
+
+  *Note:*
+    OpenVPN server selection mechanism implementation indeed will give
+    records with weight of zero a very small chance of being selected
+    first, but never skip them.
+
+  The ``service`` argument indicates the symbolic name of the desired
+  service. By default it is :code:`openvpn` registered service name.
+
+  The ``proto`` argument indicates the symbolic name of the desired
+  protocol and the protocol to use when connecting with the remote, and
+  may either be :code:`tcp`, :code:`udp` or special value :code:`auto`
+  used by default to try both. In this case all the discovered remote
+  hosts will be ordered by server selection mechanism regardless their
+  protocol. To enforce IPv4 or IPv6 connections add a :code:`4` or
+  :code:`6` suffix; like :code:`udp4` / :code:`udp6` / :code:`tcp4` /
+  :code:`tcp6` / :code:`auto4` / :code:`auto6`.
+
+  On the client, multiple ``--remote-srv`` options may be specified for
+  redundancy, each referring to a different DNS SRV record name, in the
+  order specified by the list of ``--remote-srv`` options. Specifying
+  multiple ``--remote-srv`` options for this purpose is a special case
+  of the more general connection-profile feature. See the
+  ``<connection>`` documentation below.
+
+  The client will move on to the next DNS SRV record in the ordered list,
+  in the event of connection failure. Note that at any given time, the
+  OpenVPN client will at most be connected to one server.
+
+  If partucular DNS SRV record next resolves to multiple IP addresses,
+  OpenVPN will try them in the order that the system getaddrinfo()
+  presents them, so priorization and DNS randomization is done by the
+  system library. Unless an IP version is forced by the protocol
+  specification (4/6 suffix), OpenVPN will try both IPv4 and IPv6
+  addresses, in the order getaddrinfo() returns them.
+
+  Examples:
+  ::
+
+     remote-srv example.net
+     remote-srv example.net openvpn
+     remote-srv example.net openvpn tcp
+
+  Example of DNS SRV records:
+  ::
+
+     name                             prio weight port target
+     _openvpn._udp.example.net IN SRV 10   60     1194 server1.example.net
+     _openvpn._udp.example.net IN SRV 10   40     1194 server2.example.net
+     _openvpn._udp.example.net IN SRV 10   0      1194 server3.example.net
+     _openvpn._tcp.example.net IN SRV 20   0       443 server4.example.net
+
+  For ``--remote-srv example.net`` following will happen in order:
+  
+  1. The client will first try to resolve ``_openvpn._udp.example.net``
+     and ``_openvpn._tcp.example.net``.
+  2. Records ``server1.example.net:1194``, ``server2.example.net:1194``
+     and ``server3.example.net:1194`` will be selected before record
+     ``server4.example.net:443`` as their priority 10 is smaller than 20.
+  3. Records ``server1.example.net:1194``, ``server2.example.net:1194``
+     and ``server3.example.net:1194`` will be randomly selected with
+     weight probability: first will be either ``server1.example.net:1194``
+     with 60% probability or ``server2.example.net:1194`` with 40% or
+     ``server3.example.net:1194`` with almost zero probability.
+  4. If ``server1.example.net:1194`` was selected, the second record will
+     be either ``server2.example.net:1194`` with almost 100% probability
+     or ``server3.example.net:1194`` with almost 0%.
+  5. If ``server2.example.net:1194`` was selected, the third record will
+     be the only last record of priority 10 - ``server3.example.net:1194``.
+  6. Record ``server4.example.net:443`` will be the last one selected as
+     the only record with priority 20.
+  7. Each of the resulting ```target:port`` remote hosts will be resolved
+     and accessed if its protocol has no conflict with the rest of the
+     OpenVPN options.
+
+  If DNS SRV name can't be resolved or no valid records were returned,
+  client will move on to the next connection entry.
+
+  For more information on DNS SRV see https://tools.ietf.org/html/rfc2782
+
 --remote-random
-  When multiple ``--remote`` address/ports are specified, or if connection
-  profiles are being used, initially randomize the order of the list as a
-  kind of basic load-balancing measure.
+  When multiple ``--remote`` address/ports or ``--remote-srv`` records are
+  specified, or if connection profiles are being used, initially randomize
+  the order of the list as a kind of basic load-balancing measure.
 
 --remote-random-hostname
   Prepend a random string (6 bytes, 12 hex characters) to hostname to
@@ -318,8 +425,8 @@ configuration.
   "<random-chars>.foo.bar.gov".
 
 --resolv-retry n
-  If hostname resolve fails for ``--remote``, retry resolve for ``n``
-  seconds before failing.
+  If hostname resolve fails for ``--remote`` or ``--remote-srv``, retry
+  resolve for ``n`` seconds before failing.
 
   Set ``n`` to "infinite" to retry indefinitely.
 
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 61daaf07..d06a4782 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -851,6 +851,12 @@ the above notification, use this command:
 
   remote MOD vpn.otherexample.com 1234
 
+DNS SRV discovery domain and service name with protocol code:`auto`
+can't be overriden, but either acceted or skipped only.
+Example of such notification:
+
+  >REMOTE:example.com,openvpn,auto
+
 To accept the same host and port as the client would ordinarily
 have connected to, use this command:
 
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
index a785934a..16980e8a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -352,7 +352,12 @@ management_callback_remote_cmd(void *arg, const char **p)
         }
         else if (!strcmp(p[1], "MOD") && p[2] && p[3])
         {
-            if (strlen(p[2]) < RH_HOST_LEN && strlen(p[3]) < RH_PORT_LEN)
+            if (ce->remote_srv && ce->proto == PROTO_AUTO)
+            {
+                /* can't mutate --remote-srv into --remote without protocol  */
+                ret = false;
+            }
+            else if (strlen(p[2]) < RH_HOST_LEN && strlen(p[3]) < RH_PORT_LEN)
             {
                 struct remote_host_store *rhs = c->options.rh_store;
                 if (!rhs)
@@ -365,6 +370,7 @@ management_callback_remote_cmd(void *arg, const char **p)
 
                 ce->remote = rhs->host;
                 ce->remote_port = rhs->port;
+                ce->remote_srv = false;
                 flags = CE_MAN_QUERY_REMOTE_MOD;
                 ret = true;
             }
@@ -456,10 +462,16 @@ init_connection_list(struct context *c)
 static void
 clear_remote_addrlist(struct link_socket_addr *lsa, bool free)
 {
-    if (lsa->remote_list && free)
+    if (lsa->service_list && free)
+    {
+        freeservinfo(lsa->service_list);
+    }
+    else if (lsa->remote_list && free)
     {
         freeaddrinfo(lsa->remote_list);
     }
+    lsa->service_list = NULL;
+    lsa->current_service = NULL;
     lsa->remote_list = NULL;
     lsa->current_remote = NULL;
 }
@@ -492,8 +504,29 @@ next_connection_entry(struct context *c)
                 c->c1.link_socket_addr.current_remote =
                     c->c1.link_socket_addr.current_remote->ai_next;
             }
+            /* Check if there is another resolved service to try for
+             * the current connection */
+            else if (c->c1.link_socket_addr.current_service
+                && c->c1.link_socket_addr.current_service->next)
+            {
+                c->c1.link_socket_addr.current_service =
+                    c->c1.link_socket_addr.current_service->next;
+                c->c1.link_socket_addr.remote_list =
+                    c->c1.link_socket_addr.current_service->ai;
+                c->c1.link_socket_addr.current_remote =
+                    c->c1.link_socket_addr.remote_list;
+            }
             else
             {
+                /* All services iterated w/o close_instance, so clear
+                 * the addrinfo objects here */
+                if (c->c1.link_socket_addr.service_list)
+                {
+                    ASSERT(!c->options.persist_remote_ip);
+                    clear_remote_addrlist(&c->c1.link_socket_addr,
+                                          !c->options.resolve_in_advance);
+                }
+
                 /* FIXME (schwabe) fix the persist-remote-ip option for real,
                  * this is broken probably ever since connection lists and multiple
                  * remote existed
@@ -538,8 +571,14 @@ next_connection_entry(struct context *c)
         }
 
         c->options.ce = *ce;
+        if (ce_defined && c->c1.link_socket_addr.current_service)
+        {
+            /* map in current service */
+            struct servinfo *si = c->c1.link_socket_addr.current_service;
+            ce_defined = options_mutate_ce_servinfo(&c->options, si);
+        }
 #ifdef ENABLE_MANAGEMENT
-        if (ce_defined && management && management_query_remote_enabled(management))
+        else if (ce_defined && management && management_query_remote_enabled(management))
         {
             /* allow management interface to override connection entry details */
             ce_defined = ce_management_query_remote(c);
@@ -3636,6 +3675,7 @@ do_close_link_socket(struct context *c)
                ||
                ( c->sig->source != SIG_SOURCE_HARD
                  && ((c->c1.link_socket_addr.current_remote && c->c1.link_socket_addr.current_remote->ai_next)
+                     || (c->c1.link_socket_addr.current_service && c->c1.link_socket_addr.current_service->next)
                      || c->options.no_advance))
                )))
     {
@@ -4171,6 +4211,17 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
     /* map in current connection entry */
     next_connection_entry(c);
 
+    /* map in current remote service */
+    if (c->options.ce.remote_srv)
+    {
+        do_resolve_service(c);
+        if (IS_SIG(c))
+        {
+             goto sig;
+        }
+        update_options_ce_post(&c->options);
+    }
+
     /* link_socket_mode allows CM_CHILD_TCP
      * instances to inherit acceptable fds
      * from a top-level parent */
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 3863854b..1f317fb0 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -92,7 +92,7 @@
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;dnsapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
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
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;dnsapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
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
index 8bf82c57..552b7235 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -121,6 +121,7 @@ static const char usage_message[] =
     "Tunnel Options:\n"
     "--local host    : Local host name or ip address. Implies --bind.\n"
     "--remote host [port] : Remote host name or ip address.\n"
+    "--remote-srv domain [service] : Perform DNS SRV remote host discovery.\n"
     "--remote-random : If multiple --remote options specified, choose one randomly.\n"
     "--remote-random-hostname : Add a random string to remote DNS name.\n"
     "--mode m        : Major mode, m = 'p2p' (default, point-to-point) or 'server'.\n"
@@ -1446,6 +1447,7 @@ show_connection_entry(const struct connection_entry *o)
     SHOW_STR(local_port);
     SHOW_STR(remote);
     SHOW_STR(remote_port);
+    SHOW_BOOL(remote_srv);
     SHOW_BOOL(remote_float);
     SHOW_BOOL(bind_defined);
     SHOW_BOOL(bind_local);
@@ -1980,6 +1982,58 @@ connection_entry_load_re(struct connection_entry *ce, const struct remote_entry
     {
         ce->af = re->af;
     }
+    ce->remote_srv = re->remote_srv;
+}
+
+static bool
+options_postprocess_verify_ce_proto(const struct options *options, const struct connection_entry *ce)
+{
+    int level = M_WARN|M_NOPREFIX|M_OPTERR;
+
+    /*
+     * Sanity check on --local, --remote, and --ifconfig
+     */
+
+    if (proto_is_net(ce->proto)
+        && string_defined_equal(ce->local, ce->remote)
+        && string_defined_equal(ce->local_port, ce->remote_port))
+    {
+        msg(level, "--remote and --local addresses are the same");
+        return false;
+    }
+
+    if (string_defined_equal(ce->remote, options->ifconfig_local)
+        || string_defined_equal(ce->remote, options->ifconfig_remote_netmask))
+    {
+        msg(level, "--local and --remote addresses must be distinct from --ifconfig addresses");
+        return false;
+    }
+
+    /*
+     * Check that protocol options make sense.
+     */
+
+#ifdef ENABLE_FRAGMENT
+    if (!proto_is_udp(ce->proto) && ce->fragment)
+    {
+        msg(level, "--fragment can only be used with --proto udp");
+        return false;
+    }
+#endif
+
+    if (!proto_is_udp(ce->proto) && ce->explicit_exit_notification)
+    {
+        msg(level, "--explicit-exit-notify can only be used with --proto udp");
+        return false;
+    }
+
+    if ((ce->http_proxy_options) && ce->proto != PROTO_TCP_CLIENT)
+    {
+        msg(level, "--http-proxy MUST be used in TCP Client mode (i.e. --proto tcp-client)");
+        return false;
+    }
+
+    return true;
 }
 
 static void
@@ -2014,6 +2068,11 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_USAGE, "--proto tcp is ambiguous in this context.  Please specify --proto tcp-server or --proto tcp-client");
     }
 
+    if (ce->proto == PROTO_AUTO && !ce->remote_srv)
+    {
+        msg(M_USAGE, "--proto auto can be only used with --remote-srv");
+    }
+
     /*
      * Sanity check on daemon/inetd modes
      */
@@ -2023,9 +2082,9 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_USAGE, "only one of --daemon or --inetd may be specified");
     }
 
-    if (options->inetd && (ce->local || ce->remote))
+    if (options->inetd && (ce->local || ce->remote || ce->remote_srv))
     {
-        msg(M_USAGE, "--local or --remote cannot be used with --inetd");
+        msg(M_USAGE, "--local or --remote or --remote_srv cannot be used with --inetd");
     }
 
     if (options->inetd && ce->proto == PROTO_TCP_CLIENT)
@@ -2070,7 +2129,8 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
 
     if (!proto_is_udp(ce->proto) && options->mtu_test)
     {
-        msg(M_USAGE, "--mtu-test only makes sense with --proto udp");
+        int level = (ce->proto == PROTO_AUTO) ? M_WARN|M_NOPREFIX|M_OPTERR : M_USAGE;
+        msg(level, "--mtu-test only makes sense with --proto udp");
     }
 
     /* will we be pulling options from server? */
@@ -2082,6 +2142,11 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
      * Sanity check on --local, --remote, and --ifconfig
      */
 
+    if (ce->remote_srv && options->ip_remote_hint)
+    {
+        msg(M_USAGE, "--remote-srv and --ip_remote_hint can't be used together");
+    }
+
     if (proto_is_net(ce->proto)
         && string_defined_equal(ce->local, ce->remote)
         && string_defined_equal(ce->local_port, ce->remote_port))
@@ -2200,13 +2265,15 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
 #ifdef ENABLE_FRAGMENT
     if (!proto_is_udp(ce->proto) && ce->fragment)
     {
-        msg(M_USAGE, "--fragment can only be used with --proto udp");
+        int level = (ce->proto == PROTO_AUTO) ? M_WARN|M_NOPREFIX|M_OPTERR : M_USAGE;
+        msg(level, "--fragment can only be used with --proto udp");
     }
 #endif
 
     if (!proto_is_udp(ce->proto) && ce->explicit_exit_notification)
     {
-        msg(M_USAGE, "--explicit-exit-notify can only be used with --proto udp");
+        int level = (ce->proto == PROTO_AUTO) ? M_WARN|M_NOPREFIX|M_OPTERR : M_USAGE;
+        msg(level, "--explicit-exit-notify can only be used with --proto udp");
     }
 
     if (!ce->remote && ce->proto == PROTO_TCP_CLIENT)
@@ -2216,8 +2283,10 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
 
     if ((ce->http_proxy_options) && ce->proto != PROTO_TCP_CLIENT)
     {
-        msg(M_USAGE, "--http-proxy MUST be used in TCP Client mode (i.e. --proto tcp-client)");
+        int level = (ce->proto == PROTO_AUTO) ? M_WARN|M_NOPREFIX|M_OPTERR : M_USAGE;
+        msg(level, "--http-proxy MUST be used in TCP Client mode (i.e. --proto tcp-client)");
     }
+
     if ((ce->http_proxy_options) && !ce->http_proxy_options->server)
     {
         msg(M_USAGE, "--http-proxy not specified but other http proxy options present");
@@ -2279,6 +2348,10 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         {
             msg(M_USAGE, "--remote cannot be used with --mode server");
         }
+        if (ce->remote_srv)
+        {
+            msg(M_USAGE, "--remote-srv cannot be used with --mode server");
+        }
         if (!ce->bind_local)
         {
             msg(M_USAGE, "--nobind cannot be used with --mode server");
@@ -2793,6 +2866,53 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
     uninit_options(&defaults);
 }
 
+static bool
+options_postprocess_mutate_ce_proto(struct options *o, struct connection_entry *ce)
+{
+    bool result = true;
+
+    if (ce->proto == PROTO_TCP_CLIENT && !ce->local && !ce->local_port_defined && !ce->bind_defined)
+    {
+        ce->bind_local = false;
+    }
+
+    if (ce->proto == PROTO_UDP && ce->socks_proxy_server && !ce->local && !ce->local_port_defined && !ce->bind_defined)
+    {
+        ce->bind_local = false;
+    }
+
+    if (!ce->bind_local)
+    {
+        ce->local_port = NULL;
+    }
+
+    /* if protocol forcing is enabled, disable all protocols except for the forced one */
+    if (o->proto_force >= 0 && o->proto_force != ce->proto && ce->proto != PROTO_AUTO)
+    {
+        result = false;
+    }
+
+    /* our socks code is not fully IPv6 enabled yet (TCP works, UDP not)
+     * so fall back to IPv4-only (trac #1221)
+     */
+    if (ce->socks_proxy_server && proto_is_udp(ce->proto) && ce->af != AF_INET)
+    {
+        if (ce->af == AF_INET6)
+        {
+            msg(M_INFO, "WARNING: '--proto udp6' is not compatible with "
+                "'--socks-proxy' today.  Forcing IPv4 mode." );
+        }
+        else
+        {
+            msg(M_INFO, "NOTICE: dual-stack mode for '--proto udp' does not "
+                "work correctly with '--socks-proxy' today.  Forcing IPv4." );
+        }
+        ce->af = AF_INET;
+    }
+
+    return result;
+}
+
 static void
 options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
 {
@@ -2816,23 +2936,7 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
     }
 #endif
 
-    if (ce->proto == PROTO_TCP_CLIENT && !ce->local && !ce->local_port_defined && !ce->bind_defined)
-    {
-        ce->bind_local = false;
-    }
-
-    if (ce->proto == PROTO_UDP && ce->socks_proxy_server && !ce->local && !ce->local_port_defined && !ce->bind_defined)
-    {
-        ce->bind_local = false;
-    }
-
-    if (!ce->bind_local)
-    {
-        ce->local_port = NULL;
-    }
-
-    /* if protocol forcing is enabled, disable all protocols except for the forced one */
-    if (o->proto_force >= 0 && o->proto_force != ce->proto)
+    if (!options_postprocess_mutate_ce_proto(o, ce))
     {
         ce->flags |= CE_DISABLED;
     }
@@ -2853,24 +2957,6 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
 #endif
     }
 
-    /* our socks code is not fully IPv6 enabled yet (TCP works, UDP not)
-     * so fall back to IPv4-only (trac #1221)
-     */
-    if (ce->socks_proxy_server && proto_is_udp(ce->proto) && ce->af != AF_INET)
-    {
-        if (ce->af == AF_INET6)
-        {
-            msg(M_INFO, "WARNING: '--proto udp6' is not compatible with "
-                "'--socks-proxy' today.  Forcing IPv4 mode." );
-        }
-        else
-        {
-            msg(M_INFO, "NOTICE: dual-stack mode for '--proto udp' does not "
-                "work correctly with '--socks-proxy' today.  Forcing IPv4." );
-        }
-        ce->af = AF_INET;
-    }
-
     /*
      * Set MTU defaults
      */
@@ -2938,6 +3024,32 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
     }
 }
 
+/*
+ * Merges servinfo's hostname, servname and proto into current connection
+ * entry if possible and doesn't conflict with the options.
+ * Used by runtime DNS SRV discovery.
+ */
+bool
+options_mutate_ce_servinfo(struct options *o, struct servinfo *si)
+{
+    struct connection_entry ce = o->ce;
+
+    ASSERT(ce.remote_srv);
+
+    ce.remote = si->hostname;
+    ce.remote_port = si->servname;
+    ce.proto = si->proto;
+
+    if (options_postprocess_mutate_ce_proto(o, &ce)
+        && options_postprocess_verify_ce_proto(o, &ce))
+    {
+        o->ce = ce;
+        return true;
+    }
+
+    return false;
+}
+
 #ifdef _WIN32
 /* If iservice is in use, we need def1 method for redirect-gateway */
 static void
@@ -5675,6 +5787,7 @@ add_option(struct options *options,
     {
         struct remote_entry re;
         re.remote = re.remote_port = NULL;
+        re.remote_srv = false;
         re.proto = -1;
         re.af = 0;
 
@@ -5710,6 +5823,47 @@ add_option(struct options *options,
             connection_entry_load_re(&options->ce, &re);
         }
     }
+    else if (streq(p[0], "remote-srv") && p[1] && !p[4])
+    {
+        struct remote_entry re;
+        re.remote = NULL;
+        re.remote_port = OPENVPN_SERVICE;
+        re.remote_srv = true;
+        re.proto = PROTO_AUTO;
+        re.af = 0;
+
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        re.remote = p[1];
+        if (p[2])
+        {
+            re.remote_port = p[2];
+            if (p[3])
+            {
+                const int proto = ascii2proto(p[3]);
+                const sa_family_t af = ascii2af(p[3]);
+                if (proto < 0)
+                {
+                    msg(msglevel, "remote-srv: bad protocol associated with host %s: '%s'", p[1], p[3]);
+                    goto err;
+                }
+                re.proto = proto;
+                re.af = af;
+            }
+        }
+        if (permission_mask & OPT_P_GENERAL)
+        {
+            struct remote_entry *e = alloc_remote_entry(options, msglevel);
+            if (!e)
+            {
+                goto err;
+            }
+            *e = re;
+        }
+        else if (permission_mask & OPT_P_CONNECTION)
+        {
+            connection_entry_load_re(&options->ce, &re);
+        }
+    }
     else if (streq(p[0], "resolv-retry") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
@@ -6222,7 +6376,7 @@ add_option(struct options *options,
         int proto_force;
         VERIFY_PERMISSION(OPT_P_GENERAL);
         proto_force = ascii2proto(p[1]);
-        if (proto_force < 0)
+        if (proto_force < 0 || proto_force == PROTO_AUTO)
         {
             msg(msglevel, "Bad --proto-force protocol: '%s'", p[1]);
             goto err;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 877e9396..cf22ffea 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -92,6 +92,7 @@ struct connection_entry
     const char *remote_port;
     const char *local;
     const char *remote;
+    bool remote_srv;
     bool remote_float;
     bool bind_defined;
     bool bind_ipv6_only;
@@ -152,6 +153,7 @@ struct remote_entry
     const char *remote_port;
     int proto;
     sa_family_t af;
+    bool remote_srv;
 };
 
 #define CONNECTION_LIST_SIZE 64
@@ -787,6 +789,8 @@ char *options_string_extract_option(const char *options_string,
 
 void options_postprocess(struct options *options);
 
+bool options_mutate_ce_servinfo(struct options *o, struct servinfo *si);
+
 void pre_pull_save(struct options *o);
 
 void pre_pull_restore(struct options *o, struct gc_arena *gc);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 76bdbfc5..b718ed02 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -260,22 +260,37 @@ get_cached_dns_entry(struct cached_dns_entry *dns_cache,
                      const char *servname,
                      int ai_family,
                      int resolve_flags,
-                     struct addrinfo **ai)
+                     struct addrinfo **ai,
+                     struct servinfo **si)
 {
     struct cached_dns_entry *ph;
     int flags;
 
     /* Only use flags that are relevant for the structure */
-    flags = resolve_flags & GETADDR_CACHE_MASK;
+    if (si)
+    {
+        flags = resolve_flags & GETADDR_CACHE_SERVICE_MASK;
+    }
+    else
+    {
+        flags = resolve_flags & GETADDR_CACHE_MASK;
+    }
 
     for (ph = dns_cache; ph; ph = ph->next)
     {
         if (streqnull(ph->hostname, hostname)
             && streqnull(ph->servname, servname)
-            && ph->ai_family == ai_family
+            && (si || ph->ai_family == ai_family)
             && ph->flags == flags)
         {
-            *ai = ph->ai;
+            if (si)
+            {
+                *si = ph->si;
+            }
+            else if (ai)
+            {
+                *ai = ph->ai;
+            }
             return 0;
         }
     }
@@ -298,7 +313,7 @@ do_preresolve_host(struct context *c,
                              servname,
                              af,
                              flags,
-                             &ai) == 0)
+                             &ai, NULL) == 0)
     {
         /* entry already cached, return success */
         return 0;
@@ -337,6 +352,76 @@ do_preresolve_host(struct context *c,
     return status;
 }
 
+static int
+do_preresolve_service(struct context *c,
+                      const char *hostname,
+                      const char *servname,
+                      const int af,
+                      const int flags,
+                      bool preresolve_host)
+{
+    struct servinfo *si;
+    int status;
+
+    if (get_cached_dns_entry(c->c1.dns_cache,
+                             hostname,
+                             servname,
+                             af,
+                             flags,
+                             NULL, &si) == 0)
+    {
+        /* entry already cached, return success */
+        return 0;
+    }
+
+    status = openvpn_getservinfo(flags, hostname, servname,
+                                 c->options.resolve_retry_seconds, NULL,
+                                 af, &si);
+    if (status == 0)
+    {
+        struct cached_dns_entry *ph;
+
+        ALLOC_OBJ_CLEAR_GC(ph, struct cached_dns_entry, &c->gc);
+        ph->si = si;
+        ph->hostname = hostname;
+        ph->servname = servname;
+        ph->flags = flags & GETADDR_CACHE_SERVICE_MASK;
+
+        if (!c->c1.dns_cache)
+        {
+            c->c1.dns_cache = ph;
+        }
+        else
+        {
+            struct cached_dns_entry *prev = c->c1.dns_cache;
+            while (prev->next)
+            {
+                prev = prev->next;
+            }
+            prev->next = ph;
+        }
+
+        gc_addspecial(si, &gc_freeservinfo_callback, &c->gc);
+
+        /* preresolve service targets unless disabled */
+        if (preresolve_host)
+        {
+            while (si)
+            {
+                int host_flags = flags & ~GETADDR_PROTO_MASK;
+                if (proto_is_dgram(si->proto))
+                {
+                    host_flags |= GETADDR_DATAGRAM;
+                }
+                /* ignore errors */
+                do_preresolve_host(c, si->hostname, si->servname, af, host_flags);
+                si = si->next;
+            }
+        }
+    }
+    return status;
+}
+
 void
 do_preresolve(struct context *c)
 {
@@ -375,8 +460,30 @@ do_preresolve(struct context *c)
             remote = ce->remote;
         }
 
+        /* Preresolve remote services */
+        if (ce->remote_srv)
+        {
+            int service_flags = flags|GETADDR_SERVICE;
+
+            if (proto_is_dgram(ce->proto) || ce->proto == PROTO_AUTO)
+            {
+                service_flags |= GETADDR_DATAGRAM;
+            }
+            if (proto_is_stream(ce->proto) || ce->proto == PROTO_AUTO)
+            {
+                service_flags |= GETADDR_STREAM;
+            }
+
+            /* HTTP remote hostnames does not need to be resolved */
+            status = do_preresolve_service(c, remote, ce->remote_port, ce->af,
+                                           service_flags, !ce->http_proxy_options);
+            if (status != 0)
+            {
+                goto err;
+            }
+        }
         /* HTTP remote hostname does not need to be resolved */
-        if (!ce->http_proxy_options)
+        else if (!ce->http_proxy_options)
         {
             status = do_preresolve_host(c, remote, ce->remote_port, ce->af, flags);
             if (status != 0)
@@ -432,6 +539,603 @@ err:
     throw_signal_soft(SIGHUP, "Preresolving failed");
 }
 
+/*
+ * Allocates new service structure on heap and stores
+ * its initial host, port and proto values.
+ */
+static struct servinfo *
+alloc_servinfo(const char *hostname, uint16_t port, int proto)
+{
+    size_t namesize = hostname ? strlen(hostname) + 1 : 0;
+
+    char servname[sizeof("65535")];
+    openvpn_snprintf(servname, sizeof(servname), "%u", port);
+    size_t servsize = strlen(servname) + 1;
+
+    struct servinfo *si = calloc(1, sizeof(*si) + namesize + servsize);
+    if (si)
+    {
+        if (hostname)
+        {
+            si->hostname = (char *)(si + 1);
+            memcpy((char *)si->hostname, hostname, namesize);
+        }
+        si->servname = (char *)(si + 1) + namesize;
+        memcpy((char *)si->servname, servname, servsize);
+        si->proto = proto;
+    }
+    return si;
+}
+
+#ifdef _WIN32
+/*
+ * Queries DNS SRV records for specified DNS domain.
+ * Returns EAI_* status and service list on success in order of receive.
+ */
+static int
+query_servinfo_win32(const char *domain, int proto, struct servinfo *next,
+                     struct servinfo **res)
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
+    struct servinfo *list = NULL, *first = NULL;
+    for (PDNS_RECORD rr = pDnsRecord; rr; rr = rr->pNext)
+    {
+        if (rr->wType == DNS_TYPE_SRV)
+        {
+            PDNS_SRV_DATA rdata = &rr->Data.Srv;
+
+            if (rr->wDataLength >= sizeof(DNS_SRV_DATA) && *rdata->pNameTarget)
+            {
+                struct servinfo *si = alloc_servinfo(rdata->pNameTarget, rdata->wPort, proto);
+                if (!si)
+                {
+                    freeservinfo(list);
+                    status = EAI_MEMORY;
+                    goto done;
+                }
+                si->prio = rdata->wPriority;
+                si->weight = rdata->wWeight;
+                si->next = list, list = si;
+                if (!first)
+                {
+                    first = si;
+                }
+            }
+        }
+    }
+    if (list)
+    {
+        first->next = next;
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
+query_servinfo(const char *domain, int proto, struct servinfo *next,
+               struct servinfo **res)
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
+    struct servinfo *list = NULL, *first = NULL;
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
+                struct servinfo *si = alloc_servinfo(name, ns_get16(rdata + 4), proto);
+                if (!si)
+                {
+                    freeservinfo(list);
+                    status = EAI_MEMORY;
+                    goto done;
+                }
+                si->prio = ns_get16(rdata);
+                si->weight = ns_get16(rdata + 2);
+                si->next = list, list = si;
+                if (!first)
+                {
+                    first = si;
+                }
+            }
+        }
+    }
+    if (list)
+    {
+        first->next = next;
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
+    return ae->order > be->order ? -1 : 1;
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
+    /* count and number entries in reverse order */
+    for (struct servinfo *si = list; si; si = si->next)
+    {
+        si->order = count++;
+    }
+
+    struct servinfo **sorted;
+    ALLOC_ARRAY_CLEAR_GC(sorted, struct servinfo *, count, &gc);
+    for (struct servinfo *si = list; si; si = si->next)
+    {
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
+                    /*
+                     * RFC 2782 is ambiguous, it says:
+                     *   In the presence of records containing weights greater
+                     *   than 0, records with weight 0 should have a very
+                     *   small chance of being selected.
+                     * According that, within the same priority, after all
+                     * records containing weights greater than 0 were selected,
+                     * the rest of records with weight 0 should be skipped.
+                     * At the same time, it says:
+                     *   The following algorithm SHOULD be used to order the
+                     *   SRV RRs of the same priority:
+                     *   ...
+                     *   Continue the ordering process until there are no
+                     *   unordered SRV RRs.
+                     * This means records with wight 0 should always be
+                     * selected, as last ones in worst case.
+                     */
+#if 0
+                    /*
+                     * Skip all the not selected previously records with weight
+                     * 0 after the last one with weight greater than 0.
+                     */
+                    if (unordered.weight == 0 && si->weight)
+                    {
+                        freeservinfo(unordered.next);
+                        unordered.next = NULL;
+                    }
+                    break;
+#endif
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
+ * Resolves DNS SRV records for specified domain and service.
+ * Returns EAI_* status (like getaddrinfo) and service list, ordered
+ * according server selection mechanism, defined in RFC 2782.
+ */
+static int
+getservinfo(const char *domain,
+            const char *service,
+            int flags,
+            struct servinfo **res)
+{
+    static const struct {
+        int flags;
+        int proto;
+        const char *name;
+    } proto[] = {
+        { GETADDR_DATAGRAM, PROTO_UDP, "udp" },
+        { GETADDR_STREAM, PROTO_TCP_CLIENT, "tcp" }
+    };
+    struct servinfo *list = NULL;
+    int status = EAI_SOCKTYPE;
+
+    ASSERT(res);
+
+    if (!domain)
+    {
+        return EAI_NONAME;
+    }
+    if (!service)
+    {
+        return EAI_SERVICE;
+    }
+
+    int proto_flags = flags & GETADDR_PROTO_MASK;
+    for (int i = 0; i < SIZE(proto); i++)
+    {
+        if (proto_flags & proto[i].flags)
+        {
+            proto_flags &= ~proto[i].flags;
+
+            char qname[256];
+            if (!openvpn_snprintf(qname, sizeof(qname), "_%s._%s.%s",
+                                  service, proto[i].name, domain))
+            {
+                freeservinfo(list);
+                return EAI_MEMORY;
+            }
+
+#ifdef _WIN32
+            status = query_servinfo_win32(qname, proto[i].proto, list, &list);
+#else
+            status = query_servinfo(qname, proto[i].proto, list, &list);
+#endif
+        }
+    }
+
+    if (list)
+    {
+        *res = sort_servinfo(list);
+        status = 0;
+    }
+
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
+ * Translate IPv4/IPv6 hostname and service name into struct servinfo
+ * If resolve error, try again for resolve_retry_seconds seconds.
+ */
+int
+openvpn_getservinfo(unsigned int flags,
+                    const char *hostname,
+                    const char *servname,
+                    int resolve_retry_seconds,
+                    volatile int *signal_received,
+                    int family,
+                    struct servinfo **res)
+{
+    int status;
+    int sigrec = 0;
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
+    if (hostname)
+    {
+        print_hostname = hostname;
+    }
+    else
+    {
+        print_hostname = "undefined";
+    }
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
+    if ((flags & (GETADDR_FATAL_ON_SIGNAL|GETADDR_WARN_ON_SIGNAL))
+        && !signal_received)
+    {
+        signal_received = &sigrec;
+    }
+
+    const int fail_wait_interval = 5; /* seconds */
+    /* Add +4 to cause integer division rounding up (1 + 4) = 5, (0+4)/5=0 */
+    int resolve_retries = (flags & GETADDR_TRY_ONCE) ? 1 :
+                          ((resolve_retry_seconds + 4)/ fail_wait_interval);
+    const char *fmt;
+    int level = 0;
+
+    fmt = "RESOLVE: Cannot resolve service: %s:%s (%s)";
+    if ((flags & GETADDR_MENTION_RESOLVE_RETRY)
+        && !resolve_retry_seconds)
+    {
+        fmt = "RESOLVE: Cannot resolve service: %s:%s (%s) (I would have retried this name query if you had specified the --resolv-retry option.)";
+    }
+
+#ifdef ENABLE_MANAGEMENT
+    if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
+    {
+        if (management)
+        {
+            management_set_state(management,
+                                 OPENVPN_STATE_RESOLVE,
+                                 NULL,
+                                 NULL,
+                                 NULL,
+                                 NULL,
+                                 NULL);
+        }
+    }
+#endif
+
+    /*
+     * Resolve service
+     */
+    while (true)
+    {
+        dmsg(D_SOCKET_DEBUG, "GETSERVINFO flags=0x%04x family=%d host=%s service=%s",
+             flags, family, print_hostname, print_servname);
+        status = getservinfo(hostname, servname, flags, res);
+
+        if (signal_received)
+        {
+            get_signal(signal_received);
+            if (*signal_received) /* were we interrupted by a signal? */
+            {
+                if (*signal_received == SIGUSR1) /* ignore SIGUSR1 */
+                {
+                    msg(level, "RESOLVE: Ignored SIGUSR1 signal received during DNS resolution attempt");
+                    *signal_received = 0;
+                }
+                else
+                {
+                    /* turn success into failure (interrupted syscall) */
+                    if (0 == status)
+                    {
+                        ASSERT(res);
+                        freeservinfo(*res);
+                        *res = NULL;
+                        status = EAI_AGAIN; /* = temporary failure */
+                        errno = EINTR;
+                    }
+                    goto done;
+                }
+            }
+        }
+
+        /* success? */
+        if (0 == status)
+        {
+            break;
+        }
+
+        /* resolve lookup failed, should we
+         * continue or fail? */
+        level = msglevel;
+        if (resolve_retries > 0)
+        {
+            level = D_RESOLVE_ERRORS;
+        }
+
+        msg(level,
+            fmt,
+            print_hostname,
+            print_servname,
+            gai_strerror(status));
+
+        if (--resolve_retries <= 0)
+        {
+            goto done;
+        }
+
+        management_sleep(fail_wait_interval);
+
+#ifndef _WIN32
+        /* resolve failed, force resolv.conf reload */
+        res_init();
+#endif
+    }
+
+    ASSERT(res);
+
+    /* service resolve succeeded */
+
+done:
+    if (signal_received && *signal_received)
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
 /*
  * Translate IPv4/IPv6 addr or hostname into struct addrinfo
  * If resolve error, try again for resolve_retry_seconds seconds.
@@ -557,13 +1261,10 @@ openvpn_getaddrinfo(unsigned int flags,
          */
         while (true)
         {
-#ifndef _WIN32
-            res_init();
-#endif
             /* try hostname lookup */
             hints.ai_flags &= ~AI_NUMERICHOST;
-            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d",
-                 flags, hints.ai_family, hints.ai_socktype);
+            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d hostname=%s servname=%s",
+                 flags, hints.ai_family, hints.ai_socktype, print_hostname, print_servname);
             status = getaddrinfo(hostname, servname, &hints, res);
 
             if (signal_received)
@@ -618,6 +1319,11 @@ openvpn_getaddrinfo(unsigned int flags,
             }
 
             management_sleep(fail_wait_interval);
+
+#ifndef _WIN32
+            /* resolve failed, force resolv.conf reload */
+            res_init();
+#endif
         }
 
         ASSERT(res);
@@ -1707,7 +2413,7 @@ resolve_bind_local(struct link_socket *sock, const sa_family_t af)
                                       sock->local_port,
                                       af,
                                       flags,
-                                      &sock->info.lsa->bind_local);
+                                      &sock->info.lsa->bind_local, NULL);
 
         if (status)
         {
@@ -1790,7 +2496,7 @@ resolve_remote(struct link_socket *sock,
                                           sock->remote_host,
                                           sock->remote_port,
                                           sock->info.af,
-                                          flags, &ai);
+                                          flags, &ai, NULL);
             if (status)
             {
                 status = openvpn_getaddrinfo(flags, sock->remote_host, sock->remote_port,
@@ -1801,6 +2507,10 @@ resolve_remote(struct link_socket *sock,
             {
                 sock->info.lsa->remote_list = ai;
                 sock->info.lsa->current_remote = ai;
+                if (sock->info.lsa->current_service)
+                {
+                    sock->info.lsa->current_service->ai = ai;
+                }
 
                 dmsg(D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=0x%04x phase=%d rrs=%d sig=%d status=%d",
                      flags,
@@ -1851,7 +2561,107 @@ done:
     gc_free(&gc);
 }
 
+void
+do_resolve_service(struct context *c)
+{
+    struct connection_entry *ce = &c->options.ce;
+
+    if (ce->remote_srv
+        && !c->c1.link_socket_addr.service_list)
+    {
+        if (ce->remote)
+        {
+            unsigned int flags = sf2gaf(GETADDR_RESOLVE|
+                                        GETADDR_UPDATE_MANAGEMENT_STATE|
+                                        GETADDR_SERVICE,
+                                        c->options.sockflags);
+            int retry = 0;
+            int status = -1;
+            struct servinfo *si;
+
+            if (proto_is_dgram(ce->proto) || ce->proto == PROTO_AUTO)
+            {
+                flags |= GETADDR_DATAGRAM;
+            }
+            if (proto_is_stream(ce->proto) || ce->proto == PROTO_AUTO)
+            {
+                flags |= GETADDR_STREAM;
+            }
+
+            if (c->options.sockflags & SF_HOST_RANDOMIZE)
+            {
+                flags |= GETADDR_RANDOMIZE;
+            }
+
+            if (c->options.resolve_retry_seconds == RESOLV_RETRY_INFINITE)
+            {
+                flags |= (GETADDR_TRY_ONCE | GETADDR_FATAL);
+                retry = 0;
+            }
+            else if (c->options.resolve_retry_seconds)
+            {
+                flags |= GETADDR_FATAL;
+                retry = c->options.resolve_retry_seconds;
+            }
+            else
+            {
+                flags |= (GETADDR_FATAL | GETADDR_MENTION_RESOLVE_RETRY);
+                retry = 0;
+            }
+
+            status = get_cached_dns_entry(c->c1.dns_cache,
+                                          ce->remote,
+                                          ce->remote_port,
+                                          ce->af,
+                                          flags, NULL, &si);
+            if (status)
+            {
+                status = openvpn_getservinfo(flags, ce->remote, ce->remote_port,
+                                             retry, &c->sig->signal_received, ce->af, &si);
+            }
+
+            if (status == 0)
+            {
+                c->c1.link_socket_addr.service_list = si;
+                c->c1.link_socket_addr.current_service = NULL;
+
+                /* advance to the first appropriate service */
+                while (si)
+                {
+                    /* map in current service */
+                    if (!c->c1.link_socket_addr.current_service
+                        && options_mutate_ce_servinfo(&c->options, si))
+                    {
+                        c->c1.link_socket_addr.current_service = si;
+                    }
+
+                    /* log discovered service hosts */
+                    msg(D_RESOLVE_INFO, "DNS SRV remote host: %s:%s,%s prio %u weight %u",
+                        np(si->hostname), np(si->servname),
+                        proto2ascii(si->proto, ce->af, false),
+                        si->prio, si->weight);
+
+                    si = si->next;
+                }
+                if (!c->c1.link_socket_addr.current_service)
+                {
+                    status = EAI_NODATA;
+                }
 
+                dmsg(D_SOCKET_DEBUG, "RESOLVE_SERVICE flags=0x%04x rrs=%d sig=%d status=%d",
+                     flags,
+                     retry,
+                     c->sig->signal_received,
+                     status);
+            }
+
+            if (!c->sig->signal_received && status != 0)
+            {
+                c->sig->signal_received = SIGUSR1;
+            }
+        }
+    }
+}
 
 struct link_socket *
 link_socket_new(void)
@@ -3161,16 +3971,19 @@ static const struct proto_names proto_names[] = {
     {"tcp-server", "TCP_SERVER", AF_UNSPEC, PROTO_TCP_SERVER},
     {"tcp-client", "TCP_CLIENT", AF_UNSPEC, PROTO_TCP_CLIENT},
     {"tcp",        "TCP", AF_UNSPEC, PROTO_TCP},
+    {"auto",       "AUTO", AF_UNSPEC, PROTO_AUTO},
     /* force IPv4 */
     {"udp4",       "UDPv4", AF_INET, PROTO_UDP},
     {"tcp4-server","TCPv4_SERVER", AF_INET, PROTO_TCP_SERVER},
     {"tcp4-client","TCPv4_CLIENT", AF_INET, PROTO_TCP_CLIENT},
     {"tcp4",       "TCPv4", AF_INET, PROTO_TCP},
+    {"auto4",      "AUTOv4", AF_INET, PROTO_AUTO},
     /* force IPv6 */
     {"udp6","UDPv6", AF_INET6, PROTO_UDP},
     {"tcp6-server","TCPv6_SERVER", AF_INET6, PROTO_TCP_SERVER},
     {"tcp6-client","TCPv6_CLIENT", AF_INET6, PROTO_TCP_CLIENT},
-    {"tcp6","TCPv6", AF_INET6, PROTO_TCP},
+    {"tcp6",       "TCPv6", AF_INET6, PROTO_TCP},
+    {"auto6",      "AUTOv6", AF_INET6, PROTO_AUTO},
 };
 
 bool
@@ -3180,14 +3993,21 @@ proto_is_net(int proto)
     {
         ASSERT(0);
     }
-    return proto != PROTO_NONE;
+    return proto != PROTO_NONE && proto != PROTO_AUTO;
 }
+
 bool
 proto_is_dgram(int proto)
 {
     return proto_is_udp(proto);
 }
 
+bool
+proto_is_stream(int proto)
+{
+    return proto_is_tcp(proto);
+}
+
 bool
 proto_is_udp(int proto)
 {
@@ -3266,6 +4086,11 @@ proto2ascii_all(struct gc_arena *gc)
 
     for (i = 0; i < SIZE(proto_names); ++i)
     {
+        if (proto_names[i].proto == PROTO_NONE
+            || proto_names[i].proto == PROTO_AUTO)
+        {
+            continue;
+        }
         if (i)
         {
             buf_printf(&out, " ");
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 7aeae527..8a267581 100644
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
@@ -71,13 +76,29 @@ struct openvpn_sockaddr
     } addr;
 };
 
+/* struct to hold resolved service targets */
+struct servinfo
+{
+    const char *hostname;
+    const char *servname;
+    int proto;
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
     int ai_family;
     int flags;
-    struct addrinfo *ai;
+    union {
+        struct addrinfo *ai;
+        struct servinfo *si;
+    };
     struct cached_dns_entry *next;
 };
 
@@ -106,6 +127,9 @@ struct link_socket_addr
     struct addrinfo *remote_list; /* complete remote list */
     struct addrinfo *current_remote; /* remote used in the
                                       * current connection attempt */
+    struct servinfo *service_list; /* complete service list */
+    struct servinfo *current_service; /* service used in the
+                                       * current connection attempt */
     struct link_socket_actual actual; /* reply to this address */
 };
 
@@ -338,6 +362,8 @@ void link_socket_init_phase2(struct link_socket *sock,
 
 void do_preresolve(struct context *c);
 
+void do_resolve_service(struct context *c);
+
 void socket_adjust_frame_parameters(struct frame *frame, int proto);
 
 void frame_adjust_path_mtu(struct frame *frame, int pmtu, int proto);
@@ -486,6 +512,7 @@ socket_descriptor_t socket_do_accept(socket_descriptor_t sd,
 bool proto_is_net(int proto);
 
 bool proto_is_dgram(int proto);
+bool proto_is_stream(int proto);
 
 bool proto_is_udp(int proto);
 
@@ -532,8 +559,12 @@ bool unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, int *uid, int *g
 #define GETADDR_RANDOMIZE             (1<<9)
 #define GETADDR_PASSIVE               (1<<10)
 #define GETADDR_DATAGRAM              (1<<11)
+#define GETADDR_STREAM                (1<<12)
+#define GETADDR_SERVICE               (1<<13)
 
+#define GETADDR_PROTO_MASK              (GETADDR_DATAGRAM|GETADDR_STREAM)
 #define GETADDR_CACHE_MASK              (GETADDR_DATAGRAM|GETADDR_PASSIVE)
+#define GETADDR_CACHE_SERVICE_MASK      (GETADDR_PROTO_MASK|GETADDR_SERVICE)
 
 /**
  * Translate an IPv4 addr or hostname from string form to in_addr_t
@@ -561,6 +592,28 @@ int openvpn_getaddrinfo(unsigned int flags,
                         int ai_family,
                         struct addrinfo **res);
 
+int openvpn_getservinfo(unsigned int flags,
+                        const char *hostname,
+                        const char *servname,
+                        int resolve_retry_seconds,
+                        volatile int *signal_received,
+                        int family,
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
@@ -575,6 +628,7 @@ enum proto_num {
     PROTO_TCP,
     PROTO_TCP_SERVER,
     PROTO_TCP_CLIENT,
+    PROTO_AUTO,
     PROTO_N
 };
 
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


