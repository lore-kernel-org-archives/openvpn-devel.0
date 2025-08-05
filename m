From: Gert Doering <gert@...1296...>
Date: Tue,  5 Aug 2025 15:27:01 +0200
Message-ID: <20250805132706.27619-1-gert@...1296...>
In-Reply-To: <gerrit.1754322460000.Ibd900adfc775b7f785f1d5630184a124f5d8ff4b@...2715...>
References: <gerrit.1754322460000.Ibd900adfc775b7f785f1d5630184a124f5d8ff4b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] clang-format: Switch to ColumnLimit 0
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
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1129
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
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
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
index 7e3b5a9..eaa07d2 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -128,9 +128,8 @@
     /* Check API compatibility -- struct version 5 or higher needed */
     if (v3structver < 5)
     {
-        fprintf(
-            stderr,
-            "sample-client-connect: this plugin is incompatible with the running version of OpenVPN\n");
+        fprintf(stderr,
+                "sample-client-connect: this plugin is incompatible with the running version of OpenVPN\n");
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }
 
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index cef22cf..1b43947 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -80,8 +80,7 @@
     /* Check that we are API compatible */
     if (v3structver != OPENVPN_PLUGINv3_STRUCTVER)
     {
-        printf(
-            "log_v3: ** ERROR ** Incompatible plug-in interface between this plug-in and OpenVPN\n");
+        printf("log_v3: ** ERROR ** Incompatible plug-in interface between this plug-in and OpenVPN\n");
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }
 
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c
index 8a1dedd..8ca0888 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -104,8 +104,7 @@
     /* Check that we are API compatible */
     if (v3structver != OPENVPN_PLUGINv3_STRUCTVER)
     {
-        printf(
-            "base64.c: ** ERROR ** Incompatible plug-in interface between this plug-in and OpenVPN\n");
+        printf("base64.c: ** ERROR ** Incompatible plug-in interface between this plug-in and OpenVPN\n");
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }
 
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index cfea3eb..4fb6393 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1046,11 +1046,16 @@
  * this translation table for forward lookup, only for returning the name
  * with md_kt_name() */
 const cipher_name_pair digest_name_translation_table[] = {
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
 const size_t digest_name_translation_table_count =
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 2d33d55..f1ae8c5 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -49,73 +49,73 @@
  * of output.
  */
 
-#define M_VERB0 LOGLEV(0, 0, 0) /* Messages displayed even at --verb 0 (fatal errors only) */
+#define M_VERB0 LOGLEV(0, 0, 0)                     /* Messages displayed even at --verb 0 (fatal errors only) */
 
-#define M_INFO LOGLEV(1, 0, 0)  /* default informational messages */
+#define M_INFO LOGLEV(1, 0, 0)                      /* default informational messages */
 
-#define D_LINK_ERRORS    LOGLEV(1, 1, M_NONFATAL)  /* show link errors from main event loop */
-#define D_CRYPT_ERRORS   LOGLEV(1, 2, M_NONFATAL)  /* show errors from encrypt/decrypt */
-#define D_TLS_ERRORS     LOGLEV(1, 3, M_NONFATAL)  /* show TLS control channel errors */
-#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL)  /* show hostname resolve errors */
-#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)  /* show compression errors */
-#define D_REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)  /* show packet replay errors */
-#define D_STREAM_ERRORS  LOGLEV(1, 7, M_NONFATAL)  /* TCP stream error requiring restart */
-#define D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)  /* show server import option errors */
-#define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)  /* show multi-client server errors */
-#define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL) /* show event.[ch] errors */
-#define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL) /* show push/pull errors */
-#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL) /* show packet_id persist errors */
-#define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL) /* show fragmentation errors */
-#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL) /* show bad struct alignments */
+#define D_LINK_ERRORS    LOGLEV(1, 1, M_NONFATAL)   /* show link errors from main event loop */
+#define D_CRYPT_ERRORS   LOGLEV(1, 2, M_NONFATAL)   /* show errors from encrypt/decrypt */
+#define D_TLS_ERRORS     LOGLEV(1, 3, M_NONFATAL)   /* show TLS control channel errors */
+#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL)   /* show hostname resolve errors */
+#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)   /* show compression errors */
+#define D_REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)   /* show packet replay errors */
+#define D_STREAM_ERRORS  LOGLEV(1, 7, M_NONFATAL)   /* TCP stream error requiring restart */
+#define D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)   /* show server import option errors */
+#define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)   /* show multi-client server errors */
+#define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL)  /* show event.[ch] errors */
+#define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL)  /* show push/pull errors */
+#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL)  /* show packet_id persist errors */
+#define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL)  /* show fragmentation errors */
+#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  /* show bad struct alignments */
 
-#define D_HANDSHAKE LOGLEV(2, 20, 0)               /* show data & control channel handshakes */
-#define D_CLOSE     LOGLEV(2, 22, 0)               /* show socket and TUN/TAP close */
-#define D_PROXY     LOGLEV(2, 24, 0)               /* show http proxy control packets */
-#define D_ARGV      LOGLEV(2, 25, 0)               /* show struct argv errors */
+#define D_HANDSHAKE LOGLEV(2, 20, 0)                /* show data & control channel handshakes */
+#define D_CLOSE     LOGLEV(2, 22, 0)                /* show socket and TUN/TAP close */
+#define D_PROXY     LOGLEV(2, 24, 0)                /* show http proxy control packets */
+#define D_ARGV      LOGLEV(2, 25, 0)                /* show struct argv errors */
 
-#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)       /* low frequency info from tls_session routines */
-#define D_GREMLIN       LOGLEV(3, 30, 0)       /* show simulated outage info from gremlin module */
-#define D_GENKEY        LOGLEV(3, 31, 0)       /* print message after key generation */
-#define D_ROUTE         LOGLEV(3, 0, 0)        /* show routes added and deleted (don't mute) */
-#define D_TUNTAP_INFO   LOGLEV(3, 32, 0)       /* show debugging info from TUN/TAP driver */
-#define D_RESTART       LOGLEV(3, 33, 0)       /* show certain restart messages */
-#define D_PUSH          LOGLEV(3, 34, 0)       /* show push/pull info */
-#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)       /* show ifconfig pool info */
-#define D_AUTH          LOGLEV(3, 37, 0)       /* show user/pass auth info */
-#define D_MULTI_LOW     LOGLEV(3, 38, 0)       /* show point-to-multipoint low-freq debug info */
-#define D_PLUGIN        LOGLEV(3, 39, 0)       /* show plugin calls */
-#define D_MANAGEMENT    LOGLEV(3, 40, 0)       /* show --management info */
-#define D_SCHED_EXIT    LOGLEV(3, 41, 0)       /* show arming of scheduled exit */
-#define D_ROUTE_QUOTA   LOGLEV(3, 42, 0)       /* show route quota exceeded messages */
-#define D_OSBUF         LOGLEV(3, 43, 0)       /* show socket/tun/tap buffer sizes */
-#define D_PS_PROXY      LOGLEV(3, 44, 0)       /* messages related to --port-share option */
-#define D_IFCONFIG      LOGLEV(3, 0, 0)        /* show ifconfig info (don't mute) */
-#define D_DCO           LOGLEV(3, 0, 0)        /* show DCO related messages */
+#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)            /* low frequency info from tls_session routines */
+#define D_GREMLIN       LOGLEV(3, 30, 0)            /* show simulated outage info from gremlin module */
+#define D_GENKEY        LOGLEV(3, 31, 0)            /* print message after key generation */
+#define D_ROUTE         LOGLEV(3, 0, 0)             /* show routes added and deleted (don't mute) */
+#define D_TUNTAP_INFO   LOGLEV(3, 32, 0)            /* show debugging info from TUN/TAP driver */
+#define D_RESTART       LOGLEV(3, 33, 0)            /* show certain restart messages */
+#define D_PUSH          LOGLEV(3, 34, 0)            /* show push/pull info */
+#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)            /* show ifconfig pool info */
+#define D_AUTH          LOGLEV(3, 37, 0)            /* show user/pass auth info */
+#define D_MULTI_LOW     LOGLEV(3, 38, 0)            /* show point-to-multipoint low-freq debug info */
+#define D_PLUGIN        LOGLEV(3, 39, 0)            /* show plugin calls */
+#define D_MANAGEMENT    LOGLEV(3, 40, 0)            /* show --management info */
+#define D_SCHED_EXIT    LOGLEV(3, 41, 0)            /* show arming of scheduled exit */
+#define D_ROUTE_QUOTA   LOGLEV(3, 42, 0)            /* show route quota exceeded messages */
+#define D_OSBUF         LOGLEV(3, 43, 0)            /* show socket/tun/tap buffer sizes */
+#define D_PS_PROXY      LOGLEV(3, 44, 0)            /* messages related to --port-share option */
+#define D_IFCONFIG      LOGLEV(3, 0, 0)             /* show ifconfig info (don't mute) */
+#define D_DCO           LOGLEV(3, 0, 0)             /* show DCO related messages */
 
-#define D_SHOW_PARMS       LOGLEV(4, 50, 0)    /* show all parameters on program initiation */
-#define D_LOW              LOGLEV(4, 52, 0)    /* miscellaneous low-frequency debug info */
-#define D_DHCP_OPT         LOGLEV(4, 53, 0)    /* show DHCP options binary string */
-#define D_MBUF             LOGLEV(4, 54, 0)    /* mbuf.[ch] routines */
-#define D_PACKET_TRUNC_ERR LOGLEV(4, 55, 0)    /* PACKET_TRUNCATION_CHECK */
-#define D_MULTI_DROPPED    LOGLEV(4, 57, 0)    /* show point-to-multipoint packet drops */
-#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)    /* show medium frequency multi messages */
-#define D_X509_ATTR        LOGLEV(4, 59, 0)    /* show x509-track attributes on connection */
-#define D_INIT_MEDIUM      LOGLEV(4, 60, 0)    /* show medium frequency init messages */
-#define D_MTU_INFO         LOGLEV(4, 61, 0)    /* show terse MTU info */
-#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)    /* show low-freq packet-id debugging info */
-#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0)    /* show medium-freq packet-id debugging info */
-#define D_CIPHER_INIT      LOGLEV(4, 65, 0)    /* show messages about cipher init */
+#define D_SHOW_PARMS       LOGLEV(4, 50, 0)         /* show all parameters on program initiation */
+#define D_LOW              LOGLEV(4, 52, 0)         /* miscellaneous low-frequency debug info */
+#define D_DHCP_OPT         LOGLEV(4, 53, 0)         /* show DHCP options binary string */
+#define D_MBUF             LOGLEV(4, 54, 0)         /* mbuf.[ch] routines */
+#define D_PACKET_TRUNC_ERR LOGLEV(4, 55, 0)         /* PACKET_TRUNCATION_CHECK */
+#define D_MULTI_DROPPED    LOGLEV(4, 57, 0)         /* show point-to-multipoint packet drops */
+#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)         /* show medium frequency multi messages */
+#define D_X509_ATTR        LOGLEV(4, 59, 0)         /* show x509-track attributes on connection */
+#define D_INIT_MEDIUM      LOGLEV(4, 60, 0)         /* show medium frequency init messages */
+#define D_MTU_INFO         LOGLEV(4, 61, 0)         /* show terse MTU info */
+#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)         /* show low-freq packet-id debugging info */
+#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0)         /* show medium-freq packet-id debugging info */
+#define D_CIPHER_INIT      LOGLEV(4, 65, 0)         /* show messages about cipher init */
 
-#define D_LOG_RW LOGLEV(5, 0, 0)               /* Print 'R' or 'W' to stdout for read/write */
+#define D_LOG_RW LOGLEV(5, 0, 0)                    /* Print 'R' or 'W' to stdout for read/write */
 
-#define D_RTNL          LOGLEV(6, 68, M_DEBUG) /* show RTNL low level operations */
-#define D_LINK_RW       LOGLEV(6, 69, M_DEBUG) /* show TCP/UDP reads/writes (terse) */
-#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG) /* show TUN/TAP reads/writes */
-#define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG) /* show TAP-Windows driver debug info */
-#define D_CLIENT_NAT    LOGLEV(6, 69, M_DEBUG) /* show client NAT debug info */
-#define D_XKEY          LOGLEV(6, 69, M_DEBUG) /* show xkey-provider debug info */
-#define D_DCO_DEBUG     LOGLEV(6, 69, M_DEBUG) /* show DCO related lowlevel debug messages */
-#define D_SIGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG) /* show signal related debug messages */
+#define D_RTNL          LOGLEV(6, 68, M_DEBUG)      /* show RTNL low level operations */
+#define D_LINK_RW       LOGLEV(6, 69, M_DEBUG)      /* show TCP/UDP reads/writes (terse) */
+#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG)      /* show TUN/TAP reads/writes */
+#define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)      /* show TAP-Windows driver debug info */
+#define D_CLIENT_NAT    LOGLEV(6, 69, M_DEBUG)      /* show client NAT debug info */
+#define D_XKEY          LOGLEV(6, 69, M_DEBUG)      /* show xkey-provider debug info */
+#define D_DCO_DEBUG     LOGLEV(6, 69, M_DEBUG)      /* show DCO related lowlevel debug messages */
+#define D_SIGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG)      /* show signal related debug messages */
 
 #define D_SHOW_KEYS          LOGLEV(7, 70, M_DEBUG) /* show data channel encryption keys */
 #define D_SHOW_KEY_SOURCE    LOGLEV(7, 70, M_DEBUG) /* show data channel key source entropy */
@@ -150,32 +150,32 @@
 #define D_SHOW_OCC           LOGLEV(7, 74, M_DEBUG) /* show options compatibility string */
 
 
-#define D_VLAN_DEBUG LOGLEV(7, 74, M_DEBUG)        /* show VLAN tagging/untagging debug info */
+#define D_VLAN_DEBUG LOGLEV(7, 74, M_DEBUG)             /* show VLAN tagging/untagging debug info */
 
-#define D_HANDSHAKE_VERBOSE LOGLEV(8, 70, M_DEBUG) /* show detailed description of handshake */
-#define D_TLS_DEBUG_MED     LOGLEV(8, 70, M_DEBUG) /* limited info from tls_session routines */
-#define D_INTERVAL          LOGLEV(8, 70, M_DEBUG) /* show interval.h debugging info */
-#define D_SCHEDULER         LOGLEV(8, 70, M_DEBUG) /* show scheduler debugging info */
-#define D_GREMLIN_VERBOSE   LOGLEV(8, 70, M_DEBUG) /* show verbose info from gremlin module */
-#define D_REL_DEBUG         LOGLEV(8, 70, M_DEBUG) /* show detailed info from reliable routines */
-#define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG) /* show detailed info from event waits */
-#define D_MULTI_TCP         LOGLEV(8, 70, M_DEBUG) /* show debug info from mtcp.c */
+#define D_HANDSHAKE_VERBOSE LOGLEV(8, 70, M_DEBUG)      /* show detailed description of handshake */
+#define D_TLS_DEBUG_MED     LOGLEV(8, 70, M_DEBUG)      /* limited info from tls_session routines */
+#define D_INTERVAL          LOGLEV(8, 70, M_DEBUG)      /* show interval.h debugging info */
+#define D_SCHEDULER         LOGLEV(8, 70, M_DEBUG)      /* show scheduler debugging info */
+#define D_GREMLIN_VERBOSE   LOGLEV(8, 70, M_DEBUG)      /* show verbose info from gremlin module */
+#define D_REL_DEBUG         LOGLEV(8, 70, M_DEBUG)      /* show detailed info from reliable routines */
+#define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG)      /* show detailed info from event waits */
+#define D_MULTI_TCP         LOGLEV(8, 70, M_DEBUG)      /* show debug info from mtcp.c */
 
-#define D_TLS_DEBUG         LOGLEV(9, 70, M_DEBUG) /* show detailed info from TLS routines */
-#define D_COMP              LOGLEV(9, 70, M_DEBUG) /* show compression info */
-#define D_READ_WRITE        LOGLEV(9, 70, M_DEBUG) /* show all tun/tcp/udp reads/writes/opens */
-#define D_PACKET_CONTENT    LOGLEV(9, 70, M_DEBUG) /* show before/after encryption packet content */
-#define D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG) /* show when no data channel send-key exists */
-#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG) /* show packet-id persist debugging info */
-#define D_LINK_RW_VERBOSE   LOGLEV(9, 70, M_DEBUG) /* increase link reads/writes verbosity */
-#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG) /* show TCP stream debug info */
-#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG) /* win32 I/O debugging info */
-#define D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEBUG) /* show PKCS#11 debugging */
+#define D_TLS_DEBUG         LOGLEV(9, 70, M_DEBUG)      /* show detailed info from TLS routines */
+#define D_COMP              LOGLEV(9, 70, M_DEBUG)      /* show compression info */
+#define D_READ_WRITE        LOGLEV(9, 70, M_DEBUG)      /* show all tun/tcp/udp reads/writes/opens */
+#define D_PACKET_CONTENT    LOGLEV(9, 70, M_DEBUG)      /* show before/after encryption packet content */
+#define D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG)      /* show when no data channel send-key exists */
+#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG)      /* show packet-id persist debugging info */
+#define D_LINK_RW_VERBOSE   LOGLEV(9, 70, M_DEBUG)      /* increase link reads/writes verbosity */
+#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show TCP stream debug info */
+#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG)      /* win32 I/O debugging info */
+#define D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show PKCS#11 debugging */
 
-#define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)     /* show traffic shaper info */
+#define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)          /* show traffic shaper info */
 
-#define D_REGISTRY     LOGLEV(11, 70, M_DEBUG)     /* win32 registry debugging info */
-#define D_OPENSSL_LOCK LOGLEV(11, 70, M_DEBUG)     /* show OpenSSL locks */
+#define D_REGISTRY     LOGLEV(11, 70, M_DEBUG)          /* win32 registry debugging info */
+#define D_OPENSSL_LOCK LOGLEV(11, 70, M_DEBUG)          /* show OpenSSL locks */
 
 /*#define D_THREAD_DEBUG       LOGLEV(4, 70, M_DEBUG)*/ /* show pthread debug information */
 
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index dacfa8f..1b98235 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -175,7 +175,7 @@
     {
         openvpn_exit(OPENVPN_EXIT_STATUS_CANNOT_OPEN_DEBUG_FILE); /* exit point */
     }
-#else /* ifdef OPENVPN_DEBUG_COMMAND_LINE */
+#else
     msgfp = NULL;
 #endif
 }
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index c9d3389..a419e32 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -266,7 +266,7 @@
         return IP_PMTUDISC_DONT;
     }
     msg(M_FATAL, "invalid --mtu-disc type: '%s' -- valid types are 'yes', 'maybe', or 'no'", name);
-#else /* if defined(IP_PMTUDISC_DONT) && defined(IP_PMTUDISC_WANT) && defined(IP_PMTUDISC_DO) */
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
-                "HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,Post-decrypt Trunc");
+            status_printf(so, "HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,Post-decrypt Trunc");
             hash_iterator_init(m->hash, &hi);
             while ((he = hash_iterator_next(&hi)))
             {
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index dc5c93f..c2a93e8 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -208,7 +208,7 @@
     uint8_t ntlmv2_hmacmd5[16];
     uint8_t *ntlmv2_blob = ntlmv2_response + 16; /* inside ntlmv2_response, length: 128 */
     int ntlmv2_blob_size = 0;
-    int phase3_bufpos = 0x40; /* offset to next security buffer data to be added */
+    int phase3_bufpos = 0x40;                    /* offset to next security buffer data to be added */
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
-        "Sorry, I was built with --enable-pedantic and I am incapable of doing any real work!\n");
+    fprintf(stderr, "Sorry, I was built with --enable-pedantic and I am incapable of doing any real work!\n");
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
-#ifndef ENABLE_SMALL /* Expect people using the stripped down version to know what they do */
+/* Expect people using the stripped down version to know what they do */
+#ifndef ENABLE_SMALL
 
 #define CHKACC_FILE       (1 << 0) /**< Check for a file/directory presence */
 #define CHKACC_DIRPATH    (1 << 1) /**< Check for directory presence where a file should reside */
@@ -6243,7 +6244,7 @@
         print_default_gateway(M_INFO, &rgi, &rgi6);
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
-#endif /* if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL) */
+#endif
     else if (streq(p[0], "echo") || streq(p[0], "parameter"))
     {
         struct buffer string = alloc_buf_gc(OPTION_PARM_SIZE, &gc);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 51468dd..38e67c8 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -133,16 +133,16 @@
     int tls_mtu;           /* Maximum MTU for the control channel messages */
 
     /* Advanced MTU negotiation and datagram fragmentation options */
-    int mtu_discover_type; /* used if OS supports setting Path MTU discovery options on socket */
+    int mtu_discover_type;          /* used if OS supports setting Path MTU discovery options on socket */
 
-    int fragment;          /* internal fragmentation size */
-    bool fragment_encap;   /* true if --fragment had the "mtu" parameter to
-                            * include overhead from IP and TCP/UDP encapsulation */
-    int mssfix;            /* Upper bound on TCP MSS */
-    bool mssfix_default;   /* true if --mssfix should use the default parameters */
-    bool mssfix_encap;     /* true if --mssfix had the "mtu" parameter to include
-                            * overhead from IP and TCP/UDP encapsulation */
-    bool mssfix_fixed;     /* use the mssfix value without any encapsulation adjustments */
+    int fragment;                   /* internal fragmentation size */
+    bool fragment_encap;            /* true if --fragment had the "mtu" parameter to
+                                     * include overhead from IP and TCP/UDP encapsulation */
+    int mssfix;                     /* Upper bound on TCP MSS */
+    bool mssfix_default;            /* true if --mssfix should use the default parameters */
+    bool mssfix_encap;              /* true if --mssfix had the "mtu" parameter to include
+                                     * overhead from IP and TCP/UDP encapsulation */
+    bool mssfix_fixed;              /* use the mssfix value without any encapsulation adjustments */
 
     int explicit_exit_notification; /* Explicitly tell peer when we are exiting via OCC_EXIT or
                                        [RESTART] message */
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 5251b21..c3938a7 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -146,14 +146,14 @@
     return (int)i;
 }
 
-static const char *updatable_options[] = { "block-ipv6",        "block-outside-dns",
-                                           "dhcp-option",       "dns",
-                                           "ifconfig",          "ifconfig-ipv6",
+static const char *updatable_options[] = { "block-ipv6", "block-outside-dns",
+                                           "dhcp-option", "dns",
+                                           "ifconfig", "ifconfig-ipv6",
                                            "push-continuation", "redirect-gateway",
-                                           "redirect-private",  "route",
-                                           "route-gateway",     "route-ipv6",
-                                           "route-metric",      "topology",
-                                           "tun-mtu",           "keepalive" };
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
-#define SSEC_BUILT_IN 1 /* only call built-in programs such as ifconfig, route, netsh, etc.*/
-#define SSEC_SCRIPTS  2 /* allow calling of built-in programs and user-defined scripts */
-#define SSEC_PW_ENV                                                                              \
-    3 /* allow calling of built-in programs and user-defined scripts that may receive a password \
-         as an environmental variable */
+/** strictly no calling of external programs */
+#define SSEC_NONE     0
+/** only call built-in programs such as ifconfig, route, netsh, etc.*/
+#define SSEC_BUILT_IN 1
+/** allow calling of built-in programs and user-defined scripts */
+#define SSEC_SCRIPTS  2
+/** allow calling of built-in programs and user-defined scripts that may receive a password
+    as an environmental variable */
+#define SSEC_PW_ENV   3
 
 #define OPENVPN_EXECVE_ERROR       -1  /* generic error while forking to run an external program */
 #define OPENVPN_EXECVE_NOT_ALLOWED -2  /* external program not run due to script security */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index cd5293a..e8fde86 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -222,15 +222,15 @@
      */
     uint32_t peer_id;
 
-    struct key_state_ssl ks_ssl; /* contains SSL object and BIOs for the control channel */
+    struct key_state_ssl ks_ssl;           /* contains SSL object and BIOs for the control channel */
 
-    time_t initial;              /* when we created this session */
-    time_t established;          /* when our state went S_ACTIVE */
-    time_t must_negotiate;       /* key negotiation times out if not finished before this time */
-    time_t must_die;             /* this object is destroyed at this time */
-    time_t peer_last_packet;     /* Last time we received a packet in this control session */
+    time_t initial;                        /* when we created this session */
+    time_t established;                    /* when our state went S_ACTIVE */
+    time_t must_negotiate;                 /* key negotiation times out if not finished before this time */
+    time_t must_die;                       /* this object is destroyed at this time */
+    time_t peer_last_packet;               /* Last time we received a packet in this control session */
 
-    int initial_opcode;          /* our initial P_ opcode */
+    int initial_opcode;                    /* our initial P_ opcode */
     struct session_id session_id_remote;   /* peer's random session ID */
     struct link_socket_actual remote_addr; /* peer's IP addr */
 
@@ -579,9 +579,8 @@
 enum multi_status
 {
     CAS_NOT_CONNECTED,
-    CAS_WAITING_AUTH, /**< Initial TLS connection established but deferred auth is not yet finished
-                       */
-    CAS_PENDING,      /**< Options import (Connect script/plugin, ccd,...) */
+    CAS_WAITING_AUTH,             /**< Initial TLS connection established but deferred auth is not yet finished */
+    CAS_PENDING,                  /**< Options import (Connect script/plugin, ccd,...) */
     CAS_PENDING_DEFERRED,         /**< Waiting on an async option import handler */
     CAS_PENDING_DEFERRED_PARTIAL, /**< at least handler succeeded but another is still pending */
     CAS_FAILED,                   /**< Option import failed or explicitly denied the client */
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index f4a9948..3820808 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -329,10 +329,12 @@
 
 #define MAKE_DI(x) { NID_##x, x, sizeof(x) }
 
+    /* clang-format off */
     DIG_INFO dinfo[] = {
         MAKE_DI(sha1),   MAKE_DI(sha256),     MAKE_DI(sha384),     MAKE_DI(sha512),
         MAKE_DI(sha224), MAKE_DI(sha512_224), MAKE_DI(sha512_256), { 0, NULL, 0 }
     };
+    /* clang-format on */
 
     size_t out_len = 0;
     bool ret = false;
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 09be7e8..b633e77 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -225,10 +225,8 @@
 delete_device(_In_ HDEVINFO hDeviceInfoSet, _In_ PSP_DEVINFO_DATA pDeviceInfoData,
               _Inout_ LPBOOL pbRebootRequired)
 {
-    SP_REMOVEDEVICE_PARAMS params =
-    {
-        .ClassInstallHeader =
-        {
+    SP_REMOVEDEVICE_PARAMS params = {
+        .ClassInstallHeader = {
             .cbSize = sizeof(SP_CLASSINSTALL_HEADER),
             .InstallFunction = DIF_REMOVE,
         },
@@ -281,10 +279,8 @@
 change_device_state(_In_ HDEVINFO hDeviceInfoSet, _In_ PSP_DEVINFO_DATA pDeviceInfoData,
                     _In_ BOOL bEnable, _Inout_ LPBOOL pbRebootRequired)
 {
-    SP_PROPCHANGE_PARAMS params =
-    {
-        .ClassInstallHeader =
-        {
+    SP_PROPCHANGE_PARAMS params = {
+        .ClassInstallHeader = {
             .cbSize = sizeof(SP_CLASSINSTALL_HEADER),
             .InstallFunction = DIF_PROPERTYCHANGE,
         },
@@ -768,10 +764,8 @@
     if (dwResult != ERROR_SUCCESS)
     {
         /* The adapter was installed. But, the adapter ID was unobtainable. Clean-up. */
-        SP_REMOVEDEVICE_PARAMS removedevice_params =
-        {
-            .ClassInstallHeader =
-            {
+        SP_REMOVEDEVICE_PARAMS removedevice_params = {
+            .ClassInstallHeader = {
                 .cbSize = sizeof(SP_CLASSINSTALL_HEADER),
                 .InstallFunction = DIF_REMOVE,
             },
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 3823d39..65b31e7 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -219,7 +219,7 @@
     {
         buf_reset_len(&buf);
         buf_write(&buf, client_reset_v2_tls_crypt, sizeof(client_reset_v2_tls_crypt));
-        BPTR(&buf)[i] = 0x23;
+        (BPTR(&buf))[i] = 0x23;
         verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
         assert_int_equal(verdict, VERDICT_INVALID);
         free_tls_pre_decrypt_state(&state);
@@ -274,7 +274,7 @@
     free_tls_pre_decrypt_state(&state);
 
     /* flip a byte in the hmac */
-    BPTR(&buf)[20] = 0x23;
+    (BPTR(&buf))[20] = 0x23;
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_INVALID);
     free_tls_pre_decrypt_state(&state);

