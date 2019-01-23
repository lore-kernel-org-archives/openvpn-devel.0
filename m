From: jonathan@...2489...
Date: Wed, 23 Jan 2019 14:17:17 -0600
Message-Id: <20190123201717.15048-1-jonathan@...2489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix various spelling mistakes
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

From: Jonathan Tooker <jonathan@...2489...>

New patch, omitted changes to copyrights/licenses & changelog.
---
 Changes.rst                               |  6 +++---
 INSTALL                                   |  2 +-
 TODO.IPv6                                 |  6 +++---
 configure.ac                              |  2 +-
 distro/rpm/openvpn.init.d.rhel            |  2 +-
 distro/rpm/openvpn.init.d.suse            |  4 ++--
 doc/keying-material-exporter.txt          |  2 +-
 doc/openvpn.8                             | 14 +++++++-------
 m4/pkg.m4                                 |  2 +-
 sample/sample-config-files/client.conf    |  2 +-
 sample/sample-keys/openssl.cnf            |  4 ++--
 src/openvpn/buffer.c                      |  2 +-
 src/openvpn/console.h                     |  6 +++---
 src/openvpn/crypto.h                      |  2 +-
 src/openvpn/crypto_backend.h              |  2 +-
 src/openvpn/fragment.c                    |  2 +-
 src/openvpn/init.c                        | 18 +++++++++---------
 src/openvpn/mss.c                         |  2 +-
 src/openvpn/options.c                     | 14 +++++++-------
 src/openvpn/packet_id.h                   |  2 +-
 src/openvpn/route.c                       |  2 +-
 src/openvpn/run_command.c                 |  4 ++--
 src/openvpn/socket.c                      | 12 ++++++------
 src/openvpn/socket.h                      |  2 +-
 src/openvpn/ssl.c                         |  2 +-
 src/openvpn/ssl_verify_backend.h          |  2 +-
 src/openvpn/tun.c                         |  8 ++++----
 src/openvpn/win32.c                       |  2 +-
 src/openvpn/win32.h                       |  2 +-
 src/openvpnmsica/msica_op.h               |  2 +-
 src/plugins/auth-pam/README.auth-pam      |  4 ++--
 src/plugins/auth-pam/utils.h              |  6 +++---
 src/tapctl/tap.c                          |  2 +-
 tests/t_client.sh.in                      |  2 +-
 tests/unit_tests/openvpn/test_tls_crypt.c |  2 +-
 35 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index a7429b11..00dd6ed8 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -26,7 +26,7 @@ Seamless client IP/port floating
     the new format. When a data packet arrives, the server identifies peer
     by peer-id. If peer's ip/port has changed, server assumes that
     client has floated, verifies HMAC and updates ip/port in internal structs.
-    This allows the connection to be immediatly restored, instead of requiring
+    This allows the connection to be immediately restored, instead of requiring
     a TLS handshake before the server accepts packets from the new client
     ip/port.
 
@@ -223,7 +223,7 @@ User-visible Changes
   of a field get _$N appended to it's field name, starting at N=1.  For the
   example above, that would result in e.g. X509_0_OU=one, X509_0_OU_1=two.
   Note that this breaks setups that rely on the fact that OpenVPN would
-  previously (incorrectly) only export the last occurence of a field.
+  previously (incorrectly) only export the last occurrence of a field.
 
 - ``proto udp`` and ``proto tcp`` now use both IPv4 and IPv6. The new
   options ``proto udp4`` and ``proto tcp4`` use IPv4 only.
@@ -371,7 +371,7 @@ Security
 
 - CVE-2017-7521: Fix post-authentication remote-triggerable memory leaks
   A client could cause a server to leak a few bytes each time it connects to the
-  server.  That can eventuall cause the server to run out of memory, and thereby
+  server.  That can eventually cause the server to run out of memory, and thereby
   causing the server process to terminate. Discovered and reported to the
   OpenVPN security team by Guido Vranken.  (OpenSSL builds only.)
 
diff --git a/INSTALL b/INSTALL
index 0f12a636..d0c7dfa6 100644
--- a/INSTALL
+++ b/INSTALL
@@ -200,7 +200,7 @@ OPTIONS for ./configure:
   --enable-strict-options enable strict options check between peers (debugging
                           option) [default=no]
   --enable-selinux        enable SELinux support [default=no]
-  --enable-systemd        enable systemd suppport [default=no]
+  --enable-systemd        enable systemd support [default=no]
 
 ENVIRONMENT for ./configure:
 
diff --git a/TODO.IPv6 b/TODO.IPv6
index 24bf865a..465eaa66 100644
--- a/TODO.IPv6
+++ b/TODO.IPv6
@@ -21,7 +21,7 @@ TODO for IPv6 payload support
 
 4.) do "ifconfig tun0 inet6 unplumb"  or "ifconfig tun0 destroy" for
     Solaris, *BSD, ... at program termination time, to clean up leftovers
-    (unless tunnel persistance is desired).
+    (unless tunnel persistence is desired).
 
     For Solaris, only the "ipv6 tun0" is affected, for the *BSDs all tun0
     stay around.
@@ -47,7 +47,7 @@ tun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
 4b.) verify this - on FreeBSD, tun0 is auto-destroyed if created by
      opening /dev/tun (and lingers if created by "ifconfig tun0 create")
 
-     -> use for persistant tunnels on not-linux?
+     -> use for persistent tunnels on not-linux?
 
     * 2012-06-10 tun interface behaviour is documented in "man tun(4)"
 
@@ -201,7 +201,7 @@ TODO for IPv6 transport support
     downstream.
     - Still done by flags, seems clean enough.
 
-  o implement comparison for mapped addesses: server in dual stack
+  o implement comparison for mapped addresses: server in dual stack
     listening IPv6 must permit incoming streams from allowed IPv4 peer,
     currently you need to pass eg:  --remote ffff::1.2.3.4
     - OpenVPN will compare all address of a remote
diff --git a/configure.ac b/configure.ac
index 192c15c5..84f12edc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -244,7 +244,7 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[systemd],
-	[AS_HELP_STRING([--enable-systemd], [enable systemd suppport @<:@default=no@:>@])],
+	[AS_HELP_STRING([--enable-systemd], [enable systemd support @<:@default=no@:>@])],
 	,
 	[enable_systemd="no"]
 )
diff --git a/distro/rpm/openvpn.init.d.rhel b/distro/rpm/openvpn.init.d.rhel
index bfde2216..04125ca6 100755
--- a/distro/rpm/openvpn.init.d.rhel
+++ b/distro/rpm/openvpn.init.d.rhel
@@ -113,7 +113,7 @@ case "$1" in
 
 	# From a security perspective, I think it makes
 	# sense to remove this, and have users who need
-	# it explictly enable in their --up scripts or
+	# it explicitly enable in their --up scripts or
 	# firewall setups.
 
 	#echo 1 > /proc/sys/net/ipv4/ip_forward
diff --git a/distro/rpm/openvpn.init.d.suse b/distro/rpm/openvpn.init.d.suse
index 270024e8..1b4bcf06 100644
--- a/distro/rpm/openvpn.init.d.suse
+++ b/distro/rpm/openvpn.init.d.suse
@@ -72,7 +72,7 @@
 #		- removed sourcing "network"
 #		- removed network checking. it seemed not to work with SuSE.
 #		- added sourcing "rc.status", comments and "rc_reset" command
-#		- removed "succes; echo" and "failure; echo" lines
+#		- removed "success; echo" and "failure; echo" lines
 #		- added "rc_status" lines at the end of each section
 #		- changed "service" to "/etc/init.d/" in "In addition to start/stop"
 #		  section above.
@@ -126,7 +126,7 @@ case "$1" in
 
 	# From a security perspective, I think it makes
 	# sense to remove this, and have users who need
-	# it explictly enable in their --up scripts or
+	# it explicitly enable in their --up scripts or
 	# firewall setups.
 
 	#echo 1 > /proc/sys/net/ipv4/ip_forward
diff --git a/doc/keying-material-exporter.txt b/doc/keying-material-exporter.txt
index 4187d828..4c1addc8 100644
--- a/doc/keying-material-exporter.txt
+++ b/doc/keying-material-exporter.txt
@@ -48,7 +48,7 @@ to application layer using well-defined mechanism.
    [DerivedAAABindingKey]                            [DerivedAAABindingKey]
                                                   [AuthenticateBindingKeys]
    Client                           ------->                         Server
-                             [Confidental channel]
+                             [Confidential channel]
 
 
 TLS Message flow for a full handshake
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 7abcaf1e..e5c0626a 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -696,7 +696,7 @@ are used.
 
 If the
 .B ipv6only
-keyword is present OpenVPN will bind only to IPv6 (as oposed
+keyword is present OpenVPN will bind only to IPv6 (as opposed
 to IPv6 and IPv4) when a IPv6 socket is opened.
 
 .\"*********************************************************
@@ -2221,7 +2221,7 @@ that
 is parsed on the command line even though
 the daemonization point occurs later.  If one of the
 .B \-\-log
-options is present, it will supercede syslog
+options is present, it will supersede syslog
 redirection.
 
 The optional
@@ -2332,7 +2332,7 @@ If
 already exists it will be truncated.
 This option takes effect
 immediately when it is parsed in the command line
-and will supercede syslog output if
+and will supersede syslog output if
 .B \-\-daemon
 or
 .B \-\-inetd
@@ -2817,7 +2817,7 @@ or outside this directory.
 DEFAULT_DIR is replaced by the default plug\-in directory,
 which is configured at the build time of OpenVPN.  CWD is the
 current directory where OpenVPN was started or the directory
-OpenVPN have swithed into via the
+OpenVPN have switched into via the
 .B \-\-cd
 option before the
 .B \-\-plugin
@@ -3104,7 +3104,7 @@ IV_LZO_STUB=1 \-\- if client was built with LZO stub capability
 
 IV_LZ4=1 \-\- if the client supports LZ4 compressions.
 
-IV_PROTO=2 \-\- if the client supports peer\-id floating mechansim
+IV_PROTO=2 \-\- if the client supports peer\-id floating mechanism
 
 IV_NCP=2 \-\- negotiable ciphers, client supports
 .B \-\-cipher
@@ -4934,7 +4934,7 @@ Warning!
 .B \-\-tls\-cipher
 and
 .B \-\-tls\-ciphersuites
-are expert features, which \- if used correcly \- can improve the security of
+are expert features, which \- if used correctly \- can improve the security of
 your VPN connection.  But it is also easy to unwittingly use them to carefully
 align a gun with your foot, or just break your connection.  Use with care!
 
@@ -5415,7 +5415,7 @@ UNIQUE_TOKEN_VALUE.
 
 Newer clients (2.4.7+) will fall back to the original password method
 after a failed auth. Older clients will keep using the token value
-and react acording to
+and react according to
 .B \-\-auth-retry
 .
 .\"*********************************************************
diff --git a/m4/pkg.m4 b/m4/pkg.m4
index 12d2a587..cca47a71 100644
--- a/m4/pkg.m4
+++ b/m4/pkg.m4
@@ -53,7 +53,7 @@ fi[]dnl
 # to PKG_CHECK_MODULES(), but does not set variables or print errors.
 #
 # Please remember that m4 expands AC_REQUIRE([PKG_PROG_PKG_CONFIG])
-# only at the first occurence in configure.ac, so if the first place
+# only at the first occurrence in configure.ac, so if the first place
 # it's called might be skipped (such as if it is within an "if", you
 # have to call PKG_CHECK_EXISTS manually
 # --------------------------------------------------------------
diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-files/client.conf
index 5fd4a948..7f2f30a3 100644
--- a/sample/sample-config-files/client.conf
+++ b/sample/sample-config-files/client.conf
@@ -90,7 +90,7 @@ cert client.crt
 key client.key
 
 # Verify server certificate by checking that the
-# certicate has the correct key usage set.
+# certificate has the correct key usage set.
 # This is an important precaution to protect against
 # a potential attack discussed here:
 #  http://openvpn.net/howto.html#mitm
diff --git a/sample/sample-keys/openssl.cnf b/sample/sample-keys/openssl.cnf
index aabfd48f..02bf8ac6 100644
--- a/sample/sample-keys/openssl.cnf
+++ b/sample/sample-keys/openssl.cnf
@@ -19,7 +19,7 @@ crl		= $dir/crl.pem 		# The current CRL
 private_key	= $dir/ca.key		# The private key
 RANDFILE	= $dir/.rand		# private random number file
 
-x509_extensions	= basic_exts		# The extentions to add to the cert
+x509_extensions	= basic_exts		# The extensions to add to the cert
 
 # This allows a V2 CRL. Ancient browsers don't like it, but anything Easy-RSA
 # is designed for will. In return, we get the Issuer attached to CRLs.
@@ -54,7 +54,7 @@ default_bits		= 2048
 default_keyfile		= privkey.pem
 default_md		= sha256
 distinguished_name	= cn_only
-x509_extensions		= easyrsa_ca	# The extentions to add to the self signed cert
+x509_extensions		= easyrsa_ca	# The extensions to add to the self signed cert
 
 # A placeholder to handle the $EXTRA_EXTS feature:
 #%EXTRA_EXTS%	# Do NOT remove or change this line as $EXTRA_EXTS support requires it
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 2aae5c4c..8575e295 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -46,7 +46,7 @@ array_mult_safe(const size_t m1, const size_t m2, const size_t extra)
     unsigned long long res = (unsigned long long)m1 * (unsigned long long)m2 + (unsigned long long)extra;
     if (unlikely(m1 > limit) || unlikely(m2 > limit) || unlikely(extra > limit) || unlikely(res > (unsigned long long)limit))
     {
-        msg(M_FATAL, "attemped allocation of excessively large array");
+        msg(M_FATAL, "attempted allocation of excessively large array");
     }
     return (size_t) res;
 }
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 0ffd6683..f9481684 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -33,9 +33,9 @@
  */
 struct _query_user {
     char *prompt;             /**< Prompt to present to the user */
-    size_t prompt_len;        /**< Lenght of the prompt string */
+    size_t prompt_len;        /**< Length of the prompt string */
     char *response;           /**< The user's response */
-    size_t response_len;      /**< Lenght the of the user reposone */
+    size_t response_len;      /**< Length the of the user response */
     bool echo;                /**< True: The user should see what is being typed, otherwise mask it */
 };
 
@@ -55,7 +55,7 @@ void query_user_clear(void);
  * @param prompt     Prompt to display to the user
  * @param prompt_len Length of the prompt string
  * @param resp       String containing the user response
- * @param resp_len   Lenght of the response string
+ * @param resp_len   Length of the response string
  * @param echo       Should the user input be echoed to the user?  If False, input will be masked
  *
  */
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 09f7bb25..c5947483 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -299,7 +299,7 @@ int read_key(struct key *key, const struct key_type *kt, struct buffer *buf);
  * @param authname    The name of the HMAC digest to use
  * @param keysize     The length of the cipher key to use, in bytes.  Only valid
  *                    for ciphers that support variable length keys.
- * @param tls_mode    Specifies wether we are running in TLS mode, which allows
+ * @param tls_mode    Specifies whether we are running in TLS mode, which allows
  *                    more ciphers than static key mode.
  * @param warn        Print warnings when null cipher / auth is used.
  */
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index a04e01f4..7e9a4bd2 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -634,7 +634,7 @@ void hmac_ctx_free(hmac_ctx_t *ctx);
  * Initialises the given HMAC context, using the given digest
  * and key.
  *
- * @param ctx           HMAC context to intialise
+ * @param ctx           HMAC context to initialise
  * @param key           The key to use for the HMAC
  * @param key_len       The key length to use
  * @param kt            Static message digest parameters
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 3f0ec2fa..6df71d07 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -178,7 +178,7 @@ fragment_incoming(struct fragment_master *f, struct buffer *buf,
 
             if (flags & (FRAG_SEQ_ID_MASK | FRAG_ID_MASK))
             {
-                FRAG_ERR("spurrious FRAG_WHOLE flags");
+                FRAG_ERR("spurious FRAG_WHOLE flags");
             }
         }
         else if (frag_type == FRAG_YES_NOTLAST || frag_type == FRAG_YES_LAST)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 560d87db..3c449678 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1005,7 +1005,7 @@ init_options_dev(struct options *options)
 {
     if (!options->dev && options->dev_node)
     {
-        char *dev_node = string_alloc(options->dev_node, NULL); /* POSIX basename() implementaions may modify its arguments */
+        char *dev_node = string_alloc(options->dev_node, NULL); /* POSIX basename() implementations may modify its arguments */
         options->dev = basename(dev_node);
     }
 }
@@ -1134,7 +1134,7 @@ do_persist_tuntap(const struct options *options)
              "options --mktun and --rmtun are not available on your operating "
              "system.  Please check 'man tun' (or 'tap'), whether your system "
              "supports using 'ifconfig %s create' / 'destroy' to create/remove "
-             "persistant tunnel interfaces.", options->dev );
+             "persistent tunnel interfaces.", options->dev );
 #endif
     }
     return false;
@@ -2391,7 +2391,7 @@ socket_restart_pause(struct context *c)
     }
     c->persist.restart_sleep_seconds = 0;
 
-    /* do managment hold on context restart, i.e. second, third, fourth, etc. initialization */
+    /* do management hold on context restart, i.e. second, third, fourth, etc. initialization */
     if (do_hold(sec))
     {
         sec = 0;
@@ -3066,7 +3066,7 @@ do_init_frame(struct context *c)
     /* packets with peer-id (P_DATA_V2) need 3 extra bytes in frame (on client)
      * and need link_mtu+3 bytes on socket reception (on server).
      *
-     * accomodate receive path in f->extra_link, which has the side effect of
+     * accommodate receive path in f->extra_link, which has the side effect of
      * also increasing send buffers (BUF_SIZE() macro), which need to be
      * allocated big enough before receiving peer-id option from server.
      *
@@ -3193,7 +3193,7 @@ do_option_warnings(struct context *c)
         msg(M_WARN, "WARNING: --ns-cert-type is DEPRECATED.  Use --remote-cert-tls instead.");
     }
 
-    /* If a script is used, print appropiate warnings */
+    /* If a script is used, print appropriate warnings */
     if (o->user_script_used)
     {
         if (script_security() >= SSEC_SCRIPTS)
@@ -3562,7 +3562,7 @@ do_close_link_socket(struct context *c)
 }
 
 /*
- * Close packet-id persistance file
+ * Close packet-id persistence file
  */
 static void
 do_close_packet_id(struct context *c)
@@ -3657,7 +3657,7 @@ do_close_status_output(struct context *c)
 }
 
 /*
- * Handle ifconfig-pool persistance object.
+ * Handle ifconfig-pool persistence object.
  */
 static void
 do_open_ifconfig_pool_persist(struct context *c)
@@ -4269,7 +4269,7 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
         do_init_traffic_shaper(c);
     }
 
-    /* do one-time inits, and possibily become a daemon here */
+    /* do one-time inits, and possibly become a daemon here */
     do_init_first_time(c);
 
 #ifdef ENABLE_PLUGIN
@@ -4399,7 +4399,7 @@ close_instance(struct context *c)
         do_close_plugins(c);
 #endif
 
-        /* close packet-id persistance file */
+        /* close packet-id persistence file */
         do_close_packet_id(c);
 
         /* close --status file */
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index b0e2c42b..f15c656e 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -110,7 +110,7 @@ mss_fixup_ipv6(struct buffer *buf, int maxmss)
      * before the final header (TCP, UDP, ...), so we'd need to walk that
      * chain (see RFC 2460 and RFC 6564 for details).
      *
-     * In practice, "most typically used" extention headers (AH, routing,
+     * In practice, "most typically used" extension headers (AH, routing,
      * fragment, mobility) are very unlikely to be seen inside an OpenVPN
      * tun, so for now, we only handle the case of "single next header = TCP"
      */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bebd3005..e34b65b1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -451,7 +451,7 @@ static const char usage_message[] =
     "                  user/pass via environment, if method='via-file', pass\n"
     "                  user/pass via temporary file.\n"
     "--auth-gen-token  [lifetime] Generate a random authentication token which is pushed\n"
-    "                  to each client, replacing the password.  Usefull when\n"
+    "                  to each client, replacing the password.  Useful when\n"
     "                  OTP based two-factor auth mechanisms are in use and\n"
     "                  --reneg-* options are enabled. Optionally a lifetime in seconds\n"
     "                  for generated tokens can be set.\n"
@@ -675,7 +675,7 @@ static const char usage_message[] =
     "--pkcs11-protected-authentication [0|1] ... : Use PKCS#11 protected authentication\n"
     "                              path. Set for each provider.\n"
     "--pkcs11-private-mode hex ...   : PKCS#11 private key mode mask.\n"
-    "                              0       : Try  to determind automatically (default).\n"
+    "                              0       : Try  to determine automatically (default).\n"
     "                              1       : Use Sign.\n"
     "                              2       : Use SignRecover.\n"
     "                              4       : Use Decrypt.\n"
@@ -898,7 +898,7 @@ init_options(struct options *o, const bool init_gc)
 
     /* Set default --tmp-dir */
 #ifdef _WIN32
-    /* On Windows, find temp dir via enviroment variables */
+    /* On Windows, find temp dir via environment variables */
     o->tmp_dir = win_get_tempdir();
 #else
     /* Non-windows platforms use $TMPDIR, and if not set, default to '/tmp' */
@@ -3084,8 +3084,8 @@ options_postprocess_mutate(struct options *o)
  */
 #ifndef ENABLE_SMALL  /** Expect people using the stripped down version to know what they do */
 
-#define CHKACC_FILE (1<<0)       /** Check for a file/directory precense */
-#define CHKACC_DIRPATH (1<<1)    /** Check for directory precense where a file should reside */
+#define CHKACC_FILE (1<<0)       /** Check for a file/directory presence */
+#define CHKACC_DIRPATH (1<<1)    /** Check for directory presence where a file should reside */
 #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
 #define CHKACC_INLINE (1<<3)     /** File is present if it's an inline file */
 #define CHKACC_ACPTSTDIN (1<<4)  /** If filename is stdin, it's allowed and "exists" */
@@ -3119,7 +3119,7 @@ check_file_access(const int type, const char *file, const int mode, const char *
     /* Is the directory path leading to the given file accessible? */
     if (type & CHKACC_DIRPATH)
     {
-        char *fullpath = string_alloc(file, NULL); /* POSIX dirname() implementaion may modify its arguments */
+        char *fullpath = string_alloc(file, NULL); /* POSIX dirname() implementation may modify its arguments */
         char *dirpath = dirname(fullpath);
 
         if (platform_access(dirpath, mode|X_OK) != 0)
@@ -3169,7 +3169,7 @@ check_file_access(const int type, const char *file, const int mode, const char *
         msg(M_NOPREFIX | M_OPTERR | M_ERRNO, "%s fails with '%s'", opt, file);
     }
 
-    /* Return true if an error occured */
+    /* Return true if an error occurred */
     return (errcode != 0 ? true : false);
 }
 
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 26b07975..3b58da22 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -258,7 +258,7 @@ bool packet_id_read(struct packet_id_net *pin, struct buffer *buf, bool long_for
  * @param p             Packet ID state.
  * @param buf           Buffer to write the packet ID too
  * @param long_form     If true, also update and write time_t to buf
- * @param prepend       If true, prepend to buffer, otherwise apppend.
+ * @param prepend       If true, prepend to buffer, otherwise append.
  *
  * @return true if successful, false otherwise.
  */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2836d532..376e2673 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1820,7 +1820,7 @@ route_ipv6_clear_host_bits( struct route_ipv6 *r6 )
 {
     /* clear host bit parts of route
      * (needed if routes are specified improperly, or if we need to
-     * explicitely setup/clear the "connected" network routes on some OSes)
+     * explicitly setup/clear the "connected" network routes on some OSes)
      */
     int byte = 15;
     int bits_to_clear = 128 - r6->netbits;
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 04ad2312..2d75a3e9 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -113,7 +113,7 @@ openvpn_execve_allowed(const unsigned int flags)
 /*
  * Run execve() inside a fork().  Designed to replicate the semantics of system() but
  * in a safer way that doesn't require the invocation of a shell or the risks
- * assocated with formatting and parsing a command line.
+ * associated with formatting and parsing a command line.
  */
 int
 openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags)
@@ -199,7 +199,7 @@ openvpn_execve_check(const struct argv *a, const struct env_set *es, const unsig
 /*
  * Run execve() inside a fork(), duping stdout.  Designed to replicate the semantics of popen() but
  * in a safer way that doesn't require the invocation of a shell or the risks
- * assocated with formatting and parsing a command line.
+ * associated with formatting and parsing a command line.
  */
 int
 openvpn_popen(const struct argv *a,  const struct env_set *es)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index db944245..c472cf1b 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -992,7 +992,7 @@ link_socket_update_buffer_sizes(struct link_socket *ls, int rcvbuf, int sndbuf)
 }
 
 /*
- * SOCKET INITALIZATION CODE.
+ * SOCKET INITIALIZATION CODE.
  * Create a TCP/UDP socket
  */
 
@@ -2535,7 +2535,7 @@ link_socket_current_remote(const struct link_socket_info *info)
  * by now just ignore it
  *
  * For --remote entries with multiple addresses this
- * only return the actual endpoint we have sucessfully connected to
+ * only return the actual endpoint we have successfully connected to
  */
     if (lsa->actual.dest.addr.sa.sa_family != AF_INET)
     {
@@ -2566,7 +2566,7 @@ link_socket_current_remote_ipv6(const struct link_socket_info *info)
  * for PF_INET6 routes over PF_INET6 endpoints
  *
  * For --remote entries with multiple addresses this
- * only return the actual endpoint we have sucessfully connected to
+ * only return the actual endpoint we have successfully connected to
  */
     if (lsa->actual.dest.addr.sa.sa_family != AF_INET6)
     {
@@ -3279,7 +3279,7 @@ addr_family_name(int af)
  *
  * IPv6 and IPv4 protocols are comptabile but OpenVPN
  * has always sent UDPv4, TCPv4 over the wire. Keep these
- * strings for backward compatbility
+ * strings for backward compatibility
  */
 const char *
 proto_remote(int proto, bool remote)
@@ -3364,7 +3364,7 @@ link_socket_read_tcp(struct link_socket *sock,
 
 #if ENABLE_IP_PKTINFO
 
-/* make the buffer large enough to handle ancilliary socket data for
+/* make the buffer large enough to handle ancillary socket data for
  * both IPv4 and IPv6 destination addresses, plus padding (see RFC 2292)
  */
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
@@ -3879,7 +3879,7 @@ socket_finalize(SOCKET s,
         if (ret >= 0 && io->addr_defined)
         {
             /* TODO(jjo): streamline this mess */
-            /* in this func we dont have relevant info about the PF_ of this
+            /* in this func we don't have relevant info about the PF_ of this
              * endpoint, as link_socket_actual will be zero for the 1st received packet
              *
              * Test for inets PF_ possible sizes
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 17801418..e95547d1 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -99,7 +99,7 @@ struct link_socket_actual
 #endif
 };
 
-/* IP addresses which are persistant across SIGUSR1s */
+/* IP addresses which are persistent across SIGUSR1s */
 struct link_socket_addr
 {
     struct addrinfo *bind_local;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e9927eb8..4c81ae72 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2308,7 +2308,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         /* support for P_DATA_V2 */
         buf_printf(&out, "IV_PROTO=2\n");
 
-        /* support for Negotiable Crypto Paramters */
+        /* support for Negotiable Crypto Parameters */
         if (session->opt->ncp_enabled
             && (session->opt->mode == MODE_SERVER || session->opt->pull))
         {
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index f4cc2c54..d6b31bfa 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -176,7 +176,7 @@ void x509_setenv(struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert);
  *
  * The tracked attributes are stored in ll_head.
  *
- * @param ll_head       The x509_track to store tracked atttributes in
+ * @param ll_head       The x509_track to store tracked attributes in
  * @param name          Name of the attribute to track
  * @param msglevel      Message level for errors
  * @param gc            Garbage collection arena for temp data
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 196f7c1a..48a8fdf7 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -958,7 +958,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
 
 #if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
     || defined(TARGET_DARWIN)
-    /* and, hooray, we explicitely need to add a route... */
+    /* and, hooray, we explicitly need to add a route... */
     add_route_connected_v6_net(tt, es);
 #endif
 #elif defined(TARGET_AIX)
@@ -1894,7 +1894,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     ASSERT(0);
 }
 
-#endif /* !PENDANTIC */
+#endif /* !PEDANTIC */
 
 #ifdef ENABLE_FEATURE_TUN_PERSIST
 
@@ -2510,7 +2510,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
 /* the current way OpenVPN handles tun devices on NetBSD leads to
  * lingering tunX interfaces after close -> for a full cleanup, they
- * need to be explicitely destroyed
+ * need to be explicitly destroyed
  */
 void
 close_tun(struct tuntap *tt)
@@ -2937,7 +2937,7 @@ open_darwin_utun(const char *dev, const char *dev_type, const char *dev_node, st
         {
             fd = utun_open_helper(ctlInfo, utunnum);
             /* Break if the fd is valid,
-             * or if early initalization failed (-2) */
+             * or if early initialization failed (-2) */
             if (fd !=-1)
             {
                 break;
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index be526945..463ac072 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -22,7 +22,7 @@
  */
 
 /*
- * Win32-specific OpenVPN code, targetted at the mingw
+ * Win32-specific OpenVPN code, targeted at the mingw
  * development environment.
  */
 
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 4b4524f1..4814bbc5 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -37,7 +37,7 @@
 #define WIN_NET_PATH_SUFFIX "\\system32\\net.exe"
 
 /*
- * Win32-specific OpenVPN code, targetted at the mingw
+ * Win32-specific OpenVPN code, targeted at the mingw
  * development environment.
  */
 
diff --git a/src/openvpnmsica/msica_op.h b/src/openvpnmsica/msica_op.h
index 910a6e51..7ce80519 100644
--- a/src/openvpnmsica/msica_op.h
+++ b/src/openvpnmsica/msica_op.h
@@ -390,7 +390,7 @@ struct msica_session
 /**
  * Initializes execution session
  *
- * @param session       Pointer to an unitialized execution session
+ * @param session       Pointer to an uninitialized execution session
  *
  * @param hInstall      Installer handle
  *
diff --git a/src/plugins/auth-pam/README.auth-pam b/src/plugins/auth-pam/README.auth-pam
index 90815654..4d3d4ecc 100644
--- a/src/plugins/auth-pam/README.auth-pam
+++ b/src/plugins/auth-pam/README.auth-pam
@@ -7,7 +7,7 @@ authentication via PAM, and essentially allows any authentication
 method supported by PAM (such as LDAP, RADIUS, or Linux Shadow
 passwords) to be used with OpenVPN.  While PAM supports
 username/password authentication, this can be combined with X509
-certificates to provide two indepedent levels of authentication.
+certificates to provide two independent levels of authentication.
 
 This module uses a split privilege execution model which will
 function even if you drop openvpn daemon privileges using the user,
@@ -65,7 +65,7 @@ the operation of this plugin:
   static-challenge
 
 Use of --static challenege is required to pass a pin (represented by "OTP" in
-parameter substituion) or a second password.
+parameter substitution) or a second password.
 
 Run OpenVPN with --verb 7 or higher to get debugging output from
 this plugin, including the list of queries presented by the
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
index 90fff668..c876dcc4 100644
--- a/src/plugins/auth-pam/utils.h
+++ b/src/plugins/auth-pam/utils.h
@@ -25,7 +25,7 @@
 #define _PLUGIN_AUTH_PAM_UTILS__H
 
 /**
- *  Read 'tosearch', replace all occurences of 'searchfor' with 'replacewith' and return
+ *  Read 'tosearch', replace all occurrences of 'searchfor' with 'replacewith' and return
  *  a pointer to the NEW string.  Does not modify the input strings.  Will not enter an
  *  infinite loop with clever 'searchfor' and 'replacewith' strings.
  *
@@ -35,7 +35,7 @@
  *  @param searchfor     needle to search for in the haystack
  *  @param replacewith   when a match is found, replace needle with this string
  *
- *  @return Retuns NULL when any parameter is NULL or the worst-case result is to large ( >= SIZE_MAX).
+ *  @return Returns NULL when any parameter is NULL or the worst-case result is to large ( >= SIZE_MAX).
  *          Otherwise it returns a pointer to a new buffer containing the modified input
  */
 char *
@@ -48,7 +48,7 @@ searchandreplace(const char *tosearch, const char *searchfor, const char *replac
  * @param name  Environment variable to look up
  * @param envp  Environment variable table with all key/value pairs
  *
- * @return Returns a pointer to the value of the enviroment variable if found, otherwise NULL is returned.
+ * @return Returns a pointer to the value of the environment variable if found, otherwise NULL is returned.
  */
 const char *
 get_env(const char *name, const char *envp[]);
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index ed3c6e0b..db724e03 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -322,7 +322,7 @@ get_net_interface_guid(
  *                       property that is being retrieved. This is one of the standard
  *                       registry data types. This parameter is optional and can be NULL.
  *
- * @param ppData         A pointer to pointer to data that receives the device propery. The
+ * @param ppData         A pointer to pointer to data that receives the device property. The
  *                       data must be released with free() after use.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index b92cb65d..69866fb5 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -417,7 +417,7 @@ done
 
 if [ -z "$SUMMARY_OK" ] ; then SUMMARY_OK=" none"; fi
 if [ -z "$SUMMARY_FAIL" ] ; then SUMMARY_FAIL=" none"; fi
-echo "Test sets succeded:$SUMMARY_OK."
+echo "Test sets succeeded:$SUMMARY_OK."
 echo "Test sets failed:$SUMMARY_FAIL."
 
 # remove trap handler
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 17f7d899..b9e3a7a6 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -328,7 +328,7 @@ test_tls_crypt_v2_setup(void **state) {
 
     ctx->gc = gc_new();
 
-    /* Sligthly longer buffers to be able to test too-long data */
+    /* Slightly longer buffers to be able to test too-long data */
     ctx->metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN+16, &ctx->gc);
     ctx->unwrapped_metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN+16,
                                            &ctx->gc);
-- 
2.20.1.windows.1


