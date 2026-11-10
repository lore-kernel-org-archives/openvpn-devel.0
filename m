Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A6B606A326
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SC0kithn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PVENWF1L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=demwNiVK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WQaLFUAPa/HC4I+KmSW1Dwtwm5Pxk7S5YHe7PqKImCw=; b=SC0kithngK2NgH
	vOTufaexU8aHuqaBfEcG+azlPPQD3RomdRk138W+otpOieYAiMx81Zl4PogaS8jfLuSLMzdAOAk/D
	T9rM0oofN9is0gj0jwkJLs7zIWM78H/MaeUxEoLyq/7n1YLH9SF2xV1mhuJD42n9jEWPT7opAYasa
	Clg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQfpn-000000000In-3oLC;
	Tue, 10 Nov 2026 06:59:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQfpl-000000000Ie-0XcF for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 06:59:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4r06PspmZ8d6szaXOP3hFfCyqpiW1h6rnmRGisGXT1w=; b=PVENWF1LOxS1lkTrrgBcFgVDkL
 BPtFY+hyixHiw5fWfbgSAfQJFTjJnLpNHmMTCaaSQK9rmu9Z4yPhzL/uG2qd6Oh/nIBkvpZMoqq5H
 Vvr39jeAQWV7/QRCv5i4i9CI0LmS3yjVCnYeu8WefSLTPiJz5W89Q6vV/jR3L/B1pOHA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4r06PspmZ8d6szaXOP3hFfCyqpiW1h6rnmRGisGXT1w=; b=demwNiVK6QYu6P17alAIgFMYBx
 C0fkN43aXYFr29zYINwrU6QmU6NKTuUlEHo1jxKsnVm9Zf0A9u0pYkr9tGAqLkecroWnhUnnPwmNH
 e1ITofQH23aY1cY77ZtUksy9LdS+7aEFQnuqvu8F5z9us+KgpnO+R8TsEkaC/93nKpKA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQfph-000000003yu-0yg1 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 06:59:57 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AA6xkAt005923
 for <openvpn-devel@lists.sourceforge.net>; Tue, 10 Nov 2026 07:59:46 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AA6xk3v005922
 for openvpn-devel@lists.sourceforge.net; Tue, 10 Nov 2026 07:59:46 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 07:59:39 +0100
Message-ID: <20261110065945.5905-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQfph-000000003yu-0yg1
Subject: [Openvpn-devel] [PATCH v8] Remove support for --secret
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arne Schwabe <arne@rfc2549.org>

This has been announced for a long time and good alternatives exist.

Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2081
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2081
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/Changes.md b/Changes.md
index b5ae881..7f47f77 100644
--- a/Changes.md
+++ b/Changes.md
@@ -23,6 +23,13 @@
   the characters mentioned above were already escaped. However, the behavior of
   Mbed TLS is slightly different from OpenSSL in that it also escapes "=".
 
+* **`secret` has been removed**
+
+  Static key mode (non-TLS) is no longer considered "good and secure enough" for
+  today's requirements. Use TLS mode instead. If deploying a PKI CA is considered
+  "too complicated", using `--peer-fingerprint` makes TLS mode about as easy as
+  using `--secret`.
+
 ## Maintainer-visible changes
 
 - The configure-time option `--enable-debug` is no longer  available
diff --git a/INSTALL b/INSTALL
index 486b1ae..d0ffaf0 100644
--- a/INSTALL
+++ b/INSTALL
@@ -144,8 +144,7 @@
 
 Test Crypto:
 
-./openvpn --genkey secret key
-./openvpn --test-crypto --secret key
+./openvpn --test-crypto
 
 Test SSL/TLS negotiations (runs for 2 minutes):
 
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index 6815dc2..17e4372 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -108,7 +108,7 @@
   For example on Windows, use double backslashes to represent pathnames:
   ::
 
-      secret "c:\\OpenVPN\\secret.key"
+      tls-auth "c:\\OpenVPN\\secret.key"
 
 
   For examples of configuration files, see
@@ -119,7 +119,7 @@
 
       #
       # Sample OpenVPN configuration file for
-      # using a pre-shared static key.
+      # using a p2p connection.
       #
       # '#' or ';' may be used to delimit comments.
 
@@ -133,8 +133,11 @@
       # 10.1.0.2 is our remote VPN endpoint
       ifconfig 10.1.0.1 10.1.0.2
 
-      # Our pre-shared static key
-      secret static.key
+      # Our TLS configuration
+      tls-client
+      key mynode.key
+      cert mynode.crt
+      ca myca.crt
 
 --daemon progname
   Become a daemon after all initialization functions are completed.
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 52ce5a8..9e14787 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -44,12 +44,10 @@
   of the AEAD cipher is used instead. Note that ``alg`` still specifies
   the digest used for ``tls-auth``.
 
-  In static-key encryption mode, the HMAC key is included in the key file
-  generated by ``--genkey``. In TLS mode, the HMAC key is dynamically
-  generated and shared between peers via the TLS control channel. If
-  OpenVPN receives a packet with a bad HMAC it will drop the packet. HMAC
-  usually adds 16 or 20 bytes per packet. Set ``alg=none`` to disable
-  authentication.
+  The HMAC key is dynamically generated and shared between peers via the
+  TLS control channel. If OpenVPN receives a packet with a bad HMAC it
+  will drop the packet. HMAC usually adds 16 or 20 bytes per packet. Set
+  ``alg=none`` to disable authentication.
 
   For more information on HMAC see
   https://tools.ietf.org/html/rfc2104
@@ -212,11 +210,6 @@
   have been configured with ``--enable-small``
   (typically used on routers or other embedded devices).
 
-
---allow-deprecated-insecure-static-crypto
-   **DEPRECATED** This allow using OpenVPN without TLS. This is deprecated
-   and will be removed in OpenVPN 2.8.
-
 --tran-window n
   Transition window -- our old key can live this many seconds after a new
   a key renegotiation begins (default :code:`3600` seconds). This feature
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index c273905..2794f12 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -70,3 +70,12 @@
   Removed in OpenVPN 2.8. This option caused the Mbed TLS 3 random number
   generator to be reseeded on every call. It has been removed because this
   is excessive.
+
+--secret
+  Removed in OpenVPN 2.8. Static encryption without a transient key
+  (generated by DH or ECDH) has been considered problematic for many
+  years. Please use ``--peer-fingerprint`` and self-signed certificates
+  for small setups.
+
+--allow-deprecated-insecure-static-crypto
+  Removed in OpenVPN 2.8 as --secret was also removed.
diff --git a/doc/openvpn.8.rst b/doc/openvpn.8.rst
index 65130b1..2ca9b62 100644
--- a/doc/openvpn.8.rst
+++ b/doc/openvpn.8.rst
@@ -48,10 +48,8 @@
 OpenVPN is tightly bound to the OpenSSL library, and derives much of its
 crypto capabilities from it.
 
-OpenVPN supports conventional encryption using a pre-shared secret key
-**(Static Key mode)** or public key security **(SSL/TLS mode)** using
-client & server certificates. OpenVPN also supports non-encrypted
-TCP/UDP tunnels.
+OpenVPN supports conventional encryption using public key security
+with TLS **(SSL/TLS mode)** using client & server certificates.
 
 OpenVPN is designed to work with the **TUN/TAP** virtual networking
 interface that exists on most platforms.
diff --git a/src/openvpn/check_file_access.c b/src/openvpn/check_file_access.c
index 25d7f90..ab2535d 100644
--- a/src/openvpn/check_file_access.c
+++ b/src/openvpn/check_file_access.c
@@ -312,10 +312,6 @@
                                          ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
     }
 
-    errs |=
-        check_file_access_inline(options->shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                                 options->shared_secret_file, R_OK, "--secret");
-
     errs |= check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id_file,
                               R_OK | W_OK, "--replay-persist");
 
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index f5e5904..a8ad7f0 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -872,7 +872,7 @@
  * Build a struct key_type.
  */
 void
-init_key_type(struct key_type *kt, const char *ciphername, const char *authname, bool tls_mode,
+init_key_type(struct key_type *kt, const char *ciphername, const char *authname,
               bool warn)
 {
     bool aead_cipher = false;
@@ -891,9 +891,9 @@
 
         /* check legal cipher mode */
         aead_cipher = cipher_kt_mode_aead(kt->cipher);
-        if (!(cipher_kt_mode_cbc(kt->cipher) || (tls_mode && aead_cipher)
+        if (!(cipher_kt_mode_cbc(kt->cipher) || aead_cipher
 #ifdef ENABLE_OFB_CFB_MODE
-              || (tls_mode && cipher_kt_mode_ofb_cfb(kt->cipher))
+              || cipher_kt_mode_ofb_cfb(kt->cipher)
 #endif
                   ))
         {
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index dbe0802..a03c5ce 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -58,16 +58,12 @@
  * <tt>[ * xxx * ]</tt> = encrypted and authenticated
  *
  * @par
- * <b>CBC data channel cypto format</b> \n
- * In CBC mode, both TLS-mode and static key mode are supported. The IV
- * consists of random bits to provide unpredictable IVs. \n
+ * <b>CBC data channel crypto format</b> \n
+ * The IV consists of random bits to provide unpredictable IVs. \n
  * <i>CBC IV format:</i> \n
  * <tt> [ - random - ] </tt> \n
- * <i>CBC data channel crypto format in TLS-mode:</i> \n
+ * <i>CBC data channel crypto format:</i> \n
  * <tt> [ HMAC ] [ - IV - ] [ * packet ID * ] [ * packet payload * ] </tt> \n
- * <i>CBC data channel crypto format in static key mode:</i> \n
- * <tt> [ HMAC ] [ - IV - ] [ * packet ID * ] [ * timestamp * ]
- * [ * packet payload * ] </tt>
  *
  * @par
  * <b>CFB/OFB data channel crypto format</b> \n
@@ -109,14 +105,11 @@
  *
  * @par
  * <b>No-crypto data channel format</b> \n
- * In no-crypto mode (\c \-\-cipher \c none is specified), both TLS-mode and
- * static key mode are supported. No encryption will be performed on the packet,
- * but packets can still be authenticated. This mode does not require an IV.\n
- * <i>No-crypto data channel crypto format in TLS-mode:</i> \n
+ * In no-crypto mode (\c \-\-cipher \c none is specified), no encryption
+ * will be performed on the packet,  but packets can still be authenticated.
+ * This mode does not require an IV.\n
+ * <i>No-crypto data channel crypto format:</i> \n
  * <tt> [ HMAC ] [ - packet ID - ] [ - packet payload - ] </tt> \n
- * <i>No-crypto data channel crypto format in static key mode:</i> \n
- * <tt> [ HMAC ] [ - packet ID - ] [ - timestamp - ] [ - packet payload - ] </tt>
- *
  */
 
 #ifndef CRYPTO_H
@@ -420,11 +413,9 @@
  * @param kt          The struct key_type to initialize
  * @param ciphername  The name of the cipher to use
  * @param authname    The name of the HMAC digest to use
- * @param tls_mode    Specifies whether we are running in TLS mode, which allows
- *                    more ciphers than static key mode.
  * @param warn        Print warnings when null cipher / auth is used.
  */
-void init_key_type(struct key_type *kt, const char *ciphername, const char *authname, bool tls_mode,
+void init_key_type(struct key_type *kt, const char *ciphername, const char *authname,
                    bool warn);
 
 /*
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 0ea2375..3a2a8c6 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -1013,8 +1013,7 @@
     printf("The following ciphers and cipher modes are available for use\n"
            "with " PACKAGE_NAME ".  Each cipher shown below may be used as a\n"
            "parameter to the --data-ciphers (or --cipher) option.  Using a\n"
-           "GCM or CBC mode is recommended.  In static key mode only CBC\n"
-           "mode is allowed.\n\n");
+           "GCM or CBC mode is recommended.\n\n");
 #endif
 
     for (size_t i = 0; i < cipher_info_table_entries; i++)
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index d29895b..6b5fcee6 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -266,12 +266,6 @@
             msg(M_USAGE, "--server and --server-bridge cannot be used together");
         }
 
-        if (o->shared_secret_file)
-        {
-            msg(M_USAGE,
-                "--server and --secret cannot be used together (you must use SSL/TLS keys)");
-        }
-
         if (!(o->server_flags & SF_NOPOOL) && o->ifconfig_pool_defined)
         {
             msg(M_USAGE,
@@ -461,12 +455,6 @@
                 "--server-bridge already defines an ifconfig-pool, so you can't also specify --ifconfig-pool explicitly");
         }
 
-        if (o->shared_secret_file)
-        {
-            msg(M_USAGE,
-                "--server-bridge and --secret cannot be used together (you must use SSL/TLS keys)");
-        }
-
         if (dev != DEV_TYPE_TAP)
         {
             msg(M_USAGE, "--server-bridge directive only makes sense with --dev tap");
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3bc4de4..29c24f2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -997,35 +997,10 @@
         platform_mlockall(true);
     }
 
-    /*
-     * We do not want user to use --genkey with --secret. In the transistion
-     * phase we for secret.
-     */
-    if (options->genkey && options->genkey_type != GENKEY_SECRET && options->shared_secret_file)
-    {
-        msg(M_USAGE, "Using --genkey type with --secret filename is "
-                     "not supported.  Use --genkey type filename instead.");
-    }
     if (options->genkey && options->genkey_type == GENKEY_SECRET)
     {
         int nbits_written;
         const char *genkey_filename = options->genkey_filename;
-        if (options->shared_secret_file && options->genkey_filename)
-        {
-            msg(M_USAGE, "You must provide a filename to either --genkey "
-                         "or --secret, not both");
-        }
-
-        /*
-         * Copy filename from shared_secret_file to genkey_filename to support
-         * the old --genkey --secret foo.file syntax.
-         */
-        if (options->shared_secret_file)
-        {
-            msg(M_WARN, "WARNING: Using --genkey --secret filename is "
-                        "DEPRECATED.  Use --genkey secret filename instead.");
-            genkey_filename = options->shared_secret_file;
-        }
 
         nbits_written = write_key_file(2, genkey_filename);
         if (nbits_written < 0)
@@ -1034,7 +1009,7 @@
         }
 
         msg(D_GENKEY | M_NOPREFIX, "Randomly generated %d bit key written to %s", nbits_written,
-            options->shared_secret_file);
+            genkey_filename ? genkey_filename : "stdout");
         return true;
     }
     else if (options->genkey && options->genkey_type == GENKEY_TLS_CRYPTV2_SERVER)
@@ -1080,7 +1055,7 @@
     /* sanity check on options for --mktun or --rmtun */
     notnull(options->dev, "TUN/TAP device (--dev)");
     if (options->ce.remote || options->ifconfig_local || options->ifconfig_remote_netmask
-        || options->shared_secret_file || options->tls_server || options->tls_client)
+        || options->tls_server || options->tls_client)
     {
         msg(M_FATAL | M_OPTERR,
             "options --mktun or --rmtun should only be used together with --dev");
@@ -3036,8 +3011,7 @@
     ASSERT(!key_ctx_bi_defined(&c->c1.ks.static_key));
 
     /* Init cipher and hash algorithm */
-    init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
-                  options->test_crypto, true);
+    init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname, true);
 
     generate_test_crypto_random_key(&c->c1.ks.key_type, &c->c1.ks.static_key,
                                     "test crypto key");
@@ -3047,50 +3021,6 @@
 }
 
 /*
- * Static Key Mode (using a pre-shared key)
- */
-static void
-do_init_crypto_static(struct context *c, const unsigned int flags)
-{
-    const struct options *options = &c->options;
-    ASSERT(options->shared_secret_file);
-
-    init_crypto_pre(c, flags);
-
-    /* Initialize flags */
-    if (c->options.mute_replay_warnings)
-    {
-        c->c2.crypto_options.flags |= CO_MUTE_REPLAY_WARNINGS;
-    }
-
-    /* Initialize packet ID tracking */
-    packet_id_init(&c->c2.crypto_options.packet_id, options->replay_window, options->replay_time,
-                   "STATIC", 0);
-    c->c2.crypto_options.pid_persist = &c->c1.pid_persist;
-    c->c2.crypto_options.flags |= CO_PACKET_ID_LONG_FORM;
-    packet_id_persist_load_obj(&c->c1.pid_persist, &c->c2.crypto_options.packet_id);
-
-    if (!key_ctx_bi_defined(&c->c1.ks.static_key))
-    {
-        /* Get cipher & hash algorithms */
-        init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
-                      options->test_crypto, true);
-
-        /* Read cipher and hmac keys from shared secret file */
-        crypto_read_openvpn_key(&c->c1.ks.key_type, &c->c1.ks.static_key,
-                                options->shared_secret_file, options->shared_secret_file_inline,
-                                options->key_direction, "Static Key Encryption", "secret", NULL);
-    }
-    else
-    {
-        msg(M_INFO, "Re-using pre-shared static key");
-    }
-
-    /* Get key schedule */
-    c->c2.crypto_options.key_ctx_bi = c->c1.ks.static_key;
-}
-
-/*
  * Initialize the tls-auth/crypt key context
  */
 static void
@@ -3229,7 +3159,7 @@
 
         /* Do not warn if the cipher is used only in OCC */
         bool warn = options->enable_ncp_fallback;
-        init_key_type(&c->c1.ks.key_type, ciphername, options->authname, true, warn);
+        init_key_type(&c->c1.ks.key_type, ciphername, options->authname, warn);
 
         /* initialize tls-auth/crypt/crypt-v2 key */
         do_init_tls_wrap_key(c);
@@ -3518,41 +3448,6 @@
     }
 }
 
-/*
- * No encryption or authentication.
- */
-static void
-do_init_crypto_none(struct context *c)
-{
-    ASSERT(!c->options.test_crypto);
-
-    /* Initialise key_type with auth/cipher "none", so the key_type struct is
-     * valid */
-    init_key_type(&c->c1.ks.key_type, "none", "none", c->options.test_crypto, true);
-
-    msg(M_WARN, "******* WARNING *******: All encryption and authentication features "
-                "disabled -- All data will be tunnelled as clear text and will not be "
-                "protected against man-in-the-middle changes. "
-                "PLEASE DO RECONSIDER THIS CONFIGURATION!");
-}
-
-static void
-do_init_crypto(struct context *c, const unsigned int flags)
-{
-    if (c->options.shared_secret_file)
-    {
-        do_init_crypto_static(c, flags);
-    }
-    else if (c->options.tls_server || c->options.tls_client)
-    {
-        do_init_crypto_tls(c, flags);
-    }
-    else /* no encryption or authentication. */
-    {
-        do_init_crypto_none(c);
-    }
-}
-
 static void
 do_init_frame(struct context *c)
 {
@@ -4609,7 +4504,7 @@
         {
             crypto_flags = CF_INIT_TLS_MULTI;
         }
-        do_init_crypto(c, crypto_flags);
+        do_init_crypto_tls(c, crypto_flags);
         if (IS_SIG(c) && !child)
         {
             goto sig;
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index f3c2874..5ce40c8 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -51,7 +51,6 @@
 unsigned int
 calc_packet_id_size_dc(const struct options *options, const struct key_type *kt)
 {
-    bool tlsmode = options->tls_server || options->tls_client;
     bool epoch = options->imported_protocol_flags & CO_EPOCH_DATA_KEY_FORMAT;
 
     /* epoch format uses a 64-bit packet id: 16 bit epoch + 48 bit per-epoch counter */
@@ -60,7 +59,7 @@
         return sizeof(uint64_t);
     }
 
-    bool packet_id_long_form = !tlsmode || cipher_kt_mode_ofb_cfb(kt->cipher);
+    bool packet_id_long_form = cipher_kt_mode_ofb_cfb(kt->cipher);
 
     return packet_id_size(packet_id_long_form);
 }
@@ -72,8 +71,6 @@
     /* Sum of all the overhead that reduces the usable packet size */
     size_t header_size = 0;
 
-    bool tlsmode = options->tls_server || options->tls_client;
-
     /* A socks proxy adds extra header to each packet
      * (we only support Socks with IPv4, this value is different for IPv6) */
     if (options->ce.socks_proxy_server && proto_is_udp(options->ce.proto))
@@ -88,10 +85,7 @@
     }
 
     /* Add the opcode and peerid */
-    if (tlsmode)
-    {
-        header_size += options->use_peer_id ? 4 : 1;
-    }
+    header_size += options->use_peer_id ? 4 : 1;
 
     unsigned int pkt_id_size = calc_packet_id_size_dc(options, kt);
 
@@ -156,13 +150,6 @@
 {
     struct key_type occ_kt;
 
-    /* neither --secret nor TLS mode */
-    if (!o->tls_client && !o->tls_server && !o->shared_secret_file)
-    {
-        init_key_type(&occ_kt, "none", "none", false, false);
-        return frame_calculate_payload_size(frame, o, &occ_kt);
-    }
-
     /* o->ciphername might be BF-CBC even though the underlying SSL library
      * does not support it. For this reason we workaround this corner case
      * by pretending to have no encryption enabled and by manually adding
@@ -184,9 +171,7 @@
         ciphername = "none";
     }
 
-    /* We pass tlsmode always true here since as we do not need to check if
-     * the ciphers are actually valid for non tls in occ calucation */
-    init_key_type(&occ_kt, ciphername, o->authname, true, false);
+    init_key_type(&occ_kt, ciphername, o->authname, false);
 
     size_t payload = frame_calculate_payload_size(frame, o, &occ_kt);
     overhead += frame_calculate_protocol_header_size(&occ_kt, o, true);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4dfc719..454d2d6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -558,14 +558,11 @@
     "                  server/remote. n = # of retries, default=1.\n"
     "\n"
     "Data Channel Encryption Options (must be compatible between peers):\n"
-    "(These options are meaningful for both Static Key & TLS-mode)\n"
     "--auth alg      : Authenticate packets with HMAC using message\n"
     "                  digest algorithm alg (default=%s).\n"
     "                  (usually adds 16 or 20 bytes per packet)\n"
     "                  Set alg=none to disable authentication.\n"
-    "--cipher alg    : Encrypt packets with cipher algorithm alg.\n"
-    "                  You should usually use --data-ciphers instead.\n"
-    "                  Set alg=none to disable encryption.\n"
+    "--cipher alg    : Ignored. You should usually use --data-ciphers instead.\n"
     "--data-ciphers list : List of ciphers that are allowed to be negotiated.\n"
 #ifndef ENABLE_CRYPTO_MBEDTLS
     "--engine [name] : Enable OpenSSL hardware crypto engine functionality.\n"
@@ -1588,16 +1585,17 @@
 static void
 options_postprocess_verify_ce(const struct options *options, const struct connection_entry *ce)
 {
+    if (options->test_crypto)
+    {
+        return;
+    }
     struct options defaults;
     int dev = DEV_TYPE_UNDEF;
     bool pull = false;
 
     init_options(&defaults);
 
-    if (!options->test_crypto)
-    {
-        notnull(options->dev, "TUN/TAP device (--dev)");
-    }
+    notnull(options->dev, "TUN/TAP device (--dev)");
 
     /*
      * Get tun/tap/null device type
@@ -2013,27 +2011,9 @@
     /*
      * SSL/TLS mode sanity checks.
      */
-    if (options->tls_server + options->tls_client + (options->shared_secret_file != NULL) > 1)
+    if (options->tls_server == options->tls_client)
     {
-        msg(M_USAGE, "specify only one of --tls-server, --tls-client, or --secret");
-    }
-
-    if (!options->tls_server && !options->tls_client && !options->test_crypto)
-    {
-        msglvl_t msglevel = M_USAGE;
-        if (options->allow_deprecated_insecure_static_crypto)
-        {
-            msglevel = M_INFO;
-        }
-
-        msg(msglevel, "DEPRECATION: No tls-client or tls-server option in "
-                      "configuration detected. OpenVPN 2.8 will remove the "
-                      "functionality to run a VPN without TLS. "
-                      "See the examples section in the manual page for "
-                      "examples of a similar quick setup with peer-fingerprint. "
-                      "OpenVPN 2.7 allows using this configuration when using "
-                      "--allow-deprecated-insecure-static-crypto but you should move "
-                      "to a proper configuration using TLS as soon as possible.");
+        msg(M_USAGE, "OpenVPN configuration must use either --tls-server or --tls-client");
     }
 
     if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL))
@@ -2053,188 +2033,135 @@
         msg(M_USAGE, "--tls-version-min bigger than --tls-version-max");
     }
 
-    if (options->tls_server || options->tls_client)
-    {
-        check_ca_required(options);
+    check_ca_required(options);
 #ifdef ENABLE_PKCS11
-        if (!options->pkcs11_providers[0] && options->pkcs11_id)
-        {
-            msg(M_WARN, "Option pkcs11-id is ignored as no pkcs11-providers are specified");
-        }
-        else if (!options->pkcs11_providers[0] && options->pkcs11_id_management)
-        {
-            msg(M_WARN,
-                "Option pkcs11-id-management is ignored as no pkcs11-providers are specified");
-        }
+    if (!options->pkcs11_providers[0] && options->pkcs11_id)
+    {
+        msg(M_WARN, "Option pkcs11-id is ignored as no pkcs11-providers are specified");
+    }
+    else if (!options->pkcs11_providers[0] && options->pkcs11_id_management)
+    {
+        msg(M_WARN,
+            "Option pkcs11-id-management is ignored as no pkcs11-providers are specified");
+    }
 
-        if (options->pkcs11_providers[0])
-        {
-            if (options->pkcs11_id_management && options->pkcs11_id != NULL)
-            {
-                msg(M_USAGE,
-                    "Parameter --pkcs11-id cannot be used when --pkcs11-id-management is also specified.");
-            }
-            if (!options->pkcs11_id_management && options->pkcs11_id == NULL)
-            {
-                msg(M_USAGE,
-                    "Parameter --pkcs11-id or --pkcs11-id-management should be specified.");
-            }
-            const char use_err[] =
-                "Parameter --%s cannot be used when --pkcs11-provider is also specified.";
-            MUST_BE_UNDEF(cert_file, "cert");
-            MUST_BE_UNDEF(priv_key_file, "key");
-            MUST_BE_UNDEF(pkcs12_file, "pkcs12");
-            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-external-key");
-            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
-#ifdef ENABLE_CRYPTOAPI
-            MUST_BE_UNDEF(cryptoapi_cert, "cryptoapicert");
-#endif
-        }
-        else
-#endif /* ifdef ENABLE_PKCS11 */
-#ifdef ENABLE_CRYPTOAPI
-            if (options->cryptoapi_cert)
-        {
-            const char use_err[] =
-                "Parameter --%s cannot be used when --cryptoapicert is also specified.";
-            MUST_BE_UNDEF(cert_file, "cert");
-            MUST_BE_UNDEF(priv_key_file, "key");
-            MUST_BE_UNDEF(pkcs12_file, "pkcs12");
-            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-external-key");
-            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
-        }
-        else
-#endif
-            if (options->pkcs12_file)
-        {
-#ifdef ENABLE_CRYPTO_MBEDTLS
-            msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbed TLS version of OpenVPN.");
-#else
-            const char use_err[] = "Parameter --%s cannot be used when --pkcs12 is also specified.";
-            MUST_BE_UNDEF(ca_path, "capath");
-            MUST_BE_UNDEF(cert_file, "cert");
-            MUST_BE_UNDEF(priv_key_file, "key");
-            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-external-key");
-            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
-#endif       /* ifdef ENABLE_CRYPTO_MBEDTLS */
-        }
-        else /* cert/key from none of pkcs11, pkcs12, cryptoapi */
-        {
-            if ((options->management_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
-            {
-                msg(M_USAGE, "--key and --management-external-key are mutually exclusive");
-            }
-            if ((options->management_flags & MF_EXTERNAL_CERT))
-            {
-                if (options->cert_file)
-                {
-                    msg(M_USAGE, "--cert and --management-external-cert are mutually exclusive");
-                }
-                else if (!(options->management_flags & MF_EXTERNAL_KEY))
-                {
-                    msg(M_USAGE,
-                        "--management-external-cert must be used with --management-external-key");
-                }
-            }
-            if (pull)
-            {
-                const int sum =
-                    ((options->cert_file != NULL) || (options->management_flags & MF_EXTERNAL_CERT))
-                    + ((options->priv_key_file != NULL)
-                       || (options->management_flags & MF_EXTERNAL_KEY));
-
-                if (sum == 0)
-                {
-                    if (!options->auth_user_pass_file)
-                    {
-                        msg(M_USAGE, "No client-side authentication method is "
-                                     "specified.  You must use either "
-                                     "--cert/--key, --pkcs12, or "
-                                     "--auth-user-pass");
-                    }
-                }
-                else if (sum != 2)
-                {
-                    msg(M_USAGE, "If you use one of --cert or --key, you must use them both");
-                }
-            }
-            else
-            {
-                if (!(options->management_flags & MF_EXTERNAL_CERT))
-                {
-                    notnull(options->cert_file,
-                            "certificate file (--cert) or PKCS#12 file (--pkcs12)");
-                }
-                if (!(options->management_flags & MF_EXTERNAL_KEY))
-                {
-                    notnull(options->priv_key_file,
-                            "private key file (--key) or PKCS#12 file (--pkcs12)");
-                }
-            }
-        }
-        if (ce->tls_auth_file && ce->tls_crypt_file)
-        {
-            msg(M_USAGE, "--tls-auth and --tls-crypt are mutually exclusive");
-        }
-        if (options->tls_client && ce->tls_crypt_v2_file
-            && (ce->tls_auth_file || ce->tls_crypt_file))
+    if (options->pkcs11_providers[0])
+    {
+        if (options->pkcs11_id_management && options->pkcs11_id != NULL)
         {
             msg(M_USAGE,
-                "--tls-crypt-v2, --tls-auth and --tls-crypt are mutually exclusive in client mode");
+                "Parameter --pkcs11-id cannot be used when --pkcs11-id-management is also specified.");
         }
-    }
-    else
-    {
-        /*
-         * Make sure user doesn't specify any TLS options
-         * when in non-TLS mode.
-         */
-
-        const char use_err[] = "Parameter %s can only be specified in TLS-mode, "
-                               "i.e. where --tls-server or --tls-client is also specified.";
-
-        MUST_BE_UNDEF(ca_file, "ca");
-        MUST_BE_UNDEF(ca_path, "capath");
-        MUST_BE_UNDEF(dh_file, "dh");
+        if (!options->pkcs11_id_management && options->pkcs11_id == NULL)
+        {
+            msg(M_USAGE,
+                "Parameter --pkcs11-id or --pkcs11-id-management should be specified.");
+        }
+        const char use_err[] =
+            "Parameter --%s cannot be used when --pkcs11-provider is also specified.";
         MUST_BE_UNDEF(cert_file, "cert");
         MUST_BE_UNDEF(priv_key_file, "key");
-#ifndef ENABLE_CRYPTO_MBEDTLS
         MUST_BE_UNDEF(pkcs12_file, "pkcs12");
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-external-key");
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
+#ifdef ENABLE_CRYPTOAPI
+        MUST_BE_UNDEF(cryptoapi_cert, "cryptoapicert");
 #endif
-        MUST_BE_UNDEF(cipher_list, "tls-cipher");
-        MUST_BE_UNDEF(cipher_list_tls13, "tls-ciphersuites");
-        MUST_BE_UNDEF(tls_cert_profile, "tls-cert-profile");
-        MUST_BE_UNDEF(tls_verify, "tls-verify");
-        MUST_BE_UNDEF(tls_export_peer_cert_dir, "tls-export-cert");
-        MUST_BE_UNDEF(verify_x509_name, "verify-x509-name");
-        MUST_BE_UNDEF(tls_timeout, "tls-timeout");
-        MUST_BE_UNDEF(renegotiate_bytes, "reneg-bytes");
-        MUST_BE_UNDEF(renegotiate_packets, "reneg-pkts");
-        MUST_BE_UNDEF(renegotiate_seconds, "reneg-sec");
-        MUST_BE_UNDEF(handshake_window, "hand-window");
-        MUST_BE_UNDEF(transition_window, "tran-window");
-        MUST_BE_UNDEF(tls_auth_file, "tls-auth");
-        MUST_BE_UNDEF(tls_crypt_file, "tls-crypt");
-        MUST_BE_UNDEF(tls_crypt_v2_file, "tls-crypt-v2");
-        MUST_BE_UNDEF(single_session, "single-session");
-        MUST_BE_UNDEF(push_peer_info, "push-peer-info");
-        MUST_BE_UNDEF(tls_exit, "tls-exit");
-        MUST_BE_UNDEF(crl_file, "crl-verify");
-        MUST_BE_UNDEF(ns_cert_type, "ns-cert-type");
-        MUST_BE_UNDEF(remote_cert_ku[0], "remote-cert-ku");
-        MUST_BE_UNDEF(remote_cert_eku, "remote-cert-eku");
-#ifdef ENABLE_PKCS11
-        MUST_BE_UNDEF(pkcs11_providers[0], "pkcs11-providers");
-        MUST_BE_UNDEF(pkcs11_private_mode[0], "pkcs11-private-mode");
-        MUST_BE_UNDEF(pkcs11_id, "pkcs11-id");
-        MUST_BE_UNDEF(pkcs11_id_management, "pkcs11-id-management");
+    }
+    else
+#endif /* ifdef ENABLE_PKCS11 */
+#ifdef ENABLE_CRYPTOAPI
+        if (options->cryptoapi_cert)
+    {
+        const char use_err[] =
+            "Parameter --%s cannot be used when --cryptoapicert is also specified.";
+        MUST_BE_UNDEF(cert_file, "cert");
+        MUST_BE_UNDEF(priv_key_file, "key");
+        MUST_BE_UNDEF(pkcs12_file, "pkcs12");
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-external-key");
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
+    }
+    else
 #endif
-
+        if (options->pkcs12_file)
+    {
+#ifdef ENABLE_CRYPTO_MBEDTLS
+        msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbed TLS version of OpenVPN.");
+#else
+        const char use_err[] = "Parameter --%s cannot be used when --pkcs12 is also specified.";
+        MUST_BE_UNDEF(ca_path, "capath");
+        MUST_BE_UNDEF(cert_file, "cert");
+        MUST_BE_UNDEF(priv_key_file, "key");
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-external-key");
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
+#endif   /* ifdef ENABLE_CRYPTO_MBEDTLS */
+    }
+    else /* cert/key from none of pkcs11, pkcs12, cryptoapi */
+    {
+        if ((options->management_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
+        {
+            msg(M_USAGE, "--key and --management-external-key are mutually exclusive");
+        }
+        if ((options->management_flags & MF_EXTERNAL_CERT))
+        {
+            if (options->cert_file)
+            {
+                msg(M_USAGE, "--cert and --management-external-cert are mutually exclusive");
+            }
+            else if (!(options->management_flags & MF_EXTERNAL_KEY))
+            {
+                msg(M_USAGE,
+                    "--management-external-cert must be used with --management-external-key");
+            }
+        }
         if (pull)
         {
-            msg(M_USAGE, use_err, "--pull");
+            const int sum =
+                ((options->cert_file != NULL) || (options->management_flags & MF_EXTERNAL_CERT))
+                + ((options->priv_key_file != NULL)
+                   || (options->management_flags & MF_EXTERNAL_KEY));
+
+            if (sum == 0)
+            {
+                if (!options->auth_user_pass_file)
+                {
+                    msg(M_USAGE, "No client-side authentication method is "
+                                 "specified.  You must use either "
+                                 "--cert/--key, --pkcs12, or "
+                                 "--auth-user-pass");
+                }
+            }
+            else if (sum != 2)
+            {
+                msg(M_USAGE, "If you use one of --cert or --key, you must use them both");
+            }
+        }
+        else
+        {
+            if (!(options->management_flags & MF_EXTERNAL_CERT))
+            {
+                notnull(options->cert_file,
+                        "certificate file (--cert) or PKCS#12 file (--pkcs12)");
+            }
+            if (!(options->management_flags & MF_EXTERNAL_KEY))
+            {
+                notnull(options->priv_key_file,
+                        "private key file (--key) or PKCS#12 file (--pkcs12)");
+            }
         }
     }
+    if (ce->tls_auth_file && ce->tls_crypt_file)
+    {
+        msg(M_USAGE, "--tls-auth and --tls-crypt are mutually exclusive");
+    }
+    if (options->tls_client && ce->tls_crypt_v2_file
+        && (ce->tls_auth_file || ce->tls_crypt_file))
+    {
+        msg(M_USAGE,
+            "--tls-crypt-v2, --tls-auth and --tls-crypt are mutually exclusive in client mode");
+    }
+
+
     if (options->auth_user_pass_file && !options->pull)
     {
         msg(M_USAGE, "--auth-user-pass requires --pull");
@@ -6960,32 +6887,6 @@
             goto err;
         }
     }
-    else if (streq(p[0], "secret") && p[1] && !p[3])
-    {
-        msg(M_WARN, "DEPRECATED OPTION: The option --secret is deprecated.");
-        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
-        options->shared_secret_file = p[1];
-        options->shared_secret_file_inline = is_inline;
-        if (!is_inline && p[2])
-        {
-            int key_direction;
-
-            key_direction = ascii2keydirection(msglevel, p[2]);
-            if (key_direction >= 0)
-            {
-                options->key_direction = key_direction;
-            }
-            else
-            {
-                goto err;
-            }
-        }
-    }
-    else if (streq(p[0], "allow-deprecated-insecure-static-crypto"))
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->allow_deprecated_insecure_static_crypto = true;
-    }
     else if (streq(p[0], "genkey") && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 33b50b2..38554a1 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -569,9 +569,6 @@
     struct static_challenge_info sc_info;
 #endif
     /* Cipher parms */
-    const char *shared_secret_file;
-    bool shared_secret_file_inline;
-    bool allow_deprecated_insecure_static_crypto;
     int key_direction;
     const char *ciphername;
     bool enable_ncp_fallback; /**< If defined fall back to
diff --git a/src/openvpn/options_show.c b/src/openvpn/options_show.c
index 80d36f0..321a37b 100644
--- a/src/openvpn/options_show.c
+++ b/src/openvpn/options_show.c
@@ -491,7 +491,6 @@
     }
 #endif
 
-    SHOW_STR_INLINE(shared_secret_file);
     SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false, true), "%s");
     SHOW_STR(ciphername);
     SHOW_STR(ncp_ciphers);
diff --git a/src/openvpn/options_string.c b/src/openvpn/options_string.c
index ed4d742..4a43fce4 100644
--- a/src/openvpn/options_string.c
+++ b/src/openvpn/options_string.c
@@ -140,83 +140,72 @@
     /*
      * Crypto Options
      */
-    if (o->shared_secret_file || TLS_CLIENT || TLS_SERVER)
+    struct key_type kt;
+
+    ASSERT((TLS_CLIENT == true) + (TLS_SERVER == true) <= 1);
+
+    /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
+     * to work here in the default configuration */
+    const char *ciphername = o->ciphername;
+    size_t keysize = 0;
+
+    if (strcmp(o->ciphername, "BF-CBC") == 0)
     {
-        struct key_type kt;
-
-        ASSERT((o->shared_secret_file != NULL) + (TLS_CLIENT == true) + (TLS_SERVER == true) <= 1);
-
-        /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
-         * to work here in the default configuration */
-        const char *ciphername = o->ciphername;
-        size_t keysize = 0;
-
-        if (strcmp(o->ciphername, "BF-CBC") == 0)
+        init_key_type(&kt, "none", o->authname, false);
+        keysize = 128;
+    }
+    else
+    {
+        init_key_type(&kt, o->ciphername, o->authname, false);
+        ciphername = cipher_kt_name(kt.cipher);
+        if (cipher_defined(o->ciphername))
         {
-            init_key_type(&kt, "none", o->authname, true, false);
-            keysize = 128;
-        }
-        else
-        {
-            init_key_type(&kt, o->ciphername, o->authname, true, false);
-            ciphername = cipher_kt_name(kt.cipher);
-            if (cipher_defined(o->ciphername))
-            {
-                keysize = cipher_kt_key_size(kt.cipher) * 8;
-            }
-        }
-        /* Only announce the cipher to our peer if we are willing to
-         * support it */
-        if (p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
-        {
-            buf_printf(&out, ",cipher %s", ciphername);
-        }
-        buf_printf(&out, ",auth %s", md_kt_name(kt.digest));
-        buf_printf(&out, ",keysize %zu", keysize);
-        if (o->shared_secret_file)
-        {
-            buf_printf(&out, ",secret");
+            keysize = cipher_kt_key_size(kt.cipher) * 8;
         }
     }
+    /* Only announce the cipher to our peer if we are willing to
+     * support it */
+    if (p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
+    {
+        buf_printf(&out, ",cipher %s", ciphername);
+    }
+    buf_printf(&out, ",auth %s", md_kt_name(kt.digest));
+    buf_printf(&out, ",keysize %zu", keysize);
 
     /*
      * SSL Options
      */
+    if (o->ce.tls_auth_file)
     {
-        if (TLS_CLIENT || TLS_SERVER)
-        {
-            if (o->ce.tls_auth_file)
-            {
-                buf_printf(&out, ",tls-auth");
-            }
-            /* Not adding tls-crypt here, because we won't reach this code if
-             * tls-auth/tls-crypt does not match.  Removing tls-auth here would
-             * break stuff, so leaving that in place. */
+        buf_printf(&out, ",tls-auth");
+    }
+    /* Not adding tls-crypt here, because we won't reach this code if
+     * tls-auth/tls-crypt does not match.  Removing tls-auth here would
+     * break stuff, so leaving that in place. */
 
-            buf_printf(&out, ",key-method %d", KEY_METHOD_2);
-        }
+    buf_printf(&out, ",key-method %d", KEY_METHOD_2);
 
-        if (remote)
+
+    if (remote)
+    {
+        if (TLS_CLIENT)
         {
-            if (TLS_CLIENT)
-            {
-                buf_printf(&out, ",tls-server");
-            }
-            else if (TLS_SERVER)
-            {
-                buf_printf(&out, ",tls-client");
-            }
+            buf_printf(&out, ",tls-server");
         }
-        else
+        else if (TLS_SERVER)
         {
-            if (TLS_CLIENT)
-            {
-                buf_printf(&out, ",tls-client");
-            }
-            else if (TLS_SERVER)
-            {
-                buf_printf(&out, ",tls-server");
-            }
+            buf_printf(&out, ",tls-client");
+        }
+    }
+    else
+    {
+        if (TLS_CLIENT)
+        {
+            buf_printf(&out, ",tls-client");
+        }
+        else if (TLS_SERVER)
+        {
+            buf_printf(&out, ",tls-server");
         }
     }
 
diff --git a/src/openvpn/options_string.h b/src/openvpn/options_string.h
index 02efed3..6d5518a 100644
--- a/src/openvpn/options_string.h
+++ b/src/openvpn/options_string.h
@@ -59,7 +59,6 @@
  *
  * --cipher
  * --auth
- * --secret
  *
  * SSL Options:
  *
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 420daef..a538b52 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1648,7 +1648,7 @@
         return true;
     }
 
-    init_key_type(&session->opt->key_type, options->ciphername, options->authname, true, true);
+    init_key_type(&session->opt->key_type, options->ciphername, options->authname, true);
 
     bool packet_id_long_form = cipher_kt_mode_ofb_cfb(session->opt->key_type.cipher);
     session->opt->crypto_flags &= ~(CO_PACKET_ID_LONG_FORM);
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 07c54b4..f86aca8 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -237,70 +237,58 @@
     /* common defaults */
     o.ce.tun_mtu = 1400;
     o.ce.proto = PROTO_UDP;
+    o.tls_client = true;
+    o.pull = true;
 
-    /* No crypto at all */
+    /*  auth none, cipher none */
     o.ciphername = "none";
     o.authname = "none";
     linkmtu = calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1400);
+    assert_int_equal(linkmtu, 1405);
 
-    /* Static key OCC examples */
-    o.shared_secret_file = "not null";
-
-    /* secret, auth none, cipher none */
-    o.ciphername = "none";
-    o.authname = "none";
-    linkmtu = calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1408);
-
-    /* secret, cipher AES-128-CBC, auth none */
+    /* cipher AES-128-CBC, auth none */
     o.ciphername = "AES-128-CBC";
     o.authname = "none";
     linkmtu = calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1440);
+    assert_int_equal(linkmtu, 1437);
 
-    /* secret, cipher none, auth SHA256 */
+    /* cipher none, auth SHA256 */
     o.ciphername = "none";
     o.authname = "SHA256";
     linkmtu = calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1440);
+    assert_int_equal(linkmtu, 1437);
 
-    /* secret, cipher BF-CBC, auth SHA1 */
+    /* cipher BF-CBC, auth SHA1 */
     o.ciphername = "BF-CBC";
     o.authname = "SHA1";
     linkmtu = calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1444);
+    assert_int_equal(linkmtu, 1441);
 
-    /* secret, cipher BF-CBC, auth SHA1, tcp-client */
+    /* cipher BF-CBC, auth SHA1, tcp-client */
     o.ce.proto = PROTO_TCP_CLIENT;
     linkmtu = calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1446);
+    assert_int_equal(linkmtu, 1443);
 
     o.ce.proto = PROTO_UDP;
 
 #if defined(USE_COMP)
     o.comp.alg = COMP_ALG_LZO;
 
-    /* secret, comp-lzo yes, cipher BF-CBC, auth SHA1 */
+    /*  comp-lzo yes, cipher BF-CBC, auth SHA1 */
     linkmtu = calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1445);
+    assert_int_equal(linkmtu, 1442);
 
 #if defined(ENABLE_FRAGMENT)
-    /* secret, comp-lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */
+    /* comp-lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */
     o.ce.fragment = 1200;
     linkmtu = calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1449);
+    assert_int_equal(linkmtu, 1446);
     o.ce.fragment = 0;
 #endif
 
     o.comp.alg = COMP_ALG_UNDEF;
 #endif
 
-    /* TLS mode */
-    o.shared_secret_file = NULL;
-    o.tls_client = true;
-    o.pull = true;
-
     /* tls client, cipher AES-128-CBC, auth SHA1, tls-auth */
     o.authname = "SHA1";
     o.ciphername = "AES-128-CBC";
@@ -315,15 +303,8 @@
     linkmtu = calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1457);
 
-    /* tls client, cipher none, auth none */
+    /* tls client, auth none, cipher AES-256-GCM */
     o.authname = "none";
-    o.ciphername = "none";
-
-    linkmtu = calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1405);
-
-    /* tls client, auth SHA1, cipher AES-256-GCM */
-    o.authname = "SHA1";
     o.ciphername = "AES-256-GCM";
     linkmtu = calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1449);
@@ -332,12 +313,12 @@
 #if defined(USE_COMP) && defined(ENABLE_FRAGMENT)
     o.comp.alg = COMP_ALG_LZO;
 
-    /* tls client, auth SHA1, cipher AES-256-GCM, fragment, comp-lzo yes */
+    /* tls client, auth none, cipher AES-256-GCM, fragment, comp-lzo yes */
     o.ce.fragment = 1200;
     linkmtu = calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1454);
 
-    /* tls client, auth SHA1, cipher AES-256-GCM, fragment, comp-lzo yes, socks */
+    /* tls client, auth none, cipher AES-256-GCM, fragment, comp-lzo yes, socks */
     o.ce.socks_proxy_server = "socks.example.com";
     linkmtu = calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1464);
@@ -358,50 +339,41 @@
     o.ce.tun_mtu = 1400;
     o.ce.mssfix = 1000;
     o.ce.proto = PROTO_UDP;
+    o.tls_client = true;
 
-    /* No crypto at all */
+    /*auth none, cipher none */
     o.ciphername = "none";
     o.authname = "none";
     struct key_type kt;
-    init_key_type(&kt, o.ciphername, o.authname, false, false);
+    init_key_type(&kt, o.ciphername, o.authname, false);
 
-    /* No encryption, just packet id (8) + TCP payload(20) + IP payload(20) */
+    /* No encryption, just packet id (4) + opcode (1) + TCP payload(20) + IP payload(20) */
     frame_calculate_dynamic(&f, &kt, &o, NULL);
-    assert_int_equal(f.mss_fix, 952);
+    assert_int_equal(f.mss_fix, 955);
 
-    /* Static key OCC examples */
-    o.shared_secret_file = "not null";
-
-    /* secret, auth none, cipher none */
-    o.ciphername = "none";
-    o.authname = "none";
-    init_key_type(&kt, o.ciphername, o.authname, false, false);
-    frame_calculate_dynamic(&f, &kt, &o, NULL);
-    assert_int_equal(f.mss_fix, 952);
-
-    /* secret, cipher AES-128-CBC, auth none */
+    /* cipher AES-128-CBC, auth none */
     o.ciphername = "AES-128-CBC";
     o.authname = "none";
-    init_key_type(&kt, o.ciphername, o.authname, false, false);
+    init_key_type(&kt, o.ciphername, o.authname, false);
 
-    for (int i = 990; i <= 1010; i++)
+    for (int i = 990; i <= 1015; i++)
     {
         /* 992 - 1008 should end up with the same mssfix value all they
-         * all result in the same CBC block size/padding and <= 991 and >=1008
+         * all result in the same CBC block size/padding and <= 992 and >=1009
          * should be one block less and more respectively */
         o.ce.mssfix = i;
         frame_calculate_dynamic(&f, &kt, &o, NULL);
-        if (i <= 991)
+        if (i <= 992)
         {
-            assert_int_equal(f.mss_fix, 911);
+            assert_int_equal(f.mss_fix, 915);
         }
-        else if (i >= 1008)
+        else if (i >= 1009)
         {
-            assert_int_equal(f.mss_fix, 943);
+            assert_int_equal(f.mss_fix, 947);
         }
         else
         {
-            assert_int_equal(f.mss_fix, 927);
+            assert_int_equal(f.mss_fix, 931);
         }
     }
 #ifdef USE_COMP
@@ -410,36 +382,35 @@
     /* Same but with compression added. Compression adds one byte extra to the
      * payload so the payload should be reduced by compared to the no
      * compression calculation before */
-    for (int i = 990; i <= 1010; i++)
+    for (int i = 990; i <= 1015; i++)
     {
         /* 992 - 1008 should end up with the same mssfix value all they
-         * all result in the same CBC block size/padding and <= 991 and >=1008
+         * all result in the same CBC block size/padding and <= 992 and >=1009
          * should be one block less and more respectively */
         o.ce.mssfix = i;
         frame_calculate_dynamic(&f, &kt, &o, NULL);
-        if (i <= 991)
+        if (i <= 992)
         {
-            assert_int_equal(f.mss_fix, 910);
+            assert_int_equal(f.mss_fix, 914);
         }
-        else if (i >= 1008)
+        else if (i >= 1009)
         {
-            assert_int_equal(f.mss_fix, 942);
+            assert_int_equal(f.mss_fix, 946);
         }
         else
         {
-            assert_int_equal(f.mss_fix, 926);
+            assert_int_equal(f.mss_fix, 930);
         }
     }
     o.comp.alg = COMP_ALG_UNDEF;
 #endif /* ifdef USE_COMP */
 
-    /* tls client, auth SHA1, cipher AES-256-GCM */
+    /*  auth SHA1, cipher AES-256-GCM */
     o.authname = "SHA1";
     o.ciphername = "AES-256-GCM";
-    o.tls_client = true;
     o.peer_id = 77;
     o.use_peer_id = true;
-    init_key_type(&kt, o.ciphername, o.authname, true, false);
+    init_key_type(&kt, o.ciphername, o.authname, false);
 
     for (int i = 900; i <= 1200; i++)
     {
@@ -685,7 +656,7 @@
 
     data->gc = gc_new();
 
-    init_key_type(&data->kt, "AES-128-GCM", "none", true, false);
+    init_key_type(&data->kt, "AES-128-GCM", "none", false);
 
     /* have an epoch key that uses 0x23 for the key for all bytes */
     struct epoch_key epoch1send = { .epoch = 1, .epoch_key = { 0x23 } };
@@ -907,7 +878,7 @@
     struct epoch_key e17 = { .epoch = 17, .epoch_key = { 19, 12 } };
     struct key_type kt = { 0 };
     struct key_parameters key_parameters = { 0 };
-    init_key_type(&kt, "AES-192-GCM", "none", true, false);
+    init_key_type(&kt, "AES-192-GCM", "none", false);
 
 
     epoch_data_key_derive(&key_parameters, &e17, &kt);
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index fbbb40f..49ba833 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -173,7 +173,7 @@
     tas.tls_wrap.opt.flags |= (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);
 
     struct key_type tls_crypt_kt;
-    init_key_type(&tls_crypt_kt, "none", "SHA1", true, false);
+    init_key_type(&tls_crypt_kt, "none", "SHA1", false);
 
     crypto_read_openvpn_key(&tls_crypt_kt, &tas.tls_wrap.opt.key_ctx_bi, static_key, true,
                             key_direction, "Control Channel Authentication", "tls-auth", NULL);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
