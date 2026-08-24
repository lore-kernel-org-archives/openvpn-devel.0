Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0F8C5DF81
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yYgEJpqS5uLYQ3wdNSkuvYEF0onpx2MIY9jjk86YpJI=; b=XR975kK6kQMS1u4iEcuIJ88R14
	m3WS6e2tGR9H/ZED4KGm9AiWSnjRn4oST2PISG2oEDE1RhuiKQ6uI5NDUDUt2Zj+3Ke4+OQvdduUI
	3BW3TFBoeKcli3ebq4hc0ZfqwtC5oS0IY8Vehf8m9mQemeTWMsAb8tni8ZlxFrD7csKs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyXck-0005mn-IB;
	Mon, 24 Aug 2026 16:34:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wyXce-0005mK-Rk
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:34:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6cH9JkDrJBHqcGqsWIxr6OpKOJV8DyDINuQ24/96TKA=; b=SZEn05XKMFWkJwYbZZ5Wp6deHw
 UcpDxtBk/8CMvBcZgxass5vQ3XWLmK7/tf9f1+R678KBhmDN8qWN23qw2QhWEixuBwiQFP4r/59tz
 H6vBtkcFRm41+QeDkHPsPHB8cSv/dcNkmBNLOUSQpUH5+yx938uSga+Puo0/JhCJMxuo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6cH9JkDrJBHqcGqsWIxr6OpKOJV8DyDINuQ24/96TKA=; b=ajXLPjgte/5MMbTxtevMQQOhMf
 yI95MRfY0wcg2kwbQ7qLSImlHq/TYt+ZrefCWabF/WCP8+B6t857y2AvzODMprjFj/DB18Hqjs+5b
 L3v+sirMXAtov5ecaFTZOhfpcLXQL1aCO2INzLJbRd/zrJdgsykcOjbnP5ELfw65CZjo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyXcc-0002Ij-7c for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:34:09 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67OGXxUX003884
 for <openvpn-devel@lists.sourceforge.net>; Mon, 24 Aug 2026 18:33:59 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67OGXx5F003883
 for openvpn-devel@lists.sourceforge.net; Mon, 24 Aug 2026 18:33:59 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 24 Aug 2026 18:26:44 +0200
Message-ID: <20260824162651.3228-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
References: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wyXcc-0002Ij-7c
Subject: [Openvpn-devel] [PATCH v14] Remove instances of
 constVariable/constVariablePointer cppcheck warnings
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

Of varied usefulness, but easier to just address all of
them.

Also change vpn_* parameters of dco_new_peer to const since
that is required by one of the changes and it works (and would
happen anyway when doing constParameterPointer).

Change-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1661
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1661
This mail reflects revision 14 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 2e3350b..900e03c 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -3,8 +3,6 @@
 constParameter
 constParameterCallback
 constParameterPointer
-constVariable
-constVariablePointer
 invalidPrintfArgType_sint
 invalidPrintfArgType_uint
 usleepCalled
diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c
index f6bbf44..bacf557 100644
--- a/sample/sample-plugins/defer/multi-auth.c
+++ b/sample/sample-plugins/defer/multi-auth.c
@@ -381,7 +381,7 @@
     }
     const char **argv = args->argv;
     const char **envp = args->envp;
-    struct plugin_context *context = (struct plugin_context *)args->handle;
+    const struct plugin_context *context = (struct plugin_context *)args->handle;
     struct plugin_per_client_context *pcc =
         (struct plugin_per_client_context *)args->per_client_context;
     switch (args->type)
@@ -399,7 +399,7 @@
 OPENVPN_EXPORT void *
 openvpn_plugin_client_constructor_v1(openvpn_plugin_handle_t handle)
 {
-    struct plugin_context *context = (struct plugin_context *)handle;
+    const struct plugin_context *context = (struct plugin_context *)handle;
     plog(context, PLOG_NOTE, "FUNC: openvpn_plugin_client_constructor_v1");
     return calloc(1, sizeof(struct plugin_per_client_context));
 }
@@ -407,7 +407,7 @@
 OPENVPN_EXPORT void
 openvpn_plugin_client_destructor_v1(openvpn_plugin_handle_t handle, void *per_client_context)
 {
-    struct plugin_context *context = (struct plugin_context *)handle;
+    const struct plugin_context *context = (struct plugin_context *)handle;
     plog(context, PLOG_NOTE, "FUNC: openvpn_plugin_client_destructor_v1");
     free(per_client_context);
 }
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
index 330e3e0..76350ee 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -173,7 +173,7 @@
 openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const char *argv[],
                        const char *envp[])
 {
-    struct plugin_context *context = (struct plugin_context *)handle;
+    const struct plugin_context *context = (struct plugin_context *)handle;
 
     show(type, argv, envp);
 
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index d2d44c7..09c6735 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -245,7 +245,7 @@
 openvpn_plugin_func_v3(const int version, struct openvpn_plugin_args_func_in const *args,
                        struct openvpn_plugin_args_func_return *retptr)
 {
-    struct plugin_context *context = (struct plugin_context *)args->handle;
+    const struct plugin_context *context = (struct plugin_context *)args->handle;
 
     printf("\nopenvpn_plugin_func_v3() :::::>> ");
     show(args->type, args->argv, args->envp);
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
index 687a633..3182be0 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -104,7 +104,7 @@
 openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const char *argv[],
                        const char *envp[])
 {
-    struct plugin_context *context = (struct plugin_context *)handle;
+    const struct plugin_context *context = (struct plugin_context *)handle;
 
     /* get username/password from envp string array */
     const char *username = get_env("username", envp);
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 6a5d92e..028671d 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -359,7 +359,7 @@
      *
      */
     size_t argc = argres->argc;
-    char *f = argv_prep_format(format, delim, &argc, &argres->gc);
+    const char *f = argv_prep_format(format, delim, &argc, &argres->gc);
     if (f == NULL)
     {
         goto out;
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index bd90212..f928a41 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -235,7 +235,7 @@
      * a new token with the empty username since we do not want to loose
      * the information that the username cannot be trusted
      */
-    struct key_state *ks = &multi->session[TM_ACTIVE].key[KS_PRIMARY];
+    const struct key_state *ks = &multi->session[TM_ACTIVE].key[KS_PRIMARY];
     if (ks->auth_token_state_flags & AUTH_TOKEN_VALID_EMPTYUSER)
     {
         hmac_ctx_update(ctx, (const uint8_t *)"", 0);
diff --git a/src/openvpn/base64.c b/src/openvpn/base64.c
index 7af8976..5752844 100644
--- a/src/openvpn/base64.c
+++ b/src/openvpn/base64.c
@@ -161,7 +161,7 @@
 {
     const char *p;
     unsigned char *q;
-    unsigned char *e = NULL;
+    const unsigned char *e = NULL;
 
     q = data;
     if (size >= 0)
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 8c19902..2b4d05d 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -500,7 +500,7 @@
 void
 buf_null_terminate(struct buffer *buf)
 {
-    char *last = (char *)BLAST(buf);
+    const char *last = (char *)BLAST(buf);
     if (last && *last == '\0') /* already terminated? */
     {
         return;
@@ -523,7 +523,7 @@
 {
     while (true)
     {
-        char *last = (char *)BLAST(buf);
+        const char *last = (char *)BLAST(buf);
         if (!last)
         {
             break;
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index e48a793..fbc94c5 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1318,7 +1318,7 @@
 static inline bool
 buf_copy_n(struct buffer *dest, struct buffer *src, int n)
 {
-    uint8_t *cp = buf_read_alloc(src, n);
+    const uint8_t *cp = buf_read_alloc(src, n);
     if (!cp)
     {
         return false;
@@ -1409,7 +1409,7 @@
 static inline bool
 buf_read(struct buffer *src, void *dest, int size)
 {
-    uint8_t *cp = buf_read_alloc(src, size);
+    const uint8_t *cp = buf_read_alloc(src, size);
     if (!cp)
     {
         return false;
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 45f138c..48797b0 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -164,7 +164,7 @@
     ASSERT(buf_init(&work, frame->buf.headroom));
 
     /* do unframing/swap (assumes buf->len > 0) */
-    uint8_t *head = BPTR(buf);
+    const uint8_t *head = BPTR(buf);
     c = *head;
 
     /* Not compressed */
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 674105d..e5ad31a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1210,7 +1210,7 @@
 
     /* init implicit IV */
     {
-        cipher_ctx_t *cipher = co->key_ctx_bi.encrypt.cipher;
+        const cipher_ctx_t *cipher = co->key_ctx_bi.encrypt.cipher;
         if (cipher_ctx_mode_aead(cipher))
         {
             ASSERT(cipher_ctx_iv_length(cipher) <= OPENVPN_MAX_IV_LENGTH);
@@ -1920,7 +1920,7 @@
     const char *seed = "tls1-prf-test";
     const char *secret = "tls1-prf-test-secret";
     uint8_t out[8];
-    uint8_t expected_out[] = { 'q', 'D', 0xfe, '%', '@', 's', 'u', 0x95 };
+    const uint8_t expected_out[] = { 'q', 'D', 0xfe, '%', '@', 's', 'u', 0x95 };
 
     int ret = ssl_tls1_PRF((uint8_t *)seed, strlen(seed), (uint8_t *)secret,
                            strlen(secret), out, sizeof(out));
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 37933a1..158c841 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -213,7 +213,7 @@
      *
      * The last generated key might have been moved to the decrypt key already.
      */
-    struct key_ctx *highest_future_key =
+    const struct key_ctx *highest_future_key =
         &co->epoch_data_keys_future[co->epoch_data_keys_future_count - 1];
 
     ASSERT(co->epoch_key_recv.epoch == 1 || highest_future_key->epoch == co->epoch_key_recv.epoch
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 0f95ab7..ad2706c 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -225,7 +225,6 @@
     const CERT_INFO *info = cert_ctx->pCertInfo;
     const CERT_EXTENSION *ext;
     DWORD cbext;
-    void *pvext;
     struct gc_arena gc = gc_new();
     const WCHAR *tmpl_name = wide_string(cert_prop, &gc);
 
@@ -233,7 +232,7 @@
     ext = CertFindExtension(szOID_CERTIFICATE_TEMPLATE, info->cExtension, info->rgExtension);
     if (ext)
     {
-        pvext = decode_object(&gc, X509_CERTIFICATE_TEMPLATE, &ext->Value, 0, &cbext);
+        const void *pvext = decode_object(&gc, X509_CERTIFICATE_TEMPLATE, &ext->Value, 0, &cbext);
         if (pvext && cbext >= sizeof(CERT_TEMPLATE_EXT))
         {
             const CERT_TEMPLATE_EXT *cte = (const CERT_TEMPLATE_EXT *)pvext;
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index ce73701..8eae4bf 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -112,7 +112,7 @@
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
         struct key_state *ks = get_key_scan(multi, i);
-        struct key_ctx_bi *key = &ks->crypto_options.key_ctx_bi;
+        const struct key_ctx_bi *key = &ks->crypto_options.key_ctx_bi;
 
         if (ks == primary)
         {
@@ -577,7 +577,7 @@
                         struct sockaddr_storage *local)
 {
 #if ENABLE_IP_PKTINFO
-    struct context *c = &mi->context;
+    const struct context *c = &mi->context;
 
     if (!proto_is_udp(c->c2.link_sockets[0]->info.proto)
         || !(c->options.sockflags & SF_USE_IP_PKTINFO))
@@ -625,7 +625,7 @@
 int
 dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
 {
-    struct context *c = &mi->context;
+    const struct context *c = &mi->context;
 
     int peer_id = c->c2.tls_multi->rx_peer_id;
     struct sockaddr *remoteaddr, *localaddr = NULL;
@@ -646,14 +646,14 @@
 
     /* In server mode we need to fetch the remote addresses from the push config */
     struct in_addr vpn_ip4 = { 0 };
-    struct in_addr *vpn_addr4 = NULL;
+    const struct in_addr *vpn_addr4 = NULL;
     if (c->c2.push_ifconfig_defined)
     {
         vpn_ip4.s_addr = htonl(c->c2.push_ifconfig_local);
         vpn_addr4 = &vpn_ip4;
     }
 
-    struct in6_addr *vpn_addr6 = NULL;
+    const struct in6_addr *vpn_addr6 = NULL;
     if (c->c2.push_ifconfig_ipv6_defined)
     {
         vpn_addr6 = &c->c2.push_ifconfig_ipv6_local;
@@ -702,7 +702,7 @@
     }
 #endif
 
-    struct context *c = &mi->context;
+    const struct context *c = &mi->context;
     if (addrtype == MR_ADDR_IPV6)
     {
 #if defined(_WIN32)
@@ -750,7 +750,7 @@
     }
     ASSERT(TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN);
 
-    struct context *c = &mi->context;
+    const struct context *c = &mi->context;
 
     if (mi->context.c2.push_ifconfig_defined)
     {
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index eaca86b..d933aaf 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -134,7 +134,8 @@
 
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd, struct sockaddr *localaddr,
-             struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
+             struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4,
+             const struct in6_addr *vpn_ipv6)
 {
     struct ifdrv drv;
     nvlist_t *nvl, *local_nvl, *remote_nvl;
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index da07780..fcf8aca 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -60,7 +60,7 @@
  */
 
 int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,
-                 struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6);
+                 struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);
 
 int dco_del_peer(dco_context_t *dco, unsigned int peerid);
 
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 40746bd..56f6259 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -222,7 +222,8 @@
 
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd, struct sockaddr *localaddr,
-             struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
+             struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4,
+             const struct in6_addr *vpn_ipv6)
 {
     struct gc_arena gc = gc_new();
     const char *remotestr = "[undefined]";
@@ -697,7 +698,7 @@
 {
     dco_context_t *dco = arg;
     struct nlattr *tb[CTRL_ATTR_MAX + 1];
-    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+    const struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
 
     nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0), genlmsg_attrlen(gnlh, 0), NULL);
 
@@ -706,7 +707,7 @@
         return NL_SKIP;
     }
 
-    struct nlattr *mcgrp;
+    const struct nlattr *mcgrp;
     int rem_mcgrp;
     nla_for_each_nested(mcgrp, tb[CTRL_ATTR_MCAST_GROUPS], rem_mcgrp)
     {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 2e26f2a..b3268bc 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -285,8 +285,8 @@
     msg(D_DCO_DEBUG, "%s", __func__);
 
     int ai_family = sock->info.lsa->bind_local->ai_family;
-    struct addrinfo *local = sock->info.lsa->bind_local;
-    struct addrinfo *cur = NULL;
+    const struct addrinfo *local = sock->info.lsa->bind_local;
+    const struct addrinfo *cur = NULL;
 
     for (cur = local; cur; cur = cur->ai_next)
     {
@@ -334,7 +334,7 @@
     struct addrinfo *remoteaddr = sock->info.lsa->current_remote;
 
     struct sockaddr *local = NULL;
-    struct sockaddr *remote = remoteaddr->ai_addr;
+    const struct sockaddr *remote = remoteaddr->ai_addr;
 
     if (remoteaddr->ai_protocol == IPPROTO_TCP || remoteaddr->ai_socktype == SOCK_STREAM)
     {
@@ -348,7 +348,7 @@
     if (sock->bind_local)
     {
         /* Use first local address with correct address family */
-        struct addrinfo *bind = sock->info.lsa->bind_local;
+        const struct addrinfo *bind = sock->info.lsa->bind_local;
         while (bind && !local)
         {
             if (bind->ai_family == remote->sa_family)
@@ -415,8 +415,9 @@
 }
 
 int
-dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,
-             struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
+dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd,
+             struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+             const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6)
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d, fd " SOCKET_PRINTF, __func__, peerid, sd);
 
@@ -745,7 +746,7 @@
     struct gc_arena gc = gc_new();
 
     int ret = 0;
-    struct tuntap *tt = dco->tt;
+    const struct tuntap *tt = dco->tt;
 
     if (!tuntap_defined(tt))
     {
@@ -869,7 +870,7 @@
 int
 dco_get_peer_stats_fallback(struct context *c, const bool raise_sigusr1_on_err)
 {
-    struct tuntap *tt = c->c1.tuntap;
+    const struct tuntap *tt = c->c1.tuntap;
 
     if (!tuntap_defined(tt))
     {
@@ -898,7 +899,7 @@
 int
 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
-    struct tuntap *tt = c->c1.tuntap;
+    const struct tuntap *tt = c->c1.tuntap;
 
     if (!tuntap_defined(tt))
     {
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 1465cdf..7f4dde4 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -132,7 +132,7 @@
     }
     else
     {
-        struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)ai->ai_addr;
+        const struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)ai->ai_addr;
         server->addr[server->addr_count].in.a6 = sin6->sin6_addr;
     }
 
@@ -156,7 +156,7 @@
     /* Append all domains to the end of the list */
     while (*domains)
     {
-        char *domain = *domains++;
+        const char *domain = *domains++;
         if (!validate_domain(domain))
         {
             return false;
@@ -699,7 +699,7 @@
 run_up_down_command(bool up, struct options *o, const struct tuntap *tt,
                     struct dns_updown_runner_info *updown_runner)
 {
-    struct dns_options *dns = &o->dns_options;
+    const struct dns_options *dns = &o->dns_options;
     if (!dns->updown || (o->up_script && !dns_updown_user_set(dns) && !dns_updown_forced(dns)))
     {
         return;
@@ -864,7 +864,7 @@
     }
 #ifdef _WIN32
     /* Don't use iservice in DHCP mode */
-    struct tuntap_options *tto = &o->tuntap_options;
+    const struct tuntap_options *tto = &o->tuntap_options;
     if (tto->ip_win32_type == IPW32_SET_DHCP_MASQ || tto->ip_win32_type == IPW32_SET_ADAPTIVE)
     {
         return;
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 9e17807..8b7716a 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -557,7 +557,7 @@
 ep_del(struct event_set *es, event_t event)
 {
     struct epoll_event ev;
-    struct ep_set *eps = (struct ep_set *)es;
+    const struct ep_set *eps = (struct ep_set *)es;
 
     dmsg(D_EVENT_WAIT, "EP_DEL ev=%d", (int)event);
 
@@ -572,7 +572,7 @@
 static void
 ep_ctl(struct event_set *es, event_t event, unsigned int rwflags, void *arg)
 {
-    struct ep_set *eps = (struct ep_set *)es;
+    const struct ep_set *eps = (struct ep_set *)es;
     struct epoll_event ev;
 
     CLEAR(ev);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index c5b9278..6581998 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1213,7 +1213,7 @@
 {
     if (float_sa->sa_family == AF_INET)
     {
-        struct sockaddr_in *float4 = (struct sockaddr_in *)float_sa;
+        const struct sockaddr_in *float4 = (struct sockaddr_in *)float_sa;
         /* DCO treats IPv4-mapped IPv6 addresses as pure IPv4. However, on a
          * dual-stack socket, we need to preserve the mapping otherwise openvpn
          * will not be able to find the peer by its transport address.
@@ -1236,7 +1236,7 @@
     }
     else
     {
-        struct sockaddr_in6 *float6 = (struct sockaddr_in6 *)float_sa;
+        const struct sockaddr_in6 *float6 = (struct sockaddr_in6 *)float_sa;
         memcpy(&out_osaddr->addr.in6, float6, sizeof(struct sockaddr_in6));
     }
 }
@@ -1366,8 +1366,8 @@
         return;
     }
 
-    struct openvpn_sockaddr *link_addr = &c->c2.to_link_addr->dest;
-    struct link_socket_info *lsi = get_link_socket_info(c);
+    const struct openvpn_sockaddr *link_addr = &c->c2.to_link_addr->dest;
+    const struct link_socket_info *lsi = get_link_socket_info(c);
 
     int ip_hdr_offset = 0;
     int tun_ip_ver = get_tun_ip_ver(TUNNEL_TYPE(c->c1.tuntap), buf, &ip_hdr_offset);
@@ -1404,7 +1404,7 @@
         }
 
         /* drop packets with same dest addr and port as remote */
-        uint8_t *l4_hdr = (uint8_t *)pip + ip_hlen;
+        const uint8_t *l4_hdr = (uint8_t *)pip + ip_hlen;
 
         uint16_t link_port = ntohs(link_addr->addr.in4.sin_port);
 
@@ -1451,7 +1451,7 @@
         uint16_t link_port = ntohs(link_addr->addr.in6.sin6_port);
 
         /* drop packets with same dest addr and port as remote */
-        uint8_t *l4_hdr = (uint8_t *)pip6 + sizeof(struct openvpn_ipv6hdr);
+        const uint8_t *l4_hdr = (uint8_t *)pip6 + sizeof(struct openvpn_ipv6hdr);
         uint16_t src_port = ntohs(*(uint16_t *)l4_hdr);
         uint16_t dst_port = ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t)));
         if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&link_addr->addr.in6.sin6_addr, &pip6->daddr)) && (link_port == dst_port))
@@ -2209,7 +2209,7 @@
 
                     if (e->arg >= MULTI_N)
                     {
-                        struct event_arg *ev_arg = (struct event_arg *)e->arg;
+                        const struct event_arg *ev_arg = (struct event_arg *)e->arg;
                         if (ev_arg->type != EVENT_ARG_LINK_SOCKET)
                         {
                             c->c2.event_set_status = ES_ERROR;
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 66bae34..a8e041d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -321,8 +321,8 @@
 management_callback_remote_entry_count(void *arg)
 {
     ASSERT(arg);
-    struct context *c = (struct context *)arg;
-    struct connection_list *l = c->options.connection_list;
+    const struct context *c = (struct context *)arg;
+    const struct connection_list *l = c->options.connection_list;
 
     return l->len;
 }
@@ -339,7 +339,7 @@
 
     if (l->len > 0 && index < (unsigned int)l->len)
     {
-        struct connection_entry *ce = l->array[index];
+        const struct connection_entry *ce = l->array[index];
         const char *proto = proto2ascii(ce->proto, ce->af, false);
         const char *status = (ce->flags & CE_DISABLED) ? "disabled" : "enabled";
 
@@ -517,7 +517,7 @@
 {
     struct connection_list *l = c->options.connection_list;
     bool ce_defined;
-    struct connection_entry *ce;
+    const struct connection_entry *ce;
     int n_cycles = 0;
 
     do
@@ -1563,10 +1563,10 @@
     /* Tell management interface that we initialized */
     if (management)
     {
-        in_addr_t *tun_local = NULL;
-        struct in6_addr *tun_local6 = NULL;
+        const in_addr_t *tun_local = NULL;
+        const struct in6_addr *tun_local6 = NULL;
         struct openvpn_sockaddr local, remote;
-        struct link_socket_actual *actual;
+        const struct link_socket_actual *actual;
         socklen_t sa_len = sizeof(local);
         const char *detail = "SUCCESS";
         if (flags & ISC_ERRORS)
@@ -4282,7 +4282,7 @@
     /* On some newer Android handsets, changing to a different network
      * often does not trigger a TCP reset but continue using the old
      * connection (e.g. using mobile connection when WiFi becomes available */
-    struct link_socket_info *lsi = get_link_socket_info(c);
+    const struct link_socket_info *lsi = get_link_socket_info(c);
     if (lsi && proto_is_tcp(lsi->proto) && !samenetwork)
     {
         return -2;
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 9e80761..e51dcd0 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -167,7 +167,7 @@
 hash_remove_by_value(struct hash *hash, void *value)
 {
     struct hash_iterator hi;
-    struct hash_element *he;
+    const struct hash_element *he;
 
     hash_iterator_init(hash, &hi);
     while ((he = hash_iterator_next(&hi)))
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index c082f51..604bbcd 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3820,7 +3820,7 @@
 {
     int ok;
     char *result = NULL;
-    struct buffer *buf;
+    const struct buffer *buf;
 
     ok = management_query_multiline(man, b64_data, prompt, cmd, state, input);
     if (ok && buffer_list_defined(*input))
@@ -3849,7 +3849,7 @@
 {
     int ok;
     char *result = NULL;
-    struct buffer *buf;
+    const struct buffer *buf;
 
     ok = management_query_multiline(man, b64_data, prompt, cmd, state, input);
     if (ok && buffer_list_defined(*input))
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index a8c88c9..54af890 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -131,7 +131,7 @@
     struct auth_challenge_info *ac;
     const int len = strlen(auth_challenge);
     char *work = (char *)gc_malloc(len + 1, false, gc);
-    char *cp;
+    const char *cp;
 
     struct buffer b;
     buf_set_read(&b, (const uint8_t *)auth_challenge, len);
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 14112b4..36bbb43 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -65,7 +65,7 @@
         struct buffer newbuf = *buf;
         if (buf_advance(&newbuf, hlen))
         {
-            struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *)BPTR(&newbuf);
+            const struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *)BPTR(&newbuf);
             if (tc->flags & OPENVPN_TCPH_SYN_MASK)
             {
                 mss_fixup_dowork(&newbuf, maxmss);
@@ -122,7 +122,7 @@
     newbuf = *buf;
     if (buf_advance(&newbuf, 40) && BLENZ(&newbuf) >= sizeof(struct openvpn_tcphdr))
     {
-        struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *)BPTR(&newbuf);
+        const struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *)BPTR(&newbuf);
         if (tc->flags & OPENVPN_TCPH_SYN_MASK)
         {
             mss_fixup_dowork(&newbuf, maxmss - 20);
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index f000283..5d88f8a 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -130,7 +130,7 @@
 void
 multi_tcp_dereference_instance(struct multi_io *multi_io, struct multi_instance *mi)
 {
-    struct link_socket *sock = mi->context.c2.link_sockets[0];
+    const struct link_socket *sock = mi->context.c2.link_sockets[0];
     if (sock && mi->socket_set_called)
     {
         event_del(multi_io->es, socket_event_handle(sock));
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 632b064..6d9c181 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -102,7 +102,7 @@
     verdict = tls_pre_decrypt_lite(tas, state, &m->top.c2.from, &m->top.c2.buf);
 
     uint8_t *hmac_key = m->top.c2.session_id_key;
-    struct openvpn_sockaddr *from = &m->top.c2.from.dest;
+    const struct openvpn_sockaddr *from = &m->top.c2.from.dest;
     int handwindow = m->top.options.handshake_window;
 
     if (verdict == VERDICT_VALID_RESET_V3 || verdict == VERDICT_VALID_RESET_V2)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 20b4f14..60a5148 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -86,7 +86,7 @@
     struct gc_arena gc = gc_new();
     struct env_set *es;
     bool ret = true;
-    struct plugin_list *plugins;
+    const struct plugin_list *plugins;
 
     /* get environmental variable source */
     if (mi && mi->context.c2.es)
@@ -1793,7 +1793,7 @@
      * Push the first cipher from --data-ciphers to the client that
      * the client announces to be supporting.
      */
-    char *push_cipher =
+    const char *push_cipher =
         ncp_get_best_cipher(o->ncp_ciphers, peer_info, tls_multi->remote_ciphername, &o->gc);
     if (push_cipher)
     {
@@ -1924,7 +1924,7 @@
 static enum client_connect_return
 ccs_test_deferred_ret_file(struct multi_instance *mi)
 {
-    struct client_connect_defer_state *ccs = &(mi->client_connect_defer_state);
+    const struct client_connect_defer_state *ccs = &(mi->client_connect_defer_state);
     FILE *fp = fopen(ccs->deferred_ret_file, "r");
     if (!fp)
     {
@@ -2165,7 +2165,7 @@
 {
     ASSERT(mi);
     ASSERT(option_types_found);
-    struct client_connect_defer_state *ccs = &(mi->client_connect_defer_state);
+    const struct client_connect_defer_state *ccs = &(mi->client_connect_defer_state);
     enum client_connect_return ret = CC_RET_SKIPPED;
 
     ret = ccs_test_deferred_ret_file(mi);
@@ -2567,7 +2567,7 @@
 override_locked_username(struct multi_instance *mi)
 {
     struct tls_multi *multi = mi->context.c2.tls_multi;
-    struct options *options = &mi->context.options;
+    const struct options *options = &mi->context.options;
     struct tls_session *session = &multi->session[TM_ACTIVE];
 
     if (!multi->locked_username)
@@ -2986,7 +2986,7 @@
     {
 #if defined(ENABLE_ASYNC_PUSH)
         bool was_unauthenticated = true;
-        struct key_state *ks = NULL;
+        const struct key_state *ks = NULL;
         if (mi->context.c2.tls_multi)
         {
             ks = &mi->context.c2.tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];
@@ -3919,7 +3919,7 @@
 static int
 management_callback_n_clients(void *arg)
 {
-    struct multi_context *m = (struct multi_context *)arg;
+    const struct multi_context *m = (struct multi_context *)arg;
     return m->n_clients;
 }
 
@@ -4430,7 +4430,7 @@
 bool
 multi_check_push_ifconfig_extra_route(struct multi_instance *mi, in_addr_t dest)
 {
-    struct options *o = &mi->context.options;
+    const struct options *o = &mi->context.options;
     in_addr_t local_addr, local_netmask;
 
     if (!o->ifconfig_local || !o->ifconfig_remote_netmask)
@@ -4452,7 +4452,7 @@
 multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
                                            struct in6_addr *dest)
 {
-    struct options *o = &mi->context.options;
+    const struct options *o = &mi->context.options;
 
     if (!o->ifconfig_ipv6_local || !o->ifconfig_ipv6_netbits)
     {
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index b3f8e2b..e6e72d0 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -462,7 +462,7 @@
     struct rtattr *rta = RTM_RTA(r);
     size_t len = n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
     unsigned int table, ifindex = 0;
-    void *gw = NULL;
+    const void *gw = NULL;
 
     /* filter-out non-zero dst prefixes */
     if (res->default_only && r->rtm_dst_len != 0)
@@ -1179,7 +1179,7 @@
 net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
                  const char *iface, uint32_t table, int metric)
 {
-    in_addr_t *dst_ptr = NULL, *gw_ptr = NULL;
+    const in_addr_t *dst_ptr = NULL, *gw_ptr = NULL;
     in_addr_t dst_be = 0, gw_be = 0;
     char dst_str[INET_ADDRSTRLEN];
     char gw_str[INET_ADDRSTRLEN];
@@ -1326,7 +1326,7 @@
 #if defined(ENABLE_DCO)
     if (arg && (strcmp(type, OVPN_FAMILY_NAME) == 0))
     {
-        dco_context_t *dco = arg;
+        const dco_context_t *dco = arg;
         struct rtattr *data = SITNL_NEST(&req.n, sizeof(req), IFLA_INFO_DATA);
 
         /* the netlink format is uint8_t for this and using something
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1fc38a6..b210a5d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1696,7 +1696,7 @@
 
     for (int i = 0; i < ce->local_list->len; i++)
     {
-        struct local_entry *le = ce->local_list->array[i];
+        const struct local_entry *le = ce->local_list->array[i];
 
         if (proto_is_net(le->proto) && string_defined_equal(le->local, ce->remote)
             && string_defined_equal(le->port, ce->remote_port))
@@ -7692,7 +7692,7 @@
 #ifdef ENABLE_PKCS11
     else if (streq(p[0], "show-pkcs11-ids") && !p[3])
     {
-        char *provider = p[1];
+        const char *provider = p[1];
         bool cert_private = (p[2] == NULL ? false : (atoi_warn(p[2], msglevel) != 0));
 
 #ifdef DEFAULT_PKCS11_MODULE
diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c
index a8c4aee..88ab4d2 100644
--- a/src/openvpn/options_parse.c
+++ b/src/openvpn/options_parse.c
@@ -268,7 +268,7 @@
     while (in_src_get(is, line, sizeof(line)))
     {
         (*num_lines)++;
-        char *line_ptr = line;
+        const char *line_ptr = line;
         /* Remove leading spaces */
         while (isspace(*line_ptr))
         {
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index d72ea25c..779c38e 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -273,7 +273,7 @@
         return true;
     }
 
-    struct pull_filter *f;
+    const struct pull_filter *f;
 
     for (f = o->pull_filter_list->head; f; f = f->next)
     {
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index ff74e7c..80dec6c 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -63,7 +63,7 @@
 
     for (i = 0; i < pool->size; ++i)
     {
-        struct ifconfig_pool_entry *ipe = &pool->list[i];
+        const struct ifconfig_pool_entry *ipe = &pool->list[i];
         if (!ipe->in_use)
         {
             /*
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 9acb2fa..e0700aa 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -703,7 +703,7 @@
 #if PROXY_DIGEST_AUTH
         else if (p->auth_method == HTTP_AUTH_DIGEST && !processed)
         {
-            char *pa = p->proxy_authenticate;
+            const char *pa = p->proxy_authenticate;
             const int method = p->auth_method;
             ASSERT(pa);
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 5b15f71..fa7bf1e 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -271,8 +271,8 @@
     }
 #ifdef ENABLE_MANAGEMENT
     struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
-    struct man_def_auth_context *mda = session->opt->mda_context;
-    struct env_set *es = session->opt->es;
+    const struct man_def_auth_context *mda = session->opt->mda_context;
+    const struct env_set *es = session->opt->es;
     unsigned int mda_key_id = get_primary_key(c->c2.tls_multi)->mda_key_id;
 
     management_notify_client_cr_response(mda_key_id, mda, es, m);
@@ -917,7 +917,7 @@
 push_options(struct options *o, char **p, msglvl_t msglevel, struct gc_arena *gc)
 {
     const char **argv = make_extended_arg_array(p, false, gc);
-    char *opt = print_argv(argv, gc, 0);
+    const char *opt = print_argv(argv, gc, 0);
     push_option(o, opt, msglevel);
 }
 
@@ -1199,7 +1199,7 @@
                     /* parse route-ipv6 arguments */
                     if (get_ipv6_addr(p[1], &network, &netbits, D_ROUTE_DEBUG))
                     {
-                        struct iroute_ipv6 *ir;
+                        const struct iroute_ipv6 *ir;
 
                         /* does this route-ipv6 match an iroute-ipv6? */
                         for (ir = o->iroutes_ipv6; ir != NULL; ir = ir->next)
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 6dbe3ec..03a2526 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -667,7 +667,7 @@
 
     /* parse the routes from opt to rl */
     {
-        struct route_option *ro;
+        const struct route_option *ro;
         for (ro = opt->routes; ro; ro = ro->next)
         {
             struct addrinfo *netlist = NULL;
@@ -679,7 +679,7 @@
             }
             else
             {
-                struct addrinfo *curele;
+                const struct addrinfo *curele;
                 for (curele = netlist; curele; curele = curele->ai_next)
                 {
                     struct route_ipv4 *new;
@@ -799,7 +799,7 @@
     need_remote_ipv6_route = false;
 
     {
-        struct route_ipv6_option *ro6;
+        const struct route_ipv6_option *ro6;
         for (ro6 = opt6->routes_ipv6; ro6; ro6 = ro6->next)
         {
             struct route_ipv6 *r6;
@@ -1187,7 +1187,7 @@
 {
     if (rl6 && (rl6->iflags & RL_ROUTES_ADDED))
     {
-        struct route_ipv6 *r6;
+        const struct route_ipv6 *r6;
         for (r6 = rl6->routes_ipv6; r6; r6 = r6->next)
         {
             delete_route_ipv6(r6, tt, es, ctx);
@@ -1226,7 +1226,7 @@
 void
 print_route_options(const struct route_option_list *rol, msglvl_t msglevel)
 {
-    struct route_option *ro;
+    const struct route_option *ro;
     if (rol->flags & RG_ENABLE)
     {
         msg(msglevel, "  [redirect_default_gateway local=%d]", (rol->flags & RG_LOCAL) != 0);
@@ -1335,7 +1335,7 @@
 setenv_routes(struct env_set *es, const struct route_list *rl)
 {
     int i = 1;
-    struct route_ipv4 *r;
+    const struct route_ipv4 *r;
     for (r = rl->routes; r; r = r->next)
     {
         setenv_route(es, r, i++);
@@ -1372,7 +1372,7 @@
 setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *rl6)
 {
     int i = 1;
-    struct route_ipv6 *r6;
+    const struct route_ipv6 *r6;
     for (r6 = rl6->routes_ipv6; r6; r6 = r6->next)
     {
         setenv_route_ipv6(es, r6, i++);
@@ -2423,7 +2423,7 @@
          */
         if (rl && tt->did_ifconfig_setup)
         {
-            struct route_ipv4 *r;
+            const struct route_ipv4 *r;
             for (r = rl->routes, len = 0; r; r = r->next, ++len)
             {
                 test_route_helper(&ret, &count, &good, &ambig, adapters, r->gateway);
@@ -3110,7 +3110,8 @@
     /* scan adapter list */
     if (rgi->flags & RGI_ADDR_DEFINED)
     {
-        struct ifreq *ifr, *ifend;
+        const struct ifreq *ifr;
+        const struct ifreq *ifend;
         in_addr_t addr, netmask;
         struct ifreq ifreq;
         struct ifconf ifc;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 47edbdb..50126bf 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -393,7 +393,7 @@
 
             for (int j = 0; j < ce->local_list->len; j++)
             {
-                struct local_entry *le = ce->local_list->array[j];
+                const struct local_entry *le = ce->local_list->array[j];
 
                 if (!le->local)
                 {
@@ -898,12 +898,10 @@
      * What is the correct way to deal with it?
      */
 
-    struct addrinfo *cur;
-
     ASSERT(local);
 
-
     /* find the first addrinfo with correct ai_family */
+    const struct addrinfo *cur;
     for (cur = local; cur; cur = cur->ai_next)
     {
         if (cur->ai_family == ai_family)
@@ -1490,7 +1488,7 @@
         /* Socket is always bound on the first matching address,
          * For bound sockets with no remote addr this is the element of
          * the list */
-        struct addrinfo *cur;
+        const struct addrinfo *cur;
         for (cur = sock->info.lsa->bind_local; cur; cur = cur->ai_next)
         {
             if (!ai_family || ai_family == cur->ai_family)
@@ -1621,7 +1619,7 @@
 create_socket_dco_win(struct context *c, struct link_socket *sock, struct signal_info *sig_info)
 {
     /* in P2P mode we must have remote resolved at this point */
-    struct addrinfo *remoteaddr = sock->info.lsa->current_remote;
+    const struct addrinfo *remoteaddr = sock->info.lsa->current_remote;
     if ((c->options.mode == MODE_POINT_TO_POINT) && (!remoteaddr))
     {
         return;
@@ -1910,7 +1908,7 @@
                               const struct link_socket_actual *from_addr)
 {
     struct gc_arena gc = gc_new();
-    struct addrinfo *ai;
+    const struct addrinfo *ai;
 
     switch (from_addr->dest.addr.sa.sa_family)
     {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 1a532e1..89465bc 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -761,7 +761,7 @@
 {
     if (sock && ipbuf)
     {
-        struct openvpn_iphdr *iph = (struct openvpn_iphdr *)BPTR(ipbuf);
+        const struct openvpn_iphdr *iph = (struct openvpn_iphdr *)BPTR(ipbuf);
         sock->ptos = iph->tos;
         sock->ptos_defined = true;
     }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d5bd602..5f5d1f9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1488,7 +1488,7 @@
 static bool
 generate_key_expansion(struct tls_multi *multi, struct key_state *ks, struct tls_session *session)
 {
-    struct key_ctx_bi *key = &ks->crypto_options.key_ctx_bi;
+    const struct key_ctx_bi *key = &ks->crypto_options.key_ctx_bi;
     bool ret = false;
     struct key2 key2;
 
@@ -1750,7 +1750,7 @@
 static void
 flush_payload_buffer(struct key_state *ks)
 {
-    struct buffer *b;
+    const struct buffer *b;
 
     while ((b = buffer_list_peek(ks->paybuf)))
     {
@@ -2779,7 +2779,7 @@
     /* Outgoing Ciphertext to reliable buffer */
     if (ks->state >= S_START)
     {
-        struct buffer *buf = reliable_get_buf_output_sequenced(ks->send_reliable);
+        const struct buffer *buf = reliable_get_buf_output_sequenced(ks->send_reliable);
         if (buf)
         {
             if (!write_outgoing_tls_ciphertext(session, continue_tls_process))
@@ -2848,7 +2848,7 @@
     {
         int opcode;
 
-        struct buffer *buf = reliable_send(ks->send_reliable, &opcode);
+        const struct buffer *buf = reliable_send(ks->send_reliable, &opcode);
         ASSERT(buf);
         struct buffer b = *buf;
         INCR_SENT;
@@ -3211,7 +3211,7 @@
 static void
 check_session_buf_not_used(struct buffer *to_link, struct tls_session *session)
 {
-    uint8_t *dataptr = to_link->data;
+    const uint8_t *dataptr = to_link->data;
     if (!dataptr)
     {
         return;
@@ -3233,7 +3233,7 @@
 
     for (int i = 0; i < KS_SIZE; i++)
     {
-        struct key_state *ks = &session->key[i];
+        const struct key_state *ks = &session->key[i];
         if (ks->state == S_UNDEF)
         {
             continue;
@@ -3304,7 +3304,7 @@
     {
         struct tls_session *session = &multi->session[i];
         struct key_state *ks = &session->key[KS_PRIMARY];
-        struct key_state *ks_lame = &session->key[KS_LAME_DUCK];
+        const struct key_state *ks_lame = &session->key[KS_LAME_DUCK];
 
         /* set initial remote address. This triggers connecting with that
          * session. So we only do that if the TM_ACTIVE session is not
@@ -3505,7 +3505,7 @@
 
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
-        struct key_state *ks = get_key_scan(multi, i);
+        const struct key_state *ks = get_key_scan(multi, i);
         if (ks->key_id != key_id)
         {
             continue;
@@ -4070,7 +4070,7 @@
 void
 tls_prepend_opcode_v1(const struct tls_multi *multi, struct buffer *buf)
 {
-    struct key_state *ks = multi->save_ks;
+    const struct key_state *ks = multi->save_ks;
 
     msg(D_TLS_DEBUG, __func__);
 
@@ -4084,7 +4084,7 @@
 void
 tls_prepend_opcode_v2(const struct tls_multi *multi, struct buffer *buf)
 {
-    struct key_state *ks = multi->save_ks;
+    const struct key_state *ks = multi->save_ks;
     uint32_t peer;
 
     msg(D_TLS_DEBUG, __func__);
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 6d7ac04..faf5a27 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -730,7 +730,7 @@
 static inline size_t
 external_key_len(void *vctx)
 {
-    struct external_context *const ctx = vctx;
+    const struct external_context *const ctx = vctx;
 
     return ctx->signature_length;
 }
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 162f68f..063fa5d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -409,7 +409,7 @@
                     const char *subject, const struct x509_track *x509_track)
 {
     char envname[64];
-    char *serial = NULL;
+    const char *serial = NULL;
     struct gc_arena gc = gc_new();
 
     /* Save X509 fields in environment */
@@ -699,7 +699,7 @@
                 goto cleanup;
         }
 
-        struct verify_hash_list *current_hash = opt->verify_hash;
+        const struct verify_hash_list *current_hash = opt->verify_hash;
 
         while (current_hash)
         {
@@ -1532,7 +1532,7 @@
 verify_user_pass_management(struct tls_session *session, const struct user_pass *up)
 {
     int retval = KMDA_ERROR;
-    struct key_state *ks = &session->key[KS_PRIMARY]; /* primary key */
+    const struct key_state *ks = &session->key[KS_PRIMARY]; /* primary key */
 
     /* set username/password in private env space */
     setenv_str(session->opt->es, "password", up->password);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f2a4394..af48921 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -871,7 +871,7 @@
          */
         if (strict_warn)
         {
-            struct addrinfo *curele;
+            const struct addrinfo *curele;
             ifconfig_sanity_check(tun_p2p, tt->remote_netmask);
 
             /*
@@ -1726,7 +1726,7 @@
     {
         u_int32_t type;
         struct iovec iv[2];
-        struct ip *iph = (struct ip *)buf;
+        const struct ip *iph = (struct ip *)buf;
 
         if (iph->ip_v == 6)
         {
@@ -3414,7 +3414,7 @@
         SP_DEVINFO_DATA device_info_data;
         BOOL res;
         HKEY dev_key;
-        char net_cfg_instance_id_string[] = "NetCfgInstanceId";
+        const char net_cfg_instance_id_string[] = "NetCfgInstanceId";
         BYTE net_cfg_instance_id[256];
         char device_instance_id[256];
         DWORD len;
@@ -3542,7 +3542,7 @@
         HKEY unit_key;
         char component_id_string[] = "ComponentId";
         char component_id[256];
-        char net_cfg_instance_id_string[] = "NetCfgInstanceId";
+        const char net_cfg_instance_id_string[] = "NetCfgInstanceId";
         BYTE net_cfg_instance_id[256];
         DWORD data_type;
 
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index ade7ec0..81437c1 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -889,7 +889,7 @@
 
     if (es)
     {
-        struct env_item *e;
+        const struct env_item *e;
         char *ret;
         char *p;
         size_t nchars = 1;
diff --git a/src/openvpnmsica/msica_arg.c b/src/openvpnmsica/msica_arg.c
index a334710..d763d93 100644
--- a/src/openvpnmsica/msica_arg.c
+++ b/src/openvpnmsica/msica_arg.c
@@ -92,7 +92,7 @@
 {
     /* Count required space. */
     size_t size = 2 /*x + zero-terminator*/;
-    for (struct msica_arg *p = seq->head; p != NULL; p = p->next)
+    for (const struct msica_arg *p = seq->head; p != NULL; p = p->next)
     {
         size += wcslen(p->val) + 1 /*space delimiter|zero-terminator*/;
     }
@@ -119,7 +119,7 @@
 
     /* Join. */
     LPWSTR s = str + 1 /*x*/;
-    for (struct msica_arg *p = seq->head; p != NULL; p = p->next)
+    for (const struct msica_arg *p = seq->head; p != NULL; p = p->next)
     {
         /* Convert zero-terminator into space delimiter. */
         s[0] = L' ';
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 95e457c..a861e8a 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -196,7 +196,7 @@
 
     /* Count adapters. */
     size_t adapter_count = 0;
-    for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
+    for (const struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
     {
         adapter_count++;
     }
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 32c1b9c..a9e9665 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2685,7 +2685,7 @@
     unsigned n = 0;
     for (size_t i = 0; i < _countof(data); ++i)
     {
-        nrpt_exclude_data_t *d = &data[i];
+        const nrpt_exclude_data_t *d = &data[i];
         if (d->domains_size == 0)
         {
             break;
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 3b7bcc2..948b6af 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -526,7 +526,7 @@
 openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const char *argv[],
                        const char *envp[])
 {
-    struct auth_pam_context *context = (struct auth_pam_context *)handle;
+    const struct auth_pam_context *context = (struct auth_pam_context *)handle;
 
     if (type == OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY && context->foreground_fd >= 0)
     {
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 6a4a240..6697d14 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -317,7 +317,7 @@
             return NULL;
         }
 
-        struct tap_adapter_node *conflict = find_adapter_by_name(requested_name, adapter_list);
+        const struct tap_adapter_node *conflict = find_adapter_by_name(requested_name, adapter_list);
         if (conflict)
         {
             LPOLESTR adapter_id = NULL;
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 326de40..ce38bbe 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -88,7 +88,7 @@
 
     int maxoutput = 0;
     unsigned int blocksize = 5;
-    char *separator = " ";
+    const char *separator = " ";
     output = format_hex_ex(input, input_size, maxoutput, blocksize, separator, &gc);
     assert_string_equal(output, "0100ff10ff 00f00f090a");
 
@@ -174,7 +174,7 @@
     /* With a max length of 2, no aggregation should take place */
     buffer_list_aggregate_separator(ctx->one_two_three, 2, testsep);
     assert_int_equal(ctx->one_two_three->size, 3);
-    struct buffer *buf = buffer_list_peek(ctx->one_two_three);
+    const struct buffer *buf = buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, teststr1);
 }
 
@@ -189,7 +189,7 @@
      */
     buffer_list_aggregate_separator(ctx->one_two_three, strlen(expected) + 1, testsep);
     assert_int_equal(ctx->one_two_three->size, 2);
-    struct buffer *buf = buffer_list_peek(ctx->one_two_three);
+    const struct buffer *buf = buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, expected);
 }
 
@@ -201,7 +201,7 @@
     /* Aggregate all */
     buffer_list_aggregate_separator(ctx->one_two_three, 1 << 16, testsep);
     assert_int_equal(ctx->one_two_three->size, 1);
-    struct buffer *buf = buffer_list_peek(ctx->one_two_three);
+    const struct buffer *buf = buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, teststr1 testsep teststr2 testsep teststr3 testsep);
 }
 
@@ -213,7 +213,7 @@
     /* Aggregate all */
     buffer_list_aggregate_separator(ctx->one_two_three, 1 << 16, testnosep);
     assert_int_equal(ctx->one_two_three->size, 1);
-    struct buffer *buf = buffer_list_peek(ctx->one_two_three);
+    const struct buffer *buf = buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, teststr1 teststr2 teststr3);
 }
 
@@ -226,7 +226,7 @@
     /* Aggregate all */
     buffer_list_aggregate_separator(bl_zerolen, 1 << 16, testnosep);
     assert_int_equal(bl_zerolen->size, 1);
-    struct buffer *buf = buffer_list_peek(bl_zerolen);
+    const struct buffer *buf = buffer_list_peek(bl_zerolen);
     assert_buf_equals_str(buf, "");
 }
 
@@ -239,7 +239,7 @@
     /* Aggregate all */
     buffer_list_aggregate_separator(bl_emptybuffers, 1 << 16, testnosep);
     assert_int_equal(bl_emptybuffers->size, 1);
-    struct buffer *buf = buffer_list_peek(bl_emptybuffers);
+    const struct buffer *buf = buffer_list_peek(bl_emptybuffers);
     assert_int_equal(BLEN(buf), 0);
 }
 
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 77cf295..07c54b4 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -482,9 +482,9 @@
 crypto_test_hkdf_expand_testa1(void **state)
 {
     /* RFC 5889 A.1 Test Case 1 */
-    uint8_t prk[32] = { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,
-                        0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,
-                        0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };
+    const uint8_t prk[32] = { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,
+                              0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,
+                              0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };
 
     uint8_t info[10] = { 0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9 };
 
@@ -503,9 +503,9 @@
 crypto_test_hkdf_expand_testa2(void **state)
 {
     /* RFC 5889 A.2 Test Case 2 */
-    uint8_t prk[32] = { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a, 0x06, 0x10, 0x4c,
-                        0x9c, 0xeb, 0x35, 0xb4, 0x5c, 0xef, 0x76, 0x00, 0x14, 0x90, 0x46,
-                        0x71, 0x01, 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };
+    const uint8_t prk[32] = { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a, 0x06, 0x10, 0x4c,
+                              0x9c, 0xeb, 0x35, 0xb4, 0x5c, 0xef, 0x76, 0x00, 0x14, 0x90, 0x46,
+                              0x71, 0x01, 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };
 
     uint8_t info[80] = { 0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb,
                          0xbc, 0xbd, 0xbe, 0xbf, 0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
@@ -534,11 +534,11 @@
 crypto_test_hkdf_expand_testa3(void **state)
 {
     /* RFC 5889 A.3 Test Case 3 */
-    uint8_t prk[32] = { 0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7b, 0x16, 0x7f, 0x33, 0xa9,
-                        0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x67, 0x76, 0xaf, 0xdb,
-                        0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0xcb, 0x04 };
+    const uint8_t prk[32] = { 0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7b, 0x16, 0x7f, 0x33, 0xa9,
+                              0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x67, 0x76, 0xaf, 0xdb,
+                              0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0xcb, 0x04 };
 
-    uint8_t info[] = { 0 };
+    const uint8_t info[] = { 0 };
 
     int L = 42;
     uint8_t okm[42] = { 0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0x80,
@@ -558,9 +558,9 @@
     /* tests the HDKF with a label/okm that OpenVPN itself uses in OpenSSL 3
      * HDKF unit test*/
 
-    uint8_t prk[32] = { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,
-                        0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,
-                        0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };
+    const uint8_t prk[32] = { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,
+                              0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,
+                              0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };
 
     uint8_t info[18] = { 0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6e, 0x20, 0x75,
                          0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73, 0x74, 0x00 };
@@ -680,7 +680,7 @@
 static int
 crypto_test_epoch_setup(void **state)
 {
-    uint16_t *num_future_keys = (uint16_t *)*state;
+    const uint16_t *num_future_keys = (uint16_t *)*state;
     struct epoch_test_state *data = calloc(1, sizeof(struct epoch_test_state));
 
     data->gc = gc_new();
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 508afc9..37bbe92 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -233,7 +233,7 @@
         const CERT_CONTEXT *ctx = NULL;
         while ((ctx = CertEnumCertificatesInStore(user_store, ctx)))
         {
-            char *friendly_name = get_cert_name(ctx, &gc);
+            const char *friendly_name = get_cert_name(ctx, &gc);
             if (!lookup_cert(friendly_name)) /* not our cert */
             {
                 continue;
@@ -310,7 +310,7 @@
          */
         assert_non_null(ctx);
 
-        char *friendly_name = get_cert_name(ctx, &gc);
+        const char *friendly_name = get_cert_name(ctx, &gc);
         struct test_cert *found = lookup_cert(friendly_name);
         assert_non_null(found);
         assert_string_equal(found->cname, c->cname);
@@ -343,7 +343,7 @@
          */
         assert_non_null(ctx);
 
-        char *friendly_name = get_cert_name(ctx, &gc);
+        const char *friendly_name = get_cert_name(ctx, &gc);
         struct test_cert *found = lookup_cert(friendly_name);
         assert_non_null(found);
         assert_string_equal(found->issuer, c->issuer);
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 5f03860..a41c27b 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -300,7 +300,7 @@
     {
         for (ptr_type i = 1; i <= 16; ++i)
         {
-            struct hash_element *item = hash_lookup_by_value(nhash, (void *)i);
+            const struct hash_element *item = hash_lookup_by_value(nhash, (void *)i);
             hash_remove_by_value(nhash, (void *)i);
             /* check item got removed if it was present before */
             if (item)
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 4de463c..963e8cb 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -672,7 +672,7 @@
     openvpn_encrypt(&buf, encrypt_workspace, &co);
 
     /* separate buffer in authenticated data and encrypted data */
-    uint8_t *ad_start = BPTR(&buf);
+    const uint8_t *ad_start = BPTR(&buf);
     buf_advance(&buf, 4);
 
     if (epoch)
diff --git a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
index a861bfd..89f0642 100644
--- a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
+++ b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
@@ -12,7 +12,7 @@
 static void
 pass_any_null_param__returns_null(void **state)
 {
-    char DUMMY[] = "DUMMY";
+    const char DUMMY[] = "DUMMY";
 
     assert_null(searchandreplace(NULL, DUMMY, DUMMY));
     assert_null(searchandreplace(DUMMY, NULL, DUMMY));
@@ -22,8 +22,8 @@
 static void
 pass_any_empty_string__returns_null(void **state)
 {
-    char DUMMY[] = "DUMMY";
-    char EMPTY[] = "";
+    const char DUMMY[] = "DUMMY";
+    const char EMPTY[] = "";
 
     assert_null(searchandreplace(EMPTY, DUMMY, DUMMY));
     assert_null(searchandreplace(DUMMY, EMPTY, DUMMY));


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
