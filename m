From: Gert Doering <gert@...1296...>
Date: Mon,  5 May 2025 12:54:43 +0200
Message-ID: <20250505105449.18826-1-gert@...1296...>
In-Reply-To: <gerrit.1730392980000.I7f0ba2261b61f6eed511cbd8bb2e880d774d1365@...2715...>
References: <gerrit.1730392980000.I7f0ba2261b61f6eed511cbd8bb2e880d774d1365@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v16] Manually reformat some long trailing
 comments
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

When trying to reformat the code with a formatter
that actually checks line-lengths, these never
come out nice otherwise.

Change-Id: I7f0ba2261b61f6eed511cbd8bb2e880d774d1365
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/792
This mail reflects revision 16 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c
index 291f9e1..3a09eb5 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -31,10 +31,14 @@
 #define PLUGIN_NAME "base64.c"
 
 /* Exported plug-in v3 API functions */
-plugin_log_t ovpn_log = NULL;                      /**< Pointer to the OpenVPN log function.  See plugin_log() */
-plugin_vlog_t ovpn_vlog = NULL;                    /**< Pointer to the OpenVPN vlog function. See plugin_vlog() */
-plugin_base64_encode_t ovpn_base64_encode = NULL;  /**< Pointer to the openvpn_base64_encode () function */
-plugin_base64_decode_t ovpn_base64_decode = NULL;  /**< Pointer to the openvpn_base64_decode () function */
+/** Pointer to the OpenVPN log function.  See plugin_log() */
+plugin_log_t ovpn_log = NULL;
+/** Pointer to the OpenVPN vlog function. See plugin_vlog() */
+plugin_vlog_t ovpn_vlog = NULL;
+/** Pointer to the openvpn_base64_encode () function */
+plugin_base64_encode_t ovpn_base64_encode = NULL;
+/** Pointer to the openvpn_base64_decode () function */
+plugin_base64_decode_t ovpn_base64_decode = NULL;
 
 /**
  * Search the environment pointer for a specific env var name
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 7eed331..f9f9598 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -36,20 +36,27 @@
  #define COMP_F_ADAPTIVE             (1<<0) / * COMP_ALG_LZO only * /
  #define COMP_F_ALLOW_COMPRESS       (1<<1) / * not only incoming is compressed but also outgoing * /
  */
-#define COMP_F_SWAP                 (1<<2) /* initial command byte is swapped with last byte in buffer to preserve payload alignment */
-#define COMP_F_ADVERTISE_STUBS_ONLY (1<<3) /* tell server that we only support compression stubs */
-#define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
-                                            * we still accept other compressions to be pushed */
-#define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
-#define COMP_F_ALLOW_ASYM           (1<<6) /* Compression was explicitly set to allow asymetric compression */
-#define COMP_F_ALLOW_NOCOMP_ONLY    (1<<7) /* Do not allow compression framing (breaks DCO) */
+/** initial command byte is swapped with last byte in buffer to preserve payload alignment */
+#define COMP_F_SWAP                 (1<<2)
+/** tell server that we only support compression stubs */
+#define COMP_F_ADVERTISE_STUBS_ONLY (1<<3)
+/** Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
+ * we still accept other compressions to be pushed */
+#define COMP_F_ALLOW_STUB_ONLY      (1<<4)
+/** push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
+#define COMP_F_MIGRATE              (1<<5)
+/** Compression was explicitly set to allow asymetric compression */
+#define COMP_F_ALLOW_ASYM           (1<<6)
+/** Do not allow compression framing (breaks DCO) */
+#define COMP_F_ALLOW_NOCOMP_ONLY    (1<<7)
 
 /* algorithms */
 #define COMP_ALG_UNDEF  0
-#define COMP_ALG_STUB   1 /* support compression command byte and framing without actual compression */
-#define COMP_ALG_LZO    2 /* LZO algorithm */
-#define COMP_ALG_SNAPPY 3 /* Snappy algorithm (no longer supported) */
-#define COMP_ALG_LZ4    4 /* LZ4 algorithm */
+/** support compression command byte and framing without actual compression */
+#define COMP_ALG_STUB   1
+#define COMP_ALG_LZO    2 /**< LZO algorithm */
+#define COMP_ALG_SNAPPY 3 /**< Snappy algorithm (no longer supported) */
+#define COMP_ALG_LZ4    4 /**< LZ4 algorithm */
 
 
 /* algorithm v2 */
@@ -106,7 +113,8 @@
 #define LZO_COMPRESS_BYTE 0x66
 #define LZ4_COMPRESS_BYTE 0x69
 #define NO_COMPRESS_BYTE      0xFA
-#define NO_COMPRESS_BYTE_SWAP 0xFB /* to maintain payload alignment, replace this byte with last byte of packet */
+/** to maintain payload alignment, replace this byte with last byte of packet */
+#define NO_COMPRESS_BYTE_SWAP 0xFB
 
 /* V2 on wire code */
 #define COMP_ALGV2_INDICATOR_BYTE       0x50
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index bf2e54e..1f54ed8 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -143,7 +143,7 @@
 #define D_PACKET_TRUNC_DEBUG LOGLEV(7, 70, M_DEBUG)  /* PACKET_TRUNCATION_CHECK verbose */
 #define D_PING               LOGLEV(7, 70, M_DEBUG)  /* PING send/receive messages */
 #define D_PS_PROXY_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* port share proxy debug */
-#define D_TLS_KEYSELECT      LOGLEV(7, 70, M_DEBUG)  /* show information on key selection for data channel */
+#define D_TLS_KEYSELECT      LOGLEV(7, 70, M_DEBUG)  /* show key selection for data channel */
 #define D_ARGV_PARSE_CMD     LOGLEV(7, 70, M_DEBUG)  /* show parse_line() errors in argv_parse_cmd */
 #define D_CRYPTO_DEBUG       LOGLEV(7, 70, M_DEBUG)  /* show detailed info from crypto.c routines */
 #define D_PID_DEBUG          LOGLEV(7, 70, M_DEBUG)  /* show packet-id debugging info */
@@ -153,7 +153,7 @@
 
 #define D_VLAN_DEBUG         LOGLEV(7, 74, M_DEBUG)  /* show VLAN tagging/untagging debug info */
 
-#define D_HANDSHAKE_VERBOSE  LOGLEV(8, 70, M_DEBUG)  /* show detailed description of each handshake */
+#define D_HANDSHAKE_VERBOSE  LOGLEV(8, 70, M_DEBUG)  /* show detailed description of handshake */
 #define D_TLS_DEBUG_MED      LOGLEV(8, 70, M_DEBUG)  /* limited info from tls_session routines */
 #define D_INTERVAL           LOGLEV(8, 70, M_DEBUG)  /* show interval.h debugging info */
 #define D_SCHEDULER          LOGLEV(8, 70, M_DEBUG)  /* show scheduler debugging info */
@@ -168,7 +168,7 @@
 #define D_PACKET_CONTENT     LOGLEV(9, 70, M_DEBUG)  /* show before/after encryption packet content */
 #define D_TLS_NO_SEND_KEY    LOGLEV(9, 70, M_DEBUG)  /* show when no data channel send-key exists */
 #define D_PID_PERSIST_DEBUG  LOGLEV(9, 70, M_DEBUG)  /* show packet-id persist debugging info */
-#define D_LINK_RW_VERBOSE    LOGLEV(9, 70, M_DEBUG)  /* show link reads/writes with greater verbosity */
+#define D_LINK_RW_VERBOSE    LOGLEV(9, 70, M_DEBUG)  /* increase link reads/writes verbosity */
 #define D_STREAM_DEBUG       LOGLEV(9, 70, M_DEBUG)  /* show TCP stream debug info */
 #define D_WIN32_IO           LOGLEV(9, 70, M_DEBUG)  /* win32 I/O debugging info */
 #define D_PKCS11_DEBUG       LOGLEV(9, 70, M_DEBUG)  /* show PKCS#11 debugging */
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
+     *  fragment_list.seq_id.  This means that one of these \c fragment_list
+     *  structures can at any one time contain at most packets with the
+     *  fragmentation sequence IDs in the range \c fragment_list.seq_id \c -
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
+#define MAX_FRAG_PKT_SIZE 65536 /**< (Not used) Maximum packet size before fragmenting. */
     int outgoing_frag_size;     /**< Size in bytes of each part to be
                                  *   sent, except for the last part which
                                  *   may be smaller.
@@ -183,45 +184,37 @@
 /**************************************************************************/
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
+#define FRAG_TYPE_MASK               0x00000003 /**< Bit mask for %fragment type info. */
+#define FRAG_TYPE_SHIFT              0          /**< Bit shift for %fragment type info. */
 
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
+#define FRAG_WHOLE                   0          /**< Fragment type indicating packet is whole. */
+#define FRAG_YES_NOTLAST             1
+/**< Fragment type indicating packet is part of a fragmented packet, but not
+ *   the last part in the sequence. */
+#define FRAG_YES_LAST                2
+/**< Fragment type indicating packet is the last part in the sequence of parts. */
+#define FRAG_TEST                    3
+/**< Fragment type not implemented yet.
+ * In the future might be used as a control packet for establishing MTU size. */
 
-#define FRAG_SEQ_ID_MASK      0x000000ff
-/**< Bit mask for %fragment sequence ID. */
-#define FRAG_SEQ_ID_SHIFT     2 /**< Bit shift for %fragment sequence ID. */
+#define FRAG_SEQ_ID_MASK             0x000000ff /**< Bit mask for %fragment sequence ID. */
+#define FRAG_SEQ_ID_SHIFT            2          /**< Bit shift for %fragment sequence ID. */
 
-#define FRAG_ID_MASK          0x0000001f
-/**< Bit mask for %fragment ID. */
-#define FRAG_ID_SHIFT         10
-/**< Bit shift for %fragment ID. */
+#define FRAG_ID_MASK                 0x0000001f /**< Bit mask for %fragment ID. */
+#define FRAG_ID_SHIFT                10         /**< Bit shift for %fragment ID. */
+
 
 /*
  * FRAG_SIZE  14 bits
@@ -232,12 +225,10 @@
  *   max_frag_size is only sent over the wire if FRAG_LAST is set.  Otherwise it is assumed
  *   to be the actual %fragment size received.
  */
-#define FRAG_SIZE_MASK        0x00003fff
-/**< Bit mask for %fragment size. */
-#define FRAG_SIZE_SHIFT       15
-/**< Bit shift for %fragment size. */
-#define FRAG_SIZE_ROUND_SHIFT 2 /**< Bit shift for %fragment size rounding. */
-#define FRAG_SIZE_ROUND_MASK ((1 << FRAG_SIZE_ROUND_SHIFT) - 1)
+#define FRAG_SIZE_MASK               0x00003fff /**< Bit mask for %fragment size. */
+#define FRAG_SIZE_SHIFT              15         /**< Bit shift for %fragment size. */
+#define FRAG_SIZE_ROUND_SHIFT        2          /**< Bit shift for %fragment size rounding. */
+#define FRAG_SIZE_ROUND_MASK         ((1 << FRAG_SIZE_ROUND_SHIFT) - 1)
 /**< Bit mask for %fragment size rounding. */
 
 /*
@@ -245,10 +236,8 @@
  *
  * IF FRAG_WHOLE or FRAG_YES_NOTLAST, these 16 bits are available (not currently used)
  */
-#define FRAG_EXTRA_MASK         0x0000ffff
-/**< Bit mask for extra bits. */
-#define FRAG_EXTRA_SHIFT        15
-/**< Bit shift for extra bits. */
+#define FRAG_EXTRA_MASK              0x0000ffff /**< Bit mask for extra bits. */
+#define FRAG_EXTRA_SHIFT             15         /**< Bit shift for extra bits. */
 
 /** @} name Fragment header *//********************************************/
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9eb8290..187c0a9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -983,7 +983,8 @@
 {
     if (!options->dev && options->dev_node)
     {
-        char *dev_node = string_alloc(options->dev_node, NULL); /* POSIX basename() implementations may modify its arguments */
+        /* POSIX basename() implementations may modify its arguments */
+        char *dev_node = string_alloc(options->dev_node, NULL);
         options->dev = basename(dev_node);
     }
 }
@@ -2572,12 +2573,14 @@
             }
             else
             {
-                initialization_sequence_completed(c, error_flags); /* client/p2p --route-delay undefined */
+                /* client/p2p --route-delay undefined */
+                initialization_sequence_completed(c, error_flags);
             }
         }
         else if (c->options.mode == MODE_POINT_TO_POINT)
         {
-            initialization_sequence_completed(c, error_flags); /* client/p2p restart with --persist-tun */
+            /* client/p2p restart with --persist-tun */
+            initialization_sequence_completed(c, error_flags);
         }
 
         tls_print_deferred_options_results(c);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0e73942..567b6ea 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3447,7 +3447,8 @@
         const bool standalone_disabled_save = man->persist.standalone_disabled;
         time_t expire = 0;
 
-        man->persist.standalone_disabled = false; /* This is so M_CLIENT messages will be correctly passed through msg() */
+        /* This is so M_CLIENT messages will be correctly passed through msg() */
+        man->persist.standalone_disabled = false;
 
         /* set expire time */
         update_time();
@@ -3510,7 +3511,8 @@
         unsigned int up_query_mode = 0;
         const char *sc = NULL;
         ret = true;
-        man->persist.standalone_disabled = false; /* This is so M_CLIENT messages will be correctly passed through msg() */
+        /* This is so M_CLIENT messages will be correctly passed through msg() */
+        man->persist.standalone_disabled = false;
         man->persist.special_state_msg = NULL;
 
         CLEAR(man->connection.up_query);
@@ -3634,7 +3636,8 @@
 
     if (man_standalone_ok(man))
     {
-        man->persist.standalone_disabled = false; /* This is so M_CLIENT messages will be correctly passed through msg() */
+        /* This is so M_CLIENT messages will be correctly passed through msg() */
+        man->persist.standalone_disabled = false;
         man->persist.special_state_msg = NULL;
 
         *state = EKS_SOLICIT;
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 3c46c02..5f55a060 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -114,12 +114,14 @@
 #define GET_USER_PASS_NEED_STR      (1<<5)
 #define GET_USER_PASS_PREVIOUS_CREDS_FAILED (1<<6)
 
-#define GET_USER_PASS_DYNAMIC_CHALLENGE      (1<<7) /* CRV1 protocol  -- dynamic challenge */
-#define GET_USER_PASS_STATIC_CHALLENGE       (1<<8) /* SCRV1 protocol -- static challenge */
-#define GET_USER_PASS_STATIC_CHALLENGE_ECHO  (1<<9) /* SCRV1 protocol -- echo response */
+#define GET_USER_PASS_DYNAMIC_CHALLENGE      (1<<7) /**< CRV1 protocol  -- dynamic challenge */
+#define GET_USER_PASS_STATIC_CHALLENGE       (1<<8) /**< SCRV1 protocol -- static challenge */
+#define GET_USER_PASS_STATIC_CHALLENGE_ECHO  (1<<9) /**< SCRV1 protocol -- echo response */
 
-#define GET_USER_PASS_INLINE_CREDS (1<<10)  /* indicates that auth_file is actually inline creds */
-#define GET_USER_PASS_STATIC_CHALLENGE_CONCAT (1<<11)  /* indicates password and response should be concatenated */
+/** indicates that auth_file is actually inline creds */
+#define GET_USER_PASS_INLINE_CREDS (1<<10)
+/** indicates password and response should be concatenated */
+#define GET_USER_PASS_STATIC_CHALLENGE_CONCAT (1<<11)
 
 /**
  * Retrieves the user credentials from various sources depending on the flags.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 96119c4..8c41dec 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -853,7 +853,8 @@
     o->tuntap_options.ip_win32_type = IPW32_SET_DHCP_MASQ;
 #endif
     o->tuntap_options.dhcp_lease_time = 31536000; /* one year */
-    o->tuntap_options.dhcp_masq_offset = 0;     /* use network address as internal DHCP server address */
+    /* use network address as internal DHCP server address */
+    o->tuntap_options.dhcp_masq_offset = 0;
     o->route_method = ROUTE_METHOD_ADAPTIVE;
     o->block_outside_dns = false;
     o->windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 90e16f9..d2c6393 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -75,10 +75,10 @@
  *
  * @{
  */
-#define S_ERROR         (-2)     /**< Error state.  */
-#define S_ERROR_PRE     (-1)     /**< Error state but try to send out alerts
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
  * tls_session reaches S_ACTIVE, this state machine moves to CAS_PENDING (server)
  * or CAS_CONNECT_DONE (client/p2p) as clients skip the stages associated with
  * connect scripts/plugins */
-enum multi_status {
+enum multi_status
+{
     CAS_NOT_CONNECTED,
-    CAS_WAITING_AUTH,               /**< Initial TLS connection established but deferred auth is not yet finished */
-    CAS_PENDING,                    /**< Options import (Connect script/plugin, ccd,...) */
-    CAS_PENDING_DEFERRED,           /**< Waiting on an async option import handler */
-    CAS_PENDING_DEFERRED_PARTIAL,   /**< at least handler succeeded but another is still pending */
-    CAS_FAILED,                     /**< Option import failed or explicitly denied the client */
-    CAS_WAITING_OPTIONS_IMPORT,     /**< client with pull or p2p waiting for first time options import */
-    CAS_RECONNECT_PENDING,          /**< session has already successful established (CAS_CONNECT_DONE)
-                                     * but has a reconnect and needs to redo some initialisation, this state is
-                                     * similar CAS_WAITING_OPTIONS_IMPORT but skips a few things. The normal connection
-                                     * skips this step. */
+    CAS_WAITING_AUTH, /**< Initial TLS connection established but deferred auth is not yet finished
+                       */
+    CAS_PENDING,      /**< Options import (Connect script/plugin, ccd,...) */
+    CAS_PENDING_DEFERRED,         /**< Waiting on an async option import handler */
+    CAS_PENDING_DEFERRED_PARTIAL, /**< at least handler succeeded but another is still pending */
+    CAS_FAILED,                   /**< Option import failed or explicitly denied the client */
+    CAS_WAITING_OPTIONS_IMPORT,   /**< client with pull or p2p waiting for first time options import
+                                   */
+    /** session has already successful established (CAS_CONNECT_DONE) but has a
+     * reconnect and needs to redo some initialisation, this state is similar
+     * CAS_WAITING_OPTIONS_IMPORT but skips a few things. The normal connection
+     * skips this step. */
+    CAS_RECONNECT_PENDING,
     CAS_CONNECT_DONE,
 };
 
@@ -626,8 +630,9 @@
     int n_hard_errors; /* errors due to TLS negotiation failure */
     int n_soft_errors; /* errors due to unrecognized or failed-to-authenticate incoming packets */
 
-    /*
-     * Our locked common name, username, and cert hashes (cannot change during the life of this tls_multi object)
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

