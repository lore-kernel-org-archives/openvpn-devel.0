From: Antonio Quartulli <a@...2181...>
Date: Wed, 11 Aug 2021 11:58:53 +0200
Message-Id: <20210811095853.27870-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove support for PF (Packet Filter)
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

OpenVPN shipped a small packet filtering tool called PF. It has never
been straightforward as it required a plugin to work. On top of that,
keeping PF support, makes the code more complicated and increases the
maintenance cost of OpenVPN.

PF itself is not actually maintained at all and there is little
motivation in keeping it alive.

Some years ago an IPv6 extension for PF was proposed, but it was never
picked up for the reasons above.

External (and more appropriate) tools can still be used to implement
packet filtering on the OpenVPN interface.

Drop PF support for good.

Note that IDs used for external communication (i.e. to the plugin
or management interface) have been commented out, but not removed, as
they should not be used in the future.

Cc: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

@Arne: can you please double check the change in plugin.c to make sure
the logic was properly adapted? Thanks!

Note: the code was first pruned with:

unifdef -m -UMANAGEMENT_PF -UPLUGIN_PF -UENABLE_PF *.c *.h

and then cleaned up manually by removing all remaining bits.


 configure.ac                         |   8 -
 doc/man-sections/generic-options.rst |   4 -
 include/openvpn-plugin.h.in          |  91 +---
 sample/sample-plugins/defer/simple.c | 150 +----
 src/openvpn/Makefile.am              |   1 -
 src/openvpn/errlevel.h               |   4 -
 src/openvpn/forward.c                |   8 -
 src/openvpn/init.c                   |   9 -
 src/openvpn/manage.c                 |  53 --
 src/openvpn/manage.h                 |  18 +-
 src/openvpn/mroute.c                 |  70 ---
 src/openvpn/mroute.h                 |   6 +-
 src/openvpn/multi.c                  | 137 -----
 src/openvpn/openvpn.h                |   4 -
 src/openvpn/openvpn.vcxproj          |   2 -
 src/openvpn/openvpn.vcxproj.filters  |   6 -
 src/openvpn/options.c                |  11 -
 src/openvpn/pf.c                     | 787 ---------------------------
 src/openvpn/pf.h                     | 147 -----
 src/openvpn/plugin.c                 |  11 +-
 src/openvpn/ssl_common.h             |   3 -
 src/openvpn/ssl_verify.c             |  16 -
 src/openvpn/ssl_verify.h             |  28 -
 src/openvpn/syshead.h                |  13 -
 24 files changed, 8 insertions(+), 1579 deletions(-)
 delete mode 100644 src/openvpn/pf.c
 delete mode 100644 src/openvpn/pf.h

diff --git a/configure.ac b/configure.ac
index 640ab6fa..56b536dc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -149,13 +149,6 @@ AC_ARG_ENABLE(
 	[enable_iproute2="no"]
 )
 
-AC_ARG_ENABLE(
-	[pf],
-	[AS_HELP_STRING([--disable-pf], [disable internal packet filter @<:@default=yes@:>@])],
-	,
-	[enable_pf="yes"]
-)
-
 AC_ARG_ENABLE(
 	[plugin-auth-pam],
 	[AS_HELP_STRING([--disable-plugin-auth-pam], [disable auth-pam plugin @<:@default=platform specific@:>@])],
@@ -1146,7 +1139,6 @@ test "${enable_debug}" = "yes" && AC_DEFINE([ENABLE_DEBUG], [1], [Enable debuggi
 test "${enable_small}" = "yes" && AC_DEFINE([ENABLE_SMALL], [1], [Enable smaller executable size])
 test "${enable_fragment}" = "yes" && AC_DEFINE([ENABLE_FRAGMENT], [1], [Enable internal fragmentation support])
 test "${enable_port_share}" = "yes" && AC_DEFINE([ENABLE_PORT_SHARE], [1], [Enable TCP Server port sharing])
-test "${enable_pf}" = "yes" && AC_DEFINE([ENABLE_PF], [1], [Enable internal packet filter])
 test "${enable_strict_options}" = "yes" && AC_DEFINE([ENABLE_STRICT_OPTIONS_CHECK], [1], [Enable strict options check between peers])
 
 test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index 203e35f5..db39f6e2 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -418,10 +418,6 @@ which mode OpenVPN is configured as.
     success/failure via :code:`auth_control_file` when using deferred auth
     method and pending authentification via :code:`pending_auth_file`.
 
-
-  * :code:`OPENVPN_PLUGIN_ENABLE_PF` plugin hook to pass filtering rules
-    via ``pf_file``
-
 --use-prediction-resistance
   Enable prediction resistance on mbed TLS's RNG.
 
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index abbfd9c2..d040f72b 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -71,7 +71,6 @@ extern "C" {
  * New Client Connection:
  *
  * FUNC: openvpn_plugin_client_constructor_v1
- * FUNC: openvpn_plugin_func_v1 OPENVPN_PLUGIN_ENABLE_PF
  * FUNC: openvpn_plugin_func_v1 OPENVPN_PLUGIN_TLS_VERIFY (called once for every cert
  *                                                     in the server chain)
  * FUNC: openvpn_plugin_func_v1 OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
@@ -88,8 +87,6 @@ extern "C" {
  *
  * For each "TLS soft reset", according to reneg-sec option (or similar):
  *
- * FUNC: openvpn_plugin_func_v1 OPENVPN_PLUGIN_ENABLE_PF
- *
  * FUNC: openvpn_plugin_func_v1 OPENVPN_PLUGIN_TLS_VERIFY (called once for every cert
  *                                                     in the server chain)
  * FUNC: openvpn_plugin_func_v1 OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
@@ -127,7 +124,7 @@ extern "C" {
 #define OPENVPN_PLUGIN_LEARN_ADDRESS             8
 #define OPENVPN_PLUGIN_CLIENT_CONNECT_V2         9
 #define OPENVPN_PLUGIN_TLS_FINAL                10
-#define OPENVPN_PLUGIN_ENABLE_PF                11
+//#define OPENVPN_PLUGIN_ENABLE_PF                11 *NOT IMPLEMENTED*
 #define OPENVPN_PLUGIN_ROUTE_PREDOWN            12
 #define OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER     13
 #define OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2  14
@@ -587,49 +584,8 @@ OPENVPN_PLUGIN_DEF openvpn_plugin_handle_t OPENVPN_PLUGIN_FUNC(openvpn_plugin_op
  *
  * OpenVPN will delete the auth_control_file after it goes out of scope.
  *
- * If an OPENVPN_PLUGIN_ENABLE_PF handler is defined and returns success
- * for a particular client instance, packet filtering will be enabled for that
- * instance.  OpenVPN will then attempt to read the packet filter configuration
- * from the temporary file named by the environmental variable pf_file.  This
- * file may be generated asynchronously and may be dynamically updated during the
- * client session, however the client will be blocked from sending or receiving
- * VPN tunnel packets until the packet filter file has been generated.  OpenVPN
- * will periodically test the packet filter file over the life of the client
- * instance and reload when modified.  OpenVPN will delete the packet filter file
- * when the client instance goes out of scope.
- *
- * Packet filter file grammar:
- *
- * [CLIENTS DROP|ACCEPT]
- * {+|-}common_name1
- * {+|-}common_name2
- * . . .
- * [SUBNETS DROP|ACCEPT]
- * {+|-}subnet1
- * {+|-}subnet2
- * . . .
- * [END]
- *
- * Subnet: IP-ADDRESS | IP-ADDRESS/NUM_NETWORK_BITS
- *
- * CLIENTS refers to the set of clients (by their common-name) which
- * this instance is allowed ('+') to connect to, or is excluded ('-')
- * from connecting to.  Note that in the case of client-to-client
- * connections, such communication must be allowed by the packet filter
- * configuration files of both clients.
- *
- * SUBNETS refers to IP addresses or IP address subnets which this
- * instance may connect to ('+') or is excluded ('-') from connecting
- * to.
- *
- * DROP or ACCEPT defines default policy when there is no explicit match
- * for a common-name or subnet.  The [END] tag must exist.  A special
- * purpose tag called [KILL] will immediately kill the client instance.
- * A given client or subnet rule applies to both incoming and outgoing
- * packets.
- *
  * See plugin/defer/simple.c for an example on using asynchronous
- * authentication and client-specific packet filtering.
+ * authentication.
  */
 OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v2)
     (openvpn_plugin_handle_t handle,
@@ -703,49 +659,8 @@ OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_open_v3)
  *
  * OpenVPN will delete the auth_control_file after it goes out of scope.
  *
- * If an OPENVPN_PLUGIN_ENABLE_PF handler is defined and returns success
- * for a particular client instance, packet filtering will be enabled for that
- * instance.  OpenVPN will then attempt to read the packet filter configuration
- * from the temporary file named by the environmental variable pf_file.  This
- * file may be generated asynchronously and may be dynamically updated during the
- * client session, however the client will be blocked from sending or receiving
- * VPN tunnel packets until the packet filter file has been generated.  OpenVPN
- * will periodically test the packet filter file over the life of the client
- * instance and reload when modified.  OpenVPN will delete the packet filter file
- * when the client instance goes out of scope.
- *
- * Packet filter file grammar:
- *
- * [CLIENTS DROP|ACCEPT]
- * {+|-}common_name1
- * {+|-}common_name2
- * . . .
- * [SUBNETS DROP|ACCEPT]
- * {+|-}subnet1
- * {+|-}subnet2
- * . . .
- * [END]
- *
- * Subnet: IP-ADDRESS | IP-ADDRESS/NUM_NETWORK_BITS
- *
- * CLIENTS refers to the set of clients (by their common-name) which
- * this instance is allowed ('+') to connect to, or is excluded ('-')
- * from connecting to.  Note that in the case of client-to-client
- * connections, such communication must be allowed by the packet filter
- * configuration files of both clients.
- *
- * SUBNETS refers to IP addresses or IP address subnets which this
- * instance may connect to ('+') or is excluded ('-') from connecting
- * to.
- *
- * DROP or ACCEPT defines default policy when there is no explicit match
- * for a common-name or subnet.  The [END] tag must exist.  A special
- * purpose tag called [KILL] will immediately kill the client instance.
- * A given client or subnet rule applies to both incoming and outgoing
- * packets.
- *
  * See sample/sample-plugins/defer/simple.c for an example on using
- * asynchronous authentication and client-specific packet filtering.
+ * asynchronous authentication.
  */
 OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v3)
     (const int version,
diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
index ba2e03eb..e824a24e 100644
--- a/sample/sample-plugins/defer/simple.c
+++ b/sample/sample-plugins/defer/simple.c
@@ -207,12 +207,6 @@ openvpn_plugin_open_v3(const int v3structver,
         |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_LEARN_ADDRESS)
         |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_FINAL);
 
-    /* ENABLE_PF should only be called if we're actually willing to do PF */
-    if (context->test_packet_filter)
-    {
-        ret->type_mask |= OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ENABLE_PF);
-    }
-
     ret->handle = (openvpn_plugin_handle_t *) context;
     plugin_log(PLOG_NOTE, MODULE, "initialization succeeded");
     return OPENVPN_PLUGIN_FUNC_SUCCESS;
@@ -314,134 +308,6 @@ auth_user_pass_verify(struct plugin_context *context,
     exit(0);
 }
 
-static int
-tls_final(struct plugin_context *context, struct plugin_per_client_context *pcc, const char *argv[], const char *envp[])
-{
-    if (!context->test_packet_filter)   /* no PF testing, nothing to do */
-    {
-        return OPENVPN_PLUGIN_FUNC_SUCCESS;
-    }
-
-    if (pcc->generated_pf_file)         /* we already have created a file */
-    {
-        return OPENVPN_PLUGIN_FUNC_ERROR;
-    }
-
-    const char *pff = get_env("pf_file", envp);
-    const char *cn = get_env("username", envp);
-    if (!pff || !cn)                    /* required vars missing */
-    {
-        return OPENVPN_PLUGIN_FUNC_ERROR;
-    }
-
-    pcc->generated_pf_file = true;
-
-    /* the PF API is, basically
-     *  - OpenVPN sends a filename (pf_file) to the plugin
-     *  - OpenVPN main loop will check every second if that file shows up
-     *  - when it does, it will be read & used for the pf config
-     * the pre-created file needs to be removed in ...ENABLE_PF
-     * to make deferred PF setup work
-     *
-     * the regular PF hook does not know the client username or CN, so
-     * this is deferred to the TLS_FINAL hook which knows these things
-     */
-
-    /* do the double fork dance (see above for more verbose comments)
-     */
-    pid_t p1 = fork();
-    if (p1 < 0)                 /* Fork failed */
-    {
-        return OPENVPN_PLUGIN_FUNC_ERROR;
-    }
-    if (p1 > 0)                 /* parent process */
-    {
-        waitpid(p1, NULL, 0);
-        return OPENVPN_PLUGIN_FUNC_SUCCESS;     /* no _DEFERRED here! */
-    }
-
-    /* first gen child process, fork() again and exit() right away */
-    pid_t p2 = fork();
-    if (p2 < 0)
-    {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: fork(2) failed");
-        exit(1);
-    }
-
-    if (p2 != 0)                            /* new parent: exit right away */
-    {
-        exit(0);
-    }
-
-    /* (grand-)child process
-     *  - never call "return" now (would mess up openvpn)
-     *  - return status is communicated by file
-     *  - then exit()
-     */
-
-    /* at this point, the plugin can take its time, because OpenVPN will
-     * no longer block waiting for the call to finish
-     *
-     * in this example, we build a PF file by copying over a file
-     * named "<username>.pf" to the OpenVPN-provided pf file name
-     *
-     * a real example could do a LDAP lookup, a REST call, ...
-     */
-    plugin_log(PLOG_NOTE, MODULE, "in async/deferred tls_final handler, sleep(%d)", context->test_packet_filter);
-    sleep(context->test_packet_filter);
-
-    char buf[256];
-    snprintf(buf, sizeof(buf), "%s.pf", cn );
-
-    /* there is a small race condition here - OpenVPN could detect our
-     * file while we have only written half of it.  So "perfect" code
-     * needs to create this with a temp file name, and then rename() it
-     * after it has been written.  But I am lazy.
-     */
-
-    int w_fd = open( pff, O_WRONLY|O_CREAT, 0600 );
-    if (w_fd < 0)
-    {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "can't write to '%s'", pff);
-        exit(0);
-    }
-
-    int r_fd = open( buf, O_RDONLY );
-    if (r_fd < 0)
-    {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "can't read '%s', creating empty pf file", buf);
-        close(w_fd);
-        exit(0);
-    }
-
-    char data[1024];
-
-    int r;
-    do
-    {
-        r = read(r_fd, data, sizeof(data));
-        if (r < 0)
-        {
-            plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "error reading '%s'", buf);
-            close(r_fd);
-            close(w_fd);
-            exit(0);
-        }
-        int w = write(w_fd, data, r);
-        if (w < 0 || w != r)
-        {
-            plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "error writing %d bytes to '%s'", r, pff);
-            close(r_fd);
-            close(w_fd);
-            exit(0);
-        }
-    }
-    while(r > 0);
-
-    plugin_log(PLOG_NOTE, MODULE, "copied PF config from '%s' to '%s', job done", buf, pff);
-    exit(0);
-}
-
 OPENVPN_EXPORT int
 openvpn_plugin_func_v3(const int v3structver,
                        struct openvpn_plugin_args_func_in const *args,
@@ -496,21 +362,7 @@ openvpn_plugin_func_v3(const int v3structver,
 
         case OPENVPN_PLUGIN_TLS_FINAL:
             plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_TLS_FINAL");
-            return tls_final(context, pcc, argv, envp);
-
-        case OPENVPN_PLUGIN_ENABLE_PF:
-            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_ENABLE_PF");
-
-            /* OpenVPN pre-creates the file, which gets in the way of
-             * deferred pf setup - so remove it here, and re-create
-             * it in the background handler (in tls_final()) when ready
-             */
-            const char *pff = get_env("pf_file", envp);
-            if (pff)
-            {
-                (void) unlink(pff);
-            }
-            return OPENVPN_PLUGIN_FUNC_SUCCESS;           /* must succeed */
+            return OPENVPN_PLUGIN_FUNC_SUCCESS;
 
         default:
             plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_?");
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 92e9c6ce..5883c291 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -97,7 +97,6 @@ openvpn_SOURCES = \
 	otime.c otime.h \
 	packet_id.c packet_id.h \
 	perf.c perf.h \
-	pf.c pf.h \
 	ping.c ping.h \
 	plugin.c plugin.h \
 	pool.c pool.h \
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 4131cf0a..602e48a8 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -90,7 +90,6 @@
 #define D_ROUTE_QUOTA        LOGLEV(3, 42, 0)        /* show route quota exceeded messages */
 #define D_OSBUF              LOGLEV(3, 43, 0)        /* show socket/tun/tap buffer sizes */
 #define D_PS_PROXY           LOGLEV(3, 44, 0)        /* messages related to --port-share option */
-#define D_PF_INFO            LOGLEV(3, 45, 0)        /* packet filter informational messages */
 #define D_IFCONFIG           LOGLEV(3, 0,  0)        /* show ifconfig info (don't mute) */
 
 #define D_SHOW_PARMS         LOGLEV(4, 50, 0)        /* show all parameters on program initiation */
@@ -99,7 +98,6 @@
 #define D_DHCP_OPT           LOGLEV(4, 53, 0)        /* show DHCP options binary string */
 #define D_MBUF               LOGLEV(4, 54, 0)        /* mbuf.[ch] routines */
 #define D_PACKET_TRUNC_ERR   LOGLEV(4, 55, 0)        /* PACKET_TRUNCATION_CHECK */
-#define D_PF_DROPPED         LOGLEV(4, 56, 0)        /* packet filter dropped a packet */
 #define D_MULTI_DROPPED      LOGLEV(4, 57, 0)        /* show point-to-multipoint packet drops */
 #define D_MULTI_MEDIUM       LOGLEV(4, 58, 0)        /* show medium frequency multi messages */
 #define D_X509_ATTR          LOGLEV(4, 59, 0)        /* show x509-track attributes on connection */
@@ -145,8 +143,6 @@
 #define D_ARGV_PARSE_CMD     LOGLEV(7, 70, M_DEBUG)  /* show parse_line() errors in argv_parse_cmd */
 #define D_CRYPTO_DEBUG       LOGLEV(7, 70, M_DEBUG)  /* show detailed info from crypto.c routines */
 #define D_PID_DEBUG          LOGLEV(7, 70, M_DEBUG)  /* show packet-id debugging info */
-#define D_PF_DROPPED_BCAST   LOGLEV(7, 71, M_DEBUG)  /* packet filter dropped a broadcast packet */
-#define D_PF_DEBUG           LOGLEV(7, 72, M_DEBUG)  /* packet filter debugging, must also define PF_DEBUG in pf.h */
 #define D_PUSH_DEBUG         LOGLEV(7, 73, M_DEBUG)  /* show push/pull debugging info */
 
 #define D_VLAN_DEBUG         LOGLEV(7, 74, M_DEBUG)  /* show VLAN tagging/untagging debug info */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index e4d0fa7d..f7d6bc34 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -36,7 +36,6 @@
 #include "mss.h"
 #include "event.h"
 #include "occ.h"
-#include "pf.h"
 #include "ping.h"
 #include "ps.h"
 #include "dhcp.h"
@@ -634,13 +633,6 @@ process_coarse_timers(struct context *c)
         check_push_request(c);
     }
 
-#ifdef PLUGIN_PF
-    if (c->c2.pf.enabled
-        && event_timeout_trigger(&c->c2.pf.reload, &c->c2.timeval, ETT_DEFAULT))
-    {
-        pf_check_reload(c);
-    }
-#endif
 
     /* process --route options */
     if (event_timeout_trigger(&c->c2.route_wakeup, &c->c2.timeval, ETT_DEFAULT))
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 386aee23..0edb9391 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4347,12 +4347,6 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
     }
 #endif
 
-#ifdef ENABLE_PF
-    if (child)
-    {
-        pf_init_context(c);
-    }
-#endif
 
     /* Check for signals */
     if (IS_SIG(c))
@@ -4415,9 +4409,6 @@ close_instance(struct context *c)
         }
 #endif
 
-#ifdef ENABLE_PF
-        pf_destroy_context(&c->c2.pf);
-#endif
 
 #ifdef ENABLE_PLUGIN
         /* call plugin close functions and unload */
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 86584c4b..e434dfa7 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -108,9 +108,6 @@ man_help(void)
         "                          to the client and wait for a final client-auth/client-deny");
     msg(M_CLIENT, "client-kill CID [M]    : Kill client instance CID with message M (def=RESTART)");
     msg(M_CLIENT, "env-filter [level]     : Set env-var filter level");
-#ifdef MANAGEMENT_PF
-    msg(M_CLIENT, "client-pf CID          : Define packet filter for client CID (MULTILINE)");
-#endif
     msg(M_CLIENT, "rsa-sig                : Enter a signature in response to >RSA_SIGN challenge");
     msg(M_CLIENT, "                         Enter signature base64 on subsequent lines followed by END");
     msg(M_CLIENT, "pk-sig                 : Enter a signature in response to >PK_SIGN challenge");
@@ -918,31 +915,6 @@ in_extra_dispatch(struct management *man)
             }
             break;
 
-#ifdef MANAGEMENT_PF
-        case IEC_CLIENT_PF:
-            if (man->persist.callback.client_pf)
-            {
-                const bool status = (*man->persist.callback.client_pf)
-                                        (man->persist.callback.arg,
-                                        man->connection.in_extra_cid,
-                                        man->connection.in_extra);
-                man->connection.in_extra = NULL;
-                if (status)
-                {
-                    msg(M_CLIENT, "SUCCESS: client-pf command succeeded");
-                }
-                else
-                {
-                    msg(M_CLIENT, "ERROR: client-pf command failed");
-                }
-            }
-            else
-            {
-                msg(M_CLIENT, "ERROR: The client-pf command is not supported by the current daemon mode");
-            }
-            break;
-
-#endif /* ifdef MANAGEMENT_PF */
         case IEC_PK_SIGN:
             man->connection.ext_key_state = EKS_READY;
             buffer_list_free(man->connection.ext_key_input);
@@ -1125,22 +1097,6 @@ man_env_filter(struct management *man, const int level)
     msg(M_CLIENT, "SUCCESS: env_filter_level=%d", level);
 }
 
-#ifdef MANAGEMENT_PF
-
-static void
-man_client_pf(struct management *man, const char *cid_str)
-{
-    struct man_connection *mc = &man->connection;
-    mc->in_extra_cid = 0;
-    mc->in_extra_kid = 0;
-    if (parse_cid(cid_str, &mc->in_extra_cid))
-    {
-        mc->in_extra_cmd = IEC_CLIENT_PF;
-        in_extra_reset(mc, IER_NEW);
-    }
-}
-
-#endif /* MANAGEMENT_PF */
 
 static void
 man_pk_sig(struct management *man, const char *cmd_name)
@@ -1567,15 +1523,6 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
             man_client_pending_auth(man, p[1], p[2], p[3]);
         }
     }
-#ifdef MANAGEMENT_PF
-    else if (streq(p[0], "client-pf"))
-    {
-        if (man_need(man, p, 1, 0))
-        {
-            man_client_pf(man, p[1]);
-        }
-    }
-#endif
     else if (streq(p[0], "rsa-sig"))
     {
         man_pk_sig(man, "rsa-sig");
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 6d6f2fb1..82cad632 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -176,11 +176,6 @@ struct management_callback
                                  const char *extra,
                                  unsigned int timeout);
     char *(*get_peer_info) (void *arg, const unsigned long cid);
-#ifdef MANAGEMENT_PF
-    bool (*client_pf)(void *arg,
-                      const unsigned long cid,
-                      struct buffer_list *pf_config);  /* ownership transferred */
-#endif
     bool (*proxy_cmd)(void *arg, const char **p);
     bool (*remote_cmd) (void *arg, const char **p);
 #ifdef TARGET_ANDROID
@@ -278,7 +273,7 @@ struct man_connection {
 
 #define IEC_UNDEF       0
 #define IEC_CLIENT_AUTH 1
-#define IEC_CLIENT_PF   2
+//#define IEC_CLIENT_PF   2 *NOT IMPLEMENTED*
 #define IEC_RSA_SIGN    3
 #define IEC_CERTIFICATE 4
 #define IEC_PK_SIGN     5
@@ -335,9 +330,7 @@ struct management *management_init(void);
 #define MF_FORGET_DISCONNECT (1<<4)
 #define MF_CONNECT_AS_CLIENT (1<<5)
 #define MF_CLIENT_AUTH       (1<<6)
-#ifdef MANAGEMENT_PF
-#define MF_CLIENT_PF         (1<<7)
-#endif
+//#define MF_CLIENT_PF         (1<<7) *NOT IMPLEMENTED*
 #define MF_UNIX_SOCK                (1<<8)
 #define MF_EXTERNAL_KEY             (1<<9)
 #define MF_EXTERNAL_KEY_NOPADDING   (1<<10)
@@ -460,13 +453,6 @@ management_query_proxy_enabled(const struct management *man)
     return BOOL_CAST(man->settings.flags & MF_QUERY_PROXY);
 }
 
-#ifdef MANAGEMENT_PF
-static inline bool
-management_enable_pf(const struct management *man)
-{
-    return man && BOOL_CAST(man->settings.flags & MF_CLIENT_PF);
-}
-#endif
 
 static inline bool
 management_enable_def_auth(const struct management *man)
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 4e76fb0b..450b50b3 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -148,38 +148,6 @@ mroute_is_mcast_ipv6(const struct in6_addr addr)
     return (addr.s6_addr[0] == 0xff);
 }
 
-#ifdef ENABLE_PF
-
-static unsigned int
-mroute_extract_addr_arp(struct mroute_addr *src,
-                        struct mroute_addr *dest,
-                        const struct buffer *buf)
-{
-    unsigned int ret = 0;
-    if (BLEN(buf) >= (int) sizeof(struct openvpn_arp))
-    {
-        const struct openvpn_arp *arp = (const struct openvpn_arp *) BPTR(buf);
-        if (arp->mac_addr_type == htons(0x0001)
-            && arp->proto_addr_type == htons(0x0800)
-            && arp->mac_addr_size == 0x06
-            && arp->proto_addr_size == 0x04)
-        {
-            mroute_get_in_addr_t(src, arp->ip_src, MR_ARP);
-            mroute_get_in_addr_t(dest, arp->ip_dest, MR_ARP);
-
-            /* multicast packet? */
-            if (mroute_is_mcast(arp->ip_dest))
-            {
-                ret |= MROUTE_EXTRACT_MCAST;
-            }
-
-            ret |= MROUTE_EXTRACT_SUCCEEDED;
-        }
-    }
-    return ret;
-}
-
-#endif /* ifdef ENABLE_PF */
 
 unsigned int
 mroute_extract_addr_ip(struct mroute_addr *src, struct mroute_addr *dest,
@@ -262,8 +230,6 @@ mroute_copy_ether_to_addr(struct mroute_addr *maddr,
 unsigned int
 mroute_extract_addr_ether(struct mroute_addr *src,
                           struct mroute_addr *dest,
-                          struct mroute_addr *esrc,
-                          struct mroute_addr *edest,
                           uint16_t vid,
                           const struct buffer *buf)
 {
@@ -288,42 +254,6 @@ mroute_extract_addr_ether(struct mroute_addr *src,
 
         ret |= MROUTE_EXTRACT_SUCCEEDED;
 
-#ifdef ENABLE_PF
-        if (esrc || edest)
-        {
-            struct buffer b = *buf;
-            if (!buf_advance(&b, sizeof(struct openvpn_ethhdr)))
-            {
-                return 0;
-            }
-
-            uint16_t proto = eth->proto;
-            if (proto == htons(OPENVPN_ETH_P_8021Q))
-            {
-                if (!buf_advance(&b, SIZE_ETH_TO_8021Q_HDR))
-                {
-                    /* It's an 802.1Q packet, but doesn't have a full header,
-                     * so something went wrong */
-                    return 0;
-                }
-
-                const struct openvpn_8021qhdr *tag;
-                tag = (const struct openvpn_8021qhdr *)BPTR(buf);
-                proto = tag->proto;
-            }
-
-            switch (ntohs(proto))
-            {
-                case OPENVPN_ETH_P_IPV4:
-                    ret |= (mroute_extract_addr_ip(esrc, edest, &b) << MROUTE_SEC_SHIFT);
-                    break;
-
-                case OPENVPN_ETH_P_ARP:
-                    ret |= (mroute_extract_addr_arp(esrc, edest, &b) << MROUTE_SEC_SHIFT);
-                    break;
-            }
-        }
-#endif /* ifdef ENABLE_PF */
     }
     return ret;
 }
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 8f7e0924..ab5f9028 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -177,8 +177,6 @@ unsigned int mroute_extract_addr_ip(struct mroute_addr *src,
 
 unsigned int mroute_extract_addr_ether(struct mroute_addr *src,
                                        struct mroute_addr *dest,
-                                       struct mroute_addr *esrc,
-                                       struct mroute_addr *edest,
                                        uint16_t vid,
                                        const struct buffer *buf);
 
@@ -189,8 +187,6 @@ unsigned int mroute_extract_addr_ether(struct mroute_addr *src,
 static inline unsigned int
 mroute_extract_addr_from_packet(struct mroute_addr *src,
                                 struct mroute_addr *dest,
-                                struct mroute_addr *esrc,
-                                struct mroute_addr *edest,
                                 uint16_t vid,
                                 const struct buffer *buf,
                                 int tunnel_type)
@@ -203,7 +199,7 @@ mroute_extract_addr_from_packet(struct mroute_addr *src,
     }
     else if (tunnel_type == DEV_TYPE_TAP)
     {
-        ret = mroute_extract_addr_ether(src, dest, esrc, edest, vid, buf);
+        ret = mroute_extract_addr_ether(src, dest, vid, buf);
     }
     return ret;
 }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 22357cfb..eab2b8dd 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -39,7 +39,6 @@
 #include "push.h"
 #include "run_command.h"
 #include "otime.h"
-#include "pf.h"
 #include "gremlin.h"
 #include "mstats.h"
 #include "ssl_verify.h"
@@ -2827,35 +2826,6 @@ multi_bcast(struct multi_context *m,
             mi = (struct multi_instance *) he->value;
             if (mi != sender_instance && !mi->halt)
             {
-#ifdef ENABLE_PF
-                if (sender_instance)
-                {
-                    if (!pf_c2c_test(&sender_instance->context.c2.pf,
-                                     sender_instance->context.c2.tls_multi,
-                                     &mi->context.c2.pf,
-                                     mi->context.c2.tls_multi,
-                                     "bcast_c2c"))
-                    {
-                        msg(D_PF_DROPPED_BCAST, "PF: client[%s] -> client[%s] packet dropped by BCAST packet filter",
-                            mi_prefix(sender_instance),
-                            mi_prefix(mi));
-                        continue;
-                    }
-                }
-                if (sender_addr)
-                {
-                    if (!pf_addr_test(&mi->context.c2.pf, &mi->context,
-                                      sender_addr, "bcast_src_addr"))
-                    {
-                        struct gc_arena gc = gc_new();
-                        msg(D_PF_DROPPED_BCAST, "PF: addr[%s] -> client[%s] packet dropped by BCAST packet filter",
-                            mroute_addr_print_ex(sender_addr, MAPF_SHOW_ARP, &gc),
-                            mi_prefix(mi));
-                        gc_free(&gc);
-                        continue;
-                    }
-                }
-#endif /* ifdef ENABLE_PF */
                 if (vid != 0 && vid != mi->context.options.vlan_pvid)
                 {
                     continue;
@@ -3199,8 +3169,6 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                 /* extract packet source and dest addresses */
                 mroute_flags = mroute_extract_addr_from_packet(&src,
                                                                &dest,
-                                                               NULL,
-                                                               NULL,
                                                                0,
                                                                &c->c2.to_tun,
                                                                DEV_TYPE_TUN);
@@ -3243,17 +3211,6 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                         /* if dest addr is a known client, route to it */
                         if (mi)
                         {
-#ifdef ENABLE_PF
-                            if (!pf_c2c_test(&c->c2.pf, c->c2.tls_multi,
-                                             &mi->context.c2.pf,
-                                             mi->context.c2.tls_multi,
-                                             "tun_c2c"))
-                            {
-                                msg(D_PF_DROPPED, "PF: client -> client[%s] packet dropped by TUN packet filter",
-                                    mi_prefix(mi));
-                            }
-                            else
-#endif
                             {
                                 multi_unicast(m, &c->c2.to_tun, mi);
                                 register_activity(c, BLEN(&c->c2.to_tun));
@@ -3262,23 +3219,10 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                         }
                     }
                 }
-#ifdef ENABLE_PF
-                if (c->c2.to_tun.len && !pf_addr_test(&c->c2.pf, c, &dest,
-                                                      "tun_dest_addr"))
-                {
-                    msg(D_PF_DROPPED, "PF: client -> addr[%s] packet dropped by TUN packet filter",
-                        mroute_addr_print_ex(&dest, MAPF_SHOW_ARP, &gc));
-                    c->c2.to_tun.len = 0;
-                }
-#endif
             }
             else if (TUNNEL_TYPE(m->top.c1.tuntap) == DEV_TYPE_TAP)
             {
                 uint16_t vid = 0;
-#ifdef ENABLE_PF
-                struct mroute_addr edest;
-                mroute_addr_reset(&edest);
-#endif
 
                 if (m->top.options.vlan_tagging)
                 {
@@ -3296,12 +3240,6 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                 /* extract packet source and dest addresses */
                 mroute_flags = mroute_extract_addr_from_packet(&src,
                                                                &dest,
-                                                               NULL,
-#ifdef ENABLE_PF
-                                                               &edest,
-#else
-                                                               NULL,
-#endif
                                                                vid,
                                                                &c->c2.to_tun,
                                                                DEV_TYPE_TAP);
@@ -3325,17 +3263,6 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                                 /* if dest addr is a known client, route to it */
                                 if (mi)
                                 {
-#ifdef ENABLE_PF
-                                    if (!pf_c2c_test(&c->c2.pf, c->c2.tls_multi,
-                                                     &mi->context.c2.pf,
-                                                     mi->context.c2.tls_multi,
-                                                     "tap_c2c"))
-                                    {
-                                        msg(D_PF_DROPPED, "PF: client -> client[%s] packet dropped by TAP packet filter",
-                                            mi_prefix(mi));
-                                    }
-                                    else
-#endif
                                     {
                                         multi_unicast(m, &c->c2.to_tun, mi);
                                         register_activity(c, BLEN(&c->c2.to_tun));
@@ -3344,16 +3271,6 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                                 }
                             }
                         }
-#ifdef ENABLE_PF
-                        if (c->c2.to_tun.len && !pf_addr_test(&c->c2.pf, c,
-                                                              &edest,
-                                                              "tap_dest_addr"))
-                        {
-                            msg(D_PF_DROPPED, "PF: client -> addr[%s] packet dropped by TAP packet filter",
-                                mroute_addr_print_ex(&edest, MAPF_SHOW_ARP, &gc));
-                            c->c2.to_tun.len = 0;
-                        }
-#endif
                     }
                     else
                     {
@@ -3396,19 +3313,6 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
         const int dev_type = TUNNEL_TYPE(m->top.c1.tuntap);
         int16_t vid = 0;
 
-#ifdef ENABLE_PF
-        struct mroute_addr esrc, *e1, *e2;
-        if (dev_type == DEV_TYPE_TUN)
-        {
-            e1 = NULL;
-            e2 = &src;
-        }
-        else
-        {
-            e1 = e2 = &esrc;
-            mroute_addr_reset(&esrc);
-        }
-#endif
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TUN -> TCP/UDP [%d]\n", BLEN(&m->top.c2.buf));
@@ -3435,12 +3339,6 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
 
         mroute_flags = mroute_extract_addr_from_packet(&src,
                                                        &dest,
-#ifdef ENABLE_PF
-                                                       e1,
-#else
-                                                       NULL,
-#endif
-                                                       NULL,
                                                        vid,
                                                        &m->top.c2.buf,
                                                        dev_type);
@@ -3453,11 +3351,7 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
             if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
             {
                 /* for now, treat multicast as broadcast */
-#ifdef ENABLE_PF
-                multi_bcast(m, &m->top.c2.buf, NULL, e2, vid);
-#else
                 multi_bcast(m, &m->top.c2.buf, NULL, NULL, vid);
-#endif
             }
             else
             {
@@ -3470,15 +3364,6 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
 
                     set_prefix(m->pending);
 
-#ifdef ENABLE_PF
-                    if (!pf_addr_test(&c->c2.pf, c, e2, "tun_tap_src_addr"))
-                    {
-                        msg(D_PF_DROPPED, "PF: addr[%s] -> client packet dropped by packet filter",
-                            mroute_addr_print_ex(&src, MAPF_SHOW_ARP, &gc));
-                        buf_reset_len(&c->c2.buf);
-                    }
-                    else
-#endif
                     {
                         if (multi_output_queue_ready(m, m->pending))
                         {
@@ -3997,25 +3882,6 @@ management_get_peer_info(void *arg, const unsigned long cid)
 
 #endif /* ifdef ENABLE_MANAGEMENT */
 
-#ifdef MANAGEMENT_PF
-static bool
-management_client_pf(void *arg,
-                     const unsigned long cid,
-                     struct buffer_list *pf_config)  /* ownership transferred */
-{
-    struct multi_context *m = (struct multi_context *) arg;
-    struct multi_instance *mi = lookup_by_cid(m, cid);
-    bool ret = false;
-
-    if (mi && pf_config)
-    {
-        ret = pf_load_from_buffer_list(&mi->context, pf_config);
-    }
-
-    buffer_list_free(pf_config);
-    return ret;
-}
-#endif /* ifdef MANAGEMENT_PF */
 
 void
 init_management_callback_multi(struct multi_context *m)
@@ -4037,9 +3903,6 @@ init_management_callback_multi(struct multi_context *m)
         cb.client_auth = management_client_auth;
         cb.client_pending_auth = management_client_pending_auth;
         cb.get_peer_info = management_get_peer_info;
-#ifdef MANAGEMENT_PF
-        cb.client_pf = management_client_pf;
-#endif
         management_set_callback(management, &cb);
     }
 #endif /* ifdef ENABLE_MANAGEMENT */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index f925f1f6..df6bc9df 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -42,7 +42,6 @@
 #include "sig.h"
 #include "misc.h"
 #include "mbuf.h"
-#include "pf.h"
 #include "pool.h"
 #include "plugin.h"
 #include "manage.h"
@@ -437,9 +436,6 @@ struct context_2
     int scheduled_exit_signal;
 
     /* packet filter */
-#ifdef ENABLE_PF
-    struct pf_context pf;
-#endif
 
 #ifdef ENABLE_MANAGEMENT
     struct man_def_auth_context mda_context;
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 3cf47f07..5b3e0c6c 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -276,7 +276,6 @@
     <ClCompile Include="otime.c" />
     <ClCompile Include="packet_id.c" />
     <ClCompile Include="perf.c" />
-    <ClCompile Include="pf.c" />
     <ClCompile Include="ping.c" />
     <ClCompile Include="pkcs11.c" />
     <ClCompile Include="pkcs11_openssl.c" />
@@ -362,7 +361,6 @@
     <ClInclude Include="otime.h" />
     <ClInclude Include="packet_id.h" />
     <ClInclude Include="perf.h" />
-    <ClInclude Include="pf.h" />
     <ClInclude Include="ping.h" />
     <ClInclude Include="pkcs11.h" />
     <ClInclude Include="pkcs11_backend.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index 3b75eecd..f5fdfcd7 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -129,9 +129,6 @@
     <ClCompile Include="perf.c">
       <Filter>Source Files</Filter>
     </ClCompile>
-    <ClCompile Include="pf.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
     <ClCompile Include="ping.c">
       <Filter>Source Files</Filter>
     </ClCompile>
@@ -392,9 +389,6 @@
     <ClInclude Include="perf.h">
       <Filter>Header Files</Filter>
     </ClInclude>
-    <ClInclude Include="pf.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
     <ClInclude Include="ping.h">
       <Filter>Header Files</Filter>
     </ClInclude>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7e146db9..acd1f4a1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -391,10 +391,6 @@ static const char usage_message[] =
     "--management-client-auth : gives management interface client the responsibility\n"
     "                           to authenticate clients after their client certificate\n"
     "			      has been verified.\n"
-#ifdef MANAGEMENT_PF
-    "--management-client-pf : management interface clients must specify a packet\n"
-    "                         filter file for each connecting client.\n"
-#endif
 #endif /* ifdef ENABLE_MANAGEMENT */
 #ifdef ENABLE_PLUGIN
     "--plugin m [str]: Load plug-in module m passing str as an argument\n"
@@ -5479,13 +5475,6 @@ add_option(struct options *options,
         options->management_flags |= MF_CLIENT_AUTH;
     }
 #endif /* ifdef ENABLE_MANAGEMENT */
-#ifdef MANAGEMENT_PF
-    else if (streq(p[0], "management-client-pf") && !p[1])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->management_flags |= (MF_CLIENT_PF | MF_CLIENT_AUTH);
-    }
-#endif
     else if (streq(p[0], "management-log-cache") && p[1] && !p[2])
     {
         int cache;
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
deleted file mode 100644
index 36456315..00000000
--- a/src/openvpn/pf.c
+++ /dev/null
@@ -1,787 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-/* packet filter functions */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
-#endif
-
-#include "syshead.h"
-
-#if defined(ENABLE_PF)
-
-#include "init.h"
-#include "memdbg.h"
-#include "pf.h"
-#include "ssl_verify.h"
-
-
-static void
-pf_destroy(struct pf_set *pfs)
-{
-    if (pfs)
-    {
-        if (pfs->cns.hash_table)
-        {
-            hash_free(pfs->cns.hash_table);
-        }
-
-        {
-            struct pf_cn_elem *l = pfs->cns.list;
-            while (l)
-            {
-                struct pf_cn_elem *next = l->next;
-                free(l->rule.cn);
-                free(l);
-                l = next;
-            }
-        }
-        {
-            struct pf_subnet *l = pfs->sns.list;
-            while (l)
-            {
-                struct pf_subnet *next = l->next;
-                free(l);
-                l = next;
-            }
-        }
-        free(pfs);
-    }
-}
-
-static bool
-add_client(const char *line, const char *prefix, const int line_num, struct pf_cn_elem ***next, const bool exclude)
-{
-    struct pf_cn_elem *e;
-    ALLOC_OBJ_CLEAR(e, struct pf_cn_elem);
-    e->rule.exclude = exclude;
-    e->rule.cn = string_alloc(line, NULL);
-    **next = e;
-    *next = &e->next;
-    return true;
-}
-
-static bool
-add_subnet(const char *line, const char *prefix, const int line_num, struct pf_subnet ***next, const bool exclude)
-{
-    struct in_addr network;
-    in_addr_t netmask = 0;
-
-    if (strcmp(line, "unknown"))
-    {
-        int netbits = 32;
-        char *div = strchr(line, '/');
-
-        if (div)
-        {
-            *div++ = '\0';
-            if (sscanf(div, "%d", &netbits) != 1)
-            {
-                msg(D_PF_INFO, "PF: %s/%d: bad '/n' subnet specifier: '%s'", prefix, line_num, div);
-                return false;
-            }
-            if (netbits < 0 || netbits > 32)
-            {
-                msg(D_PF_INFO, "PF: %s/%d: bad '/n' subnet specifier: must be between 0 and 32: '%s'", prefix, line_num, div);
-                return false;
-            }
-        }
-
-        if (openvpn_inet_aton(line, &network) != OIA_IP)
-        {
-            msg(D_PF_INFO, "PF: %s/%d: bad network address: '%s'", prefix, line_num, line);
-            return false;
-        }
-        netmask = netbits_to_netmask(netbits);
-        if ((network.s_addr & htonl(netmask)) != network.s_addr)
-        {
-            network.s_addr &= htonl(netmask);
-            msg(M_WARN, "WARNING: PF: %s/%d: incorrect subnet %s/%d changed to %s/%d", prefix, line_num, line, netbits, inet_ntoa(network), netbits);
-        }
-    }
-    else
-    {
-        /* match special "unknown" tag for addresses unrecognized by mroute */
-        network.s_addr = htonl(0);
-        netmask = IPV4_NETMASK_HOST;
-    }
-
-    {
-        struct pf_subnet *e;
-        ALLOC_OBJ_CLEAR(e, struct pf_subnet);
-        e->rule.exclude = exclude;
-        e->rule.network = ntohl(network.s_addr);
-        e->rule.netmask = netmask;
-        **next = e;
-        *next = &e->next;
-        return true;
-    }
-}
-
-static uint32_t
-cn_hash_function(const void *key, uint32_t iv)
-{
-    return hash_func((uint8_t *)key, strlen((char *)key) + 1, iv);
-}
-
-static bool
-cn_compare_function(const void *key1, const void *key2)
-{
-    return !strcmp((const char *)key1, (const char *)key2);
-}
-
-static bool
-genhash(struct pf_cn_set *cns, const char *prefix, const int n_clients)
-{
-    struct pf_cn_elem *e;
-    bool status = true;
-    int n_buckets = n_clients;
-
-    if (n_buckets < 16)
-    {
-        n_buckets = 16;
-    }
-    cns->hash_table = hash_init(n_buckets, 0, cn_hash_function, cn_compare_function);
-    for (e = cns->list; e != NULL; e = e->next)
-    {
-        if (!hash_add(cns->hash_table, e->rule.cn, &e->rule, false))
-        {
-            msg(D_PF_INFO, "PF: %s: duplicate common name in [clients] section: '%s'", prefix, e->rule.cn);
-            status = false;
-        }
-    }
-
-    return status;
-}
-
-static struct pf_set *
-pf_init(const struct buffer_list *bl, const char *prefix, const bool allow_kill)
-{
-#define MODE_UNDEF   0
-#define MODE_CLIENTS 1
-#define MODE_SUBNETS 2
-    int mode = MODE_UNDEF;
-    int line_num = 0;
-    int n_clients = 0;
-    int n_subnets = 0;
-    int n_errors = 0;
-    struct pf_set *pfs = NULL;
-    char line[PF_MAX_LINE_LEN];
-
-    ALLOC_OBJ_CLEAR(pfs, struct pf_set);
-    if (bl)
-    {
-        struct pf_cn_elem **cl = &pfs->cns.list;
-        struct pf_subnet **sl = &pfs->sns.list;
-        struct buffer_entry *be;
-
-        for (be = bl->head; be != NULL; be = be->next)
-        {
-            ++line_num;
-            strncpynt(line, BSTR(&be->buf), sizeof(line));
-            rm_trailing_chars(line, "\r\n\t ");
-            if (line[0] == '\0' || line[0] == '#')
-            {
-            }
-            else if (line[0] == '+' || line[0] == '-')
-            {
-                bool exclude = (line[0] == '-');
-
-                if (line[1] =='\0')
-                {
-                    msg(D_PF_INFO, "PF: %s/%d: no data after +/-: '%s'", prefix, line_num, line);
-                    ++n_errors;
-                }
-                else if (mode == MODE_CLIENTS)
-                {
-                    if (add_client(&line[1], prefix, line_num, &cl, exclude))
-                    {
-                        ++n_clients;
-                    }
-                    else
-                    {
-                        ++n_errors;
-                    }
-                }
-                else if (mode == MODE_SUBNETS)
-                {
-                    if (add_subnet(&line[1], prefix, line_num, &sl, exclude))
-                    {
-                        ++n_subnets;
-                    }
-                    else
-                    {
-                        ++n_errors;
-                    }
-                }
-                else if (mode == MODE_UNDEF)
-                {
-                }
-                else
-                {
-                    ASSERT(0);
-                }
-            }
-            else if (line[0] == '[')
-            {
-                if (!strcasecmp(line, "[clients accept]"))
-                {
-                    mode = MODE_CLIENTS;
-                    pfs->cns.default_allow = true;
-                }
-                else if (!strcasecmp(line, "[clients drop]"))
-                {
-                    mode = MODE_CLIENTS;
-                    pfs->cns.default_allow = false;
-                }
-                else if (!strcasecmp(line, "[subnets accept]"))
-                {
-                    mode = MODE_SUBNETS;
-                    pfs->sns.default_allow = true;
-                }
-                else if (!strcasecmp(line, "[subnets drop]"))
-                {
-                    mode = MODE_SUBNETS;
-                    pfs->sns.default_allow = false;
-                }
-                else if (!strcasecmp(line, "[end]"))
-                {
-                    goto done;
-                }
-                else if (allow_kill && !strcasecmp(line, "[kill]"))
-                {
-                    goto kill;
-                }
-                else
-                {
-                    mode = MODE_UNDEF;
-                    msg(D_PF_INFO, "PF: %s/%d unknown tag: '%s'", prefix, line_num, line);
-                    ++n_errors;
-                }
-            }
-            else
-            {
-                msg(D_PF_INFO, "PF: %s/%d line must begin with '+', '-', or '[' : '%s'", prefix, line_num, line);
-                ++n_errors;
-            }
-        }
-        ++n_errors;
-        msg(D_PF_INFO, "PF: %s: missing [end]", prefix);
-    }
-    else
-    {
-        msg(D_PF_INFO, "PF: %s: cannot open", prefix);
-        ++n_errors;
-    }
-
-done:
-    if (bl)
-    {
-        if (!n_errors)
-        {
-            if (!genhash(&pfs->cns, prefix, n_clients))
-            {
-                ++n_errors;
-            }
-        }
-        if (n_errors)
-        {
-            msg(D_PF_INFO, "PF: %s rejected due to %d error(s)", prefix, n_errors);
-        }
-    }
-    if (n_errors)
-    {
-        pf_destroy(pfs);
-        pfs = NULL;
-    }
-    return pfs;
-
-kill:
-    pf_destroy(pfs);
-    ALLOC_OBJ_CLEAR(pfs, struct pf_set);
-    pfs->kill = true;
-    return pfs;
-}
-
-#ifdef PLUGIN_PF
-static struct pf_set *
-pf_init_from_file(const char *fn)
-{
-    struct buffer_list *bl = buffer_list_file(fn, PF_MAX_LINE_LEN);
-    if (bl)
-    {
-        struct pf_set *pfs = pf_init(bl, fn, true);
-        buffer_list_free(bl);
-        return pfs;
-    }
-    else
-    {
-        msg(D_PF_INFO|M_ERRNO, "PF: %s: cannot open", fn);
-        return NULL;
-    }
-}
-#endif
-
-#ifdef ENABLE_DEBUG
-
-static const char *
-drop_accept(const bool accept)
-{
-    return accept ? "ACCEPT" : "DROP";
-}
-
-static const char *
-pct_name(const int type)
-{
-    switch (type)
-    {
-        case PCT_SRC:
-            return "SRC";
-
-        case PCT_DEST:
-            return "DEST";
-
-        default:
-            return "???";
-    }
-}
-
-static void
-pf_cn_test_print(const char *prefix,
-                 const int type,
-                 const char *prefix2,
-                 const char *cn,
-                 const bool allow,
-                 const struct pf_cn *rule)
-{
-    if (rule)
-    {
-        dmsg(D_PF_DEBUG, "PF: %s/%s/%s %s %s rule=[%s %s]",
-             prefix, prefix2, pct_name(type),
-             cn, drop_accept(allow),
-             rule->cn, drop_accept(!rule->exclude));
-    }
-    else
-    {
-        dmsg(D_PF_DEBUG, "PF: %s/%s/%s %s %s",
-             prefix, prefix2, pct_name(type),
-             cn, drop_accept(allow));
-    }
-}
-
-static void
-pf_addr_test_print(const char *prefix,
-                   const char *prefix2,
-                   const struct context *src,
-                   const struct mroute_addr *dest,
-                   const bool allow,
-                   const struct ipv4_subnet *rule)
-{
-    struct gc_arena gc = gc_new();
-    if (rule)
-    {
-        dmsg(D_PF_DEBUG, "PF: %s/%s %s %s %s rule=[%s/%s %s]",
-             prefix,
-             prefix2,
-             tls_common_name(src->c2.tls_multi, false),
-             mroute_addr_print_ex(dest, MAPF_SHOW_ARP, &gc),
-             drop_accept(allow),
-             print_in_addr_t(rule->network, 0, &gc),
-             print_in_addr_t(rule->netmask, 0, &gc),
-             drop_accept(!rule->exclude));
-    }
-    else
-    {
-        dmsg(D_PF_DEBUG, "PF: %s/%s %s %s %s",
-             prefix,
-             prefix2,
-             tls_common_name(src->c2.tls_multi, false),
-             mroute_addr_print_ex(dest, MAPF_SHOW_ARP, &gc),
-             drop_accept(allow));
-    }
-    gc_free(&gc);
-}
-
-#endif /* ifdef ENABLE_DEBUG */
-
-static inline struct pf_cn *
-lookup_cn_rule(struct hash *h, const char *cn, const uint32_t cn_hash)
-{
-    struct hash_element *he = hash_lookup_fast(h, hash_bucket(h, cn_hash), cn, cn_hash);
-    if (he)
-    {
-        return (struct pf_cn *) he->value;
-    }
-    else
-    {
-        return NULL;
-    }
-}
-
-bool
-pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const int type, const char *prefix)
-{
-    if (pfs && !pfs->kill)
-    {
-        const char *cn;
-        uint32_t cn_hash;
-        if (tls_common_name_hash(tm, &cn, &cn_hash))
-        {
-            const struct pf_cn *rule = lookup_cn_rule(pfs->cns.hash_table, cn, cn_hash);
-            if (rule)
-            {
-#ifdef ENABLE_DEBUG
-                if (check_debug_level(D_PF_DEBUG))
-                {
-                    pf_cn_test_print("PF_CN_MATCH", type, prefix, cn, !rule->exclude, rule);
-                }
-#endif
-                if (!rule->exclude)
-                {
-                    return true;
-                }
-                else
-                {
-                    return false;
-                }
-            }
-            else
-            {
-#ifdef ENABLE_DEBUG
-                if (check_debug_level(D_PF_DEBUG))
-                {
-                    pf_cn_test_print("PF_CN_DEFAULT", type, prefix, cn, pfs->cns.default_allow, NULL);
-                }
-#endif
-                if (pfs->cns.default_allow)
-                {
-                    return true;
-                }
-                else
-                {
-                    return false;
-                }
-            }
-        }
-    }
-#ifdef ENABLE_DEBUG
-    if (check_debug_level(D_PF_DEBUG))
-    {
-        pf_cn_test_print("PF_CN_FAULT", type, prefix, tls_common_name(tm, false), false, NULL);
-    }
-#endif
-    return false;
-}
-
-bool
-pf_addr_test_dowork(const struct context *src, const struct mroute_addr *dest, const char *prefix)
-{
-    struct pf_set *pfs = src->c2.pf.pfs;
-    if (pfs && !pfs->kill)
-    {
-        const in_addr_t addr = in_addr_t_from_mroute_addr(dest);
-        const struct pf_subnet *se = pfs->sns.list;
-        while (se)
-        {
-            if ((addr & se->rule.netmask) == se->rule.network)
-            {
-#ifdef ENABLE_DEBUG
-                if (check_debug_level(D_PF_DEBUG))
-                {
-                    pf_addr_test_print("PF_ADDR_MATCH", prefix, src, dest, !se->rule.exclude, &se->rule);
-                }
-#endif
-                return !se->rule.exclude;
-            }
-            se = se->next;
-        }
-#ifdef ENABLE_DEBUG
-        if (check_debug_level(D_PF_DEBUG))
-        {
-            pf_addr_test_print("PF_ADDR_DEFAULT", prefix, src, dest, pfs->sns.default_allow, NULL);
-        }
-#endif
-        return pfs->sns.default_allow;
-    }
-    else
-    {
-#ifdef ENABLE_DEBUG
-        if (check_debug_level(D_PF_DEBUG))
-        {
-            pf_addr_test_print("PF_ADDR_FAULT", prefix, src, dest, false, NULL);
-        }
-#endif
-        return false;
-    }
-}
-
-#ifdef PLUGIN_PF
-void
-pf_check_reload(struct context *c)
-{
-    const int slow_wakeup = 15;
-    const int fast_wakeup = 1;
-    const int wakeup_transition = 60;
-    bool reloaded = false;
-
-    if (c->c2.pf.filename)
-    {
-        platform_stat_t s;
-        if (!platform_stat(c->c2.pf.filename, &s))
-        {
-            if (s.st_mtime > c->c2.pf.file_last_mod)
-            {
-                struct pf_set *pfs = pf_init_from_file(c->c2.pf.filename);
-                if (pfs)
-                {
-                    if (c->c2.pf.pfs)
-                    {
-                        pf_destroy(c->c2.pf.pfs);
-                    }
-                    c->c2.pf.pfs = pfs;
-                    reloaded = true;
-                    if (pf_kill_test(pfs))
-                    {
-                        c->sig->signal_received = SIGTERM;
-                        c->sig->signal_text = "pf-kill";
-                    }
-                }
-                c->c2.pf.file_last_mod = s.st_mtime;
-            }
-        }
-        {
-            int wakeup = slow_wakeup;
-            if (!c->c2.pf.pfs && c->c2.pf.n_check_reload < wakeup_transition)
-            {
-                wakeup = fast_wakeup;
-            }
-            event_timeout_init(&c->c2.pf.reload, wakeup, now);
-            reset_coarse_timers(c);
-            c->c2.pf.n_check_reload++;
-        }
-    }
-#ifdef ENABLE_DEBUG
-    if (reloaded && check_debug_level(D_PF_DEBUG))
-    {
-        pf_context_print(&c->c2.pf, "pf_check_reload", D_PF_DEBUG);
-    }
-#endif
-}
-#endif /* ifdef PLUGIN_PF */
-
-#ifdef MANAGEMENT_PF
-bool
-pf_load_from_buffer_list(struct context *c, const struct buffer_list *config)
-{
-    struct pf_set *pfs = pf_init(config, "[SERVER-PF]", false);
-    if (pfs)
-    {
-        if (c->c2.pf.pfs)
-        {
-            pf_destroy(c->c2.pf.pfs);
-        }
-        c->c2.pf.pfs = pfs;
-        return true;
-    }
-    else
-    {
-        return false;
-    }
-}
-#endif
-
-void
-pf_init_context(struct context *c)
-{
-#ifdef PLUGIN_PF
-    if (plugin_defined(c->plugins, OPENVPN_PLUGIN_ENABLE_PF))
-    {
-        c->c2.pf.filename = platform_create_temp_file(c->options.tmp_dir, "pf",
-                                                      &c->c2.gc);
-        if (c->c2.pf.filename)
-        {
-            setenv_str(c->c2.es, "pf_file", c->c2.pf.filename);
-
-            if (plugin_call(c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, NULL, c->c2.es) == OPENVPN_PLUGIN_FUNC_SUCCESS)
-            {
-                event_timeout_init(&c->c2.pf.reload, 1, now);
-                c->c2.pf.enabled = true;
-#ifdef ENABLE_DEBUG
-                if (check_debug_level(D_PF_DEBUG))
-                {
-                    pf_context_print(&c->c2.pf, "pf_init_context#1", D_PF_DEBUG);
-                }
-#endif
-            }
-        }
-        if (!c->c2.pf.enabled)
-        {
-            /* At some point in openvpn history, this code just printed a
-             * warning and signalled itself (SIGUSR1, "plugin-pf-init-failed")
-             * to terminate the client instance.  This got broken at one of
-             * the client auth state refactorings (leading to SIGSEGV crashes)
-             * and due to "pf will be removed anyway" reasons the easiest way
-             * to prevent crashes is to REQUIRE that plugins succeed - so if
-             * the plugin fails, we cleanly abort OpenVPN
-             *
-             * see also: https://community.openvpn.net/openvpn/ticket/1377
-             */
-            msg(M_FATAL, "FATAL: failed to init PF plugin, must succeed.");
-            return;
-        }
-    }
-#endif /* ifdef PLUGIN_PF */
-#ifdef MANAGEMENT_PF
-    if (!c->c2.pf.enabled && management_enable_pf(management))
-    {
-        c->c2.pf.enabled = true;
-#ifdef ENABLE_DEBUG
-        if (check_debug_level(D_PF_DEBUG))
-        {
-            pf_context_print(&c->c2.pf, "pf_init_context#2", D_PF_DEBUG);
-        }
-#endif
-    }
-#endif
-}
-
-void
-pf_destroy_context(struct pf_context *pfc)
-{
-#ifdef PLUGIN_PF
-    if (pfc->filename)
-    {
-        platform_unlink(pfc->filename);
-    }
-#endif
-    if (pfc->pfs)
-    {
-        pf_destroy(pfc->pfs);
-    }
-}
-
-#ifdef ENABLE_DEBUG
-
-static void
-pf_subnet_set_print(const struct pf_subnet_set *s, const int lev)
-{
-    struct gc_arena gc = gc_new();
-    if (s)
-    {
-        struct pf_subnet *e;
-
-        msg(lev, "  ----- struct pf_subnet_set -----");
-        msg(lev, "  default_allow=%s", drop_accept(s->default_allow));
-
-        for (e = s->list; e != NULL; e = e->next)
-        {
-            msg(lev, "   %s/%s %s",
-                print_in_addr_t(e->rule.network, 0, &gc),
-                print_in_addr_t(e->rule.netmask, 0, &gc),
-                drop_accept(!e->rule.exclude));
-        }
-    }
-    gc_free(&gc);
-}
-
-static void
-pf_cn_set_print(const struct pf_cn_set *s, const int lev)
-{
-    if (s)
-    {
-        struct hash_iterator hi;
-        struct hash_element *he;
-
-        msg(lev, "  ----- struct pf_cn_set -----");
-        msg(lev, "  default_allow=%s", drop_accept(s->default_allow));
-
-        if (s->hash_table)
-        {
-            hash_iterator_init(s->hash_table, &hi);
-            while ((he = hash_iterator_next(&hi)))
-            {
-                struct pf_cn *e = (struct pf_cn *)he->value;
-                msg(lev, "   %s %s",
-                    e->cn,
-                    drop_accept(!e->exclude));
-            }
-
-            msg(lev, "  ----------");
-
-            {
-                struct pf_cn_elem *ce;
-                for (ce = s->list; ce != NULL; ce = ce->next)
-                {
-                    struct pf_cn *e = lookup_cn_rule(s->hash_table, ce->rule.cn, cn_hash_function(ce->rule.cn, 0));
-                    if (e)
-                    {
-                        msg(lev, "   %s %s",
-                            e->cn,
-                            drop_accept(!e->exclude));
-                    }
-                    else
-                    {
-                        msg(lev, "   %s LOOKUP FAILED", ce->rule.cn);
-                    }
-                }
-            }
-        }
-    }
-}
-
-static void
-pf_set_print(const struct pf_set *pfs, const int lev)
-{
-    if (pfs)
-    {
-        msg(lev, " ----- struct pf_set -----");
-        msg(lev, " kill=%d", pfs->kill);
-        pf_subnet_set_print(&pfs->sns, lev);
-        pf_cn_set_print(&pfs->cns, lev);
-    }
-}
-
-void
-pf_context_print(const struct pf_context *pfc, const char *prefix, const int lev)
-{
-    msg(lev, "----- %s : struct pf_context -----", prefix);
-    if (pfc)
-    {
-        msg(lev, "enabled=%d", pfc->enabled);
-#ifdef PLUGIN_PF
-        msg(lev, "filename='%s'", np(pfc->filename));
-        msg(lev, "file_last_mod=%u", (unsigned int)pfc->file_last_mod);
-        msg(lev, "n_check_reload=%u", pfc->n_check_reload);
-        msg(lev, "reload=[%d,%u,%u]", pfc->reload.defined, pfc->reload.n, (unsigned int)pfc->reload.last);
-#endif
-        pf_set_print(pfc->pfs, lev);
-    }
-    msg(lev, "--------------------");
-}
-
-#endif /* ifdef ENABLE_DEBUG */
-
-#endif /* if defined(ENABLE_PF) */
diff --git a/src/openvpn/pf.h b/src/openvpn/pf.h
deleted file mode 100644
index 609c842e..00000000
--- a/src/openvpn/pf.h
+++ /dev/null
@@ -1,147 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-/* packet filter functions */
-
-#if defined(ENABLE_PF) && !defined(OPENVPN_PF_H)
-#define OPENVPN_PF_H
-
-#include "list.h"
-#include "mroute.h"
-
-#define PF_MAX_LINE_LEN 256
-
-#define PCT_SRC  1
-#define PCT_DEST 2
-
-struct context;
-
-struct ipv4_subnet {
-    bool exclude;
-    in_addr_t network;
-    in_addr_t netmask;
-};
-
-struct pf_subnet {
-    struct pf_subnet *next;
-    struct ipv4_subnet rule;
-};
-
-struct pf_subnet_set {
-    bool default_allow;
-    struct pf_subnet *list;
-};
-
-struct pf_cn {
-    bool exclude;
-    char *cn;
-};
-
-struct pf_cn_elem {
-    struct pf_cn_elem *next;
-    struct pf_cn rule;
-};
-
-struct pf_cn_set {
-    bool default_allow;
-    struct pf_cn_elem *list;
-    struct hash *hash_table;
-};
-
-struct pf_set {
-    bool kill;
-    struct pf_subnet_set sns;
-    struct pf_cn_set cns;
-};
-
-struct pf_context {
-    bool enabled;
-    struct pf_set *pfs;
-#ifdef PLUGIN_PF
-    const char *filename;
-    time_t file_last_mod;
-    unsigned int n_check_reload;
-    struct event_timeout reload;
-#endif
-};
-
-void pf_init_context(struct context *c);
-
-void pf_destroy_context(struct pf_context *pfc);
-
-#ifdef PLUGIN_PF
-void pf_check_reload(struct context *c);
-
-#endif
-
-#ifdef MANAGEMENT_PF
-bool pf_load_from_buffer_list(struct context *c, const struct buffer_list *config);
-
-#endif
-
-#ifdef ENABLE_DEBUG
-void pf_context_print(const struct pf_context *pfc, const char *prefix, const int lev);
-
-#endif
-
-bool pf_addr_test_dowork(const struct context *src,
-                         const struct mroute_addr *dest, const char *prefix);
-
-static inline bool
-pf_addr_test(const struct pf_context *src_pf, const struct context *src,
-             const struct mroute_addr *dest, const char *prefix)
-{
-    if (src_pf->enabled)
-    {
-        return pf_addr_test_dowork(src, dest, prefix);
-    }
-    else
-    {
-        return true;
-    }
-}
-
-/*
- * Inline functions
- */
-
-bool pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const int type,
-                const char *prefix);
-
-static inline bool
-pf_c2c_test(const struct pf_context *src_pf, const struct tls_multi *src,
-            const struct pf_context *dest_pf, const struct tls_multi *dest,
-            const char *prefix)
-{
-    return (!src_pf->enabled || pf_cn_test(src_pf->pfs, dest, PCT_DEST, prefix))
-           && (!dest_pf->enabled || pf_cn_test(dest_pf->pfs, src, PCT_SRC,
-                                               prefix));
-}
-
-static inline bool
-pf_kill_test(const struct pf_set *pfs)
-{
-    return pfs->kill;
-}
-
-#endif /* if defined(ENABLE_PF) && !defined(OPENVPN_PF_H) */
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 7f580c27..d5704e07 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -119,9 +119,6 @@ plugin_type_name(const int type)
         case OPENVPN_PLUGIN_TLS_FINAL:
             return "PLUGIN_TLS_FINAL";
 
-        case OPENVPN_PLUGIN_ENABLE_PF:
-            return "PLUGIN_ENABLE_PF";
-
         case OPENVPN_PLUGIN_ROUTE_PREDOWN:
             return "PLUGIN_ROUTE_PREDOWN";
 
@@ -804,7 +801,6 @@ plugin_call_ssl(const struct plugin_list *pl,
         int i;
         const char **envp;
         const int n = plugin_n(pl);
-        bool success = false;
         bool error = false;
         bool deferred = false;
 
@@ -825,7 +821,6 @@ plugin_call_ssl(const struct plugin_list *pl,
             switch (status)
             {
                 case OPENVPN_PLUGIN_FUNC_SUCCESS:
-                    success = true;
                     break;
 
                 case OPENVPN_PLUGIN_FUNC_DEFERRED:
@@ -845,11 +840,7 @@ plugin_call_ssl(const struct plugin_list *pl,
 
         gc_free(&gc);
 
-        if (type == OPENVPN_PLUGIN_ENABLE_PF && success)
-        {
-            return OPENVPN_PLUGIN_FUNC_SUCCESS;
-        }
-        else if (error)
+        if (error)
         {
             return OPENVPN_PLUGIN_FUNC_ERROR;
         }
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 3ab24b85..db839034 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -464,9 +464,6 @@ struct tls_session
 
     struct cert_hash_set *cert_hash_set;
 
-#ifdef ENABLE_PF
-    uint32_t common_name_hashval;
-#endif
 
     bool verified;              /* true if peer certificate was verified against CA */
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 913c9562..b745b3c7 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -95,27 +95,11 @@ set_common_name(struct tls_session *session, const char *common_name)
     {
         free(session->common_name);
         session->common_name = NULL;
-#ifdef ENABLE_PF
-        session->common_name_hashval = 0;
-#endif
     }
     if (common_name)
     {
         /* FIXME: Last alloc will never be freed */
         session->common_name = string_alloc(common_name, NULL);
-#ifdef ENABLE_PF
-        {
-            const uint32_t len = (uint32_t) strlen(common_name);
-            if (len)
-            {
-                session->common_name_hashval = hash_func((const uint8_t *)common_name, len+1, 0);
-            }
-            else
-            {
-                session->common_name_hashval = 0;
-            }
-        }
-#endif
     }
 }
 
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 11518d96..d19673cc 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -161,34 +161,6 @@ const char *tls_username(const struct tls_multi *multi, const bool null);
  */
 bool cert_hash_compare(const struct cert_hash_set *chs1, const struct cert_hash_set *chs2);
 
-#ifdef ENABLE_PF
-
-/**
- * Retrieve the given tunnel's common name and its hash value.
- *
- * @param multi         The tunnel to use
- * @param cn            Common name's string
- * @param cn_hash       Common name's hash value
- *
- * @return true if the common name was set, false otherwise.
- */
-static inline bool
-tls_common_name_hash(const struct tls_multi *multi, const char **cn, uint32_t *cn_hash)
-{
-    if (multi)
-    {
-        const struct tls_session *s = &multi->session[TM_ACTIVE];
-        if (s->common_name && s->common_name[0] != '\0')
-        {
-            *cn = s->common_name;
-            *cn_hash = s->common_name_hashval;
-            return true;
-        }
-    }
-    return false;
-}
-
-#endif
 
 /**
  * Verify the given username and password, using either an external script, a
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 9538c938..a16084c4 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -475,19 +475,6 @@ socket_defined(const socket_descriptor_t sd)
 #define ENABLE_PREDICTION_RESISTANCE
 #endif /* ENABLE_CRYPTO_MBEDTLS */
 
-/*
- * Enable packet filter?
- */
-#if defined(ENABLE_PF) && defined(ENABLE_PLUGIN) && defined(HAVE_STAT)
-#define PLUGIN_PF
-#endif
-#if defined(ENABLE_PF) && defined(ENABLE_MANAGEMENT)
-#define MANAGEMENT_PF
-#endif
-#if !defined(PLUGIN_PF) && !defined(MANAGEMENT_PF)
-#undef ENABLE_PF
-#endif
-
 /*
  * Do we support Unix domain sockets?
  */
-- 
2.31.1


