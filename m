From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 18 Oct 2024 02:00:39 +0000
References: <gerrit.1729216832000.I0d96ee06c355c6a5ce082af23921e329d3efae33@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <edd31b0d28a97e59bcfa3d79d472b51efcaf7c96-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vBhWXldFaoQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove a large
 number of unused structs and functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vBhWXldFaoQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/783?usp=3Demail

to review the following change.


Change subject: Remove a large number of unused structs and functions
......................................................................

Remove a large number of unused structs and functions

These have been found by Clion's Inspect Code functionality and have
been verified by hand.  A few functions like buf_read_u32 have been
kept since they still feel being useful while currently not being used.

Change-Id: I0d96ee06c355c6a5ce082af23921e329d3efae33
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/crypto_mbedtls.h
M src/openvpn/crypto_openssl.h
M src/openvpn/error.h
M src/openvpn/fragment.h
M src/openvpn/init.c
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/misc.h
M src/openvpn/mtcp.c
M src/openvpn/mtcp.h
M src/openvpn/openvpn.h
M src/openvpn/packet_id.h
M src/openvpn/platform.c
M src/openvpn/platform.h
M src/openvpn/proto.h
M src/openvpn/proxy.h
M src/openvpn/ps.h
M src/openvpn/shaper.h
M src/openvpn/socket.h
M tests/unit_tests/openvpn/test_buffer.c
M tests/unit_tests/openvpn/test_pkt.c
23 files changed, 0 insertions(+), 162 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/783/1

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
-    uint8_t *cp =3D BPTR(buf);
-    int len =3D BLEN(buf);
-    while (len--)
-    {
-        if (*cp =3D=3D '\n')
-        {
-            *cp =3D '|';
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
 bool buf_parse(struct buffer *buf, const int delim, char *line, const int =
size);
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
=20
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
-                                 *   explicitly recommended an MTU value. =
*/
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
- * Return true if (from the management interface's perspective) OpenVPN sh=
ould
- * daemonize.
- */
-bool
-management_should_daemonize(struct management *man)
-{
-    return management_would_hold(man) || (man->settings.flags & MF_QUERY_P=
ASSWORDS);
-}
-
-/*
  * If the hold flag is enabled, hibernate until a management client releas=
es the hold.
  * Return true if the caller should not sleep for an additional time inter=
val.
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

-void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_ins=
tance *mi);
-
-
 /*************************************************************************=
*/
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
     return p->id >=3D PACKET_ID_WRAP_TRIGGER;
 }

-static inline bool
-check_timestamp_delta(time_t remote, unsigned int max_delta)
-{
-    unsigned int abs;
-    const time_t local_now =3D now;
-
-    if (local_now >=3D remote)
-    {
-        abs =3D local_now - remote;
-    }
-    else
-    {
-        abs =3D remote - local_now;
-    }
-    return abs <=3D max_delta;
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
-    uint16_t arp_command;       /* 0x0001 for ARP request, 0x0002 for ARP =
reply */
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
-    if (addr->addr.sa.sa_family !=3D AF_INET)
-    {
-        return 0;
-    }
-    return ntohl(addr->addr.in4.sin_addr.s_addr);
-}
-
-
 static inline bool
 addrlist_port_match(const struct openvpn_sockaddr *a1, const struct addrin=
fo *a2)
 {
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
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
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
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
 const char static_key[] =3D "<tls-auth>\n"
                           "-----BEGIN OpenVPN Static key V1-----\n"
                           "37268ea8f95d7f71f9fb8fc03770c460\n"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/783?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0d96ee06c355c6a5ce082af23921e329d3efae33
Gerrit-Change-Number: 783
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--vBhWXldFaoQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/783?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove a large number of unused structs and functions<br><br>=
These have been found by Clion&#39;s Inspect Code functionality and have<br=
>been verified by hand.  A few functions like buf_read_u32 have been<br>kep=
t since they still feel being useful while currently not being used.<br><br=
>Change-Id: I0d96ee06c355c6a5ce082af23921e329d3efae33<br>Signed-off-by: Arn=
e Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/buffer.c<br>M src=
/openvpn/buffer.h<br>M src/openvpn/crypto_mbedtls.h<br>M src/openvpn/crypto=
_openssl.h<br>M src/openvpn/error.h<br>M src/openvpn/fragment.h<br>M src/op=
envpn/init.c<br>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>M src/o=
penvpn/misc.h<br>M src/openvpn/mtcp.c<br>M src/openvpn/mtcp.h<br>M src/open=
vpn/openvpn.h<br>M src/openvpn/packet_id.h<br>M src/openvpn/platform.c<br>M=
 src/openvpn/platform.h<br>M src/openvpn/proto.h<br>M src/openvpn/proxy.h<b=
r>M src/openvpn/ps.h<br>M src/openvpn/shaper.h<br>M src/openvpn/socket.h<br=
>M tests/unit_tests/openvpn/test_buffer.c<br>M tests/unit_tests/openvpn/tes=
t_pkt.c<br>23 files changed, 0 insertions(+), 162 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/783/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span>i=
ndex 9ee76aa..b2a5bf5 100644</span><br><span>--- a/src/openvpn/buffer.c</sp=
an><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -296,24 +296,6 @=
@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * convert a multi-line output to one line</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-convert_to_one_line(struct buffer *buf)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    uint8_t *cp =3D BPTR(buf);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int len =3D BLEN(buf);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    while (len--)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (*cp =3D=3D &#39;\n&#39;)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            *cp =3D &#39;|&#39;;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        ++cp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> buf=
fer_write_file(const char *filename, const struct buffer *buf)</span><br><s=
pan> {</span><br><span>diff --git a/src/openvpn/buffer.h b/src/openvpn/buff=
er.h</span><br><span>index 8a40010..2f804fb 100644</span><br><span>--- a/sr=
c/openvpn/buffer.h</span><br><span>+++ b/src/openvpn/buffer.h</span><br><sp=
an>@@ -487,11 +487,6 @@</span><br><span> void buf_catrunc(struct buffer *bu=
f, const char *str);</span><br><span> </span><br><span> /*</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * convert a multi-line output to one =
line</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void convert_to_one_line(struct buf=
fer *buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Parse a s=
tring based on a given delimiter char</span><br><span>  */</span><br><span>=
 bool buf_parse(struct buffer *buf, const int delim, char *line, const int =
size);</span><br><span>diff --git a/src/openvpn/crypto_mbedtls.h b/src/open=
vpn/crypto_mbedtls.h</span><br><span>index 48d1e20..a966a7a 100644</span><b=
r><span>--- a/src/openvpn/crypto_mbedtls.h</span><br><span>+++ b/src/openvp=
n/crypto_mbedtls.h</span><br><span>@@ -75,7 +75,6 @@</span><br><span> #defi=
ne MD5_DIGEST_LENGTH       16</span><br><span> #define SHA_DIGEST_LENGTH   =
    20</span><br><span> #define SHA256_DIGEST_LENGTH    32</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define DES_KEY_LENGTH 8</span><br><sp=
an> </span><br><span> /**</span><br><span>  * Returns a singleton instance =
of the mbed TLS random number generator.</span><br><span>diff --git a/src/o=
penvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h</span><br><span>inde=
x 4cd988a..288c2fa 100644</span><br><span>--- a/src/openvpn/crypto_openssl.=
h</span><br><span>+++ b/src/openvpn/crypto_openssl.h</span><br><span>@@ -93=
,7 +93,6 @@</span><br><span> /** Cipher should decrypt */</span><br><span> =
#define OPENVPN_OP_DECRYPT      0</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define DES_KEY_LENGTH 8</span><br><span> #=
define MD4_DIGEST_LENGTH       16</span><br><span> </span><br><span> /**</s=
pan><br><span>diff --git a/src/openvpn/error.h b/src/openvpn/error.h</span>=
<br><span>index ab2872a..9a4577b 100644</span><br><span>--- a/src/openvpn/e=
rror.h</span><br><span>+++ b/src/openvpn/error.h</span><br><span>@@ -297,10=
 +297,6 @@</span><br><span> </span><br><span> extern const char *x_msg_pref=
ix;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
void msg_thread_init(void);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void msg_thread=
_uninit(void);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> static inline void</span><br><span> msg_set_prefix(const char *p=
refix)</span><br><span> {</span><br><span>diff --git a/src/openvpn/fragment=
.h b/src/openvpn/fragment.h</span><br><span>index c3eb2ef..3cd0ee7 100644</=
span><br><span>--- a/src/openvpn/fragment.h</span><br><span>+++ b/src/openv=
pn/fragment.h</span><br><span>@@ -137,8 +137,6 @@</span><br><span>     stru=
ct event_timeout wakeup; /**&lt; Timeout structure used by the main</span><=
br><span>                                   *   event loop to know when to =
do</span><br><span>                                   *   fragmentation hou=
sekeeping. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool=
 received_os_mtu_hint;  /**&lt; Whether the operating system has</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
 *   explicitly recommended an MTU value. */</span><br><span> #define N_SEQ=
_ID            256</span><br><span>     /**&lt; One more than the maximum f=
ragment</span><br><span>      *   sequence ID, above which the IDs wrap</sp=
an><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br=
><span>index ae911a9..9371024 100644</span><br><span>--- a/src/openvpn/init=
.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -816,8 +816,=
6 @@</span><br><span> bool</span><br><span> init_static(void)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* configure=
_path (); */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> #if defined(DMALLOC)</span><br><span>     crypto_init_dmalloc();</=
span><br><span> #endif</span><br><span>diff --git a/src/openvpn/manage.c b/=
src/openvpn/manage.c</span><br><span>index 05b5a1a..f296788 100644</span><b=
r><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage=
.c</span><br><span>@@ -3797,16 +3797,6 @@</span><br><span> }</span><br><spa=
n> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * Return true if (from the management interface&#39;s perspective) OpenV=
PN should</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * daemonize=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-management_should_daemonize(struct management *man)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return management_would_hold(man) || (m=
an-&gt;settings.flags &amp; MF_QUERY_PASSWORDS);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><=
span>  * If the hold flag is enabled, hibernate until a management client r=
eleases the hold.</span><br><span>  * Return true if the caller should not =
sleep for an additional time interval.</span><br><span>  */</span><br><span=
>diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h</span><br><span>i=
ndex 1896510..f501543 100644</span><br><span>--- a/src/openvpn/manage.h</sp=
an><br><span>+++ b/src/openvpn/manage.h</span><br><span>@@ -390,8 +390,6 @@=
</span><br><span> </span><br><span> #endif</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-bool management_should_daemonize(str=
uct management *man);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> bool management_would_hold(struct management *man);</span=
><br><span> </span><br><span> bool management_hold(struct management *man, =
int holdtime);</span><br><span>diff --git a/src/openvpn/misc.h b/src/openvp=
n/misc.h</span><br><span>index cdfb0de..3c46c02 100644</span><br><span>--- =
a/src/openvpn/misc.h</span><br><span>+++ b/src/openvpn/misc.h</span><br><sp=
an>@@ -186,9 +186,6 @@</span><br><span>  */</span><br><span> const char *sa=
fe_print(const char *str, struct gc_arena *gc);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void configure_path(void);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> const char *sanitize_control_=
message(const char *str, struct gc_arena *gc);</span><br><span> </span><br>=
<span> /*</span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtc=
p.c</span><br><span>index 96408d1..3ae8be7 100644</span><br><span>--- a/src=
/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@=
 -63,14 +63,6 @@</span><br><span> </span><br><span> #define MTCP_N         =
  ((void *)16) /* upper bound on MTCP_x */</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-struct ta_iow_flags</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    unsigned int flags;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    unsigned int ret;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    unsigned int tun;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    unsigned int sock;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> #ifdef ENABLE_DEBUG</span><br><span> static const char *=
</span><br><span> pract(int action)</span><br><span>diff --git a/src/openvp=
n/mtcp.h b/src/openvpn/mtcp.h</span><br><span>index 886d2cc..ab968e9 100644=
</span><br><span>--- a/src/openvpn/mtcp.h</span><br><span>+++ b/src/openvpn=
/mtcp.h</span><br><span>@@ -58,9 +58,6 @@</span><br><span> </span><br><span=
> void multi_tcp_instance_specific_free(struct multi_instance *mi);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_=
tcp_link_out_deferred(struct multi_context *m, struct multi_instance *mi);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /************************=
**************************************************/</span><br><span> /**</s=
pan><br><span>  * Main event loop for OpenVPN in TCP server mode.</span><br=
><span>diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h</span><br=
><span>index e98c93e..8dfcab4 100644</span><br><span>--- a/src/openvpn/open=
vpn.h</span><br><span>+++ b/src/openvpn/openvpn.h</span><br><span>@@ -200,1=
0 +200,6 @@</span><br><span>     /**&lt; Hash of option strings received fr=
om the</span><br><span>      *   remote OpenVPN server.  Only used in</span=
><br><span>      *   client-mode. */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct user_pass *auth_user_pass;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    /**&lt; Username and password for</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     *   authentication. */</span><br><span> };</=
span><br><span> </span><br><span> </span><br><span>diff --git a/src/openvpn=
/packet_id.h b/src/openvpn/packet_id.h</span><br><span>index 558361a..3778d=
19 100644</span><br><span>--- a/src/openvpn/packet_id.h</span><br><span>+++=
 b/src/openvpn/packet_id.h</span><br><span>@@ -318,23 +318,6 @@</span><br><=
span>     return p-&gt;id &gt;=3D PACKET_ID_WRAP_TRIGGER;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check=
_timestamp_delta(time_t remote, unsigned int max_delta)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    unsigned int abs;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const time_t local_now =3D now;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (local_now &gt;=3D remote)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        abs =3D local_now - remote;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        abs =3D remote - loc=
al_now;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return abs &lt;=3D max_del=
ta;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline void</=
span><br><span> packet_id_reap_test(struct packet_id_rec *p)</span><br><spa=
n> {</span><br><span>diff --git a/src/openvpn/platform.c b/src/openvpn/plat=
form.c</span><br><span>index 3d9d59e..d1cb7d1 100644</span><br><span>--- a/=
src/openvpn/platform.c</span><br><span>+++ b/src/openvpn/platform.c</span><=
br><span>@@ -483,19 +483,6 @@</span><br><span> #endif</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * Go to sleep indefinite=
ly.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-platform_sleep_until_signal(void)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ASSERT(0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    select(0, NUL=
L, NULL, NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* delete a file,=
 return true if succeeded */</span><br><span> bool</span><br><span> platfor=
m_unlink(const char *filename)</span><br><span>diff --git a/src/openvpn/pla=
tform.h b/src/openvpn/platform.h</span><br><span>index 181cb71..81c222c 100=
644</span><br><span>--- a/src/openvpn/platform.h</span><br><span>+++ b/src/=
openvpn/platform.h</span><br><span>@@ -131,13 +131,9 @@</span><br><span> </=
span><br><span> void platform_sleep_milliseconds(unsigned int n);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void platform=
_sleep_until_signal(void);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> /* delete a file, return true if succeeded */</span>=
<br><span> bool platform_unlink(const char *filename);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-int platform_putenv(char=
 *string);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> FILE *platform_fopen(const char *path, const char *mode);</span><br>=
<span> </span><br><span> int platform_open(const char *path, int flags, int=
 mode);</span><br><span>diff --git a/src/openvpn/proto.h b/src/openvpn/prot=
o.h</span><br><span>index a160fb6..7b94fbc 100644</span><br><span>--- a/src=
/openvpn/proto.h</span><br><span>+++ b/src/openvpn/proto.h</span><br><span>=
@@ -83,25 +83,6 @@</span><br><span> #define SIZE_ETH_TO_8021Q_HDR (sizeof(s=
truct openvpn_8021qhdr) \</span><br><span>                                -=
 sizeof(struct openvpn_ethhdr))</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-struct openvpn_arp {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define ARP_MAC_ADDR_TYPE 0x0001</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    uint16_t mac_addr_type;     /* 0x0001 */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    uint16_t proto_addr_type;   /* 0x0800 */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t mac_addr_size;      /=
* 0x06 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t =
proto_addr_size;    /* 0x04 */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define ARP_=
REQUEST 0x0001</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 ARP_REPLY   0x0002</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  uint16_t arp_command;       /* 0x0001 for ARP request, 0x0002 for ARP rep=
ly */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    uint8_t mac_src[OPENVPN_ETH_ALEN]=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in_addr_t ip_src=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t mac_dest=
[OPENVPN_ETH_ALEN];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  in_addr_t ip_dest;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> st=
ruct openvpn_iphdr {</span><br><span> #define OPENVPN_IPH_GET_VER(v) (((v) =
&gt;&gt; 4) &amp; 0x0F)</span><br><span> #define OPENVPN_IPH_GET_LEN(v) (((=
v) &amp; 0x0F) &lt;&lt; 2)</span><br><span>diff --git a/src/openvpn/proxy.h=
 b/src/openvpn/proxy.h</span><br><span>index d9e598c..1475b87 100644</span>=
<br><span>--- a/src/openvpn/proxy.h</span><br><span>+++ b/src/openvpn/proxy=
.h</span><br><span>@@ -61,12 +61,6 @@</span><br><span>     bool nocache;</s=
pan><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-struct http_proxy_options_simple {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    const char *server;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const char *port;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    int auth_retry;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> struct http_proxy_info {</span><br><span>     boo=
l defined;</span><br><span>     int auth_method;</span><br><span>diff --git=
 a/src/openvpn/ps.h b/src/openvpn/ps.h</span><br><span>index f0d4d7d..1be29=
ae 100644</span><br><span>--- a/src/openvpn/ps.h</span><br><span>+++ b/src/=
openvpn/ps.h</span><br><span>@@ -30,8 +30,6 @@</span><br><span> #include &q=
uot;buffer.h&quot;</span><br><span> #include &quot;ssl.h&quot;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef void (*p=
ost_fork_cleanup_func_t)(void *arg);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> struct port_share {</span><br><span>     /=
* Foreground&#39;s socket to background process */</span><br><span>     soc=
ket_descriptor_t foreground_fd;</span><br><span>diff --git a/src/openvpn/sh=
aper.h b/src/openvpn/shaper.h</span><br><span>index 8eb8db1..4783ebc 100644=
</span><br><span>--- a/src/openvpn/shaper.h</span><br><span>+++ b/src/openv=
pn/shaper.h</span><br><span>@@ -89,12 +89,6 @@</span><br><span>     shaper_=
reset_wakeup(s);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-shaper_current_bandwidth(struct shaper *s)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return s-&gt;bytes_per_second;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Returns traf=
fic shaping delay in microseconds relative to current</span><br><span>  * t=
ime, or 0 if no delay.</span><br><span>diff --git a/src/openvpn/socket.h b/=
src/openvpn/socket.h</span><br><span>index 2e583af..04eb8a4 100644</span><b=
r><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvpn/socket=
.h</span><br><span>@@ -362,16 +362,6 @@</span><br><span> </span><br><span> =
static inline</span><br><span> const char *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-print_openvpn_sockaddr_ex(const struct openvpn_sockad=
dr *addr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
              const char *separator,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                          const unsigned int flags,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                          stru=
ct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return print_sockaddr=
_ex(&amp;addr-&gt;addr.sa, separator, flags, gc);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *</span><b=
r><span> print_openvpn_sockaddr(const struct openvpn_sockaddr *addr,</span>=
<br><span>                        struct gc_arena *gc)</span><br><span> {</=
span><br><span>@@ -771,22 +761,6 @@</span><br><span>     return false;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static inline in_addr_t</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-addr_host(const struct openvpn_sockaddr *addr)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     * &quot;public&quot; addr returned is checked against ifconfig for<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * possible clash:=
 non sense for now given</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     * that we do ifconfig only IPv4</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (addr-&gt;addr.sa.sa_family !=3D AF_INET)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return ntohl(addr-&gt;addr.in4.sin_addr.s_addr);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> static inline bool</span><br><span> addrlist_port_match(const struct op=
envpn_sockaddr *a1, const struct addrinfo *a2)</span><br><span> {</span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tes=
ts/openvpn/test_buffer.c</span><br><span>index 6b860b4..0fb4697 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_buffer.c</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_buffer.c</span><br><span>@@ -49,7 +49,6 @=
@</span><br><span> #define teststr1 &quot;one&quot;</span><br><span> #defin=
e teststr2 &quot;two&quot;</span><br><span> #define teststr3 &quot;three&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define teststr4 &=
quot;four&quot;</span><br><span> </span><br><span> #define assert_buf_equal=
s_str(buf, str) \</span><br><span>     assert_int_equal(BLEN(buf), strlen(s=
tr)); \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt.c b/=
tests/unit_tests/openvpn/test_pkt.c</span><br><span>index 741c982..ebffabe =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt.c</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>@@ -69,11 +=
69,6 @@</span><br><span>     return &quot;dummy print_link_socket_actual fr=
om unit test&quot;;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-struct test_pkt_context {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct tls_auth_standalone tas_t=
ls_auth;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tl=
s_auth_standalone tas_crypt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> const char static_key[] =3D &quot;&lt;tls-auth&gt;\n&quot;</span><br>=
<span>                           &quot;-----BEGIN OpenVPN Static key V1----=
-\n&quot;</span><br><span>                           &quot;37268ea8f95d7f71=
f9fb8fc03770c460\n&quot;</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/783?usp=3Demail">change 7=
83</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/783?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0d96ee06c355c6a5ce082af2392=
1e329d3efae33 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 783 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--vBhWXldFaoQ=--

