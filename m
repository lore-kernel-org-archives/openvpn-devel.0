From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 5 Aug 2025 13:37:03 +0000
In-Reply-To: <gerrit.1754322460000.Ibd900adfc775b7f785f1d5630184a124f5d8ff4b@...2715...>
References: <gerrit.1754322460000.Ibd900adfc775b7f785f1d5630184a124f5d8ff4b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e1e72229cf6adc177aeb70dd4f35b0492d28b985-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TxooE3DfBh4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: clang-format: Switch
 to ColumnLimit 0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TxooE3DfBh4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2.

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
29?usp=3Demail )

Change subject: clang-format: Switch to ColumnLimit 0
......................................................................

clang-format: Switch to ColumnLimit 0

In some cases an actual ColumnLimit leads to unfortunate
formatting. So leave the decision to developers after all.

This commit contains:
 - changes that clang-format did as reaction to the config
   change
 - manual cleanups of these changes
 - manual cleanup of some previous changes done
   with ColumnLimit 100

Change-Id: Ibd900adfc775b7f785f1d5630184a124f5d8ff4b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250805132706.27619-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
523.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .clang-format
M sample/sample-plugins/client-connect/sample-client-connect.c
M sample/sample-plugins/log/log_v3.c
M sample/sample-plugins/simple/base64.c
M src/openvpn/crypto_openssl.c
M src/openvpn/errlevel.h
M src/openvpn/error.c
M src/openvpn/mtu.c
M src/openvpn/multi.c
M src/openvpn/ntlm.c
M src/openvpn/openvpn.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/options_util.c
M src/openvpn/run_command.h
M src/openvpn/ssl_common.h
M src/openvpn/xkey_helper.c
M src/tapctl/tap.c
M tests/unit_tests/openvpn/test_pkt.c
19 files changed, 149 insertions(+), 152 deletions(-)




diff --git a/.clang-format b/.clang-format
index c314fca..1cce4c3 100644
--- a/.clang-format
+++ b/.clang-format
@@ -24,7 +24,7 @@
 BreakBeforeBraces: Allman
 BreakBeforeTernaryOperators: true
 BreakStringLiterals: false
-ColumnLimit: '100'
+ColumnLimit: '0'
 ContinuationIndentWidth: '4'
 DerivePointerAlignment: false
 IndentCaseLabels: true
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b=
/sample/sample-plugins/client-connect/sample-client-connect.c
index 7e3b5a9..eaa07d2 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -128,9 +128,8 @@
     /* Check API compatibility -- struct version 5 or higher needed */
     if (v3structver < 5)
     {
-        fprintf(
-            stderr,
-            "sample-client-connect: this plugin is incompatible with the r=
unning version of OpenVPN\n");
+        fprintf(stderr,
+                "sample-client-connect: this plugin is incompatible with t=
he running version of OpenVPN\n");
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }

diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log=
/log_v3.c
index cef22cf..1b43947 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -80,8 +80,7 @@
     /* Check that we are API compatible */
     if (v3structver !=3D OPENVPN_PLUGINv3_STRUCTVER)
     {
-        printf(
-            "log_v3: ** ERROR ** Incompatible plug-in interface between th=
is plug-in and OpenVPN\n");
+        printf("log_v3: ** ERROR ** Incompatible plug-in interface between=
 this plug-in and OpenVPN\n");
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }

diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/=
simple/base64.c
index 8a1dedd..8ca0888 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -104,8 +104,7 @@
     /* Check that we are API compatible */
     if (v3structver !=3D OPENVPN_PLUGINv3_STRUCTVER)
     {
-        printf(
-            "base64.c: ** ERROR ** Incompatible plug-in interface between =
this plug-in and OpenVPN\n");
+        printf("base64.c: ** ERROR ** Incompatible plug-in interface betwe=
en this plug-in and OpenVPN\n");
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index cfea3eb..4fb6393 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1046,11 +1046,16 @@
  * this translation table for forward lookup, only for returning the name
  * with md_kt_name() */
 const cipher_name_pair digest_name_translation_table[] =3D {
-    { "BLAKE2s256", "BLAKE2S-256" },  { "BLAKE2b512", "BLAKE2B-512" },
-    { "RIPEMD160", "RIPEMD-160" },    { "SHA224", "SHA2-224" },
-    { "SHA256", "SHA2-256" },         { "SHA384", "SHA2-384" },
-    { "SHA512", "SHA2-512" },         { "SHA512-224", "SHA2-512/224" },
-    { "SHA512-256", "SHA2-512/256" }, { "SHAKE128", "SHAKE-128" },
+    { "BLAKE2s256", "BLAKE2S-256" },
+    { "BLAKE2b512", "BLAKE2B-512" },
+    { "RIPEMD160", "RIPEMD-160" },
+    { "SHA224", "SHA2-224" },
+    { "SHA256", "SHA2-256" },
+    { "SHA384", "SHA2-384" },
+    { "SHA512", "SHA2-512" },
+    { "SHA512-224", "SHA2-512/224" },
+    { "SHA512-256", "SHA2-512/256" },
+    { "SHAKE128", "SHAKE-128" },
     { "SHAKE256", "SHAKE-256" },
 };
 const size_t digest_name_translation_table_count =3D
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 2d33d55..f1ae8c5 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -49,73 +49,73 @@
  * of output.
  */

-#define M_VERB0 LOGLEV(0, 0, 0) /* Messages displayed even at --verb 0 (fa=
tal errors only) */
+#define M_VERB0 LOGLEV(0, 0, 0)                     /* Messages displayed =
even at --verb 0 (fatal errors only) */

-#define M_INFO LOGLEV(1, 0, 0)  /* default informational messages */
+#define M_INFO LOGLEV(1, 0, 0)                      /* default information=
al messages */

-#define D_LINK_ERRORS    LOGLEV(1, 1, M_NONFATAL)  /* show link errors fro=
m main event loop */
-#define D_CRYPT_ERRORS   LOGLEV(1, 2, M_NONFATAL)  /* show errors from enc=
rypt/decrypt */
-#define D_TLS_ERRORS     LOGLEV(1, 3, M_NONFATAL)  /* show TLS control cha=
nnel errors */
-#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL)  /* show hostname resolv=
e errors */
-#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)  /* show compression err=
ors */
-#define D_REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)  /* show packet replay e=
rrors */
-#define D_STREAM_ERRORS  LOGLEV(1, 7, M_NONFATAL)  /* TCP stream error req=
uiring restart */
-#define D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)  /* show server import o=
ption errors */
-#define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)  /* show multi-client se=
rver errors */
-#define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL) /* show event.[ch] erro=
rs */
-#define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL) /* show push/pull error=
s */
-#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL) /* show packet_id persi=
st errors */
-#define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL) /* show fragmentation e=
rrors */
-#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL) /* show bad struct alig=
nments */
+#define D_LINK_ERRORS    LOGLEV(1, 1, M_NONFATAL)   /* show link errors fr=
om main event loop */
+#define D_CRYPT_ERRORS   LOGLEV(1, 2, M_NONFATAL)   /* show errors from en=
crypt/decrypt */
+#define D_TLS_ERRORS     LOGLEV(1, 3, M_NONFATAL)   /* show TLS control ch=
annel errors */
+#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL)   /* show hostname resol=
ve errors */
+#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)   /* show compression er=
rors */
+#define D_REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)   /* show packet replay =
errors */
+#define D_STREAM_ERRORS  LOGLEV(1, 7, M_NONFATAL)   /* TCP stream error re=
quiring restart */
+#define D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)   /* show server import =
option errors */
+#define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)   /* show multi-client s=
erver errors */
+#define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL)  /* show event.[ch] err=
ors */
+#define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL)  /* show push/pull erro=
rs */
+#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL)  /* show packet_id pers=
ist errors */
+#define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL)  /* show fragmentation =
errors */
+#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  /* show bad struct ali=
gnments */

-#define D_HANDSHAKE LOGLEV(2, 20, 0)               /* show data & control =
channel handshakes */
-#define D_CLOSE     LOGLEV(2, 22, 0)               /* show socket and TUN/=
TAP close */
-#define D_PROXY     LOGLEV(2, 24, 0)               /* show http proxy cont=
rol packets */
-#define D_ARGV      LOGLEV(2, 25, 0)               /* show struct argv err=
ors */
+#define D_HANDSHAKE LOGLEV(2, 20, 0)                /* show data & control=
 channel handshakes */
+#define D_CLOSE     LOGLEV(2, 22, 0)                /* show socket and TUN=
/TAP close */
+#define D_PROXY     LOGLEV(2, 24, 0)                /* show http proxy con=
trol packets */
+#define D_ARGV      LOGLEV(2, 25, 0)                /* show struct argv er=
rors */

-#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)       /* low frequency info from =
tls_session routines */
-#define D_GREMLIN       LOGLEV(3, 30, 0)       /* show simulated outage in=
fo from gremlin module */
-#define D_GENKEY        LOGLEV(3, 31, 0)       /* print message after key =
generation */
-#define D_ROUTE         LOGLEV(3, 0, 0)        /* show routes added and de=
leted (don't mute) */
-#define D_TUNTAP_INFO   LOGLEV(3, 32, 0)       /* show debugging info from=
 TUN/TAP driver */
-#define D_RESTART       LOGLEV(3, 33, 0)       /* show certain restart mes=
sages */
-#define D_PUSH          LOGLEV(3, 34, 0)       /* show push/pull info */
-#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)       /* show ifconfig pool info =
*/
-#define D_AUTH          LOGLEV(3, 37, 0)       /* show user/pass auth info=
 */
-#define D_MULTI_LOW     LOGLEV(3, 38, 0)       /* show point-to-multipoint=
 low-freq debug info */
-#define D_PLUGIN        LOGLEV(3, 39, 0)       /* show plugin calls */
-#define D_MANAGEMENT    LOGLEV(3, 40, 0)       /* show --management info */
-#define D_SCHED_EXIT    LOGLEV(3, 41, 0)       /* show arming of scheduled=
 exit */
-#define D_ROUTE_QUOTA   LOGLEV(3, 42, 0)       /* show route quota exceede=
d messages */
-#define D_OSBUF         LOGLEV(3, 43, 0)       /* show socket/tun/tap buff=
er sizes */
-#define D_PS_PROXY      LOGLEV(3, 44, 0)       /* messages related to --po=
rt-share option */
-#define D_IFCONFIG      LOGLEV(3, 0, 0)        /* show ifconfig info (don'=
t mute) */
-#define D_DCO           LOGLEV(3, 0, 0)        /* show DCO related message=
s */
+#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)            /* low frequency info =
from tls_session routines */
+#define D_GREMLIN       LOGLEV(3, 30, 0)            /* show simulated outa=
ge info from gremlin module */
+#define D_GENKEY        LOGLEV(3, 31, 0)            /* print message after=
 key generation */
+#define D_ROUTE         LOGLEV(3, 0, 0)             /* show routes added a=
nd deleted (don't mute) */
+#define D_TUNTAP_INFO   LOGLEV(3, 32, 0)            /* show debugging info=
 from TUN/TAP driver */
+#define D_RESTART       LOGLEV(3, 33, 0)            /* show certain restar=
t messages */
+#define D_PUSH          LOGLEV(3, 34, 0)            /* show push/pull info=
 */
+#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)            /* show ifconfig pool =
info */
+#define D_AUTH          LOGLEV(3, 37, 0)            /* show user/pass auth=
 info */
+#define D_MULTI_LOW     LOGLEV(3, 38, 0)            /* show point-to-multi=
point low-freq debug info */
+#define D_PLUGIN        LOGLEV(3, 39, 0)            /* show plugin calls */
+#define D_MANAGEMENT    LOGLEV(3, 40, 0)            /* show --management i=
nfo */
+#define D_SCHED_EXIT    LOGLEV(3, 41, 0)            /* show arming of sche=
duled exit */
+#define D_ROUTE_QUOTA   LOGLEV(3, 42, 0)            /* show route quota ex=
ceeded messages */
+#define D_OSBUF         LOGLEV(3, 43, 0)            /* show socket/tun/tap=
 buffer sizes */
+#define D_PS_PROXY      LOGLEV(3, 44, 0)            /* messages related to=
 --port-share option */
+#define D_IFCONFIG      LOGLEV(3, 0, 0)             /* show ifconfig info =
(don't mute) */
+#define D_DCO           LOGLEV(3, 0, 0)             /* show DCO related me=
ssages */

-#define D_SHOW_PARMS       LOGLEV(4, 50, 0)    /* show all parameters on p=
rogram initiation */
-#define D_LOW              LOGLEV(4, 52, 0)    /* miscellaneous low-freque=
ncy debug info */
-#define D_DHCP_OPT         LOGLEV(4, 53, 0)    /* show DHCP options binary=
 string */
-#define D_MBUF             LOGLEV(4, 54, 0)    /* mbuf.[ch] routines */
-#define D_PACKET_TRUNC_ERR LOGLEV(4, 55, 0)    /* PACKET_TRUNCATION_CHECK =
*/
-#define D_MULTI_DROPPED    LOGLEV(4, 57, 0)    /* show point-to-multipoint=
 packet drops */
-#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)    /* show medium frequency mu=
lti messages */
-#define D_X509_ATTR        LOGLEV(4, 59, 0)    /* show x509-track attribut=
es on connection */
-#define D_INIT_MEDIUM      LOGLEV(4, 60, 0)    /* show medium frequency in=
it messages */
-#define D_MTU_INFO         LOGLEV(4, 61, 0)    /* show terse MTU info */
-#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)    /* show low-freq packet-id =
debugging info */
-#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0)    /* show medium-freq packet-=
id debugging info */
-#define D_CIPHER_INIT      LOGLEV(4, 65, 0)    /* show messages about ciph=
er init */
+#define D_SHOW_PARMS       LOGLEV(4, 50, 0)         /* show all parameters=
 on program initiation */
+#define D_LOW              LOGLEV(4, 52, 0)         /* miscellaneous low-f=
requency debug info */
+#define D_DHCP_OPT         LOGLEV(4, 53, 0)         /* show DHCP options b=
inary string */
+#define D_MBUF             LOGLEV(4, 54, 0)         /* mbuf.[ch] routines =
*/
+#define D_PACKET_TRUNC_ERR LOGLEV(4, 55, 0)         /* PACKET_TRUNCATION_C=
HECK */
+#define D_MULTI_DROPPED    LOGLEV(4, 57, 0)         /* show point-to-multi=
point packet drops */
+#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)         /* show medium frequen=
cy multi messages */
+#define D_X509_ATTR        LOGLEV(4, 59, 0)         /* show x509-track att=
ributes on connection */
+#define D_INIT_MEDIUM      LOGLEV(4, 60, 0)         /* show medium frequen=
cy init messages */
+#define D_MTU_INFO         LOGLEV(4, 61, 0)         /* show terse MTU info=
 */
+#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)         /* show low-freq packe=
t-id debugging info */
+#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0)         /* show medium-freq pa=
cket-id debugging info */
+#define D_CIPHER_INIT      LOGLEV(4, 65, 0)         /* show messages about=
 cipher init */

-#define D_LOG_RW LOGLEV(5, 0, 0)               /* Print 'R' or 'W' to stdo=
ut for read/write */
+#define D_LOG_RW LOGLEV(5, 0, 0)                    /* Print 'R' or 'W' to=
 stdout for read/write */

-#define D_RTNL          LOGLEV(6, 68, M_DEBUG) /* show RTNL low level oper=
ations */
-#define D_LINK_RW       LOGLEV(6, 69, M_DEBUG) /* show TCP/UDP reads/write=
s (terse) */
-#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG) /* show TUN/TAP reads/write=
s */
-#define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG) /* show TAP-Windows driver =
debug info */
-#define D_CLIENT_NAT    LOGLEV(6, 69, M_DEBUG) /* show client NAT debug in=
fo */
-#define D_XKEY          LOGLEV(6, 69, M_DEBUG) /* show xkey-provider debug=
 info */
-#define D_DCO_DEBUG     LOGLEV(6, 69, M_DEBUG) /* show DCO related lowleve=
l debug messages */
-#define D_SIGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG) /* show signal related debu=
g messages */
+#define D_RTNL          LOGLEV(6, 68, M_DEBUG)      /* show RTNL low level=
 operations */
+#define D_LINK_RW       LOGLEV(6, 69, M_DEBUG)      /* show TCP/UDP reads/=
writes (terse) */
+#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG)      /* show TUN/TAP reads/=
writes */
+#define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)      /* show TAP-Windows dr=
iver debug info */
+#define D_CLIENT_NAT    LOGLEV(6, 69, M_DEBUG)      /* show client NAT deb=
ug info */
+#define D_XKEY          LOGLEV(6, 69, M_DEBUG)      /* show xkey-provider =
debug info */
+#define D_DCO_DEBUG     LOGLEV(6, 69, M_DEBUG)      /* show DCO related lo=
wlevel debug messages */
+#define D_SIGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG)      /* show signal related=
 debug messages */

 #define D_SHOW_KEYS          LOGLEV(7, 70, M_DEBUG) /* show data channel e=
ncryption keys */
 #define D_SHOW_KEY_SOURCE    LOGLEV(7, 70, M_DEBUG) /* show data channel k=
ey source entropy */
@@ -150,32 +150,32 @@
 #define D_SHOW_OCC           LOGLEV(7, 74, M_DEBUG) /* show options compat=
ibility string */


-#define D_VLAN_DEBUG LOGLEV(7, 74, M_DEBUG)        /* show VLAN tagging/un=
tagging debug info */
+#define D_VLAN_DEBUG LOGLEV(7, 74, M_DEBUG)             /* show VLAN taggi=
ng/untagging debug info */

-#define D_HANDSHAKE_VERBOSE LOGLEV(8, 70, M_DEBUG) /* show detailed descri=
ption of handshake */
-#define D_TLS_DEBUG_MED     LOGLEV(8, 70, M_DEBUG) /* limited info from tl=
s_session routines */
-#define D_INTERVAL          LOGLEV(8, 70, M_DEBUG) /* show interval.h debu=
gging info */
-#define D_SCHEDULER         LOGLEV(8, 70, M_DEBUG) /* show scheduler debug=
ging info */
-#define D_GREMLIN_VERBOSE   LOGLEV(8, 70, M_DEBUG) /* show verbose info fr=
om gremlin module */
-#define D_REL_DEBUG         LOGLEV(8, 70, M_DEBUG) /* show detailed info f=
rom reliable routines */
-#define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG) /* show detailed info f=
rom event waits */
-#define D_MULTI_TCP         LOGLEV(8, 70, M_DEBUG) /* show debug info from=
 mtcp.c */
+#define D_HANDSHAKE_VERBOSE LOGLEV(8, 70, M_DEBUG)      /* show detailed d=
escription of handshake */
+#define D_TLS_DEBUG_MED     LOGLEV(8, 70, M_DEBUG)      /* limited info fr=
om tls_session routines */
+#define D_INTERVAL          LOGLEV(8, 70, M_DEBUG)      /* show interval.h=
 debugging info */
+#define D_SCHEDULER         LOGLEV(8, 70, M_DEBUG)      /* show scheduler =
debugging info */
+#define D_GREMLIN_VERBOSE   LOGLEV(8, 70, M_DEBUG)      /* show verbose in=
fo from gremlin module */
+#define D_REL_DEBUG         LOGLEV(8, 70, M_DEBUG)      /* show detailed i=
nfo from reliable routines */
+#define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG)      /* show detailed i=
nfo from event waits */
+#define D_MULTI_TCP         LOGLEV(8, 70, M_DEBUG)      /* show debug info=
 from mtcp.c */

-#define D_TLS_DEBUG         LOGLEV(9, 70, M_DEBUG) /* show detailed info f=
rom TLS routines */
-#define D_COMP              LOGLEV(9, 70, M_DEBUG) /* show compression inf=
o */
-#define D_READ_WRITE        LOGLEV(9, 70, M_DEBUG) /* show all tun/tcp/udp=
 reads/writes/opens */
-#define D_PACKET_CONTENT    LOGLEV(9, 70, M_DEBUG) /* show before/after en=
cryption packet content */
-#define D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG) /* show when no data ch=
annel send-key exists */
-#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG) /* show packet-id persi=
st debugging info */
-#define D_LINK_RW_VERBOSE   LOGLEV(9, 70, M_DEBUG) /* increase link reads/=
writes verbosity */
-#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG) /* show TCP stream debu=
g info */
-#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG) /* win32 I/O debugging =
info */
-#define D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEBUG) /* show PKCS#11 debuggi=
ng */
+#define D_TLS_DEBUG         LOGLEV(9, 70, M_DEBUG)      /* show detailed i=
nfo from TLS routines */
+#define D_COMP              LOGLEV(9, 70, M_DEBUG)      /* show compressio=
n info */
+#define D_READ_WRITE        LOGLEV(9, 70, M_DEBUG)      /* show all tun/tc=
p/udp reads/writes/opens */
+#define D_PACKET_CONTENT    LOGLEV(9, 70, M_DEBUG)      /* show before/aft=
er encryption packet content */
+#define D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG)      /* show when no da=
ta channel send-key exists */
+#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG)      /* show packet-id =
persist debugging info */
+#define D_LINK_RW_VERBOSE   LOGLEV(9, 70, M_DEBUG)      /* increase link r=
eads/writes verbosity */
+#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show TCP stream=
 debug info */
+#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG)      /* win32 I/O debug=
ging info */
+#define D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show PKCS#11 de=
bugging */

-#define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)     /* show traffic shaper =
info */
+#define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)          /* show traffic sh=
aper info */

-#define D_REGISTRY     LOGLEV(11, 70, M_DEBUG)     /* win32 registry debug=
ging info */
-#define D_OPENSSL_LOCK LOGLEV(11, 70, M_DEBUG)     /* show OpenSSL locks */
+#define D_REGISTRY     LOGLEV(11, 70, M_DEBUG)          /* win32 registry =
debugging info */
+#define D_OPENSSL_LOCK LOGLEV(11, 70, M_DEBUG)          /* show OpenSSL lo=
cks */

 /*#define D_THREAD_DEBUG       LOGLEV(4, 70, M_DEBUG)*/ /* show pthread de=
bug information */

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index dacfa8f..1b98235 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -175,7 +175,7 @@
     {
         openvpn_exit(OPENVPN_EXIT_STATUS_CANNOT_OPEN_DEBUG_FILE); /* exit =
point */
     }
-#else /* ifdef OPENVPN_DEBUG_COMMAND_LINE */
+#else
     msgfp =3D NULL;
 #endif
 }
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index c9d3389..a419e32 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -266,7 +266,7 @@
         return IP_PMTUDISC_DONT;
     }
     msg(M_FATAL, "invalid --mtu-disc type: '%s' -- valid types are 'yes', =
'maybe', or 'no'", name);
-#else /* if defined(IP_PMTUDISC_DONT) && defined(IP_PMTUDISC_WANT) && defi=
ned(IP_PMTUDISC_DO) */
+#else
     msg(M_FATAL, MTUDISC_NOT_SUPPORTED_MSG);
 #endif
     return -1; /* NOTREACHED */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 8b352e9..e1ce32a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1006,9 +1006,7 @@

 #ifdef PACKET_TRUNCATION_CHECK
         {
-            status_printf(
-                so,
-                "HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,=
Pre-encrypt Trunc,Post-decrypt Trunc");
+            status_printf(so, "HEADER,ERRORS,Common Name,TUN Read Trunc,TU=
N Write Trunc,Pre-encrypt Trunc,Post-decrypt Trunc");
             hash_iterator_init(m->hash, &hi);
             while ((he =3D hash_iterator_next(&hi)))
             {
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index dc5c93f..c2a93e8 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -208,7 +208,7 @@
     uint8_t ntlmv2_hmacmd5[16];
     uint8_t *ntlmv2_blob =3D ntlmv2_response + 16; /* inside ntlmv2_respon=
se, length: 128 */
     int ntlmv2_blob_size =3D 0;
-    int phase3_bufpos =3D 0x40; /* offset to next security buffer data to =
be added */
+    int phase3_bufpos =3D 0x40;                    /* offset to next secur=
ity buffer data to be added */
     size_t len;

     char domain[128];
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index f1e1f76..64b4f8c 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -160,9 +160,7 @@
     struct context c;

 #if PEDANTIC
-    fprintf(
-        stderr,
-        "Sorry, I was built with --enable-pedantic and I am incapable of d=
oing any real work!\n");
+    fprintf(stderr, "Sorry, I was built with --enable-pedantic and I am in=
capable of doing any real work!\n");
     return 1;
 #endif

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 672b954..c54032d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3931,7 +3931,8 @@
  *  Check file/directory sanity
  *
  */
-#ifndef ENABLE_SMALL /* Expect people using the stripped down version to k=
now what they do */
+/* Expect people using the stripped down version to know what they do */
+#ifndef ENABLE_SMALL

 #define CHKACC_FILE       (1 << 0) /**< Check for a file/directory presenc=
e */
 #define CHKACC_DIRPATH    (1 << 1) /**< Check for directory presence where=
 a file should reside */
@@ -6243,7 +6244,7 @@
         print_default_gateway(M_INFO, &rgi, &rgi6);
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
-#endif /* if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL) */
+#endif
     else if (streq(p[0], "echo") || streq(p[0], "parameter"))
     {
         struct buffer string =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 51468dd..38e67c8 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -133,16 +133,16 @@
     int tls_mtu;           /* Maximum MTU for the control channel messages=
 */

     /* Advanced MTU negotiation and datagram fragmentation options */
-    int mtu_discover_type; /* used if OS supports setting Path MTU discove=
ry options on socket */
+    int mtu_discover_type;          /* used if OS supports setting Path MT=
U discovery options on socket */

-    int fragment;          /* internal fragmentation size */
-    bool fragment_encap;   /* true if --fragment had the "mtu" parameter to
-                            * include overhead from IP and TCP/UDP encapsu=
lation */
-    int mssfix;            /* Upper bound on TCP MSS */
-    bool mssfix_default;   /* true if --mssfix should use the default para=
meters */
-    bool mssfix_encap;     /* true if --mssfix had the "mtu" parameter to =
include
-                            * overhead from IP and TCP/UDP encapsulation */
-    bool mssfix_fixed;     /* use the mssfix value without any encapsulati=
on adjustments */
+    int fragment;                   /* internal fragmentation size */
+    bool fragment_encap;            /* true if --fragment had the "mtu" pa=
rameter to
+                                     * include overhead from IP and TCP/UD=
P encapsulation */
+    int mssfix;                     /* Upper bound on TCP MSS */
+    bool mssfix_default;            /* true if --mssfix should use the def=
ault parameters */
+    bool mssfix_encap;              /* true if --mssfix had the "mtu" para=
meter to include
+                                     * overhead from IP and TCP/UDP encaps=
ulation */
+    bool mssfix_fixed;              /* use the mssfix value without any en=
capsulation adjustments */

     int explicit_exit_notification; /* Explicitly tell peer when we are ex=
iting via OCC_EXIT or
                                        [RESTART] message */
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 5251b21..c3938a7 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -146,14 +146,14 @@
     return (int)i;
 }

-static const char *updatable_options[] =3D { "block-ipv6",        "block-o=
utside-dns",
-                                           "dhcp-option",       "dns",
-                                           "ifconfig",          "ifconfig-=
ipv6",
+static const char *updatable_options[] =3D { "block-ipv6", "block-outside-=
dns",
+                                           "dhcp-option", "dns",
+                                           "ifconfig", "ifconfig-ipv6",
                                            "push-continuation", "redirect-=
gateway",
-                                           "redirect-private",  "route",
-                                           "route-gateway",     "route-ipv=
6",
-                                           "route-metric",      "topology",
-                                           "tun-mtu",           "keepalive=
" };
+                                           "redirect-private", "route",
+                                           "route-gateway", "route-ipv6",
+                                           "route-metric", "topology",
+                                           "tun-mtu", "keepalive" };

 bool
 check_push_update_option_flags(char *line, int *i, unsigned int *flags)
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index 4b74f22..afd1b88 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -27,12 +27,15 @@
 #include "env_set.h"

 /* Script security */
-#define SSEC_NONE     0 /* strictly no calling of external programs */
-#define SSEC_BUILT_IN 1 /* only call built-in programs such as ifconfig, r=
oute, netsh, etc.*/
-#define SSEC_SCRIPTS  2 /* allow calling of built-in programs and user-def=
ined scripts */
-#define SSEC_PW_ENV                                                       =
                       \
-    3 /* allow calling of built-in programs and user-defined scripts that =
may receive a password \
-         as an environmental variable */
+/** strictly no calling of external programs */
+#define SSEC_NONE     0
+/** only call built-in programs such as ifconfig, route, netsh, etc.*/
+#define SSEC_BUILT_IN 1
+/** allow calling of built-in programs and user-defined scripts */
+#define SSEC_SCRIPTS  2
+/** allow calling of built-in programs and user-defined scripts that may r=
eceive a password
+    as an environmental variable */
+#define SSEC_PW_ENV   3

 #define OPENVPN_EXECVE_ERROR       -1  /* generic error while forking to r=
un an external program */
 #define OPENVPN_EXECVE_NOT_ALLOWED -2  /* external program not run due to =
script security */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index cd5293a..e8fde86 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -222,15 +222,15 @@
      */
     uint32_t peer_id;

-    struct key_state_ssl ks_ssl; /* contains SSL object and BIOs for the c=
ontrol channel */
+    struct key_state_ssl ks_ssl;           /* contains SSL object and BIOs=
 for the control channel */

-    time_t initial;              /* when we created this session */
-    time_t established;          /* when our state went S_ACTIVE */
-    time_t must_negotiate;       /* key negotiation times out if not finis=
hed before this time */
-    time_t must_die;             /* this object is destroyed at this time =
*/
-    time_t peer_last_packet;     /* Last time we received a packet in this=
 control session */
+    time_t initial;                        /* when we created this session=
 */
+    time_t established;                    /* when our state went S_ACTIVE=
 */
+    time_t must_negotiate;                 /* key negotiation times out if=
 not finished before this time */
+    time_t must_die;                       /* this object is destroyed at =
this time */
+    time_t peer_last_packet;               /* Last time we received a pack=
et in this control session */

-    int initial_opcode;          /* our initial P_ opcode */
+    int initial_opcode;                    /* our initial P_ opcode */
     struct session_id session_id_remote;   /* peer's random session ID */
     struct link_socket_actual remote_addr; /* peer's IP addr */

@@ -579,9 +579,8 @@
 enum multi_status
 {
     CAS_NOT_CONNECTED,
-    CAS_WAITING_AUTH, /**< Initial TLS connection established but deferred=
 auth is not yet finished
-                       */
-    CAS_PENDING,      /**< Options import (Connect script/plugin, ccd,...)=
 */
+    CAS_WAITING_AUTH,             /**< Initial TLS connection established =
but deferred auth is not yet finished */
+    CAS_PENDING,                  /**< Options import (Connect script/plug=
in, ccd,...) */
     CAS_PENDING_DEFERRED,         /**< Waiting on an async option import h=
andler */
     CAS_PENDING_DEFERRED_PARTIAL, /**< at least handler succeeded but anot=
her is still pending */
     CAS_FAILED,                   /**< Option import failed or explicitly =
denied the client */
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index f4a9948..3820808 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -329,10 +329,12 @@
=20
 #define MAKE_DI(x) { NID_##x, x, sizeof(x) }

+    /* clang-format off */
     DIG_INFO dinfo[] =3D {
         MAKE_DI(sha1),   MAKE_DI(sha256),     MAKE_DI(sha384),     MAKE_DI=
(sha512),
         MAKE_DI(sha224), MAKE_DI(sha512_224), MAKE_DI(sha512_256), { 0, NU=
LL, 0 }
     };
+    /* clang-format on */

     size_t out_len =3D 0;
     bool ret =3D false;
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 09be7e8..b633e77 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -225,10 +225,8 @@
 delete_device(_In_ HDEVINFO hDeviceInfoSet, _In_ PSP_DEVINFO_DATA pDeviceI=
nfoData,
               _Inout_ LPBOOL pbRebootRequired)
 {
-    SP_REMOVEDEVICE_PARAMS params =3D
-    {
-        .ClassInstallHeader =3D
-        {
+    SP_REMOVEDEVICE_PARAMS params =3D {
+        .ClassInstallHeader =3D {
             .cbSize =3D sizeof(SP_CLASSINSTALL_HEADER),
             .InstallFunction =3D DIF_REMOVE,
         },
@@ -281,10 +279,8 @@
 change_device_state(_In_ HDEVINFO hDeviceInfoSet, _In_ PSP_DEVINFO_DATA pD=
eviceInfoData,
                     _In_ BOOL bEnable, _Inout_ LPBOOL pbRebootRequired)
 {
-    SP_PROPCHANGE_PARAMS params =3D
-    {
-        .ClassInstallHeader =3D
-        {
+    SP_PROPCHANGE_PARAMS params =3D {
+        .ClassInstallHeader =3D {
             .cbSize =3D sizeof(SP_CLASSINSTALL_HEADER),
             .InstallFunction =3D DIF_PROPERTYCHANGE,
         },
@@ -768,10 +764,8 @@
     if (dwResult !=3D ERROR_SUCCESS)
     {
         /* The adapter was installed. But, the adapter ID was unobtainable=
. Clean-up. */
-        SP_REMOVEDEVICE_PARAMS removedevice_params =3D
-        {
-            .ClassInstallHeader =3D
-            {
+        SP_REMOVEDEVICE_PARAMS removedevice_params =3D {
+            .ClassInstallHeader =3D {
                 .cbSize =3D sizeof(SP_CLASSINSTALL_HEADER),
                 .InstallFunction =3D DIF_REMOVE,
             },
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index 3823d39..65b31e7 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -219,7 +219,7 @@
     {
         buf_reset_len(&buf);
         buf_write(&buf, client_reset_v2_tls_crypt, sizeof(client_reset_v2_=
tls_crypt));
-        BPTR(&buf)[i] =3D 0x23;
+        (BPTR(&buf))[i] =3D 0x23;
         verdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &buf);
         assert_int_equal(verdict, VERDICT_INVALID);
         free_tls_pre_decrypt_state(&state);
@@ -274,7 +274,7 @@
     free_tls_pre_decrypt_state(&state);

     /* flip a byte in the hmac */
-    BPTR(&buf)[20] =3D 0x23;
+    (BPTR(&buf))[20] =3D 0x23;
     verdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_INVALID);
     free_tls_pre_decrypt_state(&state);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1129?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibd900adfc775b7f785f1d5630184a124f5d8ff4b
Gerrit-Change-Number: 1129
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-MessageType: merged

--TxooE3DfBh4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2. </p>
<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1129?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">clang-format: Switch to ColumnLimit 0<br><br>=
In some cases an actual ColumnLimit leads to unfortunate<br>formatting. So =
leave the decision to developers after all.<br><br>This commit contains:<br=
> - changes that clang-format did as reaction to the config<br>   change<br=
> - manual cleanups of these changes<br> - manual cleanup of some previous =
changes done<br>   with ColumnLimit 100<br><br>Change-Id: Ibd900adfc775b7f7=
85f1d5630184a124f5d8ff4b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id:=
 &lt;20250805132706.27619-1-gert@...1296...&gt;<br>URL: https://www.mail-ar=
chive.com/openvpn-devel@lists.sourceforge.net/msg32523.html<br>Signed-off-b=
y: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .clang-format<br>M samp=
le/sample-plugins/client-connect/sample-client-connect.c<br>M sample/sample=
-plugins/log/log_v3.c<br>M sample/sample-plugins/simple/base64.c<br>M src/o=
penvpn/crypto_openssl.c<br>M src/openvpn/errlevel.h<br>M src/openvpn/error.=
c<br>M src/openvpn/mtu.c<br>M src/openvpn/multi.c<br>M src/openvpn/ntlm.c<b=
r>M src/openvpn/openvpn.c<br>M src/openvpn/options.c<br>M src/openvpn/optio=
ns.h<br>M src/openvpn/options_util.c<br>M src/openvpn/run_command.h<br>M sr=
c/openvpn/ssl_common.h<br>M src/openvpn/xkey_helper.c<br>M src/tapctl/tap.c=
<br>M tests/unit_tests/openvpn/test_pkt.c<br>19 files changed, 149 insertio=
ns(+), 152 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.clang-format b/.clang-format</span><br><span>index c314fca=
..1cce4c3 100644</span><br><span>--- a/.clang-format</span><br><span>+++ b/=
.clang-format</span><br><span>@@ -24,7 +24,7 @@</span><br><span> BreakBefor=
eBraces: Allman</span><br><span> BreakBeforeTernaryOperators: true</span><b=
r><span> BreakStringLiterals: false</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-ColumnLimit: &#39;100&#39;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ColumnLimit: &#39;0&#39;</span><br><span> Continuation=
IndentWidth: &#39;4&#39;</span><br><span> DerivePointerAlignment: false</sp=
an><br><span> IndentCaseLabels: true</span><br><span>diff --git a/sample/sa=
mple-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins=
/client-connect/sample-client-connect.c</span><br><span>index 7e3b5a9..eaa0=
7d2 100644</span><br><span>--- a/sample/sample-plugins/client-connect/sampl=
e-client-connect.c</span><br><span>+++ b/sample/sample-plugins/client-conne=
ct/sample-client-connect.c</span><br><span>@@ -128,9 +128,8 @@</span><br><s=
pan>     /* Check API compatibility -- struct version 5 or higher needed */=
</span><br><span>     if (v3structver &lt; 5)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        fprintf(</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            stderr,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            &quot;sample-client-con=
nect: this plugin is incompatible with the running version of OpenVPN\n&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fprintf=
(stderr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     &quot;sample-client-connect: this plugin is incompatible with the runn=
ing version of OpenVPN\n&quot;);</span><br><span>         return OPENVPN_PL=
UGIN_FUNC_ERROR;</span><br><span>     }</span><br><span> </span><br><span>d=
iff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/=
log_v3.c</span><br><span>index cef22cf..1b43947 100644</span><br><span>--- =
a/sample/sample-plugins/log/log_v3.c</span><br><span>+++ b/sample/sample-pl=
ugins/log/log_v3.c</span><br><span>@@ -80,8 +80,7 @@</span><br><span>     /=
* Check that we are API compatible */</span><br><span>     if (v3structver =
!=3D OPENVPN_PLUGINv3_STRUCTVER)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        printf(</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            &quot;log_v3: ** ERROR ** Incompati=
ble plug-in interface between this plug-in and OpenVPN\n&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        printf(&quot;log_v3: *=
* ERROR ** Incompatible plug-in interface between this plug-in and OpenVPN\=
n&quot;);</span><br><span>         return OPENVPN_PLUGIN_FUNC_ERROR;</span>=
<br><span>     }</span><br><span> </span><br><span>diff --git a/sample/samp=
le-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c</span><b=
r><span>index 8a1dedd..8ca0888 100644</span><br><span>--- a/sample/sample-p=
lugins/simple/base64.c</span><br><span>+++ b/sample/sample-plugins/simple/b=
ase64.c</span><br><span>@@ -104,8 +104,7 @@</span><br><span>     /* Check t=
hat we are API compatible */</span><br><span>     if (v3structver !=3D OPEN=
VPN_PLUGINv3_STRUCTVER)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        printf(</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            &quot;base64.c: ** ERROR ** Incompatible plu=
g-in interface between this plug-in and OpenVPN\n&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        printf(&quot;base64.c: ** ERR=
OR ** Incompatible plug-in interface between this plug-in and OpenVPN\n&quo=
t;);</span><br><span>         return OPENVPN_PLUGIN_FUNC_ERROR;</span><br><=
span>     }</span><br><span> </span><br><span>diff --git a/src/openvpn/cryp=
to_openssl.c b/src/openvpn/crypto_openssl.c</span><br><span>index cfea3eb..=
4fb6393 100644</span><br><span>--- a/src/openvpn/crypto_openssl.c</span><br=
><span>+++ b/src/openvpn/crypto_openssl.c</span><br><span>@@ -1046,11 +1046=
,16 @@</span><br><span>  * this translation table for forward lookup, only =
for returning the name</span><br><span>  * with md_kt_name() */</span><br><=
span> const cipher_name_pair digest_name_translation_table[] =3D {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;BLAKE2s256&quot;, =
&quot;BLAKE2S-256&quot; },  { &quot;BLAKE2b512&quot;, &quot;BLAKE2B-512&quo=
t; },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;RIPE=
MD160&quot;, &quot;RIPEMD-160&quot; },    { &quot;SHA224&quot;, &quot;SHA2-=
224&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &qu=
ot;SHA256&quot;, &quot;SHA2-256&quot; },         { &quot;SHA384&quot;, &quo=
t;SHA2-384&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  { &quot;SHA512&quot;, &quot;SHA2-512&quot; },         { &quot;SHA512-224&=
quot;, &quot;SHA2-512/224&quot; },</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    { &quot;SHA512-256&quot;, &quot;SHA2-512/256&quot; }, { &q=
uot;SHAKE128&quot;, &quot;SHAKE-128&quot; },</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    { &quot;BLAKE2s256&quot;, &quot;BLAKE2S-256&qu=
ot; },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;B=
LAKE2b512&quot;, &quot;BLAKE2B-512&quot; },</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    { &quot;RIPEMD160&quot;, &quot;RIPEMD-160&quot;=
 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;SHA2=
24&quot;, &quot;SHA2-224&quot; },</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    { &quot;SHA256&quot;, &quot;SHA2-256&quot; },</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;SHA384&quot;, &quot=
;SHA2-384&quot; },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   { &quot;SHA512&quot;, &quot;SHA2-512&quot; },</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    { &quot;SHA512-224&quot;, &quot;SHA2-512/2=
24&quot; },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &q=
uot;SHA512-256&quot;, &quot;SHA2-512/256&quot; },</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    { &quot;SHAKE128&quot;, &quot;SHAKE-128&q=
uot; },</span><br><span>     { &quot;SHAKE256&quot;, &quot;SHAKE-256&quot; =
},</span><br><span> };</span><br><span> const size_t digest_name_translatio=
n_table_count =3D</span><br><span>diff --git a/src/openvpn/errlevel.h b/src=
/openvpn/errlevel.h</span><br><span>index 2d33d55..f1ae8c5 100644</span><br=
><span>--- a/src/openvpn/errlevel.h</span><br><span>+++ b/src/openvpn/errle=
vel.h</span><br><span>@@ -49,73 +49,73 @@</span><br><span>  * of output.</s=
pan><br><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define M_VERB0 LOGLEV(0, 0, 0) /* Messages displayed even a=
t --verb 0 (fatal errors only) */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define M_VERB0 LOGLEV(0, 0, 0)                     /* Messag=
es displayed even at --verb 0 (fatal errors only) */</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_INFO LOGLEV(1, 0=
, 0)  /* default informational messages */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define M_INFO LOGLEV(1, 0, 0)                      =
/* default informational messages */</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define D_LINK_ERRORS    LOGLEV(1, 1, M_NO=
NFATAL)  /* show link errors from main event loop */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_CRYPT_ERRORS   LOGLEV(1, 2, M_NON=
FATAL)  /* show errors from encrypt/decrypt */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define D_TLS_ERRORS     LOGLEV(1, 3, M_NONFATAL) =
 /* show TLS control channel errors */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL)  /* show=
 hostname resolve errors */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)  /* show compressio=
n errors */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_=
REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)  /* show packet replay errors */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_STREAM_ERRORS =
 LOGLEV(1, 7, M_NONFATAL)  /* TCP stream error requiring restart */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_IMPORT_ERRORS  LOGL=
EV(1, 8, M_NONFATAL)  /* show server import option errors */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define D_MULTI_ERRORS   LOGLEV(1, 9=
, M_NONFATAL)  /* show multi-client server errors */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_EVENT_ERRORS   LOGLEV(1, 10, M_NO=
NFATAL) /* show event.[ch] errors */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL) /* show p=
ush/pull errors */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL) /* show packet_id persist e=
rrors */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_FRA=
G_ERRORS    LOGLEV(1, 13, M_NONFATAL) /* show fragmentation errors */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_ALIGN_ERRORS   LO=
GLEV(1, 14, M_NONFATAL) /* show bad struct alignments */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define D_LINK_ERRORS    LOGLEV(1, 1, =
M_NONFATAL)   /* show link errors from main event loop */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define D_CRYPT_ERRORS   LOGLEV(1, 2,=
 M_NONFATAL)   /* show errors from encrypt/decrypt */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_TLS_ERRORS     LOGLEV(1, 3, M_N=
ONFATAL)   /* show TLS control channel errors */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFAT=
AL)   /* show hostname resolve errors */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)   /*=
 show compression errors */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define D_REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)   /* show packet =
replay errors */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine D_STREAM_ERRORS  LOGLEV(1, 7, M_NONFATAL)   /* TCP stream error requir=
ing restart */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)   /* show server import option=
 errors */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D=
_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)   /* show multi-client server erro=
rs */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_EVEN=
T_ERRORS   LOGLEV(1, 10, M_NONFATAL)  /* show event.[ch] errors */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PUSH_ERRORS    LOG=
LEV(1, 11, M_NONFATAL)  /* show push/pull errors */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_PID_PERSIST    LOGLEV(1, 12, M_=
NONFATAL)  /* show packet_id persist errors */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATA=
L)  /* show fragmentation errors */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  /* show=
 bad struct alignments */</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define D_HANDSHAKE LOGLEV(2, 20, 0)               /*=
 show data &amp; control channel handshakes */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define D_CLOSE     LOGLEV(2, 22, 0)              =
 /* show socket and TUN/TAP close */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define D_PROXY     LOGLEV(2, 24, 0)               /* show h=
ttp proxy control packets */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define D_ARGV      LOGLEV(2, 25, 0)               /* show struct ar=
gv errors */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 D_HANDSHAKE LOGLEV(2, 20, 0)                /* show data &amp; control cha=
nnel handshakes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define D_CLOSE     LOGLEV(2, 22, 0)                /* show socket and TUN/T=
AP close */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
D_PROXY     LOGLEV(2, 24, 0)                /* show http proxy control pack=
ets */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_ARG=
V      LOGLEV(2, 25, 0)                /* show struct argv errors */</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_=
TLS_DEBUG_LOW LOGLEV(3, 20, 0)       /* low frequency info from tls_session=
 routines */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D=
_GREMLIN       LOGLEV(3, 30, 0)       /* show simulated outage info from gr=
emlin module */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e D_GENKEY        LOGLEV(3, 31, 0)       /* print message after key generat=
ion */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_ROUTE=
         LOGLEV(3, 0, 0)        /* show routes added and deleted (don&#39;t=
 mute) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TU=
NTAP_INFO   LOGLEV(3, 32, 0)       /* show debugging info from TUN/TAP driv=
er */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_RESTAR=
T       LOGLEV(3, 33, 0)       /* show certain restart messages */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PUSH          LOGLEV=
(3, 34, 0)       /* show push/pull info */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)       /* show=
 ifconfig pool info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define D_AUTH          LOGLEV(3, 37, 0)       /* show user/pass auth info=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_MULTI_LO=
W     LOGLEV(3, 38, 0)       /* show point-to-multipoint low-freq debug inf=
o */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PLUGIN =
       LOGLEV(3, 39, 0)       /* show plugin calls */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_MANAGEMENT    LOGLEV(3, 40, 0)   =
    /* show --management info */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define D_SCHED_EXIT    LOGLEV(3, 41, 0)       /* show arming of=
 scheduled exit */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine D_ROUTE_QUOTA   LOGLEV(3, 42, 0)       /* show route quota exceeded me=
ssages */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_OS=
BUF         LOGLEV(3, 43, 0)       /* show socket/tun/tap buffer sizes */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PS_PROXY     =
 LOGLEV(3, 44, 0)       /* messages related to --port-share option */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_IFCONFIG      LOG=
LEV(3, 0, 0)        /* show ifconfig info (don&#39;t mute) */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define D_DCO           LOGLEV(3, 0=
, 0)        /* show DCO related messages */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)           =
 /* low frequency info from tls_session routines */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_GREMLIN       LOGLEV(3, 30, 0) =
           /* show simulated outage info from gremlin module */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define D_GENKEY        LOGLEV(=
3, 31, 0)            /* print message after key generation */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define D_ROUTE         LOGLEV(3,=
 0, 0)             /* show routes added and deleted (don&#39;t mute) */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_TUNTAP_INFO  =
 LOGLEV(3, 32, 0)            /* show debugging info from TUN/TAP driver */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_RESTART   =
    LOGLEV(3, 33, 0)            /* show certain restart messages */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PUSH          LOG=
LEV(3, 34, 0)            /* show push/pull info */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)    =
        /* show ifconfig pool info */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define D_AUTH          LOGLEV(3, 37, 0)            /* sh=
ow user/pass auth info */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define D_MULTI_LOW     LOGLEV(3, 38, 0)            /* show point-to-=
multipoint low-freq debug info */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define D_PLUGIN        LOGLEV(3, 39, 0)            /* show p=
lugin calls */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne D_MANAGEMENT    LOGLEV(3, 40, 0)            /* show --management info */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_SCHED_EXI=
T    LOGLEV(3, 41, 0)            /* show arming of scheduled exit */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_ROUTE_QUOTA   LO=
GLEV(3, 42, 0)            /* show route quota exceeded messages */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define D_OSBUF         LOGL=
EV(3, 43, 0)            /* show socket/tun/tap buffer sizes */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define D_PS_PROXY      LOGLEV(3=
, 44, 0)            /* messages related to --port-share option */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define D_IFCONFIG      LOGLE=
V(3, 0, 0)             /* show ifconfig info (don&#39;t mute) */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define D_DCO           LOGLEV=
(3, 0, 0)             /* show DCO related messages */</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_SHOW_PARMS     =
  LOGLEV(4, 50, 0)    /* show all parameters on program initiation */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_LOW              =
LOGLEV(4, 52, 0)    /* miscellaneous low-frequency debug info */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define D_DHCP_OPT         LOGLE=
V(4, 53, 0)    /* show DHCP options binary string */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_MBUF             LOGLEV(4, 54, 0)=
    /* mbuf.[ch] routines */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define D_PACKET_TRUNC_ERR LOGLEV(4, 55, 0)    /* PACKET_TRUNCATION_=
CHECK */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_MUL=
TI_DROPPED    LOGLEV(4, 57, 0)    /* show point-to-multipoint packet drops =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_MULTI_MED=
IUM     LOGLEV(4, 58, 0)    /* show medium frequency multi messages */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_X509_ATTR       =
 LOGLEV(4, 59, 0)    /* show x509-track attributes on connection */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_INIT_MEDIUM      LO=
GLEV(4, 60, 0)    /* show medium frequency init messages */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define D_MTU_INFO         LOGLEV(4, =
61, 0)    /* show terse MTU info */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)    /* show low-fr=
eq packet-id debugging info */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0)    /* show medium-freq=
 packet-id debugging info */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define D_CIPHER_INIT      LOGLEV(4, 65, 0)    /* show messages abou=
t cipher init */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine D_SHOW_PARMS       LOGLEV(4, 50, 0)         /* show all parameters on =
program initiation */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define D_LOW              LOGLEV(4, 52, 0)         /* miscellaneous low-=
frequency debug info */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define D_DHCP_OPT         LOGLEV(4, 53, 0)         /* show DHCP option=
s binary string */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define D_MBUF             LOGLEV(4, 54, 0)         /* mbuf.[ch] routines */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PACKET_TR=
UNC_ERR LOGLEV(4, 55, 0)         /* PACKET_TRUNCATION_CHECK */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define D_MULTI_DROPPED    LOGLE=
V(4, 57, 0)         /* show point-to-multipoint packet drops */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define D_MULTI_MEDIUM     LOGL=
EV(4, 58, 0)         /* show medium frequency multi messages */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define D_X509_ATTR        LOGL=
EV(4, 59, 0)         /* show x509-track attributes on connection */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_INIT_MEDIUM      =
LOGLEV(4, 60, 0)         /* show medium frequency init messages */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define D_MTU_INFO         L=
OGLEV(4, 61, 0)         /* show terse MTU info */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)  =
       /* show low-freq packet-id debugging info */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, =
0)         /* show medium-freq packet-id debugging info */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define D_CIPHER_INIT      LOGLEV(4,=
 65, 0)         /* show messages about cipher init */</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_LOG_RW LOGLEV(5=
, 0, 0)               /* Print &#39;R&#39; or &#39;W&#39; to stdout for rea=
d/write */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D=
_LOG_RW LOGLEV(5, 0, 0)                    /* Print &#39;R&#39; or &#39;W&#=
39; to stdout for read/write */</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define D_RTNL          LOGLEV(6, 68, M_DEBUG) =
/* show RTNL low level operations */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define D_LINK_RW       LOGLEV(6, 69, M_DEBUG) /* show TCP/U=
DP reads/writes (terse) */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG) /* show TUN/TAP reads/w=
rites */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TAP=
_WIN_DEBUG LOGLEV(6, 69, M_DEBUG) /* show TAP-Windows driver debug info */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_CLIENT_NAT  =
  LOGLEV(6, 69, M_DEBUG) /* show client NAT debug info */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define D_XKEY          LOGLEV(6, 69, M=
_DEBUG) /* show xkey-provider debug info */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define D_DCO_DEBUG     LOGLEV(6, 69, M_DEBUG) /* sho=
w DCO related lowlevel debug messages */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define D_SIGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG) /* show s=
ignal related debug messages */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define D_RTNL          LOGLEV(6, 68, M_DEBUG)      /* show RTN=
L low level operations */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define D_LINK_RW       LOGLEV(6, 69, M_DEBUG)      /* show TCP/UDP r=
eads/writes (terse) */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG)      /* show TUN/TAP read=
s/writes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)      /* show TAP-Windows driver debu=
g info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_=
CLIENT_NAT    LOGLEV(6, 69, M_DEBUG)      /* show client NAT debug info */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_XKEY      =
    LOGLEV(6, 69, M_DEBUG)      /* show xkey-provider debug info */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_DCO_DEBUG     LOG=
LEV(6, 69, M_DEBUG)      /* show DCO related lowlevel debug messages */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_SIGNAL_DEBUG =
 LOGLEV(6, 69, M_DEBUG)      /* show signal related debug messages */</span=
><br><span> </span><br><span> #define D_SHOW_KEYS          LOGLEV(7, 70, M_=
DEBUG) /* show data channel encryption keys */</span><br><span> #define D_S=
HOW_KEY_SOURCE    LOGLEV(7, 70, M_DEBUG) /* show data channel key source en=
tropy */</span><br><span>@@ -150,32 +150,32 @@</span><br><span> #define D_S=
HOW_OCC           LOGLEV(7, 74, M_DEBUG) /* show options compatibility stri=
ng */</span><br><span> </span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define D_VLAN_DEBUG LOGLEV(7, 74, M_DEBUG)        /* s=
how VLAN tagging/untagging debug info */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define D_VLAN_DEBUG LOGLEV(7, 74, M_DEBUG)           =
  /* show VLAN tagging/untagging debug info */</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define D_HANDSHAKE_VERBOSE LOGL=
EV(8, 70, M_DEBUG) /* show detailed description of handshake */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define D_TLS_DEBUG_MED     LOGLE=
V(8, 70, M_DEBUG) /* limited info from tls_session routines */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define D_INTERVAL          LOGLEV=
(8, 70, M_DEBUG) /* show interval.h debugging info */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_SCHEDULER         LOGLEV(8, 70, M=
_DEBUG) /* show scheduler debugging info */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define D_GREMLIN_VERBOSE   LOGLEV(8, 70, M_DEBUG) /*=
 show verbose info from gremlin module */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define D_REL_DEBUG         LOGLEV(8, 70, M_DEBUG) /* s=
how detailed info from reliable routines */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG) /*=
 show detailed info from event waits */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define D_MULTI_TCP         LOGLEV(8, 70, M_DEBUG) /* sho=
w debug info from mtcp.c */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define D_HANDSHAKE_VERBOSE LOGLEV(8, 70, M_DEBUG)      /* show det=
ailed description of handshake */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define D_TLS_DEBUG_MED     LOGLEV(8, 70, M_DEBUG)      /* li=
mited info from tls_session routines */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define D_INTERVAL          LOGLEV(8, 70, M_DEBUG)     =
 /* show interval.h debugging info */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define D_SCHEDULER         LOGLEV(8, 70, M_DEBUG)      /=
* show scheduler debugging info */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define D_GREMLIN_VERBOSE   LOGLEV(8, 70, M_DEBUG)      /* s=
how verbose info from gremlin module */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define D_REL_DEBUG         LOGLEV(8, 70, M_DEBUG)     =
 /* show detailed info from reliable routines */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define D_EVENT_WAIT        LOGLEV(8, 70, M_DE=
BUG)      /* show detailed info from event waits */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_MULTI_TCP         LOGLEV(8, 70,=
 M_DEBUG)      /* show debug info from mtcp.c */</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TLS_DEBUG         LO=
GLEV(9, 70, M_DEBUG) /* show detailed info from TLS routines */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define D_COMP              LOGLE=
V(9, 70, M_DEBUG) /* show compression info */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define D_READ_WRITE        LOGLEV(9, 70, M_DEBUG) =
/* show all tun/tcp/udp reads/writes/opens */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define D_PACKET_CONTENT    LOGLEV(9, 70, M_DEBUG) =
/* show before/after encryption packet content */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEB=
UG) /* show when no data channel send-key exists */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M=
_DEBUG) /* show packet-id persist debugging info */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_LINK_RW_VERBOSE   LOGLEV(9, 70, M=
_DEBUG) /* increase link reads/writes verbosity */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DE=
BUG) /* show TCP stream debug info */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG) /* win32=
 I/O debugging info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEBUG) /* show PKCS#11 debuggi=
ng */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_TLS_=
DEBUG         LOGLEV(9, 70, M_DEBUG)      /* show detailed info from TLS ro=
utines */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_=
COMP              LOGLEV(9, 70, M_DEBUG)      /* show compression info */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_READ_WRITE =
       LOGLEV(9, 70, M_DEBUG)      /* show all tun/tcp/udp reads/writes/ope=
ns */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PACK=
ET_CONTENT    LOGLEV(9, 70, M_DEBUG)      /* show before/after encryption p=
acket content */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG)      /* show when no data c=
hannel send-key exists */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG)      /* show packe=
t-id persist debugging info */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define D_LINK_RW_VERBOSE   LOGLEV(9, 70, M_DEBUG)      /* incre=
ase link reads/writes verbosity */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* s=
how TCP stream debug info */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG)      /* win32 I=
/O debugging info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show PKCS#11 de=
bugging */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)     /* show traffic s=
haper info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)          /* show traffic shaper in=
fo */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define D_REGISTRY     LOGLEV(11, 70, M_DEBUG)     /* win32 registry debu=
gging info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
D_OPENSSL_LOCK LOGLEV(11, 70, M_DEBUG)     /* show OpenSSL locks */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_REGISTRY     LOGL=
EV(11, 70, M_DEBUG)          /* win32 registry debugging info */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define D_OPENSSL_LOCK LOGLEV(=
11, 70, M_DEBUG)          /* show OpenSSL locks */</span><br><span> </span>=
<br><span> /*#define D_THREAD_DEBUG       LOGLEV(4, 70, M_DEBUG)*/ /* show =
pthread debug information */</span><br><span> </span><br><span>diff --git a=
/src/openvpn/error.c b/src/openvpn/error.c</span><br><span>index dacfa8f..1=
b98235 100644</span><br><span>--- a/src/openvpn/error.c</span><br><span>+++=
 b/src/openvpn/error.c</span><br><span>@@ -175,7 +175,7 @@</span><br><span>=
     {</span><br><span>         openvpn_exit(OPENVPN_EXIT_STATUS_CANNOT_OPE=
N_DEBUG_FILE); /* exit point */</span><br><span>     }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#else /* ifdef OPENVPN_DEBUG_COMMAND_LINE =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><=
span>     msgfp =3D NULL;</span><br><span> #endif</span><br><span> }</span>=
<br><span>diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c</span><br><spa=
n>index c9d3389..a419e32 100644</span><br><span>--- a/src/openvpn/mtu.c</sp=
an><br><span>+++ b/src/openvpn/mtu.c</span><br><span>@@ -266,7 +266,7 @@</s=
pan><br><span>         return IP_PMTUDISC_DONT;</span><br><span>     }</spa=
n><br><span>     msg(M_FATAL, &quot;invalid --mtu-disc type: &#39;%s&#39; -=
- valid types are &#39;yes&#39;, &#39;maybe&#39;, or &#39;no&#39;&quot;, na=
me);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* if defin=
ed(IP_PMTUDISC_DONT) &amp;&amp; defined(IP_PMTUDISC_WANT) &amp;&amp; define=
d(IP_PMTUDISC_DO) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#else</span><br><span>     msg(M_FATAL, MTUDISC_NOT_SUPPORTED_MSG);</span>=
<br><span> #endif</span><br><span>     return -1; /* NOTREACHED */</span><b=
r><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><s=
pan>index 8b352e9..e1ce32a 100644</span><br><span>--- a/src/openvpn/multi.c=
</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -1006,9 +1006=
,7 @@</span><br><span> </span><br><span> #ifdef PACKET_TRUNCATION_CHECK</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            status_printf(</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                so,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                &quot;HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Wri=
te Trunc,Pre-encrypt Trunc,Post-decrypt Trunc&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            status_printf(so, &quot;HEADE=
R,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,Post-=
decrypt Trunc&quot;);</span><br><span>             hash_iterator_init(m-&gt=
;hash, &amp;hi);</span><br><span>             while ((he =3D hash_iterator_=
next(&amp;hi)))</span><br><span>             {</span><br><span>diff --git a=
/src/openvpn/ntlm.c b/src/openvpn/ntlm.c</span><br><span>index dc5c93f..c2a=
93e8 100644</span><br><span>--- a/src/openvpn/ntlm.c</span><br><span>+++ b/=
src/openvpn/ntlm.c</span><br><span>@@ -208,7 +208,7 @@</span><br><span>    =
 uint8_t ntlmv2_hmacmd5[16];</span><br><span>     uint8_t *ntlmv2_blob =3D =
ntlmv2_response + 16; /* inside ntlmv2_response, length: 128 */</span><br><=
span>     int ntlmv2_blob_size =3D 0;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    int phase3_bufpos =3D 0x40; /* offset to next security =
buffer data to be added */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int phase3_bufpos =3D 0x40;                    /* offset to next=
 security buffer data to be added */</span><br><span>     size_t len;</span=
><br><span> </span><br><span>     char domain[128];</span><br><span>diff --=
git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c</span><br><span>index f=
1e1f76..64b4f8c 100644</span><br><span>--- a/src/openvpn/openvpn.c</span><b=
r><span>+++ b/src/openvpn/openvpn.c</span><br><span>@@ -160,9 +160,7 @@</sp=
an><br><span>     struct context c;</span><br><span> </span><br><span> #if =
PEDANTIC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fprintf(<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        stderr,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;Sorry, I was b=
uilt with --enable-pedantic and I am incapable of doing any real work!\n&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fprintf(st=
derr, &quot;Sorry, I was built with --enable-pedantic and I am incapable of=
 doing any real work!\n&quot;);</span><br><span>     return 1;</span><br><s=
pan> #endif</span><br><span> </span><br><span>diff --git a/src/openvpn/opti=
ons.c b/src/openvpn/options.c</span><br><span>index 672b954..c54032d 100644=
</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/open=
vpn/options.c</span><br><span>@@ -3931,7 +3931,8 @@</span><br><span>  *  Ch=
eck file/directory sanity</span><br><span>  *</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL /* Expect=
 people using the stripped down version to know what they do */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* Expect people using the stri=
pped down version to know what they do */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> </span><br><spa=
n> #define CHKACC_FILE       (1 &lt;&lt; 0) /**&lt; Check for a file/direct=
ory presence */</span><br><span> #define CHKACC_DIRPATH    (1 &lt;&lt; 1) /=
**&lt; Check for directory presence where a file should reside */</span><br=
><span>@@ -6243,7 +6244,7 @@</span><br><span>         print_default_gateway=
(M_INFO, &amp;rgi, &amp;rgi6);</span><br><span>         openvpn_exit(OPENVP=
N_EXIT_STATUS_GOOD); /* exit point */</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(ENABLE_DEBUG) &=
amp;&amp; !defined(ENABLE_SMALL) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span>     else if (streq(p[0], &quot;echo=
&quot;) || streq(p[0], &quot;parameter&quot;))</span><br><span>     {</span=
><br><span>         struct buffer string =3D alloc_buf_gc(OPTION_PARM_SIZE,=
 &amp;gc);</span><br><span>diff --git a/src/openvpn/options.h b/src/openvpn=
/options.h</span><br><span>index 51468dd..38e67c8 100644</span><br><span>--=
- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span=
><br><span>@@ -133,16 +133,16 @@</span><br><span>     int tls_mtu;         =
  /* Maximum MTU for the control channel messages */</span><br><span> </spa=
n><br><span>     /* Advanced MTU negotiation and datagram fragmentation opt=
ions */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int mtu_di=
scover_type; /* used if OS supports setting Path MTU discovery options on s=
ocket */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int mtu=
_discover_type;          /* used if OS supports setting Path MTU discovery =
options on socket */</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int fragment;          /* internal fragmentation size =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool fragment_e=
ncap;   /* true if --fragment had the &quot;mtu&quot; parameter to</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                            * =
include overhead from IP and TCP/UDP encapsulation */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int mssfix;            /* Upper bound o=
n TCP MSS */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool =
mssfix_default;   /* true if --mssfix should use the default parameters */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool mssfix_encap;=
     /* true if --mssfix had the &quot;mtu&quot; parameter to include</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
 * overhead from IP and TCP/UDP encapsulation */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    bool mssfix_fixed;     /* use the mssfix val=
ue without any encapsulation adjustments */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int fragment;                   /* internal fra=
gmentation size */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool fragment_encap;            /* true if --fragment had the &quot;mtu&=
quot; parameter to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                    * include overhead from IP and TCP/UDP =
encapsulation */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int mssfix;                     /* Upper bound on TCP MSS */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    bool mssfix_default;         =
   /* true if --mssfix should use the default parameters */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    bool mssfix_encap;             =
 /* true if --mssfix had the &quot;mtu&quot; parameter to include</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
        * overhead from IP and TCP/UDP encapsulation */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    bool mssfix_fixed;              /* =
use the mssfix value without any encapsulation adjustments */</span><br><sp=
an> </span><br><span>     int explicit_exit_notification; /* Explicitly tel=
l peer when we are exiting via OCC_EXIT or</span><br><span>                =
                        [RESTART] message */</span><br><span>diff --git a/s=
rc/openvpn/options_util.c b/src/openvpn/options_util.c</span><br><span>inde=
x 5251b21..c3938a7 100644</span><br><span>--- a/src/openvpn/options_util.c<=
/span><br><span>+++ b/src/openvpn/options_util.c</span><br><span>@@ -146,14=
 +146,14 @@</span><br><span>     return (int)i;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const=
 char *updatable_options[] =3D { &quot;block-ipv6&quot;,        &quot;block=
-outside-dns&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                                         &quot;dhcp-option&quot;,       &qu=
ot;dns&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                                   &quot;ifconfig&quot;,          &quot;ifc=
onfig-ipv6&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic const char *updatable_options[] =3D { &quot;block-ipv6&quot;, &quot;bl=
ock-outside-dns&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                           &quot;dhcp-option&quot;, &quo=
t;dns&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                                    &quot;ifconfig&quot;, &quot;ifconfig-ip=
v6&quot;,</span><br><span>                                            &quot=
;push-continuation&quot;, &quot;redirect-gateway&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                         =
  &quot;redirect-private&quot;,  &quot;route&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                           =
&quot;route-gateway&quot;,     &quot;route-ipv6&quot;,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                          =
 &quot;route-metric&quot;,      &quot;topology&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                           =
&quot;tun-mtu&quot;,           &quot;keepalive&quot; };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
    &quot;redirect-private&quot;, &quot;route&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
  &quot;route-gateway&quot;, &quot;route-ipv6&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
  &quot;route-metric&quot;, &quot;topology&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                           &q=
uot;tun-mtu&quot;, &quot;keepalive&quot; };</span><br><span> </span><br><sp=
an> bool</span><br><span> check_push_update_option_flags(char *line, int *i=
, unsigned int *flags)</span><br><span>diff --git a/src/openvpn/run_command=
.h b/src/openvpn/run_command.h</span><br><span>index 4b74f22..afd1b88 10064=
4</span><br><span>--- a/src/openvpn/run_command.h</span><br><span>+++ b/src=
/openvpn/run_command.h</span><br><span>@@ -27,12 +27,15 @@</span><br><span>=
 #include &quot;env_set.h&quot;</span><br><span> </span><br><span> /* Scrip=
t security */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
SSEC_NONE     0 /* strictly no calling of external programs */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define SSEC_BUILT_IN 1 /* only ca=
ll built-in programs such as ifconfig, route, netsh, etc.*/</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define SSEC_SCRIPTS  2 /* allow call=
ing of built-in programs and user-defined scripts */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define SSEC_PW_ENV                        =
                                                      \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    3 /* allow calling of built-in progra=
ms and user-defined scripts that may receive a password \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-         as an environmental variable *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** strictly no ca=
lling of external programs */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define SSEC_NONE     0</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/** only call built-in programs such as ifconfig, route, nets=
h, etc.*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SS=
EC_BUILT_IN 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** al=
low calling of built-in programs and user-defined scripts */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define SSEC_SCRIPTS  2</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/** allow calling of built-in =
programs and user-defined scripts that may receive a password</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    as an environmental variable =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SSEC_PW_E=
NV   3</span><br><span> </span><br><span> #define OPENVPN_EXECVE_ERROR     =
  -1  /* generic error while forking to run an external program */</span><b=
r><span> #define OPENVPN_EXECVE_NOT_ALLOWED -2  /* external program not run=
 due to script security */</span><br><span>diff --git a/src/openvpn/ssl_com=
mon.h b/src/openvpn/ssl_common.h</span><br><span>index cd5293a..e8fde86 100=
644</span><br><span>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/sr=
c/openvpn/ssl_common.h</span><br><span>@@ -222,15 +222,15 @@</span><br><spa=
n>      */</span><br><span>     uint32_t peer_id;</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct key_state_ssl ks_s=
sl; /* contains SSL object and BIOs for the control channel */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct key_state_ssl ks_ssl;=
           /* contains SSL object and BIOs for the control channel */</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    time_=
t initial;              /* when we created this session */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    time_t established;          /* wh=
en our state went S_ACTIVE */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    time_t must_negotiate;       /* key negotiation times out if no=
t finished before this time */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    time_t must_die;             /* this object is destroyed at th=
is time */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    time_t =
peer_last_packet;     /* Last time we received a packet in this control ses=
sion */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    time_t i=
nitial;                        /* when we created this session */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    time_t established;      =
              /* when our state went S_ACTIVE */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    time_t must_negotiate;                 /* =
key negotiation times out if not finished before this time */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    time_t must_die;             =
          /* this object is destroyed at this time */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    time_t peer_last_packet;             =
  /* Last time we received a packet in this control session */</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int initial_=
opcode;          /* our initial P_ opcode */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int initial_opcode;                    /* our =
initial P_ opcode */</span><br><span>     struct session_id session_id_remo=
te;   /* peer&#39;s random session ID */</span><br><span>     struct link_s=
ocket_actual remote_addr; /* peer&#39;s IP addr */</span><br><span> </span>=
<br><span>@@ -579,9 +579,8 @@</span><br><span> enum multi_status</span><br>=
<span> {</span><br><span>     CAS_NOT_CONNECTED,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    CAS_WAITING_AUTH, /**&lt; Initial TLS connec=
tion established but deferred auth is not yet finished</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                       */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    CAS_PENDING,      /**&lt; Options =
import (Connect script/plugin, ccd,...) */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    CAS_WAITING_AUTH,             /**&lt; Initial TL=
S connection established but deferred auth is not yet finished */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    CAS_PENDING,             =
     /**&lt; Options import (Connect script/plugin, ccd,...) */</span><br><=
span>     CAS_PENDING_DEFERRED,         /**&lt; Waiting on an async option =
import handler */</span><br><span>     CAS_PENDING_DEFERRED_PARTIAL, /**&lt=
; at least handler succeeded but another is still pending */</span><br><spa=
n>     CAS_FAILED,                   /**&lt; Option import failed or explic=
itly denied the client */</span><br><span>diff --git a/src/openvpn/xkey_hel=
per.c b/src/openvpn/xkey_helper.c</span><br><span>index f4a9948..3820808 10=
0644</span><br><span>--- a/src/openvpn/xkey_helper.c</span><br><span>+++ b/=
src/openvpn/xkey_helper.c</span><br><span>@@ -329,10 +329,12 @@</span><br><=
span> </span><br><span> #define MAKE_DI(x) { NID_##x, x, sizeof(x) }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* c=
lang-format off */</span><br><span>     DIG_INFO dinfo[] =3D {</span><br><s=
pan>         MAKE_DI(sha1),   MAKE_DI(sha256),     MAKE_DI(sha384),     MAK=
E_DI(sha512),</span><br><span>         MAKE_DI(sha224), MAKE_DI(sha512_224)=
, MAKE_DI(sha512_256), { 0, NULL, 0 }</span><br><span>     };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* clang-format on */</span><=
br><span> </span><br><span>     size_t out_len =3D 0;</span><br><span>     =
bool ret =3D false;</span><br><span>diff --git a/src/tapctl/tap.c b/src/tap=
ctl/tap.c</span><br><span>index 09be7e8..b633e77 100644</span><br><span>---=
 a/src/tapctl/tap.c</span><br><span>+++ b/src/tapctl/tap.c</span><br><span>=
@@ -225,10 +225,8 @@</span><br><span> delete_device(_In_ HDEVINFO hDeviceIn=
foSet, _In_ PSP_DEVINFO_DATA pDeviceInfoData,</span><br><span>             =
  _Inout_ LPBOOL pbRebootRequired)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SP_REMOVEDEVICE_PARAMS params =3D</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        .ClassInstallHeader =3D</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SP_REMOVEDEVICE_PARAMS params =3D {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        .ClassInstall=
Header =3D {</span><br><span>             .cbSize =3D sizeof(SP_CLASSINSTAL=
L_HEADER),</span><br><span>             .InstallFunction =3D DIF_REMOVE,</s=
pan><br><span>         },</span><br><span>@@ -281,10 +279,8 @@</span><br><s=
pan> change_device_state(_In_ HDEVINFO hDeviceInfoSet, _In_ PSP_DEVINFO_DAT=
A pDeviceInfoData,</span><br><span>                     _In_ BOOL bEnable, =
_Inout_ LPBOOL pbRebootRequired)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SP_PROPCHANGE_PARAMS params =3D</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        .ClassInstallHeader =3D</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SP_PROPCHANGE_PARAMS params =3D {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        .ClassInstallHe=
ader =3D {</span><br><span>             .cbSize =3D sizeof(SP_CLASSINSTALL_=
HEADER),</span><br><span>             .InstallFunction =3D DIF_PROPERTYCHAN=
GE,</span><br><span>         },</span><br><span>@@ -768,10 +764,8 @@</span>=
<br><span>     if (dwResult !=3D ERROR_SUCCESS)</span><br><span>     {</spa=
n><br><span>         /* The adapter was installed. But, the adapter ID was =
unobtainable. Clean-up. */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        SP_REMOVEDEVICE_PARAMS removedevice_params =3D</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            .ClassInstallHeader =3D</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        SP_REMOVEDEVICE_PARAMS removedevi=
ce_params =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        .ClassInstallHeader =3D {</span><br><span>                 .cbSize =
=3D sizeof(SP_CLASSINSTALL_HEADER),</span><br><span>                 .Insta=
llFunction =3D DIF_REMOVE,</span><br><span>             },</span><br><span>=
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c</span><br><span>index 3823d39..65b31e7 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_pkt.c</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_pkt.c</span><br><span>@@ -219,7 +219,7 @@</span><br><span=
>     {</span><br><span>         buf_reset_len(&amp;buf);</span><br><span> =
        buf_write(&amp;buf, client_reset_v2_tls_crypt, sizeof(client_reset_=
v2_tls_crypt));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  BPTR(&amp;buf)[i] =3D 0x23;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        (BPTR(&amp;buf))[i] =3D 0x23;</span><br><span>         ve=
rdict =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &amp;from, &amp;buf);<=
/span><br><span>         assert_int_equal(verdict, VERDICT_INVALID);</span>=
<br><span>         free_tls_pre_decrypt_state(&amp;state);</span><br><span>=
@@ -274,7 +274,7 @@</span><br><span>     free_tls_pre_decrypt_state(&amp;st=
ate);</span><br><span> </span><br><span>     /* flip a byte in the hmac */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    BPTR(&amp;buf)[20]=
 =3D 0x23;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (BPTR=
(&amp;buf))[20] =3D 0x23;</span><br><span>     verdict =3D tls_pre_decrypt_=
lite(&amp;tas, &amp;state, &amp;from, &amp;buf);</span><br><span>     asser=
t_int_equal(verdict, VERDICT_INVALID);</span><br><span>     free_tls_pre_de=
crypt_state(&amp;state);</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1129?usp=3Demail">change =
1129</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1129?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibd900adfc775b7f785f1d563018=
4a124f5d8ff4b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1129 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--TxooE3DfBh4=--

