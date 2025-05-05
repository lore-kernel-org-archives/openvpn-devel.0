From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 5 May 2025 11:03:48 +0000
In-Reply-To: <gerrit.1730392980000.I7f0ba2261b61f6eed511cbd8bb2e880d774d1365@...2715...>
References: <gerrit.1730392980000.I7f0ba2261b61f6eed511cbd8bb2e880d774d1365@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8a33ee563a00ae2bceeb57cf25a8b1612869b549-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gxu4xeyvDd0="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Manually reformat
 some long trailing comments
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gxu4xeyvDd0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#17) to the change originally created b=
y flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/792?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Manually reformat some long trailing comments
......................................................................

Manually reformat some long trailing comments

When trying to reformat the code with a formatter
that actually checks line-lengths, these never
come out nice otherwise.

Change-Id: I7f0ba2261b61f6eed511cbd8bb2e880d774d1365
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250505105449.18826-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
561.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M sample/sample-plugins/simple/base64.c
M src/openvpn/comp.h
M src/openvpn/errlevel.h
M src/openvpn/fragment.h
M src/openvpn/init.c
M src/openvpn/manage.c
M src/openvpn/misc.h
M src/openvpn/options.c
M src/openvpn/ssl_common.h
9 files changed, 152 insertions(+), 134 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/792/17

diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/=
simple/base64.c
index 291f9e1..3a09eb5 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -31,10 +31,14 @@
 #define PLUGIN_NAME "base64.c"

 /* Exported plug-in v3 API functions */
-plugin_log_t ovpn_log =3D NULL;                      /**< Pointer to the O=
penVPN log function.  See plugin_log() */
-plugin_vlog_t ovpn_vlog =3D NULL;                    /**< Pointer to the O=
penVPN vlog function. See plugin_vlog() */
-plugin_base64_encode_t ovpn_base64_encode =3D NULL;  /**< Pointer to the o=
penvpn_base64_encode () function */
-plugin_base64_decode_t ovpn_base64_decode =3D NULL;  /**< Pointer to the o=
penvpn_base64_decode () function */
+/** Pointer to the OpenVPN log function.  See plugin_log() */
+plugin_log_t ovpn_log =3D NULL;
+/** Pointer to the OpenVPN vlog function. See plugin_vlog() */
+plugin_vlog_t ovpn_vlog =3D NULL;
+/** Pointer to the openvpn_base64_encode () function */
+plugin_base64_encode_t ovpn_base64_encode =3D NULL;
+/** Pointer to the openvpn_base64_decode () function */
+plugin_base64_decode_t ovpn_base64_decode =3D NULL;

 /**
  * Search the environment pointer for a specific env var name
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 7eed331..f9f9598 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -36,20 +36,27 @@
  #define COMP_F_ADAPTIVE             (1<<0) / * COMP_ALG_LZO only * /
  #define COMP_F_ALLOW_COMPRESS       (1<<1) / * not only incoming is compr=
essed but also outgoing * /
  */
-#define COMP_F_SWAP                 (1<<2) /* initial command byte is swap=
ped with last byte in buffer to preserve payload alignment */
-#define COMP_F_ADVERTISE_STUBS_ONLY (1<<3) /* tell server that we only sup=
port compression stubs */
-#define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compression=
, even with COMP_F_ADVERTISE_STUBS_ONLY
-                                            * we still accept other compre=
ssions to be pushed */
-#define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo no =
when we see a client with comp-lzo in occ */
-#define COMP_F_ALLOW_ASYM           (1<<6) /* Compression was explicitly s=
et to allow asymetric compression */
-#define COMP_F_ALLOW_NOCOMP_ONLY    (1<<7) /* Do not allow compression fra=
ming (breaks DCO) */
+/** initial command byte is swapped with last byte in buffer to preserve p=
ayload alignment */
+#define COMP_F_SWAP                 (1<<2)
+/** tell server that we only support compression stubs */
+#define COMP_F_ADVERTISE_STUBS_ONLY (1<<3)
+/** Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
+ * we still accept other compressions to be pushed */
+#define COMP_F_ALLOW_STUB_ONLY      (1<<4)
+/** push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ =
*/
+#define COMP_F_MIGRATE              (1<<5)
+/** Compression was explicitly set to allow asymetric compression */
+#define COMP_F_ALLOW_ASYM           (1<<6)
+/** Do not allow compression framing (breaks DCO) */
+#define COMP_F_ALLOW_NOCOMP_ONLY    (1<<7)

 /* algorithms */
 #define COMP_ALG_UNDEF  0
-#define COMP_ALG_STUB   1 /* support compression command byte and framing =
without actual compression */
-#define COMP_ALG_LZO    2 /* LZO algorithm */
-#define COMP_ALG_SNAPPY 3 /* Snappy algorithm (no longer supported) */
-#define COMP_ALG_LZ4    4 /* LZ4 algorithm */
+/** support compression command byte and framing without actual compressio=
n */
+#define COMP_ALG_STUB   1
+#define COMP_ALG_LZO    2 /**< LZO algorithm */
+#define COMP_ALG_SNAPPY 3 /**< Snappy algorithm (no longer supported) */
+#define COMP_ALG_LZ4    4 /**< LZ4 algorithm */


 /* algorithm v2 */
@@ -106,7 +113,8 @@
 #define LZO_COMPRESS_BYTE 0x66
 #define LZ4_COMPRESS_BYTE 0x69
 #define NO_COMPRESS_BYTE      0xFA
-#define NO_COMPRESS_BYTE_SWAP 0xFB /* to maintain payload alignment, repla=
ce this byte with last byte of packet */
+/** to maintain payload alignment, replace this byte with last byte of pac=
ket */
+#define NO_COMPRESS_BYTE_SWAP 0xFB

 /* V2 on wire code */
 #define COMP_ALGV2_INDICATOR_BYTE       0x50
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index bf2e54e..1f54ed8 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -143,7 +143,7 @@
 #define D_PACKET_TRUNC_DEBUG LOGLEV(7, 70, M_DEBUG)  /* PACKET_TRUNCATION_=
CHECK verbose */
 #define D_PING               LOGLEV(7, 70, M_DEBUG)  /* PING send/receive =
messages */
 #define D_PS_PROXY_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* port share proxy d=
ebug */
-#define D_TLS_KEYSELECT      LOGLEV(7, 70, M_DEBUG)  /* show information o=
n key selection for data channel */
+#define D_TLS_KEYSELECT      LOGLEV(7, 70, M_DEBUG)  /* show key selection=
 for data channel */
 #define D_ARGV_PARSE_CMD     LOGLEV(7, 70, M_DEBUG)  /* show parse_line() =
errors in argv_parse_cmd */
 #define D_CRYPTO_DEBUG       LOGLEV(7, 70, M_DEBUG)  /* show detailed info=
 from crypto.c routines */
 #define D_PID_DEBUG          LOGLEV(7, 70, M_DEBUG)  /* show packet-id deb=
ugging info */
@@ -153,7 +153,7 @@

 #define D_VLAN_DEBUG         LOGLEV(7, 74, M_DEBUG)  /* show VLAN tagging/=
untagging debug info */

-#define D_HANDSHAKE_VERBOSE  LOGLEV(8, 70, M_DEBUG)  /* show detailed desc=
ription of each handshake */
+#define D_HANDSHAKE_VERBOSE  LOGLEV(8, 70, M_DEBUG)  /* show detailed desc=
ription of handshake */
 #define D_TLS_DEBUG_MED      LOGLEV(8, 70, M_DEBUG)  /* limited info from =
tls_session routines */
 #define D_INTERVAL           LOGLEV(8, 70, M_DEBUG)  /* show interval.h de=
bugging info */
 #define D_SCHEDULER          LOGLEV(8, 70, M_DEBUG)  /* show scheduler deb=
ugging info */
@@ -168,7 +168,7 @@
 #define D_PACKET_CONTENT     LOGLEV(9, 70, M_DEBUG)  /* show before/after =
encryption packet content */
 #define D_TLS_NO_SEND_KEY    LOGLEV(9, 70, M_DEBUG)  /* show when no data =
channel send-key exists */
 #define D_PID_PERSIST_DEBUG  LOGLEV(9, 70, M_DEBUG)  /* show packet-id per=
sist debugging info */
-#define D_LINK_RW_VERBOSE    LOGLEV(9, 70, M_DEBUG)  /* show link reads/wr=
ites with greater verbosity */
+#define D_LINK_RW_VERBOSE    LOGLEV(9, 70, M_DEBUG)  /* increase link read=
s/writes verbosity */
 #define D_STREAM_DEBUG       LOGLEV(9, 70, M_DEBUG)  /* show TCP stream de=
bug info */
 #define D_WIN32_IO           LOGLEV(9, 70, M_DEBUG)  /* win32 I/O debuggin=
g info */
 #define D_PKCS11_DEBUG       LOGLEV(9, 70, M_DEBUG)  /* show PKCS#11 debug=
ging */
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index 3cd0ee7..88f6053 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -92,25 +92,28 @@
  * List of fragment structures for reassembling multiple incoming packets
  * concurrently.
  */
-struct fragment_list {
-    int seq_id;                 /**< Highest fragmentation sequence ID of
-                                 *   the packets currently being
-                                 *   reassembled. */
-    int index;                  /**< Index of the packet being reassembled
-                                 *   with the highest fragmentation
-                                 *   sequence ID into the \c
-                                 *   fragment_list.fragments array. */
+struct fragment_list
+{
+    /** Highest fragmentation sequence ID of
+     *  the packets currently being
+     *  reassembled. */
+    int seq_id;
+    /** Index of the packet being reassembled
+     *   with the highest fragmentation
+     *   sequence ID into the \c
+     *   fragment_list.fragments array. */
+    int index;

-/** Array of reassembly structures, each can contain one whole packet.
- *
- *  The fragmentation sequence IDs of the packets being reassembled in
- *  this array are linearly increasing. \c
- *  fragment_list.fragments[fragment_list.index] has an ID of \c
- *  fragment_list.seq_id.  This means that one of these \c fragment_list
- *  structures can at any one time contain at most packets with the
- *  fragmentation sequence IDs in the range \c fragment_list.seq_id \c -
- *  \c N_FRAG_BUF \c + \c 1 to \c fragment_list.seq_id, inclusive.
- */
+    /** Array of reassembly structures, each can contain one whole packet.
+     *
+     *  The fragmentation sequence IDs of the packets being reassembled in
+     *  this array are linearly increasing. \c
+     *  fragment_list.fragments[fragment_list.index] has an ID of \c
+     *  fragment_list.seq_id.  This means that one of these \c fragment_li=
st
+     *  structures can at any one time contain at most packets with the
+     *  fragmentation sequence IDs in the range \c fragment_list.seq_id \c=
 -
+     *  \c N_FRAG_BUF \c + \c 1 to \c fragment_list.seq_id, inclusive.
+     */
     struct fragment fragments[N_FRAG_BUF];
 };

@@ -149,9 +152,7 @@
                                  *   the remote OpenVPN peer can determine
                                  *   which parts belong to which original
                                  *   packet. */
-#define MAX_FRAG_PKT_SIZE 65536
-    /**< (Not used) Maximum packet size before
-     *   fragmenting. */
+#define MAX_FRAG_PKT_SIZE 65536 /**< (Not used) Maximum packet size before=
 fragmenting. */
     int outgoing_frag_size;     /**< Size in bytes of each part to be
                                  *   sent, except for the last part which
                                  *   may be smaller.
@@ -183,45 +184,37 @@
 /*************************************************************************=
*/
 /** @name Fragment header
  *  @todo Add description of %fragment header format.
- *//** @{ *//*************************************/
+ */
+/** @{ */ /*************************************/

 typedef uint32_t fragment_header_type;
-/**< Fragmentation information is stored in
- *   a 32-bit packet header. */
+/**< Fragmentation information is stored in a 32-bit packet header. */

 #define hton_fragment_header_type(x) htonl(x)
-/**< Convert a fragment_header_type from
- *   host to network order. */
+/**< Convert a fragment_header_type from host to network order. */

 #define ntoh_fragment_header_type(x) ntohl(x)
-/**< Convert a \c fragment_header_type
- *   from network to host order. */
+/**< Convert a \c fragment_header_type from network to host order. */

-#define FRAG_TYPE_MASK        0x00000003
-/**< Bit mask for %fragment type info. */
-#define FRAG_TYPE_SHIFT       0 /**< Bit shift for %fragment type info. */
+#define FRAG_TYPE_MASK               0x00000003 /**< Bit mask for %fragmen=
t type info. */
+#define FRAG_TYPE_SHIFT              0          /**< Bit shift for %fragme=
nt type info. */

-#define FRAG_WHOLE            0 /**< Fragment type indicating packet is
-                                 *   whole. */
-#define FRAG_YES_NOTLAST      1 /**< Fragment type indicating packet is
-                                 *   part of a fragmented packet, but not
-                                 *   the last part in the sequence. */
-#define FRAG_YES_LAST         2 /**< Fragment type indicating packet is
-                                 *   the last part in the sequence of
-                                 *   parts. */
-#define FRAG_TEST             3 /**< Fragment type not implemented yet.
-                                 *   In the future might be used as a
-                                 *   control packet for establishing MTU
-                                 *   size. */
+#define FRAG_WHOLE                   0          /**< Fragment type indicat=
ing packet is whole. */
+#define FRAG_YES_NOTLAST             1
+/**< Fragment type indicating packet is part of a fragmented packet, but n=
ot
+ *   the last part in the sequence. */
+#define FRAG_YES_LAST                2
+/**< Fragment type indicating packet is the last part in the sequence of p=
arts. */
+#define FRAG_TEST                    3
+/**< Fragment type not implemented yet.
+ * In the future might be used as a control packet for establishing MTU si=
ze. */

-#define FRAG_SEQ_ID_MASK      0x000000ff
-/**< Bit mask for %fragment sequence ID. */
-#define FRAG_SEQ_ID_SHIFT     2 /**< Bit shift for %fragment sequence ID. =
*/
+#define FRAG_SEQ_ID_MASK             0x000000ff /**< Bit mask for %fragmen=
t sequence ID. */
+#define FRAG_SEQ_ID_SHIFT            2          /**< Bit shift for %fragme=
nt sequence ID. */

-#define FRAG_ID_MASK          0x0000001f
-/**< Bit mask for %fragment ID. */
-#define FRAG_ID_SHIFT         10
-/**< Bit shift for %fragment ID. */
+#define FRAG_ID_MASK                 0x0000001f /**< Bit mask for %fragmen=
t ID. */
+#define FRAG_ID_SHIFT                10         /**< Bit shift for %fragme=
nt ID. */
+

 /*
  * FRAG_SIZE  14 bits
@@ -232,12 +225,10 @@
  *   max_frag_size is only sent over the wire if FRAG_LAST is set.  Otherw=
ise it is assumed
  *   to be the actual %fragment size received.
  */
-#define FRAG_SIZE_MASK        0x00003fff
-/**< Bit mask for %fragment size. */
-#define FRAG_SIZE_SHIFT       15
-/**< Bit shift for %fragment size. */
-#define FRAG_SIZE_ROUND_SHIFT 2 /**< Bit shift for %fragment size rounding=
. */
-#define FRAG_SIZE_ROUND_MASK ((1 << FRAG_SIZE_ROUND_SHIFT) - 1)
+#define FRAG_SIZE_MASK               0x00003fff /**< Bit mask for %fragmen=
t size. */
+#define FRAG_SIZE_SHIFT              15         /**< Bit shift for %fragme=
nt size. */
+#define FRAG_SIZE_ROUND_SHIFT        2          /**< Bit shift for %fragme=
nt size rounding. */
+#define FRAG_SIZE_ROUND_MASK         ((1 << FRAG_SIZE_ROUND_SHIFT) - 1)
 /**< Bit mask for %fragment size rounding. */

 /*
@@ -245,10 +236,8 @@
  *
  * IF FRAG_WHOLE or FRAG_YES_NOTLAST, these 16 bits are available (not cur=
rently used)
  */
-#define FRAG_EXTRA_MASK         0x0000ffff
-/**< Bit mask for extra bits. */
-#define FRAG_EXTRA_SHIFT        15
-/**< Bit shift for extra bits. */
+#define FRAG_EXTRA_MASK              0x0000ffff /**< Bit mask for extra bi=
ts. */
+#define FRAG_EXTRA_SHIFT             15         /**< Bit shift for extra b=
its. */

 /** @} name Fragment header *//*******************************************=
*/

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9eb8290..187c0a9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -983,7 +983,8 @@
 {
     if (!options->dev && options->dev_node)
     {
-        char *dev_node =3D string_alloc(options->dev_node, NULL); /* POSIX=
 basename() implementations may modify its arguments */
+        /* POSIX basename() implementations may modify its arguments */
+        char *dev_node =3D string_alloc(options->dev_node, NULL);
         options->dev =3D basename(dev_node);
     }
 }
@@ -2572,12 +2573,14 @@
             }
             else
             {
-                initialization_sequence_completed(c, error_flags); /* clie=
nt/p2p --route-delay undefined */
+                /* client/p2p --route-delay undefined */
+                initialization_sequence_completed(c, error_flags);
             }
         }
         else if (c->options.mode =3D=3D MODE_POINT_TO_POINT)
         {
-            initialization_sequence_completed(c, error_flags); /* client/p=
2p restart with --persist-tun */
+            /* client/p2p restart with --persist-tun */
+            initialization_sequence_completed(c, error_flags);
         }

         tls_print_deferred_options_results(c);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0e73942..567b6ea 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3447,7 +3447,8 @@
         const bool standalone_disabled_save =3D man->persist.standalone_di=
sabled;
         time_t expire =3D 0;

-        man->persist.standalone_disabled =3D false; /* This is so M_CLIENT=
 messages will be correctly passed through msg() */
+        /* This is so M_CLIENT messages will be correctly passed through m=
sg() */
+        man->persist.standalone_disabled =3D false;

         /* set expire time */
         update_time();
@@ -3510,7 +3511,8 @@
         unsigned int up_query_mode =3D 0;
         const char *sc =3D NULL;
         ret =3D true;
-        man->persist.standalone_disabled =3D false; /* This is so M_CLIENT=
 messages will be correctly passed through msg() */
+        /* This is so M_CLIENT messages will be correctly passed through m=
sg() */
+        man->persist.standalone_disabled =3D false;
         man->persist.special_state_msg =3D NULL;

         CLEAR(man->connection.up_query);
@@ -3634,7 +3636,8 @@

     if (man_standalone_ok(man))
     {
-        man->persist.standalone_disabled =3D false; /* This is so M_CLIENT=
 messages will be correctly passed through msg() */
+        /* This is so M_CLIENT messages will be correctly passed through m=
sg() */
+        man->persist.standalone_disabled =3D false;
         man->persist.special_state_msg =3D NULL;

         *state =3D EKS_SOLICIT;
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 3c46c02..5f55a060 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -114,12 +114,14 @@
 #define GET_USER_PASS_NEED_STR      (1<<5)
 #define GET_USER_PASS_PREVIOUS_CREDS_FAILED (1<<6)

-#define GET_USER_PASS_DYNAMIC_CHALLENGE      (1<<7) /* CRV1 protocol  -- d=
ynamic challenge */
-#define GET_USER_PASS_STATIC_CHALLENGE       (1<<8) /* SCRV1 protocol -- s=
tatic challenge */
-#define GET_USER_PASS_STATIC_CHALLENGE_ECHO  (1<<9) /* SCRV1 protocol -- e=
cho response */
+#define GET_USER_PASS_DYNAMIC_CHALLENGE      (1<<7) /**< CRV1 protocol  --=
 dynamic challenge */
+#define GET_USER_PASS_STATIC_CHALLENGE       (1<<8) /**< SCRV1 protocol --=
 static challenge */
+#define GET_USER_PASS_STATIC_CHALLENGE_ECHO  (1<<9) /**< SCRV1 protocol --=
 echo response */

-#define GET_USER_PASS_INLINE_CREDS (1<<10)  /* indicates that auth_file is=
 actually inline creds */
-#define GET_USER_PASS_STATIC_CHALLENGE_CONCAT (1<<11)  /* indicates passwo=
rd and response should be concatenated */
+/** indicates that auth_file is actually inline creds */
+#define GET_USER_PASS_INLINE_CREDS (1<<10)
+/** indicates password and response should be concatenated */
+#define GET_USER_PASS_STATIC_CHALLENGE_CONCAT (1<<11)

 /**
  * Retrieves the user credentials from various sources depending on the fl=
ags.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 96119c4..8c41dec 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -853,7 +853,8 @@
     o->tuntap_options.ip_win32_type =3D IPW32_SET_DHCP_MASQ;
 #endif
     o->tuntap_options.dhcp_lease_time =3D 31536000; /* one year */
-    o->tuntap_options.dhcp_masq_offset =3D 0;     /* use network address a=
s internal DHCP server address */
+    /* use network address as internal DHCP server address */
+    o->tuntap_options.dhcp_masq_offset =3D 0;
     o->route_method =3D ROUTE_METHOD_ADAPTIVE;
     o->block_outside_dns =3D false;
     o->windows_driver =3D WINDOWS_DRIVER_UNSPECIFIED;
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 90e16f9..d2c6393 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -75,10 +75,10 @@
  *
  * @{
  */
-#define S_ERROR         (-2)     /**< Error state.  */
-#define S_ERROR_PRE     (-1)     /**< Error state but try to send out aler=
ts
-                                  *  before killing the keystore and moving
-                                  *  it to S_ERROR */
+#define S_ERROR         (-2)    /**< Error state.  */
+#define S_ERROR_PRE     (-1)    /**< Error state but try to send out alerts
+                                 *  before killing the keystore and moving
+                                 *  it to S_ERROR */
 #define S_UNDEF           0     /**< Undefined state, used after a \c
                                  *   key_state is cleaned up. */
 #define S_INITIAL         1     /**< Initial \c key_state state after
@@ -567,18 +567,22 @@
  * tls_session reaches S_ACTIVE, this state machine moves to CAS_PENDING (=
server)
  * or CAS_CONNECT_DONE (client/p2p) as clients skip the stages associated =
with
  * connect scripts/plugins */
-enum multi_status {
+enum multi_status
+{
     CAS_NOT_CONNECTED,
-    CAS_WAITING_AUTH,               /**< Initial TLS connection establishe=
d but deferred auth is not yet finished */
-    CAS_PENDING,                    /**< Options import (Connect script/pl=
ugin, ccd,...) */
-    CAS_PENDING_DEFERRED,           /**< Waiting on an async option import=
 handler */
-    CAS_PENDING_DEFERRED_PARTIAL,   /**< at least handler succeeded but an=
other is still pending */
-    CAS_FAILED,                     /**< Option import failed or explicitl=
y denied the client */
-    CAS_WAITING_OPTIONS_IMPORT,     /**< client with pull or p2p waiting f=
or first time options import */
-    CAS_RECONNECT_PENDING,          /**< session has already successful es=
tablished (CAS_CONNECT_DONE)
-                                     * but has a reconnect and needs to re=
do some initialisation, this state is
-                                     * similar CAS_WAITING_OPTIONS_IMPORT =
but skips a few things. The normal connection
-                                     * skips this step. */
+    CAS_WAITING_AUTH, /**< Initial TLS connection established but deferred=
 auth is not yet finished
+                       */
+    CAS_PENDING,      /**< Options import (Connect script/plugin, ccd,...)=
 */
+    CAS_PENDING_DEFERRED,         /**< Waiting on an async option import h=
andler */
+    CAS_PENDING_DEFERRED_PARTIAL, /**< at least handler succeeded but anot=
her is still pending */
+    CAS_FAILED,                   /**< Option import failed or explicitly =
denied the client */
+    CAS_WAITING_OPTIONS_IMPORT,   /**< client with pull or p2p waiting for=
 first time options import
+                                   */
+    /** session has already successful established (CAS_CONNECT_DONE) but =
has a
+     * reconnect and needs to redo some initialisation, this state is simi=
lar
+     * CAS_WAITING_OPTIONS_IMPORT but skips a few things. The normal conne=
ction
+     * skips this step. */
+    CAS_RECONNECT_PENDING,
     CAS_CONNECT_DONE,
 };

@@ -626,8 +630,9 @@
     int n_hard_errors; /* errors due to TLS negotiation failure */
     int n_soft_errors; /* errors due to unrecognized or failed-to-authenti=
cate incoming packets */

-    /*
-     * Our locked common name, username, and cert hashes (cannot change du=
ring the life of this tls_multi object)
+    /**
+     * Our locked common name, username, and cert hashes
+     * (cannot change during the life of this tls_multi object)
      */
     char *locked_cn;

@@ -642,43 +647,46 @@

     struct cert_hash_set *locked_cert_hash_set;

-    /** Time of last when we updated the cached state of
+    /**
+     * Time of last when we updated the cached state of
      * tls_authentication_status deferred files */
     time_t tas_cache_last_update;

     /** The number of times we updated the cache */
     unsigned int tas_cache_num_updates;

-    /*
-     * An error message to send to client on AUTH_FAILED
-     */
+    /** An error message to send to client on AUTH_FAILED */
     char *client_reason;

-    /*
+    /**
      * A multi-line string of general-purpose info received from peer
      * over control channel.
      */
     char *peer_info;
-    char *auth_token;    /**< If server sends a generated auth-token,
-                          *   this is the token to use for future
-                          *   user/pass authentications in this session.
-                          */
-    char *auth_token_initial;
-    /**< The first auth-token we sent to a client. We use this to remember
+    /**
+     * If server sends a generated auth-token,
+     * this is the token to use for future
+     * user/pass authentications in this session.
+     */
+    char *auth_token;
+    /**
+     * The first auth-token we sent to a client. We use this to remember
      * the session ID and initial timestamp when generating new auth-token.
      */
-#define  AUTH_TOKEN_HMAC_OK              (1<<0)
-    /**< Auth-token sent from client has valid hmac */
-#define  AUTH_TOKEN_EXPIRED              (1<<1)
-    /**< Auth-token sent from client has expired */
-#define  AUTH_TOKEN_VALID_EMPTYUSER      (1<<2)
-    /**<
-     * Auth-token is only valid for an empty username
-     * and not the username actually supplied from the client
-     *
-     * OpenVPN 3 clients sometimes wipes or replaces the username with a
-     * username hint from their config.
-     */
+    char *auth_token_initial;
+
+/** Auth-token sent from client has valid hmac */
+#define AUTH_TOKEN_HMAC_OK         (1 << 0)
+/** Auth-token sent from client has expired */
+#define AUTH_TOKEN_EXPIRED         (1 << 1)
+/**
+ * Auth-token is only valid for an empty username
+ * and not the username actually supplied from the client
+ *
+ * OpenVPN 3 clients sometimes wipes or replaces the username with a
+ * username hint from their config.
+ */
+#define AUTH_TOKEN_VALID_EMPTYUSER (1 << 2)

     /* For P_DATA_V2 */
     uint32_t peer_id;
@@ -690,10 +698,10 @@
     /*
      * Our session objects.
      */
+    /** Array of \c tls_session objects
+     *  representing control channel
+     *  sessions with the remote peer. */
     struct tls_session session[TM_SIZE];
-    /**< Array of \c tls_session objects
-     *   representing control channel
-     *   sessions with the remote peer. */

     /* Only used when DCO is used to remember how many keys we installed
      * for this session */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/792?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7f0ba2261b61f6eed511cbd8bb2e880d774d1365
Gerrit-Change-Number: 792
Gerrit-PatchSet: 17
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--gxu4xeyvDd0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #17</strong> to the change originally c=
reated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/792?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Manually reformat some long trailing comments<br><br=
>When trying to reformat the code with a formatter<br>that actually checks =
line-lengths, these never<br>come out nice otherwise.<br><br>Change-Id: I7f=
0ba2261b61f6eed511cbd8bb2e880d774d1365<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<=
br>Message-Id: &lt;20250505105449.18826-1-gert@...1296...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31561.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M sample/sa=
mple-plugins/simple/base64.c<br>M src/openvpn/comp.h<br>M src/openvpn/errle=
vel.h<br>M src/openvpn/fragment.h<br>M src/openvpn/init.c<br>M src/openvpn/=
manage.c<br>M src/openvpn/misc.h<br>M src/openvpn/options.c<br>M src/openvp=
n/ssl_common.h<br>9 files changed, 152 insertions(+), 134 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/792/1=
7</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/sample/sample-plugins/simple/base64.c b/sample/sampl=
e-plugins/simple/base64.c</span><br><span>index 291f9e1..3a09eb5 100644</sp=
an><br><span>--- a/sample/sample-plugins/simple/base64.c</span><br><span>++=
+ b/sample/sample-plugins/simple/base64.c</span><br><span>@@ -31,10 +31,14 =
@@</span><br><span> #define PLUGIN_NAME &quot;base64.c&quot;</span><br><spa=
n> </span><br><span> /* Exported plug-in v3 API functions */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-plugin_log_t ovpn_log =3D NULL;     =
                 /**&lt; Pointer to the OpenVPN log function.  See plugin_l=
og() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-plugin_vlog_t =
ovpn_vlog =3D NULL;                    /**&lt; Pointer to the OpenVPN vlog =
function. See plugin_vlog() */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-plugin_base64_encode_t ovpn_base64_encode =3D NULL;  /**&lt; Point=
er to the openvpn_base64_encode () function */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-plugin_base64_decode_t ovpn_base64_decode =3D NULL=
;  /**&lt; Pointer to the openvpn_base64_decode () function */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/** Pointer to the OpenVPN log f=
unction.  See plugin_log() */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+plugin_log_t ovpn_log =3D NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/** Pointer to the OpenVPN vlog function. See plugin_=
vlog() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+plugin_vlo=
g_t ovpn_vlog =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/** Pointer to the openvpn_base64_encode () function */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+plugin_base64_encode_t ovpn_base64_=
encode =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
 Pointer to the openvpn_base64_decode () function */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+plugin_base64_decode_t ovpn_base64_decode=
 =3D NULL;</span><br><span> </span><br><span> /**</span><br><span>  * Searc=
h the environment pointer for a specific env var name</span><br><span>diff =
--git a/src/openvpn/comp.h b/src/openvpn/comp.h</span><br><span>index 7eed3=
31..f9f9598 100644</span><br><span>--- a/src/openvpn/comp.h</span><br><span=
>+++ b/src/openvpn/comp.h</span><br><span>@@ -36,20 +36,27 @@</span><br><sp=
an>  #define COMP_F_ADAPTIVE             (1&lt;&lt;0) / * COMP_ALG_LZO only=
 * /</span><br><span>  #define COMP_F_ALLOW_COMPRESS       (1&lt;&lt;1) / *=
 not only incoming is compressed but also outgoing * /</span><br><span>  */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define COMP_F_SWAP  =
               (1&lt;&lt;2) /* initial command byte is swapped with last by=
te in buffer to preserve payload alignment */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define COMP_F_ADVERTISE_STUBS_ONLY (1&lt;&lt;3) /*=
 tell server that we only support compression stubs */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define COMP_F_ALLOW_STUB_ONLY      (1&lt;=
&lt;4) /* Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ON=
LY</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                         * we still accept other compressions to be pushed =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define COMP_F_MIGR=
ATE              (1&lt;&lt;5) /* push stub-v2 or comp-lzo no when we see a =
client with comp-lzo in occ */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define COMP_F_ALLOW_ASYM           (1&lt;&lt;6) /* Compression wa=
s explicitly set to allow asymetric compression */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define COMP_F_ALLOW_NOCOMP_ONLY    (1&lt;&lt;=
7) /* Do not allow compression framing (breaks DCO) */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/** initial command byte is swapped with=
 last byte in buffer to preserve payload alignment */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define COMP_F_SWAP                 (1&lt=
;&lt;2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** tell ser=
ver that we only support compression stubs */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define COMP_F_ADVERTISE_STUBS_ONLY (1&lt;&lt;3)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Only accept stub=
 compression, even with COMP_F_ADVERTISE_STUBS_ONLY</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * we still accept other compressions to =
be pushed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 COMP_F_ALLOW_STUB_ONLY      (1&lt;&lt;4)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/** push stub-v2 or comp-lzo no when we see a client =
with comp-lzo in occ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define COMP_F_MIGRATE              (1&lt;&lt;5)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/** Compression was explicitly set to all=
ow asymetric compression */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define COMP_F_ALLOW_ASYM           (1&lt;&lt;6)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/** Do not allow compression framing (=
breaks DCO) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne COMP_F_ALLOW_NOCOMP_ONLY    (1&lt;&lt;7)</span><br><span> </span><br><sp=
an> /* algorithms */</span><br><span> #define COMP_ALG_UNDEF  0</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define COMP_ALG_STUB   1 /* supp=
ort compression command byte and framing without actual compression */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define COMP_ALG_LZO    2 =
/* LZO algorithm */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine COMP_ALG_SNAPPY 3 /* Snappy algorithm (no longer supported) */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define COMP_ALG_LZ4    4 /*=
 LZ4 algorithm */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
* support compression command byte and framing without actual compression *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define COMP_ALG_S=
TUB   1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define COMP=
_ALG_LZO    2 /**&lt; LZO algorithm */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define COMP_ALG_SNAPPY 3 /**&lt; Snappy algorithm (no l=
onger supported) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define COMP_ALG_LZ4    4 /**&lt; LZ4 algorithm */</span><br><span> </span>=
<br><span> </span><br><span> /* algorithm v2 */</span><br><span>@@ -106,7 +=
113,8 @@</span><br><span> #define LZO_COMPRESS_BYTE 0x66</span><br><span> #=
define LZ4_COMPRESS_BYTE 0x69</span><br><span> #define NO_COMPRESS_BYTE    =
  0xFA</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define NO_COMP=
RESS_BYTE_SWAP 0xFB /* to maintain payload alignment, replace this byte wit=
h last byte of packet */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/** to maintain payload alignment, replace this byte with last byte of=
 packet */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define N=
O_COMPRESS_BYTE_SWAP 0xFB</span><br><span> </span><br><span> /* V2 on wire =
code */</span><br><span> #define COMP_ALGV2_INDICATOR_BYTE       0x50</span=
><br><span>diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h</sp=
an><br><span>index bf2e54e..1f54ed8 100644</span><br><span>--- a/src/openvp=
n/errlevel.h</span><br><span>+++ b/src/openvpn/errlevel.h</span><br><span>@=
@ -143,7 +143,7 @@</span><br><span> #define D_PACKET_TRUNC_DEBUG LOGLEV(7, =
70, M_DEBUG)  /* PACKET_TRUNCATION_CHECK verbose */</span><br><span> #defin=
e D_PING               LOGLEV(7, 70, M_DEBUG)  /* PING send/receive message=
s */</span><br><span> #define D_PS_PROXY_DEBUG     LOGLEV(7, 70, M_DEBUG)  =
/* port share proxy debug */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define D_TLS_KEYSELECT      LOGLEV(7, 70, M_DEBUG)  /* show informa=
tion on key selection for data channel */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define D_TLS_KEYSELECT      LOGLEV(7, 70, M_DEBUG)  =
/* show key selection for data channel */</span><br><span> #define D_ARGV_P=
ARSE_CMD     LOGLEV(7, 70, M_DEBUG)  /* show parse_line() errors in argv_pa=
rse_cmd */</span><br><span> #define D_CRYPTO_DEBUG       LOGLEV(7, 70, M_DE=
BUG)  /* show detailed info from crypto.c routines */</span><br><span> #def=
ine D_PID_DEBUG          LOGLEV(7, 70, M_DEBUG)  /* show packet-id debuggin=
g info */</span><br><span>@@ -153,7 +153,7 @@</span><br><span> </span><br><=
span> #define D_VLAN_DEBUG         LOGLEV(7, 74, M_DEBUG)  /* show VLAN tag=
ging/untagging debug info */</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define D_HANDSHAKE_VERBOSE  LOGLEV(8, 70, M_DEBUG=
)  /* show detailed description of each handshake */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_HANDSHAKE_VERBOSE  LOGLEV(8, 70=
, M_DEBUG)  /* show detailed description of handshake */</span><br><span> #=
define D_TLS_DEBUG_MED      LOGLEV(8, 70, M_DEBUG)  /* limited info from tl=
s_session routines */</span><br><span> #define D_INTERVAL           LOGLEV(=
8, 70, M_DEBUG)  /* show interval.h debugging info */</span><br><span> #def=
ine D_SCHEDULER          LOGLEV(8, 70, M_DEBUG)  /* show scheduler debuggin=
g info */</span><br><span>@@ -168,7 +168,7 @@</span><br><span> #define D_PA=
CKET_CONTENT     LOGLEV(9, 70, M_DEBUG)  /* show before/after encryption pa=
cket content */</span><br><span> #define D_TLS_NO_SEND_KEY    LOGLEV(9, 70,=
 M_DEBUG)  /* show when no data channel send-key exists */</span><br><span>=
 #define D_PID_PERSIST_DEBUG  LOGLEV(9, 70, M_DEBUG)  /* show packet-id per=
sist debugging info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define D_LINK_RW_VERBOSE    LOGLEV(9, 70, M_DEBUG)  /* show link reads/wr=
ites with greater verbosity */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define D_LINK_RW_VERBOSE    LOGLEV(9, 70, M_DEBUG)  /* increase=
 link reads/writes verbosity */</span><br><span> #define D_STREAM_DEBUG    =
   LOGLEV(9, 70, M_DEBUG)  /* show TCP stream debug info */</span><br><span=
> #define D_WIN32_IO           LOGLEV(9, 70, M_DEBUG)  /* win32 I/O debuggi=
ng info */</span><br><span> #define D_PKCS11_DEBUG       LOGLEV(9, 70, M_DE=
BUG)  /* show PKCS#11 debugging */</span><br><span>diff --git a/src/openvpn=
/fragment.h b/src/openvpn/fragment.h</span><br><span>index 3cd0ee7..88f6053=
 100644</span><br><span>--- a/src/openvpn/fragment.h</span><br><span>+++ b/=
src/openvpn/fragment.h</span><br><span>@@ -92,25 +92,28 @@</span><br><span>=
  * List of fragment structures for reassembling multiple incoming packets<=
/span><br><span>  * concurrently.</span><br><span>  */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-struct fragment_list {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int seq_id;                 /**&lt; H=
ighest fragmentation sequence ID of</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                                 *   the packets currently be=
ing</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
               *   reassembled. */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int index;                  /**&lt; Index of the packet be=
ing reassembled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                           *   with the highest fragmentation</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                 * =
  sequence ID into the \c</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                 *   fragment_list.fragments array. */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct fragment_list=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /** Highest fragmentation sequenc=
e ID of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *  the =
packets currently being</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     *  reassembled. */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int seq_id;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /** Index of the packet being reassembled</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     *   with the highest fragmentation</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     *   sequence ID into=
 the \c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *   fra=
gment_list.fragments array. */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int index;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/** Array of reassembly structures, each can contain =
one whole packet.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  The fragmentation s=
equence IDs of the packets being reassembled in</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  this array are linearly increasing. \c</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  fragment_list.fragments[=
fragment_list.index] has an ID of \c</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *  fragment_list.seq_id.  This means that one of these \c f=
ragment_list</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  struc=
tures can at any one time contain at most packets with the</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *  fragmentation sequence IDs in the =
range \c fragment_list.seq_id \c -</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  \c N_FRAG_BUF \c + \c 1 to \c fragment_list.seq_id, inclus=
ive.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /** Array of reassembly struc=
tures, each can contain one whole packet.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     *  The fragmentation sequence IDs of the packets being reasse=
mbled in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *  thi=
s array are linearly increasing. \c</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     *  fragment_list.fragments[fragment_list.index] has an=
 ID of \c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *  fr=
agment_list.seq_id.  This means that one of these \c fragment_list</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     *  structures can at an=
y one time contain at most packets with the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     *  fragmentation sequence IDs in the range \c =
fragment_list.seq_id \c -</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     *  \c N_FRAG_BUF \c + \c 1 to \c fragment_list.seq_id, inclusive=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br>=
<span>     struct fragment fragments[N_FRAG_BUF];</span><br><span> };</span=
><br><span> </span><br><span>@@ -149,9 +152,7 @@</span><br><span>          =
                        *   the remote OpenVPN peer can determine</span><br=
><span>                                  *   which parts belong to which or=
iginal</span><br><span>                                  *   packet. */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MAX_FRAG_PKT_SIZE=
 65536</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; (No=
t used) Maximum packet size before</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-     *   fragmenting. */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define MAX_FRAG_PKT_SIZE 65536 /**&lt; (Not used) Maximu=
m packet size before fragmenting. */</span><br><span>     int outgoing_frag=
_size;     /**&lt; Size in bytes of each part to be</span><br><span>       =
                           *   sent, except for the last part which</span><=
br><span>                                  *   may be smaller.</span><br><s=
pan>@@ -183,45 +184,37 @@</span><br><span> /*******************************=
*******************************************/</span><br><span> /** @name Fra=
gment header</span><br><span>  *  @todo Add description of %fragment header=
 format.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *//** @{ *//=
*************************************/</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/** @{ */ /*************************************/</span><br><span> </spa=
n><br><span> typedef uint32_t fragment_header_type;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**&lt; Fragmentation information is stored=
 in</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   a 32-bit pack=
et header. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**&lt=
; Fragmentation information is stored in a 32-bit packet header. */</span><=
br><span> </span><br><span> #define hton_fragment_header_type(x) htonl(x)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**&lt; Convert a fragm=
ent_header_type from</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*   host to network order. */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**&lt; Convert a fragment_header_type from host to network order=
. */</span><br><span> </span><br><span> #define ntoh_fragment_header_type(x=
) ntohl(x)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**&lt; Con=
vert a \c fragment_header_type</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *   from network to host order. */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**&lt; Convert a \c fragment_header_type from net=
work to host order. */</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define FRAG_TYPE_MASK        0x00000003</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/**&lt; Bit mask for %fragment type i=
nfo. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define FRAG_T=
YPE_SHIFT       0 /**&lt; Bit shift for %fragment type info. */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define FRAG_TYPE_MASK         =
      0x00000003 /**&lt; Bit mask for %fragment type info. */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define FRAG_TYPE_SHIFT          =
    0          /**&lt; Bit shift for %fragment type info. */</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define FRAG_WHOLE=
            0 /**&lt; Fragment type indicating packet is</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                 *   who=
le. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define FRAG_YE=
S_NOTLAST      1 /**&lt; Fragment type indicating packet is</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                 *   =
part of a fragmented packet, but not</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                 *   the last part in the se=
quence. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define FRA=
G_YES_LAST         2 /**&lt; Fragment type indicating packet is</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
*   the last part in the sequence of</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                 *   parts. */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define FRAG_TEST             3 /**=
&lt; Fragment type not implemented yet.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                 *   In the future might =
be used as a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                        *   control packet for establishing MTU</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
*   size. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 FRAG_WHOLE                   0          /**&lt; Fragment type indicating p=
acket is whole. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define FRAG_YES_NOTLAST             1</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**&lt; Fragment type indicating packet is part of a frag=
mented packet, but not</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *   the last part in the sequence. */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define FRAG_YES_LAST                2</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**&lt; Fragment type indicating p=
acket is the last part in the sequence of parts. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define FRAG_TEST                    3</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**&lt; Fragment type =
not implemented yet.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * In the future might be used as a control packet for establishing MTU si=
ze. */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define FRAG_SEQ_ID_MASK      0x000000ff</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/**&lt; Bit mask for %fragment sequence ID. */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define FRAG_SEQ_ID_SHIFT   =
  2 /**&lt; Bit shift for %fragment sequence ID. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define FRAG_SEQ_ID_MASK             0x00=
0000ff /**&lt; Bit mask for %fragment sequence ID. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define FRAG_SEQ_ID_SHIFT            2   =
       /**&lt; Bit shift for %fragment sequence ID. */</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define FRAG_ID_MASK    =
      0x0000001f</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**&l=
t; Bit mask for %fragment ID. */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define FRAG_ID_SHIFT         10</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/**&lt; Bit shift for %fragment ID. */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define FRAG_ID_MASK              =
   0x0000001f /**&lt; Bit mask for %fragment ID. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define FRAG_ID_SHIFT                10  =
       /**&lt; Bit shift for %fragment ID. */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> /*</span><br>=
<span>  * FRAG_SIZE  14 bits</span><br><span>@@ -232,12 +225,10 @@</span><b=
r><span>  *   max_frag_size is only sent over the wire if FRAG_LAST is set.=
  Otherwise it is assumed</span><br><span>  *   to be the actual %fragment =
size received.</span><br><span>  */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define FRAG_SIZE_MASK        0x00003fff</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/**&lt; Bit mask for %fragment size. */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define FRAG_SIZE_SHIFT =
      15</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**&lt; Bit s=
hift for %fragment size. */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define FRAG_SIZE_ROUND_SHIFT 2 /**&lt; Bit shift for %fragment size =
rounding. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define F=
RAG_SIZE_ROUND_MASK ((1 &lt;&lt; FRAG_SIZE_ROUND_SHIFT) - 1)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define FRAG_SIZE_MASK            =
   0x00003fff /**&lt; Bit mask for %fragment size. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define FRAG_SIZE_SHIFT              15  =
       /**&lt; Bit shift for %fragment size. */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define FRAG_SIZE_ROUND_SHIFT        2         =
 /**&lt; Bit shift for %fragment size rounding. */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define FRAG_SIZE_ROUND_MASK         ((1 &lt=
;&lt; FRAG_SIZE_ROUND_SHIFT) - 1)</span><br><span> /**&lt; Bit mask for %fr=
agment size rounding. */</span><br><span> </span><br><span> /*</span><br><s=
pan>@@ -245,10 +236,8 @@</span><br><span>  *</span><br><span>  * IF FRAG_WH=
OLE or FRAG_YES_NOTLAST, these 16 bits are available (not currently used)</=
span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine FRAG_EXTRA_MASK         0x0000ffff</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/**&lt; Bit mask for extra bits. */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define FRAG_EXTRA_SHIFT        15</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/**&lt; Bit shift for extra b=
its. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define FRAG=
_EXTRA_MASK              0x0000ffff /**&lt; Bit mask for extra bits. */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define FRAG_EXTRA_SHIF=
T             15         /**&lt; Bit shift for extra bits. */</span><br><sp=
an> </span><br><span> /** @} name Fragment header *//**********************=
**********************/</span><br><span> </span><br><span>diff --git a/src/=
openvpn/init.c b/src/openvpn/init.c</span><br><span>index 9eb8290..187c0a9 =
100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/o=
penvpn/init.c</span><br><span>@@ -983,7 +983,8 @@</span><br><span> {</span>=
<br><span>     if (!options-&gt;dev &amp;&amp; options-&gt;dev_node)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   char *dev_node =3D string_alloc(options-&gt;dev_node, NULL); /* POSIX ba=
sename() implementations may modify its arguments */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* POSIX basename() implementatio=
ns may modify its arguments */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        char *dev_node =3D string_alloc(options-&gt;dev_node, NU=
LL);</span><br><span>         options-&gt;dev =3D basename(dev_node);</span=
><br><span>     }</span><br><span> }</span><br><span>@@ -2572,12 +2573,14 @=
@</span><br><span>             }</span><br><span>             else</span><b=
r><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                initialization_sequence_completed(c, error_flags); /* clie=
nt/p2p --route-delay undefined */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                /* client/p2p --route-delay undefined */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                initiali=
zation_sequence_completed(c, error_flags);</span><br><span>             }</=
span><br><span>         }</span><br><span>         else if (c-&gt;options.m=
ode =3D=3D MODE_POINT_TO_POINT)</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            initialization_sequence_co=
mpleted(c, error_flags); /* client/p2p restart with --persist-tun */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            /* client/p2p =
restart with --persist-tun */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            initialization_sequence_completed(c, error_flags);</s=
pan><br><span>         }</span><br><span> </span><br><span>         tls_pri=
nt_deferred_options_results(c);</span><br><span>diff --git a/src/openvpn/ma=
nage.c b/src/openvpn/manage.c</span><br><span>index 0e73942..567b6ea 100644=
</span><br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openv=
pn/manage.c</span><br><span>@@ -3447,7 +3447,8 @@</span><br><span>         =
const bool standalone_disabled_save =3D man-&gt;persist.standalone_disabled=
;</span><br><span>         time_t expire =3D 0;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        man-&gt;persist.standal=
one_disabled =3D false; /* This is so M_CLIENT messages will be correctly p=
assed through msg() */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* This is so M_CLIENT messages will be correctly passed through=
 msg() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ma=
n-&gt;persist.standalone_disabled =3D false;</span><br><span> </span><br><s=
pan>         /* set expire time */</span><br><span>         update_time();<=
/span><br><span>@@ -3510,7 +3511,8 @@</span><br><span>         unsigned int=
 up_query_mode =3D 0;</span><br><span>         const char *sc =3D NULL;</sp=
an><br><span>         ret =3D true;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        man-&gt;persist.standalone_disabled =3D false; /* Thi=
s is so M_CLIENT messages will be correctly passed through msg() */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* This is so M_CLI=
ENT messages will be correctly passed through msg() */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        man-&gt;persist.standalone_disab=
led =3D false;</span><br><span>         man-&gt;persist.special_state_msg =
=3D NULL;</span><br><span> </span><br><span>         CLEAR(man-&gt;connecti=
on.up_query);</span><br><span>@@ -3634,7 +3636,8 @@</span><br><span> </span=
><br><span>     if (man_standalone_ok(man))</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        man-&gt;persist.standa=
lone_disabled =3D false; /* This is so M_CLIENT messages will be correctly =
passed through msg() */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* This is so M_CLIENT messages will be correctly passed throug=
h msg() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
an-&gt;persist.standalone_disabled =3D false;</span><br><span>         man-=
&gt;persist.special_state_msg =3D NULL;</span><br><span> </span><br><span> =
        *state =3D EKS_SOLICIT;</span><br><span>diff --git a/src/openvpn/mi=
sc.h b/src/openvpn/misc.h</span><br><span>index 3c46c02..5f55a060 100644</s=
pan><br><span>--- a/src/openvpn/misc.h</span><br><span>+++ b/src/openvpn/mi=
sc.h</span><br><span>@@ -114,12 +114,14 @@</span><br><span> #define GET_USE=
R_PASS_NEED_STR      (1&lt;&lt;5)</span><br><span> #define GET_USER_PASS_PR=
EVIOUS_CREDS_FAILED (1&lt;&lt;6)</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define GET_USER_PASS_DYNAMIC_CHALLENGE      (=
1&lt;&lt;7) /* CRV1 protocol  -- dynamic challenge */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define GET_USER_PASS_STATIC_CHALLENGE     =
  (1&lt;&lt;8) /* SCRV1 protocol -- static challenge */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define GET_USER_PASS_STATIC_CHALLENGE_EC=
HO  (1&lt;&lt;9) /* SCRV1 protocol -- echo response */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define GET_USER_PASS_DYNAMIC_CHALLENGE =
     (1&lt;&lt;7) /**&lt; CRV1 protocol  -- dynamic challenge */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define GET_USER_PASS_STATIC_C=
HALLENGE       (1&lt;&lt;8) /**&lt; SCRV1 protocol -- static challenge */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GET_USER_PASS=
_STATIC_CHALLENGE_ECHO  (1&lt;&lt;9) /**&lt; SCRV1 protocol -- echo respons=
e */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define GET_USER_PASS_INLINE_CREDS (1&lt;&lt;10)  /* indicates that auth_f=
ile is actually inline creds */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define GET_USER_PASS_STATIC_CHALLENGE_CONCAT (1&lt;&lt;11)  /* i=
ndicates password and response should be concatenated */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/** indicates that auth_file is actual=
ly inline creds */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define GET_USER_PASS_INLINE_CREDS (1&lt;&lt;10)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/** indicates password and response should be c=
oncatenated */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne GET_USER_PASS_STATIC_CHALLENGE_CONCAT (1&lt;&lt;11)</span><br><span> </s=
pan><br><span> /**</span><br><span>  * Retrieves the user credentials from =
various sources depending on the flags.</span><br><span>diff --git a/src/op=
envpn/options.c b/src/openvpn/options.c</span><br><span>index 96119c4..8c41=
dec 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ =
b/src/openvpn/options.c</span><br><span>@@ -853,7 +853,8 @@</span><br><span=
>     o-&gt;tuntap_options.ip_win32_type =3D IPW32_SET_DHCP_MASQ;</span><br=
><span> #endif</span><br><span>     o-&gt;tuntap_options.dhcp_lease_time =
=3D 31536000; /* one year */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    o-&gt;tuntap_options.dhcp_masq_offset =3D 0;     /* use network =
address as internal DHCP server address */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* use network address as internal DHCP server a=
ddress */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;=
tuntap_options.dhcp_masq_offset =3D 0;</span><br><span>     o-&gt;route_met=
hod =3D ROUTE_METHOD_ADAPTIVE;</span><br><span>     o-&gt;block_outside_dns=
 =3D false;</span><br><span>     o-&gt;windows_driver =3D WINDOWS_DRIVER_UN=
SPECIFIED;</span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/open=
vpn/ssl_common.h</span><br><span>index 90e16f9..d2c6393 100644</span><br><s=
pan>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_co=
mmon.h</span><br><span>@@ -75,10 +75,10 @@</span><br><span>  *</span><br><s=
pan>  * @{</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define S_ERROR         (-2)     /**&lt; Error state.  */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define S_ERROR_PRE     (-1) =
    /**&lt; Error state but try to send out alerts</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                  *  before ki=
lling the keystore and moving</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                  *  it to S_ERROR */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define S_ERROR         (-2)    /=
**&lt; Error state.  */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define S_ERROR_PRE     (-1)    /**&lt; Error state but try to send out=
 alerts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                     *  before killing the keystore and moving</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
 *  it to S_ERROR */</span><br><span> #define S_UNDEF           0     /**&l=
t; Undefined state, used after a \c</span><br><span>                       =
           *   key_state is cleaned up. */</span><br><span> #define S_INITI=
AL         1     /**&lt; Initial \c key_state state after</span><br><span>@=
@ -567,18 +567,22 @@</span><br><span>  * tls_session reaches S_ACTIVE, this=
 state machine moves to CAS_PENDING (server)</span><br><span>  * or CAS_CON=
NECT_DONE (client/p2p) as clients skip the stages associated with</span><br=
><span>  * connect scripts/plugins */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-enum multi_status {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+enum multi_status</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span>     CAS_NOT_CONNECTED,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    CAS_WAITING_AUTH,               /**&l=
t; Initial TLS connection established but deferred auth is not yet finished=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CAS_PENDING,  =
                  /**&lt; Options import (Connect script/plugin, ccd,...) *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CAS_PENDING_DEFE=
RRED,           /**&lt; Waiting on an async option import handler */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    CAS_PENDING_DEFERRED_PAR=
TIAL,   /**&lt; at least handler succeeded but another is still pending */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CAS_FAILED,       =
              /**&lt; Option import failed or explicitly denied the client =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CAS_WAITING_OPT=
IONS_IMPORT,     /**&lt; client with pull or p2p waiting for first time opt=
ions import */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CAS=
_RECONNECT_PENDING,          /**&lt; session has already successful establi=
shed (CAS_CONNECT_DONE)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                     * but has a reconnect and needs to r=
edo some initialisation, this state is</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                     * similar CAS_WAITING=
_OPTIONS_IMPORT but skips a few things. The normal connection</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                   =
  * skips this step. */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    CAS_WAITING_AUTH, /**&lt; Initial TLS connection established but de=
ferred auth is not yet finished</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                       */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    CAS_PENDING,      /**&lt; Options import (Connect scr=
ipt/plugin, ccd,...) */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    CAS_PENDING_DEFERRED,         /**&lt; Waiting on an async option im=
port handler */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
CAS_PENDING_DEFERRED_PARTIAL, /**&lt; at least handler succeeded but anothe=
r is still pending */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    CAS_FAILED,                   /**&lt; Option import failed or explici=
tly denied the client */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CAS_WAITING_OPTIONS_IMPORT,   /**&lt; client with pull or p2p wait=
ing for first time options import</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                   */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /** session has already successful es=
tablished (CAS_CONNECT_DONE) but has a</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * reconnect and needs to redo some initialisation, =
this state is similar</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * CAS_WAITING_OPTIONS_IMPORT but skips a few things. The normal conn=
ection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * skips =
this step. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CA=
S_RECONNECT_PENDING,</span><br><span>     CAS_CONNECT_DONE,</span><br><span=
> };</span><br><span> </span><br><span>@@ -626,8 +630,9 @@</span><br><span>=
     int n_hard_errors; /* errors due to TLS negotiation failure */</span><=
br><span>     int n_soft_errors; /* errors due to unrecognized or failed-to=
-authenticate incoming packets */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     * Our locked common name, username, and cert hashes (=
cannot change during the life of this tls_multi object)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * Our locked common name, username, and cert h=
ashes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (cannot=
 change during the life of this tls_multi object)</span><br><span>      */<=
/span><br><span>     char *locked_cn;</span><br><span> </span><br><span>@@ =
-642,43 +647,46 @@</span><br><span> </span><br><span>     struct cert_hash_=
set *locked_cert_hash_set;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /** Time of last when we updated the cached stat=
e of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * Time of last when we=
 updated the cached state of</span><br><span>      * tls_authentication_sta=
tus deferred files */</span><br><span>     time_t tas_cache_last_update;</s=
pan><br><span> </span><br><span>     /** The number of times we updated the=
 cache */</span><br><span>     unsigned int tas_cache_num_updates;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-     * An error message to =
send to client on AUTH_FAILED</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/** An error message to send to client on AUTH_FAILED */</span><br><span>  =
   char *client_reason;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /**</span><br><span>      * A multi-line string of general-purpo=
se info received from peer</span><br><span>      * over control channel.</s=
pan><br><span>      */</span><br><span>     char *peer_info;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    char *auth_token;    /**&lt; If =
server sends a generated auth-token,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                          *   this is the token to use for f=
uture</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
          *   user/pass authentications in this session.</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                          */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    char *auth_token_initial;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; The first aut=
h-token we sent to a client. We use this to remember</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * If server sends a generated auth-token,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * this is the token t=
o use for future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * user/pass authentications in this session.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char *auth_token;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * The first auth-token we sent to a client. We use this to rememb=
er</span><br><span>      * the session ID and initial timestamp when genera=
ting new auth-token.</span><br><span>      */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define  AUTH_TOKEN_HMAC_OK              (1&lt;&lt;=
0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; Auth-to=
ken sent from client has valid hmac */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define  AUTH_TOKEN_EXPIRED              (1&lt;&lt;1)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; Auth-token sen=
t from client has expired */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define  AUTH_TOKEN_VALID_EMPTYUSER      (1&lt;&lt;2)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /**&lt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     * Auth-token is only valid for an empty u=
sername</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * and not=
 the username actually supplied from the client</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     * OpenVPN 3 clients sometimes wipes or replaces the usernam=
e with a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * userna=
me hint from their config.</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cha=
r *auth_token_initial;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Auth-token s=
ent from client has valid hmac */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define AUTH_TOKEN_HMAC_OK         (1 &lt;&lt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/** Auth-token sent from client=
 has expired */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine AUTH_TOKEN_EXPIRED         (1 &lt;&lt; 1)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Auth-token is only valid for an empty username</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * and not the username actually su=
pplied from the client</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * OpenVPN 3 c=
lients sometimes wipes or replaces the username with a</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * username hint from their config.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define AUTH_TOKEN_VALID_EMPTYUSER (1 &l=
t;&lt; 2)</span><br><span> </span><br><span>     /* For P_DATA_V2 */</span>=
<br><span>     uint32_t peer_id;</span><br><span>@@ -690,10 +698,10 @@</spa=
n><br><span>     /*</span><br><span>      * Our session objects.</span><br>=
<span>      */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
** Array of \c tls_session objects</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     *  representing control channel</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     *  sessions with the remote peer. */=
</span><br><span>     struct tls_session session[TM_SIZE];</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; Array of \c tls_session ob=
jects</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *   represe=
nting control channel</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     *   sessions with the remote peer. */</span><br><span> </span><br><spa=
n>     /* Only used when DCO is used to remember how many keys we installed=
</span><br><span>      * for this session */</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/792?u=
sp=3Demail">change 792</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/792?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7f0ba2261b61f6eed511cbd8bb2=
e880d774d1365 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 792 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--gxu4xeyvDd0=--

