From: Arne Schwabe <arne@...1227...>
Date: Wed, 11 Jan 2023 14:44:39 +0100
Message-Id: <20230111134439.1107915-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Deprecate OCC checking
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

- Move OCC warnings to debug level. This moves the only useful OCC message
  of compress-migrate to D_PUSH
- remove configure option --enable-strict-options
- ignore disable-occ in TLS mode as it is logged under debug now only
  disable-occ is now strictly a non-TLS option
- mark opt-verify and disable-occ as deprecated.

Patch v2: change one missed M_WARN to D_OCC

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                          |  6 ++++++
 configure.ac                         |  1 -
 doc/man-sections/generic-options.rst |  3 ++-
 doc/man-sections/server-options.rst  |  4 ++--
 src/openvpn/errlevel.h               |  3 ++-
 src/openvpn/init.c                   |  2 --
 src/openvpn/options.c                | 14 ++++++++------
 src/openvpn/ssl.c                    |  5 ++---
 8 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 187d03fcf..35337a483 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -183,6 +183,12 @@ PF (Packet Filtering) support has been removed
    This implies that also ``--management-client-pf`` and any other compile
    time or run time related option do not exist any longer.
 
+Option conflict checking is being deprecated and phased out
+    The static option checking is no longer useful in typical setup that
+    negotiate most connection parameters. The ``--opt-verify`` and
+    ``--occ-disable`` are deprecated and the configure option
+    enable-strict-options has been removed. Logging of mismatched options has
+    been moved to debug logging.
 
 User-visible Changes
 --------------------
diff --git a/configure.ac b/configure.ac
index befdaa096..915000870 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1233,7 +1233,6 @@ test "${enable_debug}" = "yes" && AC_DEFINE([ENABLE_DEBUG], [1], [Enable debuggi
 test "${enable_small}" = "yes" && AC_DEFINE([ENABLE_SMALL], [1], [Enable smaller executable size])
 test "${enable_fragment}" = "yes" && AC_DEFINE([ENABLE_FRAGMENT], [1], [Enable internal fragmentation support])
 test "${enable_port_share}" = "yes" && AC_DEFINE([ENABLE_PORT_SHARE], [1], [Enable TCP Server port sharing])
-test "${enable_strict_options}" = "yes" && AC_DEFINE([ENABLE_STRICT_OPTIONS_CHECK], [1], [Enable strict options check between peers])
 
 test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
 if test "${have_export_keying_material}" = "yes"; then
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index d2b226c45..c827651d6 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -181,7 +181,8 @@ which mode OpenVPN is configured as.
   older than version 2.4 to connect.
 
 --disable-occ
-  Disable "options consistency check" (OCC).
+  **DEPRECATED** Disable "options consistency check" (OCC) in configurations
+  that do not use TLS.
 
   Don't output a warning message if option inconsistencies are detected
   between peers. An example of an option inconsistency would be where one
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index dbe35d6e1..6b9ad21b8 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -400,8 +400,8 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   the kernel routing table.
 
 --opt-verify
-  Clients that connect with options that are incompatible with those of the
-  server will be disconnected.
+  **DEPRECATED** Clients that connect with options that are incompatible with
+  those of the server will be disconnected.
 
   Options that will be compared for compatibility include ``dev-type``,
   ``link-mtu``, ``tun-mtu``, ``proto``, ``ifconfig``,
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 64ba4a339..c69ea91d6 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -94,7 +94,6 @@
 #define D_DCO                LOGLEV(3, 0, 0)         /* show DCO related messages */
 
 #define D_SHOW_PARMS         LOGLEV(4, 50, 0)        /* show all parameters on program initiation */
-#define D_SHOW_OCC           LOGLEV(4, 51, 0)        /* show options compatibility string */
 #define D_LOW                LOGLEV(4, 52, 0)        /* miscellaneous low-frequency debug info */
 #define D_DHCP_OPT           LOGLEV(4, 53, 0)        /* show DHCP options binary string */
 #define D_MBUF               LOGLEV(4, 54, 0)        /* mbuf.[ch] routines */
@@ -147,6 +146,8 @@
 #define D_CRYPTO_DEBUG       LOGLEV(7, 70, M_DEBUG)  /* show detailed info from crypto.c routines */
 #define D_PID_DEBUG          LOGLEV(7, 70, M_DEBUG)  /* show packet-id debugging info */
 #define D_PUSH_DEBUG         LOGLEV(7, 73, M_DEBUG)  /* show push/pull debugging info */
+#define D_SHOW_OCC           LOGLEV(7, 74, M_DEBUG)  /* show options compatibility string */
+
 
 #define D_VLAN_DEBUG         LOGLEV(7, 74, M_DEBUG)  /* show VLAN tagging/untagging debug info */
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 773588305..b500d3543 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3175,8 +3175,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         to.xmit_hold = true;
     }
 
-    to.disable_occ = !options->occ;
-
     to.verify_command = options->tls_verify;
     to.verify_export_cert = options->tls_export_cert;
     to.verify_x509_type = (options->verify_x509_type & 0xff);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9f027e768..3a0995f11 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -359,7 +359,7 @@ static const char usage_message[] =
     "--status file [n] : Write operational status to file every n seconds.\n"
     "--status-version [n] : Choose the status file format version number.\n"
     "                  Currently, n can be 1, 2, or 3 (default=1).\n"
-    "--disable-occ   : Disable options consistency check between peers.\n"
+    "--disable-occ   : (DEPRECATED) Disable options consistency check between peers.\n"
 #ifdef ENABLE_DEBUG
     "--gremlin mask  : Special stress testing mode (for debugging only).\n"
 #endif
@@ -458,7 +458,7 @@ static const char usage_message[] =
     "                  OTP based two-factor auth mechanisms are in use and\n"
     "                  --reneg-* options are enabled. Optionally a lifetime in seconds\n"
     "                  for generated tokens can be set.\n"
-    "--opt-verify    : Clients that connect with options that are incompatible\n"
+    "--opt-verify    : (DEPRECATED) Clients that connect with options that are incompatible\n"
     "                  with those of the server will be disconnected.\n"
     "--auth-user-pass-optional : Allow connections by clients that don't\n"
     "                  specify a username/password.\n"
@@ -4567,15 +4567,15 @@ options_cmp_equal_safe(char *actual, const char *expected, size_t actual_n)
     if (actual_n > 0)
     {
         actual[actual_n - 1] = 0;
-#ifndef ENABLE_STRICT_OPTIONS_CHECK
         if (strncmp(actual, expected, 2))
         {
             msg(D_SHOW_OCC, "NOTE: Options consistency check may be skewed by version differences");
             options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n);
         }
         else
-#endif
-        ret = !strcmp(actual, expected);
+        {
+            ret = !strcmp(actual, expected);
+        }
     }
     gc_free(&gc);
     return ret;
@@ -4584,7 +4584,7 @@ options_cmp_equal_safe(char *actual, const char *expected, size_t actual_n)
 void
 options_warning_safe(char *actual, const char *expected, size_t actual_n)
 {
-    options_warning_safe_ml(M_WARN, actual, expected, actual_n);
+    options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n);
 }
 
 const char *
@@ -7538,6 +7538,8 @@ add_option(struct options *options,
     else if (streq(p[0], "opt-verify") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
+        msg(M_INFO, "DEPRECATION: opt-verify is deprecated and will be removed "
+            "in OpenVPN 2.7");
         options->ssl_flags |= SSLF_OPT_VERIFY;
     }
     else if (streq(p[0], "auth-user-pass-verify") && p[1])
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cbb596c13..016bdc57f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2420,14 +2420,13 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
     }
 
     /* check options consistency */
-    if (!session->opt->disable_occ
-        && !options_cmp_equal(options, session->opt->remote_options))
+    if (!options_cmp_equal(options, session->opt->remote_options))
     {
         const char *remote_options = session->opt->remote_options;
 #ifdef USE_COMP
         if (multi->opt.comp_options.flags & COMP_F_MIGRATE && multi->remote_usescomp)
         {
-            msg(D_SHOW_OCC, "Note: 'compress migrate' detected remote peer "
+            msg(D_PUSH, "Note: 'compress migrate' detected remote peer "
                 "with compression enabled.");
             remote_options = options_string_compat_lzo(remote_options, &gc);
         }
-- 
2.37.1 (Apple Git-137.1)


