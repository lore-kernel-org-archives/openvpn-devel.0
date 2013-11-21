From: David Sommerseth <dazo@...384...>
Date: Thu, 21 Nov 2013 18:02:11 +0100
Message-Id: <1385053332-14533-4-git-send-email-dazo@...384...>
In-Reply-To: <1385053332-14533-1-git-send-email-dazo@...384...>
References: <1385053332-14533-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 3/4] Move ALLOC_OBJ() macro to use calloc()
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

From: David Sommerseth <davids@...1347...>

This continues the malloc() -> calloc() patch set.

This patch also merges ALLOC_OBJ() and ALLOC_OBJ_CLEAR(),
as ALLOC_OBJ_CLEAR() would just be a straight wrapper around
ALLOC_OBJ()

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/buffer.c       |  6 +++---
 src/openvpn/buffer.h       | 10 ++--------
 src/openvpn/comp.c         |  6 +++---
 src/openvpn/event.c        |  8 ++++----
 src/openvpn/fragment.c     |  2 +-
 src/openvpn/init.c         |  2 +-
 src/openvpn/list.c         |  2 +-
 src/openvpn/manage.c       |  4 ++--
 src/openvpn/mbuf.c         |  2 +-
 src/openvpn/mroute.c       |  2 +-
 src/openvpn/mtcp.c         |  2 +-
 src/openvpn/multi.c        |  2 +-
 src/openvpn/pf.c           |  8 ++++----
 src/openvpn/plugin.c       |  6 +++---
 src/openvpn/pool.c         |  4 ++--
 src/openvpn/proxy.c        |  2 +-
 src/openvpn/ps.c           |  6 +++---
 src/openvpn/schedule.c     |  4 ++--
 src/openvpn/socket.c       |  2 +-
 src/openvpn/socks.c        |  2 +-
 src/openvpn/ssl.c          | 10 +++++-----
 src/openvpn/ssl_openssl.c  |  2 +-
 src/openvpn/ssl_polarssl.c | 22 +++++++++++-----------
 src/openvpn/ssl_verify.c   |  4 ++--
 src/openvpn/status.c       |  2 +-
 25 files changed, 58 insertions(+), 64 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index cd8d397..372eb24 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -943,7 +943,7 @@ struct buffer_list *
 buffer_list_new (const int max_size)
 {
   struct buffer_list *ret;
-  ALLOC_OBJ_CLEAR (ret, struct buffer_list);
+  ALLOC_OBJ (ret, struct buffer_list);
   ret->max_size = max_size;
   ret->size = 0;
   return ret;
@@ -998,7 +998,7 @@ buffer_list_push_data (struct buffer_list *ol, const uint8_t *data, size_t size)
   struct buffer_entry *e = NULL;
   if (data && (!ol->max_size || ol->size < ol->max_size))
     {
-      ALLOC_OBJ_CLEAR (e, struct buffer_entry);
+      ALLOC_OBJ (e, struct buffer_entry);
 
       ++ol->size;
       if (ol->tail)
@@ -1047,7 +1047,7 @@ buffer_list_aggregate (struct buffer_list *bl, const size_t max)
 	  int i;
 	  struct buffer_entry *e = bl->head, *f;
 
-	  ALLOC_OBJ_CLEAR (f, struct buffer_entry);
+	  ALLOC_OBJ (f, struct buffer_entry);
 	  f->buf.data = calloc (1, size);
 	  check_malloc_return (f->buf.data);
 	  f->buf.capacity = size;
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index bbf715a..81d8fea 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -824,18 +824,12 @@ gc_reset (struct gc_arena *a)
 
 #define ALLOC_OBJ(dptr, type) \
 { \
-  check_malloc_return ((dptr) = (type *) malloc (sizeof (type))); \
-}
-
-#define ALLOC_OBJ_CLEAR(dptr, type) \
-{ \
-  ALLOC_OBJ (dptr, type); \
-  memset ((dptr), 0, sizeof(type)); \
+  check_malloc_return ((dptr) = (type *) calloc (1, sizeof (type)));     \
 }
 
 #define ALLOC_ARRAY(dptr, type, n) \
 { \
-  check_malloc_return ((dptr) = (type *) malloc (array_mult_safe (sizeof (type), (n), 0))); \
+  check_malloc_return ((dptr) = (type *) calloc (1, array_mult_safe (sizeof (type), (n), 0))); \
 }
 
 #define ALLOC_ARRAY_GC(dptr, type, n, gc) \
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 9692257..1507fd2 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -45,14 +45,14 @@ comp_init(const struct compress_options *opt)
   switch (opt->alg)
     {
     case COMP_ALG_STUB:
-      ALLOC_OBJ_CLEAR (compctx, struct compress_context);
+      ALLOC_OBJ (compctx, struct compress_context);
       compctx->flags = opt->flags;
       compctx->alg = comp_stub_alg;
       (*compctx->alg.compress_init)(compctx);
       break;
 #ifdef ENABLE_LZO
     case COMP_ALG_LZO:
-      ALLOC_OBJ_CLEAR (compctx, struct compress_context);
+      ALLOC_OBJ (compctx, struct compress_context);
       compctx->flags = opt->flags;
       compctx->alg = lzo_alg;
       (*compctx->alg.compress_init)(compctx);
@@ -60,7 +60,7 @@ comp_init(const struct compress_options *opt)
 #endif
 #ifdef ENABLE_SNAPPY
     case COMP_ALG_SNAPPY:
-      ALLOC_OBJ_CLEAR (compctx, struct compress_context);
+      ALLOC_OBJ (compctx, struct compress_context);
       compctx->flags = opt->flags;
       compctx->alg = snappy_alg;
       (*compctx->alg.compress_init)(compctx);
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 34a3c45..e8ebbd2 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -432,7 +432,7 @@ we_init (int *maxevents, unsigned int flags)
 
   dmsg (D_EVENT_WAIT, "WE_INIT maxevents=%d flags=0x%08x", *maxevents, flags);
 
-  ALLOC_OBJ_CLEAR (wes, struct we_set);
+  ALLOC_OBJ (wes, struct we_set);
 
   /* set dispatch functions */
   wes->func.free = we_free;
@@ -585,7 +585,7 @@ ep_init (int *maxevents, unsigned int flags)
 
   set_cloexec (fd);
 
-  ALLOC_OBJ_CLEAR (eps, struct ep_set);
+  ALLOC_OBJ (eps, struct ep_set);
 
   /* set dispatch functions */
   eps->func.free = ep_free;
@@ -774,7 +774,7 @@ po_init (int *maxevents, unsigned int flags)
 
   dmsg (D_EVENT_WAIT, "PO_INIT maxevents=%d flags=0x%08x", *maxevents, flags);
 
-  ALLOC_OBJ_CLEAR (pos, struct po_set);
+  ALLOC_OBJ (pos, struct po_set);
 
   /* set dispatch functions */
   pos->func.free = po_free;
@@ -973,7 +973,7 @@ se_init (int *maxevents, unsigned int flags)
 
   dmsg (D_EVENT_WAIT, "SE_INIT maxevents=%d flags=0x%08x", *maxevents, flags);
 
-  ALLOC_OBJ_CLEAR (ses, struct se_set);
+  ALLOC_OBJ (ses, struct se_set);
 
   /* set dispatch functions */
   ses->func.free = se_free;
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 7ad1d61..7da9098 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -88,7 +88,7 @@ fragment_init (struct frame *frame)
 
   /* code that initializes other parts of
      fragment_master assume an initial CLEAR */
-  ALLOC_OBJ_CLEAR (ret, struct fragment_master);
+  ALLOC_OBJ (ret, struct fragment_master);
 
   /* add in the size of our contribution to the expanded frame size */
   frame_add_to_extra_frame (frame, sizeof(fragment_header_type));
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ba15fe3..705d50b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2568,7 +2568,7 @@ init_context_buffers (const struct frame *frame)
 {
   struct context_buffers *b;
 
-  ALLOC_OBJ_CLEAR (b, struct context_buffers);
+  ALLOC_OBJ (b, struct context_buffers);
 
   b->read_link_buf = alloc_buf (BUF_SIZE (frame));
   b->read_tun_buf = alloc_buf (BUF_SIZE (frame));
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index ea6bd74..df13450 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -47,7 +47,7 @@ hash_init (const int n_buckets,
   int i;
 
   ASSERT (n_buckets > 0);
-  ALLOC_OBJ_CLEAR (h, struct hash);
+  ALLOC_OBJ (h, struct hash);
   h->n_buckets = (int) adjust_power_of_2 (n_buckets);
   h->mask = h->n_buckets - 1;
   h->hash_function = hash_function;
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 9c40fbe..6c4070f 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2233,7 +2233,7 @@ struct management *
 management_init (void)
 {
   struct management *man;
-  ALLOC_OBJ_CLEAR (man, struct management);
+  ALLOC_OBJ (man, struct management);
 
   man_persist_init (man,
 		    MANAGEMENT_LOG_HISTORY_INITIAL_SIZE,
@@ -3204,7 +3204,7 @@ struct command_line *
 command_line_new (const int buf_len)
 {
   struct command_line *cl;
-  ALLOC_OBJ_CLEAR (cl, struct command_line);
+  ALLOC_OBJ (cl, struct command_line);
   cl->buf = alloc_buf (buf_len);
   cl->residual = alloc_buf (buf_len);
   return cl;
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 82f2388..0d0fe56 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -43,7 +43,7 @@ struct mbuf_set *
 mbuf_init (unsigned int size)
 {
   struct mbuf_set *ret;
-  ALLOC_OBJ_CLEAR (ret, struct mbuf_set);
+  ALLOC_OBJ (ret, struct mbuf_set);
   ret->capacity = adjust_power_of_2 (size);
   ALLOC_ARRAY (ret->array, struct mbuf_item, ret->capacity);
   return ret;
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 850e336..f03a8b7 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -454,7 +454,7 @@ struct mroute_helper *
 mroute_helper_init (int ageable_ttl_secs)
 {
   struct mroute_helper *mh;
-  ALLOC_OBJ_CLEAR (mh, struct mroute_helper);
+  ALLOC_OBJ (mh, struct mroute_helper);
   mh->ageable_ttl_secs = ageable_ttl_secs;
   return mh;
 }
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index dc15f09..5db7dcf 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -182,7 +182,7 @@ multi_tcp_init (int maxevents, int *maxclients)
   ASSERT (maxevents >= 1);
   ASSERT (maxclients);
 
-  ALLOC_OBJ_CLEAR (mtcp, struct multi_tcp);
+  ALLOC_OBJ (mtcp, struct multi_tcp);
   mtcp->maxevents = maxevents + extra_events;
   mtcp->es = event_set_init (&mtcp->maxevents, 0);
   wait_signal (mtcp->es, MTCP_SIG);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f016b14..2cb37c8 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -653,7 +653,7 @@ multi_create_instance (struct multi_context *m, const struct mroute_addr *real)
 
   msg (D_MULTI_MEDIUM, "MULTI: multi_create_instance called");
 
-  ALLOC_OBJ_CLEAR (mi, struct multi_instance);
+  ALLOC_OBJ (mi, struct multi_instance);
 
   mi->gc = gc_new ();
   multi_instance_inc_refcount (mi);
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 461beed..8f4ca72 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -75,7 +75,7 @@ static bool
 add_client (const char *line, const char *prefix, const int line_num, struct pf_cn_elem ***next, const bool exclude)
 {
   struct pf_cn_elem *e;
-  ALLOC_OBJ_CLEAR (e, struct pf_cn_elem);
+  ALLOC_OBJ (e, struct pf_cn_elem);
   e->rule.exclude = exclude;
   e->rule.cn = string_alloc (line, NULL);
   **next = e;
@@ -130,7 +130,7 @@ add_subnet (const char *line, const char *prefix, const int line_num, struct pf_
 
   {
     struct pf_subnet *e;
-    ALLOC_OBJ_CLEAR (e, struct pf_subnet);
+    ALLOC_OBJ (e, struct pf_subnet);
     e->rule.exclude = exclude;
     e->rule.network = ntohl (network.s_addr);
     e->rule.netmask = netmask;
@@ -188,7 +188,7 @@ pf_init (const struct buffer_list *bl, const char *prefix, const bool allow_kill
   struct pf_set *pfs = NULL;
   char line[PF_MAX_LINE_LEN];
 
-  ALLOC_OBJ_CLEAR (pfs, struct pf_set);
+  ALLOC_OBJ (pfs, struct pf_set);
   if (bl)
     {
       struct pf_cn_elem **cl = &pfs->cns.list;
@@ -300,7 +300,7 @@ pf_init (const struct buffer_list *bl, const char *prefix, const bool allow_kill
   
  kill:
   pf_destroy (pfs);
-  ALLOC_OBJ_CLEAR (pfs, struct pf_set);
+  ALLOC_OBJ (pfs, struct pf_set);
   pfs->kill = true;
   return pfs;
 }
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 71ad0b6..cad98ac 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -561,7 +561,7 @@ struct plugin_list *
 plugin_list_inherit (const struct plugin_list *src)
 {
   struct plugin_list *pl;
-  ALLOC_OBJ_CLEAR (pl, struct plugin_list);
+  ALLOC_OBJ (pl, struct plugin_list);
   pl->common = src->common;
   ASSERT (pl->common);
   plugin_per_client_init (pl->common, &pl->per_client, -1);
@@ -574,7 +574,7 @@ plugin_common_init (const struct plugin_option_list *list)
   int i;
   struct plugin_common *pc;
 
-  ALLOC_OBJ_CLEAR (pc, struct plugin_common);
+  ALLOC_OBJ (pc, struct plugin_common);
 
   for (i = 0; i < list->n; ++i)
     {
@@ -636,7 +636,7 @@ struct plugin_list *
 plugin_list_init (const struct plugin_option_list *list)
 {
   struct plugin_list *pl;
-  ALLOC_OBJ_CLEAR (pl, struct plugin_list);
+  ALLOC_OBJ (pl, struct plugin_list);
   pl->common = plugin_common_init (list);
   pl->common_owned = true;
   return pl;
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 28c26b4..0addda7 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -147,7 +147,7 @@ ifconfig_pool_init (int type, in_addr_t start, in_addr_t end,
   struct ifconfig_pool *pool = NULL;
 
   ASSERT (start <= end && end - start < IFCONFIG_POOL_MAX);
-  ALLOC_OBJ_CLEAR (pool, struct ifconfig_pool);
+  ALLOC_OBJ (pool, struct ifconfig_pool);
 
   pool->type = type;
   pool->duplicate_cn = duplicate_cn;
@@ -406,7 +406,7 @@ ifconfig_pool_persist_init (const char *filename, int refresh_freq)
 
   ASSERT (filename);
 
-  ALLOC_OBJ_CLEAR (ret, struct ifconfig_pool_persist);
+  ALLOC_OBJ (ret, struct ifconfig_pool_persist);
   if (refresh_freq > 0)
     {
       ret->fixed = false;
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 9ef1b8f..58e1338 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -445,7 +445,7 @@ http_proxy_new (const struct http_proxy_options *o)
 
   ASSERT (legal_ipv4_port (o->port));
 
-  ALLOC_OBJ_CLEAR (p, struct http_proxy_info);
+  ALLOC_OBJ (p, struct http_proxy_info);
   p->options = *o;
 
   /* parse authentication method */
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index f6b5212..d68e47d 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -435,8 +435,8 @@ proxy_entry_new (struct proxy_connection **list,
   set_nonblock (sd_server);
 
   /* allocate 2 new proxy_connection objects */
-  ALLOC_OBJ_CLEAR (pc, struct proxy_connection);
-  ALLOC_OBJ_CLEAR (cp, struct proxy_connection);
+  ALLOC_OBJ (pc, struct proxy_connection);
+  ALLOC_OBJ (cp, struct proxy_connection);
 
   /* client object */
   pc->defined = true;
@@ -798,7 +798,7 @@ port_share_open (const char *host,
   in_addr_t hostaddr;
   struct port_share *ps;
 
-  ALLOC_OBJ_CLEAR (ps, struct port_share);
+  ALLOC_OBJ (ps, struct port_share);
   ps->foreground_fd = -1;
   ps->background_pid = -1;
 
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index 471330f..520992b 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -368,7 +368,7 @@ schedule_init (void)
 {
   struct schedule *s;
 
-  ALLOC_OBJ_CLEAR (s, struct schedule);
+  ALLOC_OBJ (s, struct schedule);
   return s;
 }
 
@@ -605,7 +605,7 @@ schedule_test (void)
 
   for (i = 0; i < n; ++i)
     {
-      ALLOC_OBJ_CLEAR (array[i], struct schedule_entry);
+      ALLOC_OBJ (array[i], struct schedule_entry);
       tv_randomize (&array[i]->tv);
       /*schedule_print (s);*/
       /*schedule_verify (s);*/
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 3c0a379..7e44569 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1335,7 +1335,7 @@ link_socket_new (void)
 {
   struct link_socket *sock;
 
-  ALLOC_OBJ_CLEAR (sock, struct link_socket);
+  ALLOC_OBJ (sock, struct link_socket);
   sock->sd = SOCKET_UNDEFINED;
 #ifdef ENABLE_SOCKS
   sock->ctrl_sd = SOCKET_UNDEFINED;
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 235982e..874c95e 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -67,7 +67,7 @@ socks_proxy_new (const char *server,
 {
   struct socks_proxy_info *p;
 
-  ALLOC_OBJ_CLEAR (p, struct socks_proxy_info);
+  ALLOC_OBJ (p, struct socks_proxy_info);
 
   ASSERT (server);
   ASSERT (legal_ipv4_port (port));
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7ceb79b..1650b27 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -733,12 +733,12 @@ key_state_init (struct tls_session *session, struct key_state *ks)
     session->key_id = 1;
 
   /* allocate key source material object */
-  ALLOC_OBJ_CLEAR (ks->key_src, struct key_source2);
+  ALLOC_OBJ (ks->key_src, struct key_source2);
 
   /* allocate reliability objects */
-  ALLOC_OBJ_CLEAR (ks->send_reliable, struct reliable);
-  ALLOC_OBJ_CLEAR (ks->rec_reliable, struct reliable);
-  ALLOC_OBJ_CLEAR (ks->rec_ack, struct reliable_ack);
+  ALLOC_OBJ (ks->send_reliable, struct reliable);
+  ALLOC_OBJ (ks->rec_reliable, struct reliable);
+  ALLOC_OBJ (ks->rec_ack, struct reliable_ack);
 
   /* allocate buffers */
   ks->plaintext_read_buf = alloc_buf (TLS_CHANNEL_BUF_SIZE);
@@ -1030,7 +1030,7 @@ tls_multi_init (struct tls_options *tls_options)
 {
   struct tls_multi *ret;
 
-  ALLOC_OBJ_CLEAR (ret, struct tls_multi);
+  ALLOC_OBJ (ret, struct tls_multi);
 
   /* get command line derived options */
   ret->opt = *tls_options;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index e392691..5399f5f 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -675,7 +675,7 @@ tls_ctx_use_external_private_key (struct tls_root_ctx *ctx, X509 *cert)
   ASSERT (NULL != cert);
 
   /* allocate custom RSA method object */
-  ALLOC_OBJ_CLEAR (rsa_meth, RSA_METHOD);
+  ALLOC_OBJ (rsa_meth, RSA_METHOD);
   rsa_meth->name = "OpenVPN external private key RSA Method";
   rsa_meth->rsa_pub_enc = rsa_pub_enc;
   rsa_meth->rsa_pub_dec = rsa_pub_dec;
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index fb73225..83d5ae2 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -71,11 +71,11 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
   ASSERT(NULL != ctx);
   CLEAR(*ctx);
 
-  ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
-  ALLOC_OBJ_CLEAR(ctx->priv_key, rsa_context);
+  ALLOC_OBJ (ctx->dhm_ctx, dhm_context);
+  ALLOC_OBJ (ctx->priv_key, rsa_context);
 
-  ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_cert);
-  ALLOC_OBJ_CLEAR(ctx->crt_chain, x509_cert);
+  ALLOC_OBJ (ctx->ca_chain, x509_cert);
+  ALLOC_OBJ (ctx->crt_chain, x509_cert);
 
 
   ctx->endpoint = SSL_IS_SERVER;
@@ -88,11 +88,11 @@ tls_ctx_client_new(struct tls_root_ctx *ctx)
   ASSERT(NULL != ctx);
   CLEAR(*ctx);
 
-  ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
-  ALLOC_OBJ_CLEAR(ctx->priv_key, rsa_context);
+  ALLOC_OBJ (ctx->dhm_ctx, dhm_context);
+  ALLOC_OBJ (ctx->priv_key, rsa_context);
 
-  ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_cert);
-  ALLOC_OBJ_CLEAR(ctx->crt_chain, x509_cert);
+  ALLOC_OBJ (ctx->ca_chain, x509_cert);
+  ALLOC_OBJ (ctx->crt_chain, x509_cert);
 
   ctx->endpoint = SSL_IS_CLIENT;
   ctx->initialised = true;
@@ -520,7 +520,7 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
   ASSERT(ks_ssl);
   CLEAR(*ks_ssl);
 
-  ALLOC_OBJ_CLEAR(ks_ssl->ctx, ssl_context);
+  ALLOC_OBJ (ks_ssl->ctx, ssl_context);
   if (0 == ssl_init(ks_ssl->ctx))
     {
       /* Initialise SSL context */
@@ -591,8 +591,8 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
       }
 
       /* Initialise BIOs */
-      ALLOC_OBJ_CLEAR (ks_ssl->ct_in, endless_buffer);
-      ALLOC_OBJ_CLEAR (ks_ssl->ct_out, endless_buffer);
+      ALLOC_OBJ (ks_ssl->ct_in, endless_buffer);
+      ALLOC_OBJ (ks_ssl->ct_out, endless_buffer);
       ssl_set_bio (ks_ssl->ctx, endless_buf_read, ks_ssl->ct_in,
 	  endless_buf_write, ks_ssl->ct_out);
     }
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 4dd3aa2..43579c7 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -196,7 +196,7 @@ cert_hash_remember (struct tls_session *session, const int error_depth, const un
   if (error_depth >= 0 && error_depth < MAX_CERT_DEPTH)
     {
       if (!session->cert_hash_set)
-	ALLOC_OBJ_CLEAR (session->cert_hash_set, struct cert_hash_set);
+	ALLOC_OBJ (session->cert_hash_set, struct cert_hash_set);
       if (!session->cert_hash_set->ch[error_depth])
 	ALLOC_OBJ (session->cert_hash_set->ch[error_depth], struct cert_hash);
       {
@@ -271,7 +271,7 @@ cert_hash_copy (const struct cert_hash_set *chs)
   if (chs)
     {
       int i;
-      ALLOC_OBJ_CLEAR (dest, struct cert_hash_set);
+      ALLOC_OBJ (dest, struct cert_hash_set);
       for (i = 0; i < MAX_CERT_DEPTH; ++i)
 	{
 	  const struct cert_hash *ch = chs->ch[i];
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index b7ff484..1f492d5 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -67,7 +67,7 @@ status_open (const char *filename,
   struct status_output *so = NULL;
   if (filename || msglevel >= 0 || vout)
     {
-      ALLOC_OBJ_CLEAR (so, struct status_output);
+      ALLOC_OBJ (so, struct status_output);
       so->flags = flags;
       so->msglevel = msglevel;
       so->vout = vout;
-- 
1.8.3.1


