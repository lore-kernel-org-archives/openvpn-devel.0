Sender: daniel kubec <kubec.daniel@...277...>
Date: Thu, 24 Apr 2014 18:32:18 +0200
From: Daniel Kubec <niel@...1898...>
Message-ID: <20140424163216.GA4403@...1907...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <56408.109.81.184.65.1397980655.squirrel@...1899...>
Subject: Re: [Openvpn-devel] [PATCH] Keying Material Exporters [RFC 5705]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

updated patch:

git format-patch -n HEAD^ --stdout > ./openvpn-channel-bindings.patch

vpn_binding_key: 
  - keying material derived by openvpn's crypto later (ssl.c:tls1_*)
  - life time across negotiations (works a bit like EKM)

tls_binding_key: Exported Keying Material [RFC 5705] 
  - derived when crypto backend support ( currently openssl >= 1.0.2 )

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-channel-bindings.patch"

From b577afe5c076b9f93ff6112c9efb7966f32f86a3 Mon Sep 17 00:00:00 2001
From: Daniel Kubec <niel@...1898...>
Date: Thu, 24 Apr 2014 18:17:17 +0200
Subject: [PATCH 1/1] Channel Bindings based on Keying Material Exporters [RFC 5705]

---
 src/openvpn/init.c        |    8 ++
 src/openvpn/options.c     |   17 +++
 src/openvpn/options.h     |    4 +
 src/openvpn/ssl.c         |  262 +++++++++++++++++++++++++++++++++++----------
 src/openvpn/ssl_common.h  |   13 +++
 src/openvpn/ssl_openssl.c |   22 ++++
 6 files changed, 267 insertions(+), 59 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c2907cd..7dc1982 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2292,6 +2292,13 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.comp_options = options->comp;
 #endif
 
+  /* Checking for required parameters for Channel Bindings */
+  to.ekm_size = options->keying_material_exporter_length;
+  to.ekm_label = (uint8_t*)options->keying_material_exporter_label;
+  to.ekm_label_size = to.ekm_label ? strlen(to.ekm_label) : 0;
+
+  to.ekm_used = (to.ekm_label_size && to.ekm_size >= 20) ? true : false;
+
   /* TLS handshake authentication (--tls-auth) */
   if (options->tls_auth_file)
     {
@@ -2315,6 +2322,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
 
   if (flags & CF_INIT_TLS_AUTH_STANDALONE)
     c->c2.tls_auth_standalone = tls_auth_standalone_init (&to, &c->c2.gc);
+
 }
 
 static void
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4af2974..8be527d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6984,6 +6984,23 @@ add_option (struct options *options,
       options->persist_mode = 1;
     }
 #endif
+  else if (streq (p[0], "keying-material-exporter-label") && p[1])
+    {
+      if (strncmp(p[1], "EXPORTER", 8))
+        {
+          msg (msglevel, "keying material exporter labels SHOULD begin with \"EXPORTER\"");
+          goto err;
+        }
+        VERIFY_PERMISSION (OPT_P_GENERAL);
+        options->keying_material_exporter_label = p[1];
+    }
+  else if (streq (p[0], "keying-material-exporter-length"))
+    {
+      int len = positive_atoi (p[1]);
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+
+      options->keying_material_exporter_length = len;
+    }
   else
     {
       int i;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index ec1d091..8c8aeb3 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -600,6 +600,10 @@ struct options
   bool show_net_up;
   int route_method;
 #endif
+
+  /* Keying Material Exporters [RFC 5705] */
+  const char *keying_material_exporter_label;
+  int keying_material_exporter_length;
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b09e52b..bac1c77 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2,12 +2,13 @@
  *  OpenVPN -- An application to securely tunnel IP networks
  *             over a single TCP/UDP port, with support for SSL/TLS-based
  *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
+ *             packet encryption, packet authentication,
+ *             packet compression and channel bindings.
  *
  *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
  *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
+ *  Copyright (C) 2014 Daniel Kubec <niel@...1898...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -887,6 +888,14 @@ tls_session_init (struct tls_multi *multi, struct tls_session *session)
 	P_CONTROL_HARD_RESET_SERVER_V2 : P_CONTROL_HARD_RESET_CLIENT_V2;
     }
 
+  /* allocate buffers for vpn_binding_key and tls_ekm [RFC 5705] */            
+  session->ekm = malloc (session->opt->ekm_size);                              
+  session->ekm_exported = false;                                               
+  session->binding_key = malloc (session->opt->ekm_size);                      
+
+  memset (session->ekm, 0, session->opt->ekm_size);                             
+  memset (session->binding_key, 0, session->opt->ekm_size);
+
   /* Initialize control channel authentication parameters */
   session->tls_auth = session->opt->tls_auth;
 
@@ -1492,45 +1501,143 @@ openvpn_PRF (const uint8_t *secret,
   VALGRIND_MAKE_READABLE ((void *)output, output_len);
 }
 
+static void                                                                    
+generate_master_secret(struct key_ctx_bi *key,                                 
+                       const struct key_type *key_type,                        
+                       const struct key_source2 *key_src,                      
+                       uint8_t *master,                                        
+                       unsigned int master_size)                               
+{                                                                              
+  /* compute master secret */                                                  
+  openvpn_PRF (key_src->client.pre_master,                                     
+               sizeof(key_src->client.pre_master),                             
+               KEY_EXPANSION_ID " master secret",                              
+               key_src->client.random1,                                        
+               sizeof(key_src->client.random1),                                
+               key_src->server.random1,                                        
+               sizeof(key_src->server.random1),                                
+               NULL,                                                           
+               NULL,                                                           
+               master,                                                         
+               master_size);                                                   
+
+  key_source2_print (key_src);                                                 
+}
+
+/*                                                                              
+ * Use the tls1_keying_material_exporter for generating VPN Binding Key        
+ *                                                                             
+ * Labels here have the same definition as in TLS, i.e., an ASCII string       
+ * with no terminating NULL.                                                   
+ *                                                                             
+ * Note that exporter labels have the potential to collide with existing       
+ * tls1_PRF labels.  In order to prevent this, labels SHOULD begin with
+ * "EXPORTER".
+ *
+ * The output is a pseudorandom bit string of length bytes generated
+ * from the master_secret.
+ *
+ * If no context is provided, it then computes:
+ *
+ *     tls1_PRF(SecurityParameters.master_secret, label,
+ *              SecurityParameters.client_random +
+ *              SecurityParameters.server_random)[length]
+ *
+ * If context is provided, it computes:
+ *
+ *     tls1_PRF(SecurityParameters.master_secret, label,
+ *              SecurityParameters.client_random +
+ *              SecurityParameters.server_random +
+ *              context_value_length + context_value)[length]
+ */
+
+static void
+tls1_keying_material_exporter(uint8_t *master, int master_size,
+                               uint8_t *label, int label_len,
+                               const uint8_t *client_random, int client_random_len,
+                               const uint8_t *server_random, int server_random_len,
+                               const uint8_t *context_value, int context_value_len,
+                               uint8_t *out, int out_len)
+{
+  struct buffer seed = alloc_buf (master_size
+                                + label_len
+                                + client_random_len
+                                + server_random_len
+                                + context_value_len);
+
+  ASSERT (buf_write (&seed, label, label_len));
+  ASSERT (buf_write (&seed, client_random, client_random_len));
+  ASSERT (buf_write (&seed, server_random, server_random_len));
+
+  if (context_value)
+    ASSERT (buf_write (&seed, context_value, context_value_len));
+
+  /* compute PRF */
+  tls1_PRF (BPTR(&seed), BLEN(&seed), master, master_size, out, out_len);
+
+  buf_clear (&seed);
+  free_buf (&seed);
+
+  VALGRIND_MAKE_READABLE ((void *)out, out_len);
+}
+
+/*
+ * Generated Binding Key using tls1_keying_material_exporter()
+ */
+static bool
+generate_binding_key(uint8_t *master,
+                     int master_size,
+                     struct key_ctx_bi *key,
+                     const struct key_type *key_type,
+                     const struct key_source2 *key_src,
+                     uint8_t *label, int label_len,
+                     uint8_t *binding_key, int binding_key_len)
+{
+  const char *context_value = KEY_EXPANSION_ID " binding key";
+  struct gc_arena gc = gc_new ();
+
+  tls1_keying_material_exporter(master, master_size,
+                                label, label_len,
+                                key_src->client.random2,
+                                sizeof(key_src->client.random2),
+                                key_src->server.random2,
+                                sizeof(key_src->server.random2),
+                                context_value,
+                                strlen(context_value),
+                                binding_key, binding_key_len);
+
+  dmsg (D_SHOW_KEY_SOURCE, "vpn_binding_key: %s",
+        format_hex (binding_key, binding_key_len, 0, &gc));
+  gc_free (&gc);
+  return true;
+}
+
 /* 
  * Using source entropy from local and remote hosts, mix into
  * master key.
  */
 static bool
-generate_key_expansion (struct key_ctx_bi *key,
+generate_key_expansion (uint8_t *master, 
+                        int master_size,
+                        struct key_ctx_bi *key,
 			const struct key_type *key_type,
 			const struct key_source2 *key_src,
 			const struct session_id *client_sid,
 			const struct session_id *server_sid,
 			bool server)
 {
-  uint8_t master[48];
   struct key2 key2;
   bool ret = false;
   int i;
 
-  CLEAR (master);
   CLEAR (key2);
 
   /* debugging print of source key material */
   key_source2_print (key_src);
 
-  /* compute master secret */
-  openvpn_PRF (key_src->client.pre_master,
-	       sizeof(key_src->client.pre_master),
-	       KEY_EXPANSION_ID " master secret",
-	       key_src->client.random1,
-	       sizeof(key_src->client.random1),
-	       key_src->server.random1,
-	       sizeof(key_src->server.random1),
-	       NULL,
-	       NULL,
-	       master,
-	       sizeof(master));
-  
   /* compute key expansion */
   openvpn_PRF (master,
-	       sizeof(master),
+	       master_size,
 	       KEY_EXPANSION_ID " key expansion",
 	       key_src->client.random2,
 	       sizeof(key_src->client.random2),
@@ -1867,6 +1974,68 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 }
 
 static bool
+key_method_final(struct tls_session *session, bool server)
+{
+  struct key_state *ks = &session->key[KS_PRIMARY];        /* primary key */
+  const struct session_id *client_sid;
+  const struct session_id *server_sid;
+  uint8_t master[48];
+
+  CLEAR(master);
+
+  generate_master_secret(&ks->key, &session->opt->key_type,
+                         ks->key_src, master, sizeof(master));
+
+  /* VPN binding key identifies TLS Session across (re)negotiations */
+  if (session->opt->ekm_used && session->key_id == 1)
+    generate_binding_key(master, sizeof(master),
+                         &ks->key, &session->opt->key_type, ks->key_src,
+                         session->opt->ekm_label, session->opt->ekm_label_size,
+                         session->binding_key, session->opt->ekm_size);
+  /*
+   * Call OPENVPN_PLUGIN_TLS_FINAL plugin if defined, for final
+   * veto opportunity over authentication decision.
+   */
+  if (ks->authenticated && plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
+    {
+      if (session->opt->ekm_used)
+        {
+          struct gc_arena gc = gc_new ();
+          setenv_str (session->opt->es, "vpn_binding_key", 
+                      format_hex (session->binding_key, session->opt->ekm_size, 0, &gc));
+
+          /* Exported Keying Material [RFC 5705] */
+          if (session->ekm_exported == true)
+            setenv_str (session->opt->es, "tls_binding_key",
+                        format_hex (session->ekm, session->opt->ekm_size, 0, &gc));
+
+          gc_free (&gc);
+        }
+
+      if (plugin_call (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NULL, session->opt->es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+        ks->authenticated = false;
+    }
+
+  client_sid = server ? &ks->session_id_remote : &session->session_id;
+  server_sid = server ? &session->session_id : &ks->session_id_remote;
+
+  if (!generate_key_expansion (master,
+                               sizeof(master),
+                               &ks->key,
+                               &session->opt->key_type,
+                               ks->key_src,
+                               client_sid,
+                               server_sid,
+                               server))
+    {
+      msg (D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
+      return false;
+    }
+
+  return true;
+}
+
+static bool
 key_method_2_write (struct buffer *buf, struct tls_session *session)
 {
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
@@ -1920,25 +2089,19 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
   /*
    * generate tunnel keys if server
    */
-  if (session->opt->server)
+  if (!session->opt->server)
+    goto done;
+
+  if (!ks->authenticated)
     {
-      if (ks->authenticated)
-	{
-	  if (!generate_key_expansion (&ks->key,
-				       &session->opt->key_type,
-				       ks->key_src,
-				       &ks->session_id_remote,
-				       &session->session_id,
-				       true))
-	    {
-	      msg (D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
-	      goto error;
-	    }
-	}
-		      
       CLEAR (*ks->key_src);
+      goto done;
     }
 
+  if (!key_method_final(session, true))
+    goto error;
+
+ done:
   return true;
 
  error:
@@ -2122,34 +2285,15 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
   buf_clear (buf);
 
   /*
-   * Call OPENVPN_PLUGIN_TLS_FINAL plugin if defined, for final
-   * veto opportunity over authentication decision.
-   */
-  if (ks->authenticated && plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
-    {
-      if (plugin_call (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NULL, session->opt->es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
-	ks->authenticated = false;
-    }
-
-  /*
    * Generate tunnel keys if client
    */
-  if (!session->opt->server)
-    {
-      if (!generate_key_expansion (&ks->key,
-				   &session->opt->key_type,
-				   ks->key_src,
-				   &session->session_id,
-				   &ks->session_id_remote,
-				   false))
-	{
-	  msg (D_TLS_ERRORS, "TLS Error: client generate_key_expansion failed");
-	  goto error;
-	}
-		      
-      CLEAR (*ks->key_src);
-    }
+  if (session->opt->server)
+    goto done;
 
+  if (!key_method_final(session, false))
+    goto error;
+
+ done:
   gc_free (&gc);
   return true;
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 04ba789..ad4c8b1 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -314,6 +314,12 @@ struct tls_options
 
   /* --gremlin bits */
   int gremlin;
+
+  /* Keying Material Exporter [RFC 5705] parameters */
+  uint8_t *ekm_label;
+  int ekm_label_size;
+  bool ekm_used; /* true when Keying Material should be exported */
+  int ekm_size;
 };
 
 /** @addtogroup control_processor
@@ -355,6 +361,13 @@ struct tls_session
   /* during hard reset used to control burst retransmit */
   bool burst;
 
+  /* Exported Keying Material [RFC 5705] */
+  uint8_t *ekm;                 /* buffer size: session->opt->ekm_size */
+  bool ekm_exported;            /* true when ekm contains updated material */
+
+  /* VPN's binding key derived by tls1_keying_material_exporter() */
+  uint8_t *binding_key;         /* buffer size: session->opt->ekm_size */
+
   /* authenticate control packets */
   struct crypto_options tls_auth;
   struct packet_id tls_auth_pid;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 1923230..e59f9e6 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -154,6 +154,28 @@ info_callback (INFO_CALLBACK_SSL_CONST SSL * s, int where, int ret)
 	   SSL_alert_type_string_long (ret),
 	   SSL_alert_desc_string_long (ret));
     }
+  else if (where & SSL_CB_HANDSHAKE_DONE)
+    {
+      struct tls_session *tls;
+      tls = (struct tls_session *)SSL_get_ex_data (s, mydata_index);
+
+      tls->ekm_exported = false;
+      if (tls->opt->ekm_used == false)
+        goto done;
+
+      memset(tls->ekm, 0, tls->opt->ekm_size);
+
+#if (OPENSSL_VERSION_NUMBER > 0x10002000)
+      tls->ekm_exported = (bool)SSL_export_keying_material((SSL *)s,
+                                                           tls->ekm,
+                                                           tls->opt->ekm_size,
+                                                           tls->opt->ekm_label,
+                                                           tls->opt->ekm_label_size,
+                                                           NULL, 0, 0);
+#endif
+done:
+      msg (D_HANDSHAKE_VERBOSE, "SSL Handshake done.");
+    }
 }
 
 /*
-- 
1.7.1


--qMm9M+Fa2AknHoGS--

