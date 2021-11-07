From: Arne Schwabe <arne@...1227...>
Date: Sun,  7 Nov 2021 10:01:47 +0100
Message-Id: <20211107090147.3150261-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove custom PRNG function
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

Remove the custom PRNG from OpenVPN and instead rely always on the random
number generator from the SSL library. The only place that this is in a
performance critical place is the CBC IV generation. Even with that in mind
a micro benchmark shows no significant enough change with OpenSSL 3.0:

------------------------------------------------------------------------
Benchmark                              Time             CPU   Iterations
------------------------------------------------------------------------
BM_OpenSSL_RAND                      842 ns          842 ns       753401
BM_OpenVPN_RAND                      743 ns          743 ns       826690
BM_Encrypt_AES_CBC_dummy            1044 ns         1044 ns       631530
BM_Encrypt_AES_CBC_RAND_bytes       1892 ns         1891 ns       346566
BM_Encrypt_AES_CBC_prng_bytes       1818 ns         1817 ns       373970

(source https://gist.github.com/schwabe/029dc5e5a690df8e2e3f774a13ec7bce)

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                           |  6 ++
 doc/man-sections/advanced-options.rst | 17 ------
 src/openvpn/crypto.c                  | 88 +--------------------------
 src/openvpn/crypto.h                  | 20 ------
 src/openvpn/init.c                    | 30 ---------
 src/openvpn/options.c                 | 30 +--------
 src/openvpn/options.h                 |  2 -
 src/openvpn/ps.c                      |  5 +-
 src/openvpn/ssl.c                     |  1 -
 9 files changed, 9 insertions(+), 190 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index b08bff3d7..174e233c8 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -94,6 +94,11 @@ TLS 1.0 and 1.1 are deprecated
     Should backwards compatibility with older OpenVPN peers be
     required, please see the ``--compat-mode`` instead.
 
+``--prng`` has beeen removed
+    OpenVPN used to implement its own PRNG based on a hash. However implementing
+    a PRNG is better left to a crypto library. So we use mbed TLS or OpenSSL
+    PRNG instead now.
+
 
 Compression no longer enabled by default
     Unless an explicit compression option is specified in the configuration,
@@ -111,6 +116,7 @@ PF (Packet Filtering) support has been removed
 User-visible Changes
 --------------------
 - CHACHA20-POLY1305 is included in the default of ``--data-ciphers`` when available.
+- Option ``--prng`` is ignored as we rely on the SSL library radnom generator.
 
 Overview of changes in 2.5
 ==========================
diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index 24ea8ddb3..cdec95021 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -45,23 +45,6 @@ used when debugging or testing out special usage scenarios.
   Preserve most recently authenticated remote IP address and port number
   across :code:`SIGUSR1` or ``--ping-restart`` restarts.
 
---prng args
-  *(Advanced)* Change the PRNG (Pseudo-random number generator) parameters
-
-  Valid syntaxes:
-  ::
-
-     prng alg
-     prng alg nsl
-
-  Changes the PRNG to use digest algorithm **alg** (default :code:`sha1`),
-  and set ``nsl`` (default :code:`16`) to the size in bytes of the nonce
-  secret length (between 16 and 64).
-
-  Set ``alg`` to :code:`none` to disable the PRNG and use the OpenSSL
-  RAND\_bytes function instead for all of OpenVPN's pseudo-random number
-  needs.
-
 --rcvbuf size
   Set the TCP/UDP socket receive buffer size. Defaults to operating system
   default.
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 0676c8491..1d242ac5a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1681,96 +1681,10 @@ key_len_err:
     return 0;
 }
 
-/*
- * Random number functions, used in cases where we want
- * reasonably strong cryptographic random number generation
- * without depleting our entropy pool.  Used for random
- * IV values and a number of other miscellaneous tasks.
- */
-
-static uint8_t *nonce_data = NULL; /* GLOBAL */
-static const md_kt_t *nonce_md = NULL; /* GLOBAL */
-static int nonce_secret_len = 0; /* GLOBAL */
-
-/* Reset the nonce value, also done periodically to refresh entropy */
-static void
-prng_reset_nonce(void)
-{
-    const int size = md_kt_size(nonce_md) + nonce_secret_len;
-#if 1 /* Must be 1 for real usage */
-    if (!rand_bytes(nonce_data, size))
-    {
-        msg(M_FATAL, "ERROR: Random number generator cannot obtain entropy for PRNG");
-    }
-#else
-    /* Only for testing -- will cause a predictable PRNG sequence */
-    {
-        int i;
-        for (i = 0; i < size; ++i)
-        {
-            nonce_data[i] = (uint8_t) i;
-        }
-    }
-#endif
-}
-
-void
-prng_init(const char *md_name, const int nonce_secret_len_parm)
-{
-    prng_uninit();
-    nonce_md = md_name ? md_kt_get(md_name) : NULL;
-    if (nonce_md)
-    {
-        ASSERT(nonce_secret_len_parm >= NONCE_SECRET_LEN_MIN && nonce_secret_len_parm <= NONCE_SECRET_LEN_MAX);
-        nonce_secret_len = nonce_secret_len_parm;
-        {
-            const int size = md_kt_size(nonce_md) + nonce_secret_len;
-            dmsg(D_CRYPTO_DEBUG, "PRNG init md=%s size=%d", md_kt_name(nonce_md), size);
-            nonce_data = (uint8_t *) malloc(size);
-            check_malloc_return(nonce_data);
-            prng_reset_nonce();
-        }
-    }
-}
-
-void
-prng_uninit(void)
-{
-    free(nonce_data);
-    nonce_data = NULL;
-    nonce_md = NULL;
-    nonce_secret_len = 0;
-}
-
 void
 prng_bytes(uint8_t *output, int len)
 {
-    static size_t processed = 0;
-
-    if (nonce_md)
-    {
-        const int md_size = md_kt_size(nonce_md);
-        while (len > 0)
-        {
-            const int blen = min_int(len, md_size);
-            md_full(nonce_md, nonce_data, md_size + nonce_secret_len, nonce_data);
-            memcpy(output, nonce_data, blen);
-            output += blen;
-            len -= blen;
-
-            /* Ensure that random data is reset regularly */
-            processed += blen;
-            if (processed > PRNG_NONCE_RESET_BYTES)
-            {
-                prng_reset_nonce();
-                processed = 0;
-            }
-        }
-    }
-    else
-    {
-        ASSERT(rand_bytes(output, len));
-    }
+    ASSERT(rand_bytes(output, len));
 }
 
 /* an analogue to the random() function, but use prng_bytes */
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 8e50c632a..795a4d2cd 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -460,24 +460,6 @@ bool
 read_pem_key_file(struct buffer *key, const char *pem_name,
                   const char *key_file, bool key_inline);
 
-/* Minimum length of the nonce used by the PRNG */
-#define NONCE_SECRET_LEN_MIN 16
-
-/* Maximum length of the nonce used by the PRNG */
-#define NONCE_SECRET_LEN_MAX 64
-
-/** Number of bytes of random to allow before resetting the nonce */
-#define PRNG_NONCE_RESET_BYTES 1024
-
-/**
- * Pseudo-random number generator initialisation.
- * (see \c prng_rand_bytes())
- *
- * @param md_name                       Name of the message digest to use
- * @param nonce_secret_len_param        Length of the nonce to use
- */
-void prng_init(const char *md_name, const int nonce_secret_len_parm);
-
 /*
  * Message digest-based pseudo random number generator.
  *
@@ -495,8 +477,6 @@ void prng_init(const char *md_name, const int nonce_secret_len_parm);
  */
 void prng_bytes(uint8_t *output, int len);
 
-void prng_uninit(void);
-
 /* an analogue to the random() function, but use prng_bytes */
 long int get_random(void);
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a9986e529..ce376c7cf 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -797,11 +797,6 @@ init_static(void)
 
     init_ssl_lib();
 
-    /* init PRNG used for IV generation */
-    /* When forking, copy this to more places in the code to avoid fork
-     * random-state predictability */
-    prng_init(NULL, 0);
-
 #ifdef PID_TEST
     packet_id_interactive_test();       /* test the sequence number code */
     return false;
@@ -876,29 +871,6 @@ init_static(void)
     return false;
 #endif
 
-#ifdef PRNG_TEST
-    {
-        struct gc_arena gc = gc_new();
-        uint8_t rndbuf[8];
-        int i;
-        prng_init("sha1", 16);
-        /*prng_init (NULL, 0);*/
-        const int factor = 1;
-        for (i = 0; i < factor * 8; ++i)
-        {
-#if 1
-            prng_bytes(rndbuf, sizeof(rndbuf));
-#else
-            ASSERT(rand_bytes(rndbuf, sizeof(rndbuf)));
-#endif
-            printf("[%d] %s\n", i, format_hex(rndbuf, sizeof(rndbuf), 0, &gc));
-        }
-        gc_free(&gc);
-        prng_uninit();
-        return false;
-    }
-#endif /* ifdef PRNG_TEST */
-
 #ifdef BUFFER_LIST_AGGREGATE_TEST
     /* test buffer_list_aggregate function */
     {
@@ -2927,8 +2899,6 @@ do_init_crypto_tls_c1(struct context *c)
             init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
                           true, warn);
         }
-        /* Initialize PRNG with config-specified digest */
-        prng_init(options->prng_hash, options->prng_nonce_secret_len);
 
         /* initialize tls-auth/crypt/crypt-v2 key */
         do_init_tls_wrap_key(c);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d2a2ead46..ee92b51d2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -526,8 +526,6 @@ static const char usage_message[] =
     "                  (default=%s).\n"
     "                  Set alg=none to disable encryption.\n"
     "--data-ciphers list : List of ciphers that are allowed to be negotiated.\n"
-    "--prng alg [nsl] : For PRNG, use digest algorithm alg, and\n"
-    "                   nonce_secret_len=nsl.  Set alg=none to disable PRNG.\n"
 #ifndef ENABLE_CRYPTO_MBEDTLS
     "--engine [name] : Enable OpenSSL hardware crypto engine functionality.\n"
 #endif
@@ -843,8 +841,6 @@ init_options(struct options *o, const bool init_gc)
     o->ifconfig_pool_persist_refresh_freq = 600;
     o->scheduled_exit_interval = 5;
     o->authname = "SHA1";
-    o->prng_hash = "SHA1";
-    o->prng_nonce_secret_len = 16;
     o->replay = true;
     o->replay_window = DEFAULT_SEQ_BACKTRACK;
     o->replay_time = DEFAULT_TIME_BACKTRACK;
@@ -1719,8 +1715,6 @@ show_settings(const struct options *o)
     SHOW_STR(ciphername);
     SHOW_STR(ncp_ciphers);
     SHOW_STR(authname);
-    SHOW_STR(prng_hash);
-    SHOW_INT(prng_nonce_secret_len);
 #ifndef ENABLE_CRYPTO_MBEDTLS
     SHOW_BOOL(engine);
 #endif /* ENABLE_CRYPTO_MBEDTLS */
@@ -8284,29 +8278,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "prng") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (streq(p[1], "none"))
-        {
-            options->prng_hash = NULL;
-        }
-        else
-        {
-            options->prng_hash = p[1];
-        }
-        if (p[2])
-        {
-            const int sl = atoi(p[2]);
-            if (sl >= NONCE_SECRET_LEN_MIN && sl <= NONCE_SECRET_LEN_MAX)
-            {
-                options->prng_nonce_secret_len = sl;
-            }
-            else
-            {
-                msg(msglevel, "prng parameter nonce_secret_len must be between %d and %d",
-                    NONCE_SECRET_LEN_MIN, NONCE_SECRET_LEN_MAX);
-                goto err;
-            }
-        }
+        msg(M_WARN, "NOTICE: --prng option ignored (SSL library PRNG is used)");
     }
     else if (streq(p[0], "no-replay") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index eb599c5ff..b62a2a927 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -527,8 +527,6 @@ struct options
                                     * ciphername if NCP fails */
     const char *ncp_ciphers;
     const char *authname;
-    const char *prng_hash;
-    int prng_nonce_secret_len;
     const char *engine;
     struct provider_list providers;
     bool replay;
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index a61176172..a0f8a00e9 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -912,10 +912,7 @@ port_share_open(const char *host,
 
         /* no blocking on control channel back to parent */
         set_nonblock(fd[1]);
-
-        /* initialize prng */
-        prng_init(NULL, 0);
-
+        
         /* execute the event loop */
         port_share_proxy(hostaddr, fd[1], max_initial_buf, journal_dir);
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9b47ae294..26b0d4bea 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -345,7 +345,6 @@ void
 free_ssl_lib(void)
 {
     crypto_uninit_lib();
-    prng_uninit();
 
     tls_free_lib();
 }
-- 
2.33.0


