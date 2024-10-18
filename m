From: Gert Doering <gert@...1296...>
Date: Fri, 18 Oct 2024 08:37:17 +0200
Message-ID: <20241018063717.14629-1-gert@...1296...>
In-Reply-To: <gerrit.1729216832000.I0d96ee06c355c6a5ce082af23921e329d3efae33@...2715...>
References: <gerrit.1729216832000.I0d96ee06c355c6a5ce082af23921e329d3efae33@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove a large number of unused structs
 and functions
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

From: Arne Schwabe <arne@...1227...>

These have been found by Clion's Inspect Code functionality and have
been verified by hand.  A few functions like buf_read_u32 have been
kept since they still feel being useful while currently not being used.

Change-Id: I0d96ee06c355c6a5ce082af23921e329d3efae33
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/783
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 9ee76aa..b2a5bf5 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -296,24 +296,6 @@
     }
 }
 
-/*
- * convert a multi-line output to one line
- */
-void
-convert_to_one_line(struct buffer *buf)
-{
-    uint8_t *cp = BPTR(buf);
-    int len = BLEN(buf);
-    while (len--)
-    {
-        if (*cp == '\n')
-        {
-            *cp = '|';
-        }
-        ++cp;
-    }
-}
-
 bool
 buffer_write_file(const char *filename, const struct buffer *buf)
 {
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 8a40010..2f804fb 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -487,11 +487,6 @@
 void buf_catrunc(struct buffer *buf, const char *str);
 
 /*
- * convert a multi-line output to one line
- */
-void convert_to_one_line(struct buffer *buf);
-
-/*
  * Parse a string based on a given delimiter char
  */
 bool buf_parse(struct buffer *buf, const int delim, char *line, const int size);
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 48d1e20..a966a7a 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -75,7 +75,6 @@
 #define MD5_DIGEST_LENGTH       16
 #define SHA_DIGEST_LENGTH       20
 #define SHA256_DIGEST_LENGTH    32
-#define DES_KEY_LENGTH 8
 
 /**
  * Returns a singleton instance of the mbed TLS random number generator.
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 4cd988a..288c2fa 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -93,7 +93,6 @@
 /** Cipher should decrypt */
 #define OPENVPN_OP_DECRYPT      0
 
-#define DES_KEY_LENGTH 8
 #define MD4_DIGEST_LENGTH       16
 
 /**
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index ab2872a..9a4577b 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -297,10 +297,6 @@
 
 extern const char *x_msg_prefix;
 
-void msg_thread_init(void);
-
-void msg_thread_uninit(void);
-
 static inline void
 msg_set_prefix(const char *prefix)
 {
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index c3eb2ef..3cd0ee7 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -137,8 +137,6 @@
     struct event_timeout wakeup; /**< Timeout structure used by the main
                                   *   event loop to know when to do
                                   *   fragmentation housekeeping. */
-    bool received_os_mtu_hint;  /**< Whether the operating system has
-                                 *   explicitly recommended an MTU value. */
 #define N_SEQ_ID            256
     /**< One more than the maximum fragment
      *   sequence ID, above which the IDs wrap
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ae911a9..9371024 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -816,8 +816,6 @@
 bool
 init_static(void)
 {
-    /* configure_path (); */
-
 #if defined(DMALLOC)
     crypto_init_dmalloc();
 #endif
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 05b5a1a..f296788 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3797,16 +3797,6 @@
 }
 
 /*
- * Return true if (from the management interface's perspective) OpenVPN should
- * daemonize.
- */
-bool
-management_should_daemonize(struct management *man)
-{
-    return management_would_hold(man) || (man->settings.flags & MF_QUERY_PASSWORDS);
-}
-
-/*
  * If the hold flag is enabled, hibernate until a management client releases the hold.
  * Return true if the caller should not sleep for an additional time interval.
  */
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 1896510..f501543 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -390,8 +390,6 @@
 
 #endif
 
-bool management_should_daemonize(struct management *man);
-
 bool management_would_hold(struct management *man);
 
 bool management_hold(struct management *man, int holdtime);
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index cdfb0de..3c46c02 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -186,9 +186,6 @@
  */
 const char *safe_print(const char *str, struct gc_arena *gc);
 
-
-void configure_path(void);
-
 const char *sanitize_control_message(const char *str, struct gc_arena *gc);
 
 /*
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 96408d1..3ae8be7 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -63,14 +63,6 @@
 
 #define MTCP_N           ((void *)16) /* upper bound on MTCP_x */
 
-struct ta_iow_flags
-{
-    unsigned int flags;
-    unsigned int ret;
-    unsigned int tun;
-    unsigned int sock;
-};
-
 #ifdef ENABLE_DEBUG
 static const char *
 pract(int action)
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index 886d2cc..ab968e9 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -58,9 +58,6 @@
 
 void multi_tcp_instance_specific_free(struct multi_instance *mi);
 
-void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_instance *mi);
-
-
 /**************************************************************************/
 /**
  * Main event loop for OpenVPN in TCP server mode.
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index e98c93e..8dfcab4 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -200,10 +200,6 @@
     /**< Hash of option strings received from the
      *   remote OpenVPN server.  Only used in
      *   client-mode. */
-
-    struct user_pass *auth_user_pass;
-    /**< Username and password for
-     *   authentication. */
 };
 
 
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 558361a..3778d19 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -318,23 +318,6 @@
     return p->id >= PACKET_ID_WRAP_TRIGGER;
 }
 
-static inline bool
-check_timestamp_delta(time_t remote, unsigned int max_delta)
-{
-    unsigned int abs;
-    const time_t local_now = now;
-
-    if (local_now >= remote)
-    {
-        abs = local_now - remote;
-    }
-    else
-    {
-        abs = remote - local_now;
-    }
-    return abs <= max_delta;
-}
-
 static inline void
 packet_id_reap_test(struct packet_id_rec *p)
 {
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 3d9d59e..d1cb7d1 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -483,19 +483,6 @@
 #endif
 }
 
-/*
- * Go to sleep indefinitely.
- */
-void
-platform_sleep_until_signal(void)
-{
-#ifdef _WIN32
-    ASSERT(0);
-#else
-    select(0, NULL, NULL, NULL, NULL);
-#endif
-}
-
 /* delete a file, return true if succeeded */
 bool
 platform_unlink(const char *filename)
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 181cb71..81c222c 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -131,13 +131,9 @@
 
 void platform_sleep_milliseconds(unsigned int n);
 
-void platform_sleep_until_signal(void);
-
 /* delete a file, return true if succeeded */
 bool platform_unlink(const char *filename);
 
-int platform_putenv(char *string);
-
 FILE *platform_fopen(const char *path, const char *mode);
 
 int platform_open(const char *path, int flags, int mode);
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index a160fb6..7b94fbc 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -83,25 +83,6 @@
 #define SIZE_ETH_TO_8021Q_HDR (sizeof(struct openvpn_8021qhdr) \
                                - sizeof(struct openvpn_ethhdr))
 
-
-struct openvpn_arp {
-#define ARP_MAC_ADDR_TYPE 0x0001
-    uint16_t mac_addr_type;     /* 0x0001 */
-
-    uint16_t proto_addr_type;   /* 0x0800 */
-    uint8_t mac_addr_size;      /* 0x06 */
-    uint8_t proto_addr_size;    /* 0x04 */
-
-#define ARP_REQUEST 0x0001
-#define ARP_REPLY   0x0002
-    uint16_t arp_command;       /* 0x0001 for ARP request, 0x0002 for ARP reply */
-
-    uint8_t mac_src[OPENVPN_ETH_ALEN];
-    in_addr_t ip_src;
-    uint8_t mac_dest[OPENVPN_ETH_ALEN];
-    in_addr_t ip_dest;
-};
-
 struct openvpn_iphdr {
 #define OPENVPN_IPH_GET_VER(v) (((v) >> 4) & 0x0F)
 #define OPENVPN_IPH_GET_LEN(v) (((v) & 0x0F) << 2)
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index d9e598c..1475b87 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -61,12 +61,6 @@
     bool nocache;
 };
 
-struct http_proxy_options_simple {
-    const char *server;
-    const char *port;
-    int auth_retry;
-};
-
 struct http_proxy_info {
     bool defined;
     int auth_method;
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index f0d4d7d..1be29ae 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -30,8 +30,6 @@
 #include "buffer.h"
 #include "ssl.h"
 
-typedef void (*post_fork_cleanup_func_t)(void *arg);
-
 struct port_share {
     /* Foreground's socket to background process */
     socket_descriptor_t foreground_fd;
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index 8eb8db1..4783ebc 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -89,12 +89,6 @@
     shaper_reset_wakeup(s);
 }
 
-static inline int
-shaper_current_bandwidth(struct shaper *s)
-{
-    return s->bytes_per_second;
-}
-
 /*
  * Returns traffic shaping delay in microseconds relative to current
  * time, or 0 if no delay.
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 2e583af..04eb8a4 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -362,16 +362,6 @@
 
 static inline
 const char *
-print_openvpn_sockaddr_ex(const struct openvpn_sockaddr *addr,
-                          const char *separator,
-                          const unsigned int flags,
-                          struct gc_arena *gc)
-{
-    return print_sockaddr_ex(&addr->addr.sa, separator, flags, gc);
-}
-
-static inline
-const char *
 print_openvpn_sockaddr(const struct openvpn_sockaddr *addr,
                        struct gc_arena *gc)
 {
@@ -771,22 +761,6 @@
     return false;
 }
 
-static inline in_addr_t
-addr_host(const struct openvpn_sockaddr *addr)
-{
-    /*
-     * "public" addr returned is checked against ifconfig for
-     * possible clash: non sense for now given
-     * that we do ifconfig only IPv4
-     */
-    if (addr->addr.sa.sa_family != AF_INET)
-    {
-        return 0;
-    }
-    return ntohl(addr->addr.in4.sin_addr.s_addr);
-}
-
-
 static inline bool
 addrlist_port_match(const struct openvpn_sockaddr *a1, const struct addrinfo *a2)
 {
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 6b860b4..0fb4697 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -49,7 +49,6 @@
 #define teststr1 "one"
 #define teststr2 "two"
 #define teststr3 "three"
-#define teststr4 "four"
 
 #define assert_buf_equals_str(buf, str) \
     assert_int_equal(BLEN(buf), strlen(str)); \
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 741c982..ebffabe 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -69,11 +69,6 @@
     return "dummy print_link_socket_actual from unit test";
 }
 
-struct test_pkt_context {
-    struct tls_auth_standalone tas_tls_auth;
-    struct tls_auth_standalone tas_crypt;
-};
-
 const char static_key[] = "<tls-auth>\n"
                           "-----BEGIN OpenVPN Static key V1-----\n"
                           "37268ea8f95d7f71f9fb8fc03770c460\n"

