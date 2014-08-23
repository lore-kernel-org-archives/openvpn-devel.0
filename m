From: Steffan Karger <steffan@...1856...>
Date: Sat, 23 Aug 2014 18:21:41 +0200
Message-Id: <1408810901-24715-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add option to disable Diffie Hellman key
	exchange by setting "--dh none"
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

As requested on the mailing list and in trac ticket #410, add an option to
disable 'traditional' Diffie Hellman key exchange. People want to be able
to create ecdh-only configurations.

Also update the manpage to reflect the new behaviour, and while touching it
change the text to motivate users towards a more secure configuration.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8         | 15 ++++++++++-----
 src/openvpn/options.c | 14 ++++++++++----
 src/openvpn/ssl.c     |  5 ++++-
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index f2911c0..0448d29 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4238,13 +4238,18 @@ Not available with PolarSSL.
 File containing Diffie Hellman parameters
 in .pem format (required for
 .B \-\-tls-server
-only). Use
+only).
 
-.B openssl dhparam -out dh1024.pem 1024
+Set
+.B file=none
+to disable Diffie Hellman key exchange (and use ECDH only). Note that this
+requires peers to be using an SSL library that supports ECDH TLS cipher suites
+(e.g. OpenSSL 1.0.1+, or PolarSSL 1.3+).
 
-to generate your own, or use the existing dh1024.pem file
-included with the OpenVPN distribution.  Diffie Hellman parameters
-may be considered public.
+Use
+.B openssl dhparam -out dh2048.pem 2048
+to generate 2048-bit DH parameters. Diffie Hellman parameters may be considered
+public.
 .\"*********************************************************
 .TP
 .B \-\-ecdh-curve name
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 84eb6ed..92189a5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2149,10 +2149,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       (options->shared_secret_file != NULL) > 1)
     msg (M_USAGE, "specify only one of --tls-server, --tls-client, or --secret");
 
-  if (options->tls_server)
-    {
-      notnull (options->dh_file, "DH file (--dh)");
-    }
   if (options->tls_server || options->tls_client)
     {
 #ifdef ENABLE_PKCS11
@@ -2504,6 +2500,16 @@ options_postprocess_mutate (struct options *o)
   for (i = 0; i < o->connection_list->len; ++i)
 	options_postprocess_mutate_ce (o, o->connection_list->array[i]);
 
+#ifdef ENABLE_SSL
+  if (o->tls_server)
+    {
+      /* Check that DH file is specified, or explicitly disabled */
+      notnull (o->dh_file, "DH file (--dh)");
+      if (streq (o->dh_file, "none"))
+	o->dh_file = NULL;
+    }
+#endif
+
 #if ENABLE_MANAGEMENT
   if (o->http_proxy_override)
 	options_postprocess_http_proxy_override(o);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3ce1f60..34f02a7 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -483,7 +483,10 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
   if (options->tls_server)
     {
       tls_ctx_server_new(new_ctx);
-      tls_ctx_load_dh_params(new_ctx, options->dh_file, options->dh_file_inline);
+
+      if (options->dh_file)
+	tls_ctx_load_dh_params(new_ctx, options->dh_file,
+			       options->dh_file_inline);
     }
   else				/* if client */
     {
-- 
1.9.1


