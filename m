From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 15 Nov 2016 14:29:46 +0100
Message-ID: <1479216586-20078-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1479203199-15297-1-git-send-email-steffan.karger@...1435...>
References: <1479203199-15297-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/5 v3] Add control channel encryption
	(--tls-crypt)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This adds a --tls-crypt option, which uses a pre-shared static key (like
the --tls-auth key) to encrypt control channel packets.

Encrypting control channel packets has three main advantages:

* It provides more privacy by hiding the certificate used for the TLS
  connection.
* It is harder to identify OpenVPN traffic as such.
* It provides "poor-man's" post-quantum security, against attackers who
  will never know the pre-shared key (i.e. no forward secrecy).

Control channel packet encryption
---------------------------------

We propose to use the following encryption method, based on the SIV
construction [0], to achieve nonce misuse-resistant authenticated
encryption:

   msg      = control channel plaintext
   header   = opcode (1 byte) || session_id (8 bytes) || packet_id (8 bytes)
   Ka       = authentication key (256 bits)
   Ke       = encryption key (256 bits)
   (Ka and Ke are pre-shared keys, like with --tls-auth)

   auth_tag = HMAC-SHA256(Ka, header || msg)
   IV       = 128 most-significant bits of auth_tag
   ciph     = AES256-CTR(Ke, IV, msg)

   output   = Header || Tag || Ciph

This boils down to the following on-the-wire packet format:

   -opcode- || -session_id- || -packet_id- || auth_tag || * payload *

   Where
   - XXX - means authenticated, and
   * XXX * means authenticated and encrypted.

Which is very similar to the current tls-auth packet format, and has the
same overhead as "--tls-auth" with "--auth SHA256".

The use of a nonce misuse-resistant authenticated encryption scheme
allows us to worry less about the risks of nonce collisions.  This is
important, because in contrast with the data channel in TLS mode, we
will not be able to rotate tls-crypt keys often or fully guarantee nonce
uniqueness.  For non misuse-resistant modes such as GCM [1], [2], the
data channel in TLS mode only has to ensure that the packet counter
never rolls over, while tls-crypt would have to provide nonce uniqueness
over all control channel packets sent by all clients, for the lifetime
of the tls-crypt key.

Unlike with tls-auth, no --key-direction has to be specified for
tls-crypt.  TLS servers always use key direction 1, and TLS clients
always use key direction 2, which means that client->server traffic and
server->client traffic always use different keys, without requiring
configuration.

Using fixed, secure, encryption and authentication algorithms makes both
implementation and configuration easier.  If we ever want to, we can
extend this to support other crypto primitives.  Since tls-crypt should
provide privacy as well as DoS protection, these should not be made
negotiable.

Security considerations:
------------------------

tls-crypt is a best-effort mechanism that aims to provide as much
privacy and security as possible, while staying as simple as possible.
The following are some security considerations for this scheme.

1. The same tls-crypt key is potentially shared by a lot of peers, so it
   is quite likely to get compromised.  Once an attacker acquires the
   tls-crypt key, this mechanism no longer provides any security against
   the attacker.

2. Since many peers potentially use the tls-crypt key for a long time, a
   lot of data might be encrypted under the tls-crypt key.  This leads
   to two potential problems:

   * The "opcode || session id || packet id" combination might collide.
     This might happen in larger setups, because the session id contains
     just 64 bits or random.  Using the uniqueness requirement from the
     GCM spec [3] (a collision probability of less than 2^(-32)),
     uniqueness is achieved when using the tls-crypt key for at most
     2^16 (65536) connections per process start.  (The packet id
     includes the daemon start time in the packet ID, which should be
     different after stopping and (re)starting OpenPVN.)

     And if a collision happens, an attacker can *only* learn whether
     colliding packets contain the same plaintext.  Attackers will not
     be able to learn anything else about the plaintext (unless the
     attacker knows the plaintext of one of these packets, of course).
     Since the impact is limited, I consider this an acceptable
     remaining risk.

   * The IVs used in encryption might collide.  When two IVs collide, an
     attacker can learn the xor of the two plaintexts by xorring the
     ciphertexts.  This is a serious loss of confidentiality.  The IVs
     are 128-bit, so when HMAC-SHA256 is a secure PRF (an assumption
     that must also hold for TLS), and we use the same uniqueness
     requirement from [3], this limits the total amount of control
     channel messages for all peers in the setup to 2^48.  Assuming a
     large setup of 2^16 (65536) clients, and a (conservative) number of
     2^16 control channel packets per connection on average, this means
     that clients may set up 2^16 connections on average.  I think these
     numbers are reasonable.

(I have a follow-up proposal to use client-specific tls-auth/tls-crypt
keys to partially mitigate these issues, but let's tackle this patch
first.)

References:
-----------

[0] Rogaway & Shrimpton, A Provable-Security Treatment of the Key-Wrap
    Problem, 2006
    (https://www.iacr.org/archive/eurocrypt2006/40040377/40040377.pdf)

[1] Ferguson, Authentication weaknesses in GCM, 2005
    (http://csrc.nist.gov/groups/ST/toolkit/BCM/documents/comments/CWC-GCM/Ferguson2.pdf)

[2] Joux, Authentication Failures in NIST version of GCM, 2006
    (http://csrc.nist.gov/groups/ST/toolkit/BCM/documents/comments/800-38_Series-Drafts/GCM/Joux_comments.pdf)

[3] Dworking, Recommendation for Block Cipher Modes of Operation:
    Galois/Counter Mode (GCM) and GMAC, 2007
    (http://csrc.nist.gov/publications/nistpubs/800-38D/SP-800-38D.pdf)

Patch history:
--------------

v2 - processed Arne's review comments:

 * Error out early with a clear error message when AES-256-CTR or
   HMAC-SHA-256 are not supported by the crypto library.
 * Clarify that cipher_ctx_reset() sets the IV.

v3 - actually add error messages promised in v2...

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 Changes.rst              |   5 +
 doc/openvpn.8            |  39 +++++++-
 src/openvpn/Makefile.am  |   1 +
 src/openvpn/crypto.c     |  17 +---
 src/openvpn/crypto.h     |  18 ++++
 src/openvpn/init.c       |  30 ++++--
 src/openvpn/openvpn.h    |   4 +-
 src/openvpn/options.c    |  31 +++++-
 src/openvpn/options.h    |   8 +-
 src/openvpn/ssl.c        | 119 ++++++++++++++--------
 src/openvpn/ssl.h        |   2 +-
 src/openvpn/ssl_common.h |  18 +++-
 src/openvpn/tls_crypt.c  | 254 +++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/tls_crypt.h  | 144 +++++++++++++++++++++++++++
 14 files changed, 612 insertions(+), 78 deletions(-)
 create mode 100644 src/openvpn/tls_crypt.c
 create mode 100644 src/openvpn/tls_crypt.h

diff --git a/Changes.rst b/Changes.rst
index 2b99a1d..94fdb47 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -111,6 +111,11 @@ AIX platform support
 	AIX platform support has been added. The support only includes tap
     devices since AIX does not provide tun interface.
 
+Control channel encryption (``--tls-crypt``)
+    Use a pre-shared static key (like the ``--tls-auth`` key) to encrypt control
+    channel packets.  Provides more privacy, some obfuscation and poor-man's
+    post-quantum security.
+
 
 Deprecated features
 -------------------
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 7227d22..4c52cb6 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3471,8 +3471,10 @@ DoS scenario, legitimate connections might also be refused.
 For the best protection against DoS attacks in server mode,
 use
 .B \-\-proto udp
-and
-.B \-\-tls\-auth.
+and either
+.B \-\-tls\-auth
+or
+.B \-\-tls\-crypt\fR.
 .\"*********************************************************
 .TP
 .B \-\-learn\-address cmd
@@ -4938,8 +4940,8 @@ Exit on TLS negotiation failure.
 .\"*********************************************************
 .TP
 .B \-\-tls\-auth file [direction]
-Add an additional layer of HMAC authentication on top of the TLS
-control channel to protect against DoS attacks.
+Add an additional layer of HMAC authentication on top of the TLS control channel
+to mitigate DoS attacks and attacks on the TLS stack.
 
 In a nutshell,
 .B \-\-tls\-auth
@@ -5010,12 +5012,39 @@ option which will keep OpenVPN's replay protection state
 in a file so that it is not lost across restarts.
 
 It should be emphasized that this feature is optional and that the
-passphrase/key file used with
+key file used with
 .B \-\-tls\-auth
 gives a peer nothing more than the power to initiate a TLS
 handshake.  It is not used to encrypt or authenticate any tunnel data.
 .\"*********************************************************
 .TP
+.B \-\-tls\-crypt keyfile
+
+Encrypt and authenticate all control channel packets with the key from
+.B keyfile.
+(See
+.B \-\-tls\-auth
+for more background.)
+
+Encrypting (and authenticating) control channel packets:
+.RS
+.IP \[bu] 2
+provides more privacy by hiding the certificate used for the TLS connection,
+.IP \[bu]
+makes it harder to identify OpenVPN traffic as such,
+.IP \[bu]
+provides "poor-man's" post-quantum security, against attackers who will never
+know the pre-shared key (i.e. no forward secrecy).
+.RE
+
+.IP
+In contrast to
+.B \-\-tls\-auth\fR,
+.B \-\-tls\-crypt
+does *not* require the user to set
+.B \-\-key\-direction\fR.
+.\"*********************************************************
+.TP
 .B \-\-askpass [file]
 Get certificate password from console or
 .B file
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 12b9ebf..4c18449 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -113,6 +113,7 @@ openvpn_SOURCES = \
 	ssl_verify_mbedtls.c ssl_verify_mbedtls.h \
 	status.c status.h \
 	syshead.h \
+	tls_crypt.c tls_crypt.h \
 	tun.c tun.h \
 	win32.h win32.c \
 	cryptoapi.h cryptoapi.c
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 8b2f460..05622ce 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2016 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -63,9 +63,6 @@
  * happen unless the frame parameters are wrong.
  */
 
-#define CRYPT_ERROR(format) \
-  do { msg (D_CRYPT_ERRORS, "%s: " format, error_prefix); goto error_exit; } while (false)
-
 static void
 openvpn_encrypt_aead (struct buffer *buf, struct buffer work,
 	 struct crypto_options *opt) {
@@ -326,17 +323,7 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
     }
 }
 
-/**
- * Check packet ID for replay, and perform replay administration.
- *
- * @param opt	Crypto options for this packet, contains replay state.
- * @param pin	Packet ID read from packet.
- * @param error_prefix	Prefix to use when printing error messages.
- * @param gc	Garbage collector to use.
- *
- * @return true if packet ID is validated to be not a replay, false otherwise.
- */
-static bool crypto_check_replay(struct crypto_options *opt,
+bool crypto_check_replay(struct crypto_options *opt,
     const struct packet_id_net *pin, const char *error_prefix,
     struct gc_arena *gc) {
   bool ret = false;
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index bc9630a..ff90745 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -266,6 +266,9 @@ struct crypto_options
                                  *   security operation functions. */
 };
 
+#define CRYPT_ERROR(format) \
+  do { msg (D_CRYPT_ERRORS, "%s: " format, error_prefix); goto error_exit; } while (false)
+
 /**
  * Minimal IV length for AEAD mode ciphers (in bytes):
  * 4-byte packet id + 8 bytes implicit IV.
@@ -397,6 +400,21 @@ bool openvpn_decrypt (struct buffer *buf, struct buffer work,
 
 /** @} name Functions for performing security operations on data channel packets */
 
+/**
+ * Check packet ID for replay, and perform replay administration.
+ *
+ * @param opt	Crypto options for this packet, contains replay state.
+ * @param pin	Packet ID read from packet.
+ * @param error_prefix	Prefix to use when printing error messages.
+ * @param gc	Garbage collector to use.
+ *
+ * @return true if packet ID is validated to be not a replay, false otherwise.
+ */
+bool crypto_check_replay(struct crypto_options *opt,
+    const struct packet_id_net *pin, const char *error_prefix,
+    struct gc_arena *gc);
+
+
 /** Calculate crypto overhead and adjust frame to account for that */
 void crypto_adjust_frame_parameters(struct frame *frame,
 				    const struct key_type* kt,
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index eaa5e79..ec1adc4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -44,6 +44,7 @@
 #include "ping.h"
 #include "mstats.h"
 #include "ssl_verify.h"
+#include "tls_crypt.h"
 #include "forward-inline.h"
 
 #include "memdbg.h"
@@ -2078,7 +2079,7 @@ key_schedule_free (struct key_schedule *ks, bool free_ssl_ctx)
   if (tls_ctx_initialised(&ks->ssl_ctx) && free_ssl_ctx)
     {
       tls_ctx_free (&ks->ssl_ctx);
-      free_key_ctx_bi (&ks->tls_auth_key);
+      free_key_ctx_bi (&ks->tls_wrap_key);
     }
 #endif /* ENABLE_CRYPTO */
   CLEAR (*ks);
@@ -2235,11 +2236,17 @@ do_init_crypto_tls_c1 (struct context *c)
 	    }
 
 	  crypto_read_openvpn_key (&c->c1.ks.tls_auth_key_type,
-	      &c->c1.ks.tls_auth_key, options->tls_auth_file,
+	      &c->c1.ks.tls_wrap_key, options->tls_auth_file,
 	      options->tls_auth_file_inline, options->key_direction,
 	      "Control Channel Authentication", "tls-auth");
 	}
 
+      /* TLS handshake encryption+authentication (--tls-crypt) */
+      if (options->tls_crypt_file) {
+	  tls_crypt_init_key (&c->c1.ks.tls_wrap_key, options->tls_crypt_file,
+	      options->tls_crypt_inline, options->tls_server);
+      }
+
       c->c1.ciphername = options->ciphername;
       c->c1.authname = options->authname;
 
@@ -2418,14 +2425,25 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   /* TLS handshake authentication (--tls-auth) */
   if (options->tls_auth_file)
     {
-      to.tls_auth.key_ctx_bi = c->c1.ks.tls_auth_key;
-      to.tls_auth.pid_persist = &c->c1.pid_persist;
-      to.tls_auth.flags |= CO_PACKET_ID_LONG_FORM;
+      to.tls_wrap.mode = TLS_WRAP_AUTH;
+      to.tls_wrap.opt.key_ctx_bi = c->c1.ks.tls_wrap_key;
+      to.tls_wrap.opt.pid_persist = &c->c1.pid_persist;
+      to.tls_wrap.opt.flags |= CO_PACKET_ID_LONG_FORM;
       crypto_adjust_frame_parameters (&to.frame,
 				      &c->c1.ks.tls_auth_key_type,
 				      false, true, true);
     }
 
+  /* TLS handshake encryption (--tls-crypt) */
+  if (options->tls_crypt_file)
+    {
+      to.tls_wrap.mode = TLS_WRAP_CRYPT;
+      to.tls_wrap.opt.key_ctx_bi = c->c1.ks.tls_wrap_key;
+      to.tls_wrap.opt.pid_persist = &c->c1.pid_persist;
+      to.tls_wrap.opt.flags |= CO_PACKET_ID_LONG_FORM;
+      tls_crypt_adjust_frame_parameters (&to.frame);
+    }
+
   /* If we are running over TCP, allow for
      length prefix */
   socket_adjust_frame_parameters (&to.frame, options->ce.proto);
@@ -3789,7 +3807,7 @@ inherit_context_child (struct context *dest,
   dest->c1.ks.key_type = src->c1.ks.key_type;
   /* inherit SSL context */
   dest->c1.ks.ssl_ctx = src->c1.ks.ssl_ctx;
-  dest->c1.ks.tls_auth_key = src->c1.ks.tls_auth_key;
+  dest->c1.ks.tls_wrap_key = src->c1.ks.tls_wrap_key;
   dest->c1.ks.tls_auth_key_type = src->c1.ks.tls_auth_key_type;
 #endif
 
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 5cda7b4..9e6a5fb 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -65,9 +65,9 @@ struct key_schedule
   /* our global SSL context */
   struct tls_root_ctx ssl_ctx;
 
-  /* optional authentication HMAC key for TLS control channel */
+  /* optional TLS control channel wrapping */
   struct key_type tls_auth_key_type;
-  struct key_ctx_bi tls_auth_key;
+  struct key_ctx_bi tls_wrap_key;
 #else				/* ENABLE_CRYPTO */
   int dummy;
 #endif				/* ENABLE_CRYPTO */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 443f96b..8b225cd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -610,10 +610,17 @@ static const char usage_message[] =
   "--single-session: Allow only one session (reset state on restart).\n"
   "--tls-exit      : Exit on TLS negotiation failure.\n"
   "--tls-auth f [d]: Add an additional layer of authentication on top of the TLS\n"
-  "                  control channel to protect against DoS attacks.\n"
-  "                  f (required) is a shared-secret passphrase file.\n"
+  "                  control channel to protect against attacks on the TLS stack\n"
+  "                  and DoS attacks.\n"
+  "                  f (required) is a shared-secret key file.\n"
   "                  The optional d parameter controls key directionality,\n"
   "                  see --secret option for more info.\n"
+  "--tls-crypt key : Add an additional layer of authenticated encryption on top\n"
+  "                  of the TLS control channel to hide the TLS certificate,\n"
+  "                  provide basic post-quantum security and protect against\n"
+  "                  attacks on the TLS stack and DoS attacks.\n"
+  "                  key (required) provides the pre-shared key file.\n"
+  "                  see --secret option for more info.\n"
   "--askpass [file]: Get PEM password from controlling tty before we daemonize.\n"
   "--auth-nocache  : Don't cache --askpass or --auth-user-pass passwords.\n"
   "--crl-verify crl ['dir']: Check peer certificate against a CRL.\n"
@@ -1709,6 +1716,7 @@ show_settings (const struct options *o)
   SHOW_BOOL (tls_exit);
 
   SHOW_STR (tls_auth_file);
+  SHOW_STR (tls_crypt_file);
 #endif /* ENABLE_CRYPTO */
 
 #ifdef ENABLE_PKCS11
@@ -2383,6 +2391,10 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	      notnull (options->priv_key_file, "private key file (--key) or PKCS#12 file (--pkcs12)");
 	    }
 	}
+    if (options->tls_auth_file && options->tls_crypt_file)
+      {
+        msg (M_USAGE, "--tls-auth and --tls-crypt are mutually exclusive");
+      }
     }
   else
     {
@@ -2414,6 +2426,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       MUST_BE_UNDEF (handshake_window);
       MUST_BE_UNDEF (transition_window);
       MUST_BE_UNDEF (tls_auth_file);
+      MUST_BE_UNDEF (tls_crypt_file);
       MUST_BE_UNDEF (single_session);
 #ifdef ENABLE_PUSH_PEER_INFO
       MUST_BE_UNDEF (push_peer_info);
@@ -2892,6 +2905,8 @@ options_postprocess_filechecks (struct options *options)
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
 			     options->tls_auth_file, R_OK, "--tls-auth");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+			     options->tls_crypt_file, R_OK, "--tls-crypt");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
 			     options->shared_secret_file, R_OK, "--secret");
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR,
 			     options->packet_id_file, R_OK|W_OK, "--replay-persist");
@@ -3232,6 +3247,9 @@ options_string (const struct options *o,
       {
 	if (o->tls_auth_file)
 	  buf_printf (&out, ",tls-auth");
+	/* Not adding tls-crypt here, because we won't reach this code if
+	 * tls-auth/tls-crypt does not match.  Removing tls-auth here would
+	 * break stuff, so leaving that in place. */
 
 	if (o->key_method > 1)
 	  buf_printf (&out, ",key-method %d", o->key_method);
@@ -7254,6 +7272,15 @@ add_option (struct options *options,
 	}
       options->tls_auth_file = p[1];
     }
+  else if (streq (p[0], "tls-crypt") && p[1] && !p[3])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      if (streq (p[1], INLINE_FILE_TAG) && p[2])
+	{
+	  options->tls_crypt_inline = p[2];
+	}
+      options->tls_crypt_file = p[1];
+    }
   else if (streq (p[0], "key-method") && p[1] && !p[2])
     {
       int key_method;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d51150b..a028556 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -558,10 +558,14 @@ struct options
   /* Old key allowed to live n seconds after new key goes active */
   int transition_window;
 
-  /* Special authentication MAC for TLS control channel */
-  const char *tls_auth_file;		/* shared secret */
+  /* Shared secret used for TLS control channel authentication */
+  const char *tls_auth_file;
   const char *tls_auth_file_inline;
 
+  /* Shared secret used for TLS control channel authenticated encryption */
+  const char *tls_crypt_file;
+  const char *tls_crypt_inline;
+
   /* Allow only one session */
   bool single_session;
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5803cd4..3fc9207 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -57,6 +57,7 @@
 #include "gremlin.h"
 #include "pkcs11.h"
 #include "route.h"
+#include "tls_crypt.h"
 
 #include "ssl.h"
 #include "ssl_verify.h"
@@ -965,16 +966,18 @@ tls_session_init (struct tls_multi *multi, struct tls_session *session)
     }
 
   /* Initialize control channel authentication parameters */
-  session->tls_auth = session->opt->tls_auth;
+  session->tls_wrap = session->opt->tls_wrap;
+  session->tls_wrap.work = alloc_buf (TLS_CHANNEL_BUF_SIZE);
 
   /* initialize packet ID replay window for --tls-auth */
-  packet_id_init (&session->tls_auth.packet_id,
+  packet_id_init (&session->tls_wrap.opt.packet_id,
 		  session->opt->replay_window,
 		  session->opt->replay_time,
-		  "TLS_AUTH", session->key_id);
+		  "TLS_WRAP", session->key_id);
 
   /* load most recent packet-id to replay protect on --tls-auth */
-  packet_id_persist_load_obj (session->tls_auth.pid_persist, &session->tls_auth.packet_id);
+  packet_id_persist_load_obj (session->tls_wrap.opt.pid_persist,
+      &session->tls_wrap.opt.packet_id);
 
   key_state_init (session, &session->key[KS_PRIMARY]);
 
@@ -1001,8 +1004,10 @@ tls_session_free (struct tls_session *session, bool clear)
 {
   int i;
 
-  if (packet_id_initialized(&session->tls_auth.packet_id))
-    packet_id_free (&session->tls_auth.packet_id);
+  if (packet_id_initialized(&session->tls_wrap.opt.packet_id))
+    packet_id_free (&session->tls_wrap.opt.packet_id);
+
+  free_buf (&session->tls_wrap.work);
 
   for (i = 0; i < KS_SIZE; ++i)
     key_state_free (&session->key[i], false);
@@ -1134,9 +1139,14 @@ tls_auth_standalone_init (struct tls_options *tls_options,
 
   ALLOC_OBJ_CLEAR_GC (tas, struct tls_auth_standalone, gc);
 
-  /* set up pointer to HMAC object for TLS packet authentication */
-  tas->tls_auth_options.key_ctx_bi = tls_options->tls_auth.key_ctx_bi;
-  tas->tls_auth_options.flags |= CO_PACKET_ID_LONG_FORM;
+  tas->tls_wrap = tls_options->tls_wrap;
+
+  /*
+   * Standalone tls-auth is in read-only mode with respect to TLS
+   * control channel state.  After we build a new client instance
+   * object, we will process this session-initiating packet for real.
+   */
+  tas->tls_wrap.opt.flags |= CO_IGNORE_PACKET_ID;
 
   /* get initial frame parms, still need to finalize */
   tas->frame = tls_options->frame;
@@ -1283,20 +1293,34 @@ write_control_auth (struct tls_session *session,
 		    int max_ack,
 		    bool prepend_ack)
 {
-  uint8_t *header;
+  uint8_t header = ks->key_id | (opcode << P_OPCODE_SHIFT);
   struct buffer null = clear_buf ();
 
   ASSERT (link_socket_actual_defined (&ks->remote_addr));
   ASSERT (reliable_ack_write
 	  (ks->rec_ack, buf, &ks->session_id_remote, max_ack, prepend_ack));
-  ASSERT (session_id_write_prepend (&session->session_id, buf));
-  ASSERT (header = buf_prepend (buf, 1));
-  *header = ks->key_id | (opcode << P_OPCODE_SHIFT);
-  if (session->tls_auth.key_ctx_bi.encrypt.hmac)
+
+  if (session->tls_wrap.mode == TLS_WRAP_AUTH ||
+      session->tls_wrap.mode == TLS_WRAP_NONE)
+    {
+      ASSERT (session_id_write_prepend (&session->session_id, buf));
+      ASSERT (buf_write_prepend (buf, &header, sizeof(header)));
+    }
+  if (session->tls_wrap.mode == TLS_WRAP_AUTH)
     {
       /* no encryption, only write hmac */
-      openvpn_encrypt (buf, null, &session->tls_auth);
-      ASSERT (swap_hmac (buf, &session->tls_auth, false));
+      openvpn_encrypt (buf, null, &session->tls_wrap.opt);
+      ASSERT (swap_hmac (buf, &session->tls_wrap.opt, false));
+    }
+  else if (session->tls_wrap.mode == TLS_WRAP_CRYPT)
+    {
+      buf_init (&session->tls_wrap.work, buf->offset);
+      ASSERT (buf_write (&session->tls_wrap.work, &header, sizeof(header)));
+      ASSERT (session_id_write (&session->session_id, &session->tls_wrap.work));
+      ASSERT (tls_crypt_wrap (buf, &session->tls_wrap.work, &session->tls_wrap.opt));
+      /* Don't change the original data in buf, it's used by the reliability
+       * layer to resend on failure. */
+      *buf = session->tls_wrap.work;
     }
   *to_link_addr = &ks->remote_addr;
 }
@@ -1306,17 +1330,18 @@ write_control_auth (struct tls_session *session,
  */
 static bool
 read_control_auth (struct buffer *buf,
-		   struct crypto_options *co,
+		   struct tls_wrap_ctx *ctx,
 		   const struct link_socket_actual *from)
 {
   struct gc_arena gc = gc_new ();
+  bool ret = false;
 
-  if (co->key_ctx_bi.decrypt.hmac)
+  if (ctx->mode == TLS_WRAP_AUTH)
     {
       struct buffer null = clear_buf ();
 
       /* move the hmac record to the front of the packet */
-      if (!swap_hmac (buf, co, true))
+      if (!swap_hmac (buf, &ctx->opt, true))
 	{
 	  msg (D_TLS_ERRORS,
 	       "TLS Error: cannot locate HMAC in incoming packet from %s",
@@ -1327,24 +1352,41 @@ read_control_auth (struct buffer *buf,
 
       /* authenticate only (no decrypt) and remove the hmac record
          from the head of the buffer */
-      openvpn_decrypt (buf, null, co, NULL, BPTR (buf));
+      openvpn_decrypt (buf, null, &ctx->opt, NULL, BPTR (buf));
       if (!buf->len)
 	{
 	  msg (D_TLS_ERRORS,
 	       "TLS Error: incoming packet authentication failed from %s",
 	       print_link_socket_actual (from, &gc));
-	  gc_free (&gc);
-	  return false;
+	  goto cleanup;
 	}
 
     }
+  else if (ctx->mode == TLS_WRAP_CRYPT)
+    {
+      struct buffer tmp = alloc_buf (buf_forward_capacity_total (buf));
+      if (!tls_crypt_unwrap (buf, &tmp, &ctx->opt))
+	{
+	  msg (D_TLS_ERRORS, "TLS Error: tls-crypt unwrapping failed from %s",
+	      print_link_socket_actual (from, &gc));
+	  goto cleanup;
+	}
+      ASSERT (buf_init (buf, buf->offset));
+      ASSERT (buf_copy (buf, &tmp));
+      free_buf (&tmp);
+    }
 
-  /* advance buffer pointer past opcode & session_id since our caller
-     already read it */
-  buf_advance (buf, SID_SIZE + 1);
+  if (ctx->mode == TLS_WRAP_NONE || ctx->mode == TLS_WRAP_AUTH)
+    {
+      /* advance buffer pointer past opcode & session_id since our caller
+	 already read it */
+      buf_advance (buf, SID_SIZE + 1);
+    }
 
+  ret = true;
+cleanup:
   gc_free (&gc);
-  return true;
+  return ret;
 }
 
 /*
@@ -2716,11 +2758,11 @@ tls_process (struct tls_multi *multi,
   /* Send 1 or more ACKs (each received control packet gets one ACK) */
   if (!to_link->len && !reliable_ack_empty (ks->rec_ack))
     {
-      buf = &ks->ack_write_buf;
-      ASSERT (buf_init (buf, FRAME_HEADROOM (&multi->opt.frame)));
-      write_control_auth (session, ks, buf, to_link_addr, P_ACK_V1,
+      struct buffer buf = ks->ack_write_buf;
+      ASSERT (buf_init (&buf, FRAME_HEADROOM (&multi->opt.frame)));
+      write_control_auth (session, ks, &buf, to_link_addr, P_ACK_V1,
 			  RELIABLE_ACK_SIZE, false);
-      *to_link = *buf;
+      *to_link = buf;
       active = true;
       state_change = true;
       dmsg (D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
@@ -3218,7 +3260,7 @@ tls_pre_decrypt (struct tls_multi *multi,
 		  goto error;
 		}
 
-	      if (!read_control_auth (buf, &session->tls_auth, from))
+	      if (!read_control_auth (buf, &session->tls_wrap, from))
 		goto error;
 
 	      /*
@@ -3269,7 +3311,7 @@ tls_pre_decrypt (struct tls_multi *multi,
 	      if (op == P_CONTROL_SOFT_RESET_V1
 		  && DECRYPT_KEY_ENABLED (multi, ks))
 		{
-		  if (!read_control_auth (buf, &session->tls_auth, from))
+		  if (!read_control_auth (buf, &session->tls_wrap, from))
 		    goto error;
 
 		  key_state_soft_reset (session);
@@ -3286,7 +3328,7 @@ tls_pre_decrypt (struct tls_multi *multi,
 		  if (op == P_CONTROL_SOFT_RESET_V1)
 		    do_burst = true;
 
-		  if (!read_control_auth (buf, &session->tls_auth, from))
+		  if (!read_control_auth (buf, &session->tls_wrap, from))
 		    goto error;
 
 		  dmsg (D_TLS_DEBUG,
@@ -3483,18 +3525,11 @@ tls_pre_decrypt_lite (const struct tls_auth_standalone *tas,
 
       {
 	struct buffer newbuf = clone_buf (buf);
-	struct crypto_options co = tas->tls_auth_options;
+	struct tls_wrap_ctx tls_wrap_tmp = tas->tls_wrap;
 	bool status;
 
-	/*
-	 * We are in read-only mode at this point with respect to TLS
-	 * control channel state.  After we build a new client instance
-	 * object, we will process this session-initiating packet for real.
-	 */
-	co.flags |= CO_IGNORE_PACKET_ID;
-
 	/* HMAC test, if --tls-auth was specified */
-	status = read_control_auth (&newbuf, &co, from);
+	status = read_control_auth (&newbuf, &tls_wrap_tmp, from);
 	free_buf (&newbuf);
 	if (!status)
 	  goto error;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index e6963a4..777b621 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -136,7 +136,7 @@
  */
 struct tls_auth_standalone
 {
-  struct crypto_options tls_auth_options;
+  struct tls_wrap_ctx tls_wrap;
   struct frame frame;
 };
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index b04a24c..28702af 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -204,6 +204,18 @@ struct key_state
 #endif
 };
 
+/** Control channel wrapping (--tls-auth/--tls-crypt) context */
+struct tls_wrap_ctx
+{
+  enum {
+    TLS_WRAP_NONE = 0,	/**< No control channel wrapping */
+    TLS_WRAP_AUTH,	/**< Control channel authentication */
+    TLS_WRAP_CRYPT,	/**< Control channel encryption and authentication */
+  } mode;			/**< Control channel wrapping mode */
+  struct crypto_options opt;	/**< Crypto state */
+  struct buffer work;		/**< Work buffer (only for --tls-crypt) */
+};
+
 /*
  * Our const options, obtained directly or derived from
  * command line options.
@@ -278,8 +290,8 @@ struct tls_options
   const char *config_authname;
   bool ncp_enabled;
 
-  /* packet authentication for TLS handshake */
-  struct crypto_options tls_auth;
+  /** TLS handshake wrapping state */
+  struct tls_wrap_ctx tls_wrap;
 
   /* frame parameters for TLS control channel */
   struct frame frame;
@@ -380,7 +392,7 @@ struct tls_session
   bool burst;
 
   /* authenticate control packets */
-  struct crypto_options tls_auth;
+  struct tls_wrap_ctx tls_wrap;
 
   int initial_opcode;		/* our initial P_ opcode */
   struct session_id session_id;	/* our random session ID */
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
new file mode 100644
index 0000000..d40532e
--- /dev/null
+++ b/src/openvpn/tls_crypt.c
@@ -0,0 +1,254 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#ifdef ENABLE_CRYPTO
+#include "crypto.h"
+#include "session_id.h"
+
+#include "tls_crypt.h"
+
+int tls_crypt_buf_overhead(void)
+{
+  return packet_id_size (true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_SIZE;
+}
+
+void
+tls_crypt_init_key (struct key_ctx_bi *key, const char *key_file,
+    const char *key_inline, bool tls_server) {
+  const int key_direction = tls_server ?
+      KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
+
+  struct key_type kt;
+  kt.cipher = cipher_kt_get ("AES-256-CTR");
+  kt.cipher_length = cipher_kt_key_size (kt.cipher);
+  kt.digest = md_kt_get ("SHA256");
+  kt.hmac_length = md_kt_size (kt.digest);
+
+  if (!kt.cipher)
+    {
+      msg (M_FATAL, "ERROR: --tls-crypt requires AES-256-CTR support.");
+    }
+  if (!kt.digest)
+    {
+      msg (M_FATAL, "ERROR: --tls-crypt requires HMAC-SHA-256 support.");
+    }
+
+  crypto_read_openvpn_key (&kt, key, key_file, key_inline, key_direction,
+			   "Control Channel Encryption", "tls-crypt");
+}
+
+void
+tls_crypt_adjust_frame_parameters(struct frame *frame)
+{
+  frame_add_to_extra_frame (frame, tls_crypt_buf_overhead());
+
+  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for tls-crypt by %i bytes",
+      __func__, tls_crypt_buf_overhead());
+}
+
+
+bool
+tls_crypt_wrap (const struct buffer *src, struct buffer *dst,
+	 struct crypto_options *opt) {
+  const struct key_ctx *ctx = &opt->key_ctx_bi.encrypt;
+  struct gc_arena gc;
+
+  /* IV, packet-ID and implicit IV required for this mode. */
+  ASSERT (ctx->cipher);
+  ASSERT (ctx->hmac);
+  ASSERT (packet_id_initialized(&opt->packet_id));
+  ASSERT (hmac_ctx_size(ctx->hmac) == 256/8);
+
+  gc_init (&gc);
+
+  dmsg (D_PACKET_CONTENT, "TLS-CRYPT WRAP FROM: %s",
+      format_hex (BPTR (src), BLEN (src), 80, &gc));
+
+  /* Get packet ID */
+  {
+    struct packet_id_net pin;
+    packet_id_alloc_outgoing (&opt->packet_id.send, &pin, true);
+    packet_id_write (&pin, dst, true, false);
+  }
+
+  dmsg (D_PACKET_CONTENT, "TLS-CRYPT WRAP AD: %s",
+      format_hex (BPTR (dst), BLEN (dst), 0, &gc));
+
+  /* Buffer overflow check */
+  if (!buf_safe (dst, BLEN (src) + TLS_CRYPT_BLOCK_SIZE + TLS_CRYPT_TAG_SIZE))
+    {
+      msg (D_CRYPT_ERRORS, "TLS-CRYPT WRAP: buffer size error, "
+	  "sc=%d so=%d sl=%d dc=%d do=%d dl=%d", src->capacity, src->offset,
+	  src->len, dst->capacity, dst->offset, dst->len);
+      goto err;
+    }
+
+  /* Calculate auth tag and synthetic IV */
+  {
+    uint8_t *tag = NULL;
+    hmac_ctx_reset (ctx->hmac);
+    hmac_ctx_update (ctx->hmac, BPTR (dst), BLEN (dst));
+    hmac_ctx_update (ctx->hmac, BPTR (src), BLEN (src));
+
+    ASSERT (tag = buf_write_alloc (dst, TLS_CRYPT_TAG_SIZE));
+    hmac_ctx_final (ctx->hmac, tag);
+
+    dmsg (D_PACKET_CONTENT, "TLS-CRYPT WRAP TAG: %s",
+        format_hex (tag, TLS_CRYPT_TAG_SIZE, 0, &gc));
+
+    /* Use the 128 most significant bits of the tag as IV */
+    ASSERT (cipher_ctx_reset (ctx->cipher, tag));
+  }
+
+  /* Encrypt src */
+  {
+    int outlen = 0;
+    ASSERT (cipher_ctx_update (ctx->cipher, BEND (dst), &outlen,
+	BPTR (src), BLEN(src)));
+    ASSERT (buf_inc_len (dst, outlen));
+    ASSERT (cipher_ctx_final (ctx->cipher, BPTR (dst), &outlen));
+    ASSERT (buf_inc_len (dst, outlen));
+  }
+
+  dmsg (D_PACKET_CONTENT, "TLS-CRYPT WRAP TO: %s",
+      format_hex (BPTR (dst), BLEN (dst), 80, &gc));
+
+  gc_free (&gc);
+  return true;
+
+err:
+  crypto_clear_error();
+  dst->len = 0;
+  gc_free (&gc);
+  return false;
+}
+
+bool
+tls_crypt_unwrap (const struct buffer *src, struct buffer *dst,
+    struct crypto_options *opt)
+{
+  static const char error_prefix[] = "tls-crypt unwrap error";
+  const struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
+  struct gc_arena gc;
+
+  gc_init (&gc);
+
+  ASSERT (opt);
+  ASSERT (src->len > 0);
+  ASSERT (ctx->cipher);
+  ASSERT (packet_id_initialized (&opt->packet_id) ||
+      (opt->flags & CO_IGNORE_PACKET_ID));
+
+  dmsg (D_PACKET_CONTENT, "TLS-CRYPT UNWRAP FROM: %s",
+      format_hex (BPTR (src), BLEN (src), 80, &gc));
+
+  if (buf_len (src) < TLS_CRYPT_OFF_CT)
+    {
+      CRYPT_ERROR ("packet too short");
+    }
+
+  /* Decrypt cipher text */
+  {
+    int outlen = 0;
+
+    /* Buffer overflow check (should never fail) */
+    if (!buf_safe (dst, BLEN (src) - TLS_CRYPT_OFF_CT + TLS_CRYPT_BLOCK_SIZE))
+      {
+	CRYPT_ERROR ("potential buffer overflow");
+      }
+
+    if (!cipher_ctx_reset (ctx->cipher, BPTR (src) + TLS_CRYPT_OFF_TAG))
+      {
+	CRYPT_ERROR ("cipher reset failed");
+      }
+    if (!cipher_ctx_update (ctx->cipher, BPTR (dst), &outlen,
+	BPTR (src) + TLS_CRYPT_OFF_CT, BLEN (src) - TLS_CRYPT_OFF_CT))
+      {
+	CRYPT_ERROR ("cipher update failed");
+      }
+    ASSERT (buf_inc_len (dst, outlen));
+    if (!cipher_ctx_final (ctx->cipher, BPTR(dst), &outlen))
+      {
+	CRYPT_ERROR ("cipher final failed");
+      }
+    ASSERT (buf_inc_len (dst, outlen));
+  }
+
+  /* Check authentication */
+  {
+    const uint8_t *tag = BPTR (src) + TLS_CRYPT_OFF_TAG;
+    uint8_t tag_check[TLS_CRYPT_TAG_SIZE] = { 0 };
+
+    dmsg (D_PACKET_CONTENT, "TLS-CRYPT UNWRAP AD: %s",
+        format_hex (BPTR (src), TLS_CRYPT_OFF_TAG, 0, &gc));
+    dmsg (D_PACKET_CONTENT, "TLS-CRYPT UNWRAP TO: %s",
+         format_hex (BPTR (dst), BLEN (dst), 80, &gc));
+
+    hmac_ctx_reset (ctx->hmac);
+    hmac_ctx_update (ctx->hmac, BPTR (src), TLS_CRYPT_OFF_TAG);
+    hmac_ctx_update (ctx->hmac, BPTR (dst), BLEN (dst));
+    hmac_ctx_final (ctx->hmac, tag_check);
+
+    if (memcmp_constant_time (tag, tag_check, sizeof(tag_check)))
+      {
+	dmsg (D_CRYPTO_DEBUG, "tag      : %s",
+	    format_hex (tag, sizeof(tag_check), 0, &gc));
+	dmsg (D_CRYPTO_DEBUG, "tag_check: %s",
+	    format_hex (tag_check, sizeof(tag_check), 0, &gc));
+	CRYPT_ERROR ("packet authentication failed");
+      }
+  }
+
+  /* Check replay */
+  if (!(opt->flags & CO_IGNORE_PACKET_ID))
+    {
+      struct packet_id_net pin;
+      struct buffer tmp = *src;
+      ASSERT (buf_advance (&tmp, TLS_CRYPT_OFF_PID));
+      ASSERT (packet_id_read (&pin, &tmp, true));
+      if (!crypto_check_replay (opt, &pin, error_prefix, &gc))
+	{
+	  CRYPT_ERROR ("packet replay");
+	}
+    }
+
+  gc_free (&gc);
+  return true;
+
+ error_exit:
+  crypto_clear_error();
+  dst->len = 0;
+  gc_free (&gc);
+  return false;
+}
+
+#endif /* EMABLE_CRYPTO */
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
new file mode 100644
index 0000000..d1962c9
--- /dev/null
+++ b/src/openvpn/tls_crypt.h
@@ -0,0 +1,144 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @defgroup tls_crypt Control channel encryption (--tls-crypt)
+ * @ingroup control_tls
+ * @{
+ *
+ * @par
+ * Control channel encryption uses a pre-shared static key (like the --tls-auth
+ * key) to encrypt control channel packets.
+ *
+ * @par
+ * Encrypting control channel packets has three main advantages:
+ *  - It provides more privacy by hiding the certificate used for the TLS
+ *    connection.
+ *  - It is harder to identify OpenVPN traffic as such.
+ *  - It provides "poor-man's" post-quantum security, against attackers who
+ *    will never know the pre-shared key (i.e. no forward secrecy).
+ *
+ * @par Specification
+ * Control channel encryption is based on the SIV construction [0], to achieve
+ * nonce misuse-resistant authenticated encryption:
+ *
+ * @par
+ * \code{.unparsed}
+ * msg      = control channel plaintext
+ * header   = opcode (1 byte) || session_id (8 bytes) || packet_id (8 bytes)
+ * Ka       = authentication key (256 bits)
+ * Ke       = encryption key (256 bits)
+ * (Ka and Ke are pre-shared keys, like with --tls-auth)
+ *
+ * auth_tag = HMAC-SHA256(Ka, header || msg)
+ * IV       = 128 most-significant bits of auth_tag
+ * ciph     = AES256-CTR(Ke, IV, msg)
+ *
+ * output   = Header || Tag || Ciph
+ * \endcode
+ *
+ * @par
+ * This boils down to the following on-the-wire packet format:
+ *
+ * @par
+ * \code{.unparsed}
+ * - opcode - || - session_id - || - packet_id - || auth_tag || * payload *
+ * \endcode
+ *
+ * @par
+ * Where
+ * <tt>- XXX -</tt> means authenticated, and
+ * <tt>* XXX *</tt> means authenticated and encrypted.
+ */
+
+#ifndef TLSCRYPT_H
+#define TLSCRYPT_H
+
+#include "buffer.h"
+#include "crypto.h"
+#include "session_id.h"
+
+#define TLS_CRYPT_TAG_SIZE (256/8)
+#define TLS_CRYPT_PID_SIZE (sizeof (packet_id_type) + sizeof (net_time_t))
+#define TLS_CRYPT_BLOCK_SIZE (128/8)
+
+#define TLS_CRYPT_OFF_PID (1 + SID_SIZE)
+#define TLS_CRYPT_OFF_TAG (TLS_CRYPT_OFF_PID + TLS_CRYPT_PID_SIZE)
+#define TLS_CRYPT_OFF_CT (TLS_CRYPT_OFF_TAG + TLS_CRYPT_TAG_SIZE)
+
+/**
+ * Initialize a key_ctx_bi structure for use with --tls-crypt.
+ *
+ * @param key		The key context to initialize
+ * @param key_file	The file to read the key from (or the inline tag to
+ *			indicate and inline key).
+ * @param key_inline	Array containing (zero-terminated) inline key, or NULL
+ *			if not used.
+ * @param tls_server	Must be set to true is this is a TLS server instance.
+ */
+void tls_crypt_init_key (struct key_ctx_bi *key, const char *key_file,
+    const char *key_inline, bool tls_server);
+
+/**
+ * Returns the maximum overhead (in bytes) added to the destination buffer by
+ * tls_crypt_wrap().
+ */
+int tls_crypt_buf_overhead(void);
+
+/**
+ * Adjust frame parameters for --tls-crypt overhead.
+ */
+void tls_crypt_adjust_frame_parameters(struct frame *frame);
+
+/**
+ * Wrap a control channel packet (both authenticates and encrypts the data).
+ *
+ * @param src	Data to authenticate and encrypt.
+ * @param dst	Any data present in this buffer is first authenticated, then
+ *		the wrapped packet id and data from the src buffer are appended.
+ *		Must have at least tls_crypt_buf_overhead()+BLEN(src) headroom.
+ * @param opt	The crypto state for this --tls-crypt instance.
+ *
+ * @returns true iff wrapping succeeded.
+ */
+bool tls_crypt_wrap (const struct buffer *src, struct buffer *dst,
+	 struct crypto_options *opt);
+
+/**
+ * Unwrap a control channel packet (decrypts, authenticates and performs
+ * replay checks).
+ *
+ * @param src	Data to decrypt and authenticate.
+ * @param dst	Returns the decrypted data, if unwrapping was successful.
+ * @param opt	The crypto state for this --tls-crypt instance.
+ *
+ * @returns true iff unwrapping succeeded (data authenticated correctly and was
+ * no replay).
+ */
+bool tls_crypt_unwrap (const struct buffer *src, struct buffer *dst,
+    struct crypto_options *opt);
+
+/** @} */
+
+#endif /* TLSCRYPT_H */
-- 
2.7.4


