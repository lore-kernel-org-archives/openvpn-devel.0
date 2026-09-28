Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759A4CA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 21:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EWLfBY5BNG8Dct4c6iF0eOkAEdXdmN5fqNCjU4aHpv8=; b=ifuBU6VPzEciVxzbMJbkF+gyEU
	0950UB95CCzwzdpumg0zrkhWVkOV1Zplbi65emUQjv/7YwEFRuAtHkRHj3ca00yG1tJr0V1e9dqQT
	7snROi9hHvoMgZq3BA86kfYjBHb5a+6ZCy5P4tvyifsAAh9q1HOr4EqZehh5qkVwsea8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBIZ6-0002ke-NS;
	Mon, 28 Sep 2026 21:07:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xBIZ5-0002kX-JI
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 21:07:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6VsHSz8NL03vi50ZroXHbxnogU8sNLHR8fnn6Z7i5+k=; b=TgyyeCJD3ENFpE+1IJ/mGVgOlA
 XiJmF7TMDvAHW+HziRu6RG0JzFsGWt6yH3sSASMRG5dy4j6cIuoJDC0kPMoT/MTuXchmVG6kbJNIG
 rH4jIQ5fBDwMGVH5HXUEje2hPa39+zMG7I/33+W/XcLRlIJi58BemfLg3cefwbO+HQOI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6VsHSz8NL03vi50ZroXHbxnogU8sNLHR8fnn6Z7i5+k=; b=MCYjw2ETTcwEgkGJFHO1/4HaOd
 AOw7fhVDQcM00HDk005Oxsaa91dwzdiqKfSU0K15TQJ1EixDURAhlPtZfULRne7X6DJ6Cehac2yQg
 WDTaucC3nob3cheQnYBtQFKeQcZPFJbQU2gjMfYQO3ea5y7vgnTNurj7VnipDfXjXf6U=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBIZ0-0007Eh-US for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 21:07:09 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68SL709j012800
 for <openvpn-devel@lists.sourceforge.net>; Mon, 28 Sep 2026 23:07:00 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68SL70vn012799
 for openvpn-devel@lists.sourceforge.net; Mon, 28 Sep 2026 23:07:00 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 28 Sep 2026 23:06:54 +0200
Message-ID: <20260928210659.12780-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790613679000.Ib69b6c7a5f21f8552159c94560830f182c6238b7@gerrit.openvpn.net>
References: <gerrit.1790613679000.Ib69b6c7a5f21f8552159c94560830f182c6238b7@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xBIZ0-0007Eh-US
Subject: [Openvpn-devel] [PATCH v1] Fix (almost) all occurrences of cppcheck
 variableScope
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

In two cases I found the code change too ugly and added
a suppression. In most cases the change is trivially
correct (as long as it builds).

Some drive-by style fixes, and marked some of the moved
variables const as appropriate.

Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1963
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1963
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/cppcheck-suppressions.xml b/dev-tools/cppcheck-suppressions.xml
index 38de5f2a..bd24c3b 100644
--- a/dev-tools/cppcheck-suppressions.xml
+++ b/dev-tools/cppcheck-suppressions.xml
@@ -14,9 +14,6 @@
   <suppress>
     <id>usleepCalled</id>
   </suppress>
-  <suppress>
-    <id>variableScope</id>
-  </suppress>
   <!-- We have a lot of library includes, not all of them are really required,
        so ignore them -->
   <suppress>
@@ -288,4 +285,15 @@
     <id>unusedStructMember</id>
     <fileName>tests/unit_tests/openvpn/test_pkcs11.c</fileName>
   </suppress>
+  <!-- IGN: nicer -->
+  <suppress>
+    <id>variableScope</id>
+    <fileName>src/openvpnserv/interactive.c</fileName>
+    <symbolName>cmds</symbolName>
+  </suppress>
+  <suppress>
+    <id>variableScope</id>
+    <fileName>src/openvpnserv/interactive.c</fileName>
+    <symbolName>sys_key</symbolName>
+  </suppress>
 </suppressions>
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index 512861a..2474bf1 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -120,13 +120,14 @@
     ASN1_OBJECT *fn;
     ASN1_STRING *val;
     X509_NAME *x509_name;
-    X509_NAME_ENTRY *ent;
     const char *objbuf;
 
     x509_name = X509_get_subject_name(x509);
-    int i, n = X509_NAME_entry_count(x509_name);
-    for (i = 0; i < n; ++i)
+    int n = X509_NAME_entry_count(x509_name);
+    for (int i = 0; i < n; ++i)
     {
+        X509_NAME_ENTRY *ent;
+
         if (!(ent = X509_NAME_get_entry(x509_name, i)))
         {
             continue;
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 09c6735..1c781a3 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -197,7 +197,6 @@
     ASN1_OBJECT *fn;
     ASN1_STRING *val;
     X509_NAME *x509_name;
-    X509_NAME_ENTRY *ent;
     const char *objbuf;
     unsigned char *buf = NULL;
 
@@ -205,7 +204,7 @@
     n = X509_NAME_entry_count(x509_name);
     for (i = 0; i < n; ++i)
     {
-        ent = X509_NAME_get_entry(x509_name, i);
+        X509_NAME_ENTRY *ent = X509_NAME_get_entry(x509_name, i);
         if (!ent)
         {
             continue;
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 21e113d..8f558b1 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -228,13 +228,13 @@
     int ret = false;
     if (buf_defined(buf))
     {
-        va_list arglist;
         uint8_t *ptr = BEND(buf);
         int cap = buf_forward_capacity(buf);
 
         if (cap > 0)
         {
             int stat;
+            va_list arglist;
             va_start(arglist, format);
             stat = vsnprintf((char *)ptr, cap, format, arglist);
             va_end(arglist);
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 9fa8f5f..d72d42a 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -50,12 +50,11 @@
 print_client_nat_list(const struct client_nat_option_list *list, msglvl_t msglevel)
 {
     struct gc_arena gc = gc_new();
-    int i;
 
     msg(msglevel, "*** CNAT list");
     if (list)
     {
-        for (i = 0; i < list->n; ++i)
+        for (int i = 0; i < list->n; ++i)
         {
             const struct client_nat_entry *e = &list->entries[i];
             msg(msglevel, "  CNAT[%d] t=%d %s/%s/%s", i, e->type,
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 9c8d72a..cf6cc37 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -77,7 +77,6 @@
     bool is_console = (GetFileType(in) == FILE_TYPE_CHAR);
     DWORD flags_save = 0;
     int status = 0;
-    WCHAR *winput;
 
     if (is_console)
     {
@@ -100,7 +99,7 @@
 
     if (is_console)
     {
-        winput = malloc(capacity * sizeof(WCHAR));
+        WCHAR *winput = malloc(capacity * sizeof(WCHAR));
         if (winput == NULL)
         {
             return false;
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 8196c26..3d3ab0c 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1774,13 +1774,10 @@
 static const cipher_name_pair *
 get_cipher_name_pair(const char *cipher_name)
 {
-    const cipher_name_pair *pair;
-    size_t i = 0;
-
     /* Search for a cipher name translation */
-    for (; i < cipher_name_translation_table_count; i++)
+    for (size_t i = 0; i < cipher_name_translation_table_count; i++)
     {
-        pair = &cipher_name_translation_table[i];
+        const cipher_name_pair *pair = &cipher_name_translation_table[i];
         if (0 == strcmp(cipher_name, pair->openvpn_name)
             || 0 == strcmp(cipher_name, pair->lib_name))
         {
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 158c841..69a1852 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -387,9 +387,6 @@
     else if (epoch > opt->key_ctx_bi.decrypt.epoch
              && epoch <= opt->key_ctx_bi.decrypt.epoch + opt->epoch_data_keys_future_count)
     {
-        /* Key in the range of future keys */
-        int index = epoch - (opt->key_ctx_bi.decrypt.epoch + 1);
-
         /* If we have reached the edge of the valid keys we do not return
          * the key anymore since regenerating the new keys would move us
          * over the window of valid keys and would need all kind of
@@ -400,6 +397,9 @@
         }
         else
         {
+            /* Key in the range of future keys */
+            const int index = epoch - (opt->key_ctx_bi.decrypt.epoch + 1);
+
             return &opt->epoch_data_keys_future[index];
         }
     }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 7346903..3148f10 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -444,7 +444,6 @@
 key_to_nvlist(const uint8_t *key, const uint8_t *implicit_iv, const char *ciphername)
 {
     nvlist_t *nvl;
-    size_t key_len;
 
     nvl = nvlist_create(0);
 
@@ -452,7 +451,7 @@
 
     if (strcmp(ciphername, "none") != 0)
     {
-        key_len = cipher_kt_key_size(ciphername);
+        const size_t key_len = cipher_kt_key_size(ciphername);
 
         nvlist_add_binary(nvl, "key", key, key_len);
         nvlist_add_binary(nvl, "iv", implicit_iv, 8);
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 5cdcfcf..19e9e2d 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -271,7 +271,6 @@
 {
     char tmp_buf[256];
     size_t len = 0;
-    size_t label_length_pos;
 
     for (int i = 0; i < array_len; i++)
     {
@@ -290,7 +289,7 @@
 
         /* label_length_pos points to the byte to be replaced by the length
          * of the following domain label */
-        label_length_pos = len++;
+        size_t label_length_pos = len++;
 
         while (true)
         {
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index d992097..67a5bf5 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -62,14 +62,13 @@
 static bool
 env_string_equal(const char *s1, const char *s2)
 {
-    int c1, c2;
     ASSERT(s1);
     ASSERT(s2);
 
     while (true)
     {
-        c1 = *s1++;
-        c2 = *s2++;
+        int c1 = *s1++;
+        int c2 = *s2++;
         if (c1 == '=')
         {
             c1 = 0;
@@ -214,12 +213,11 @@
     if (check_debug_level(msglevel))
     {
         const struct env_item *e;
-        int i;
 
         if (es)
         {
+            int i = 0;
             e = es->list;
-            i = 0;
 
             while (e)
             {
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 204b0b7..41388d4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2039,13 +2039,13 @@
     unsigned int socket = 0;
     unsigned int tuntap = 0;
     static uintptr_t tun_shift = TUN_SHIFT;
-    static uintptr_t err_shift = ERR_SHIFT;
 
     /*
      * Calculate the flags based on the provided 'flags' argument.
      */
     if ((c->options.mode != MODE_SERVER) && (flags & IOW_WAIT_SIGNAL))
     {
+        static uintptr_t err_shift = ERR_SHIFT;
         wait_signal(es, (void *)err_shift);
     }
 
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index ab8a710..52df383 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -34,12 +34,9 @@
 static void
 CvtHex(IN HASH Bin, OUT HASHHEX Hex)
 {
-    unsigned short i;
-    unsigned char j;
-
-    for (i = 0; i < HASHLEN; i++)
+    for (unsigned short i = 0; i < HASHLEN; i++)
     {
-        j = (Bin[i] >> 4) & 0xf;
+        unsigned char j = (Bin[i] >> 4) & 0xf;
         if (j <= 9)
         {
             Hex[i * 2] = (j + '0');
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 2f1ca95..1e74f09 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -368,7 +368,6 @@
     {
         struct gc_arena gc = gc_new();
         struct log_entry e;
-        const char *out = NULL;
         unsigned int action_flags = 0;
 
         ++recursive_level;
@@ -391,6 +390,8 @@
 
         if (!man_password_needed(man))
         {
+            const char *out = NULL;
+
             if (flags == M_CLIENT)
             {
                 out = log_entry_print(&e, LOG_PRINT_CRLF, &gc);
@@ -3036,14 +3037,15 @@
 static void
 man_output_peer_info_env(struct management *man, const struct man_def_auth_context *mdac)
 {
-    char line[256];
     if (man->persist.callback.get_peer_info)
     {
         const char *peer_info =
             (*man->persist.callback.get_peer_info)(man->persist.callback.arg, mdac->cid);
         if (peer_info)
         {
+            char line[256];
             struct buffer buf;
+
             buf_set_read(&buf, (const uint8_t *)peer_info, strlen(peer_info));
             while (buf_parse(&buf, '\n', line, sizeof(line)))
             {
@@ -3820,13 +3822,12 @@
 {
     int ok;
     char *result = NULL;
-    const struct buffer *buf;
 
     ok = management_query_multiline(man, b64_data, prompt, cmd, state, input);
     if (ok && buffer_list_defined(*input))
     {
         buffer_list_aggregate_separator(*input, 10000, "\n");
-        buf = buffer_list_peek(*input);
+        const struct buffer *buf = buffer_list_peek(*input);
         if (buf && BLEN(buf) > 0)
         {
             result = (char *)malloc(BLENZ(buf) + 1);
@@ -3847,15 +3848,13 @@
 management_query_multiline_flatten(struct management *man, const char *b64_data, const char *prompt,
                                    const char *cmd, int *state, struct buffer_list **input)
 {
-    int ok;
     char *result = NULL;
-    const struct buffer *buf;
 
-    ok = management_query_multiline(man, b64_data, prompt, cmd, state, input);
+    const int ok = management_query_multiline(man, b64_data, prompt, cmd, state, input);
     if (ok && buffer_list_defined(*input))
     {
         buffer_list_aggregate(*input, 2048);
-        buf = buffer_list_peek(*input);
+        const struct buffer *buf = buffer_list_peek(*input);
         if (buf && BLEN(buf) > 0)
         {
             result = (char *)malloc(BLENZ(buf) + 1);
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 54af890..6e9591f 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -474,7 +474,7 @@
 purge_user_pass(struct user_pass *up, const bool force)
 {
     const bool nocache = up->nocache;
-    static bool warn_shown = false;
+
     if (nocache || force)
     {
         secure_memzero(up, sizeof(*up));
@@ -482,6 +482,8 @@
     }
     else
     {
+        static bool warn_shown = false;
+
         protect_user_pass(up);
         /*
          * don't show warning if the pass has been replaced by a token: this is an
@@ -721,11 +723,10 @@
 bool
 validate_peer_info_line(char *line)
 {
-    uint8_t c;
     int state = 0;
     while (*line)
     {
-        c = *line;
+        const uint8_t c = *line;
         switch (state)
         {
             case 0:
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index b6c428c..658424f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4200,13 +4200,11 @@
 static void
 tunnel_server_loop(struct multi_context *multi)
 {
-    int status;
-
     while (true)
     {
         /* wait on tun/socket list */
         multi_get_timeout(multi, &multi->top.c2.timeval);
-        status = multi_io_wait(multi);
+        const int status = multi_io_wait(multi);
         MULTI_CHECK_SIG(multi);
 
         /* check on status of coarse timers */
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index bb29781..49de664 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1375,13 +1375,11 @@
 sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len,
                          unsigned short flags)
 {
-    unsigned short type;
-
     memset(tb, 0, sizeof(struct rtattr *) * (max + 1));
 
     while (RTA_OK(rta, len))
     {
-        type = rta->rta_type & ~flags;
+        const unsigned short type = rta->rta_type & ~flags;
 
         if ((type <= max) && (!tb[type]))
         {
@@ -1409,7 +1407,6 @@
 static int
 sitnl_type_save(struct nlmsghdr *n, void *arg)
 {
-    char *type = arg;
     struct ifinfomsg *ifi = NLMSG_DATA(n);
     struct rtattr *tb[IFLA_MAX + 1];
 
@@ -1418,6 +1415,7 @@
     if (tb[IFLA_LINKINFO])
     {
         struct rtattr *tb_link[IFLA_INFO_MAX + 1];
+        char *type = arg;
 
         sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MAX, tb[IFLA_LINKINFO]);
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5a57c0a..1f4b191 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1019,10 +1019,9 @@
 
     for (current = *list, prev = NULL; current != NULL; current = current->next)
     {
-        char *tmp_value = NULL;
         if (!strncmp(current->string, "foreign_option_", sizeof("foreign_option_") - 1))
         {
-            tmp_value = strchr(current->string, '=');
+            const char *tmp_value = strchr(current->string, '=');
             if (tmp_value && ++tmp_value)
             {
                 if (!strncmp(tmp_value, "dhcp-option ", sizeof("dhcp-option ") - 1))
diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c
index 0e94522..79b8098 100644
--- a/src/openvpn/options_parse.c
+++ b/src/openvpn/options_parse.c
@@ -351,7 +351,6 @@
 {
     const int max_recursive_levels = 10;
     FILE *fp;
-    int line_num;
     char line[OPTION_LINE_SIZE + 1];
     char *p[MAX_PARMS + 1];
 
@@ -368,7 +367,7 @@
         }
         if (fp)
         {
-            line_num = 0;
+            int line_num = 0;
             while (fgets(line, sizeof(line), fp))
             {
                 int offset = 0;
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 22c53c7..50d7c76 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -219,8 +219,6 @@
 bool
 packet_id_test(struct packet_id_rec *p, const struct packet_id_net *pin)
 {
-    uint64_t diff;
-
     packet_id_debug(D_PID_DEBUG, p, pin, "PID_TEST", 0);
 
     ASSERT(p->initialized);
@@ -247,7 +245,7 @@
             }
 
             /* check packet-id sliding window for original/replay status */
-            diff = p->id - pin->id;
+            const uint64_t diff = p->id - pin->id;
 
             /* keep track of maximum backtrack seen for debugging purposes */
             if (diff > p->max_backtrack_stat)
@@ -512,7 +510,6 @@
     {
         struct packet_id_persist_file_image image;
         CLEAR(image);
-        ssize_t n;
         off_t seek_ret;
         struct gc_arena gc = gc_new();
 
@@ -521,7 +518,7 @@
         seek_ret = lseek(p->fd, (off_t)0, SEEK_SET);
         if (seek_ret == (off_t)0)
         {
-            n = write(p->fd, &image, sizeof(image));
+            const ssize_t n = write(p->fd, &image, sizeof(image));
             if (n == sizeof(image))
             {
                 p->time_last_written = p->time;
@@ -599,7 +596,6 @@
     {
         char c;
         time_t v;
-        int diff;
 
         v = CIRC_LIST_ITEM(sl, i);
         if (v == SEQ_UNSEEN)
@@ -612,7 +608,7 @@
         }
         else
         {
-            diff = (int)(prev_now - v);
+            const int diff = (int)(prev_now - v);
             if (diff < 0)
             {
                 c = 'N';
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index ccdd43d..9412eeb 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -539,8 +539,6 @@
 const char *
 platform_create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
 {
-    int fd;
-    const char *retfname = NULL;
     unsigned int attempts = 0;
     char fname[256] = { 0 };
     const char *fname_fmt = PACKAGE "_%.*s_%08" PRIx64 "%08" PRIx64 ".tmp";
@@ -557,7 +555,7 @@
             return NULL;
         }
 
-        retfname = platform_gen_path(directory, fname, gc);
+        const char *retfname = platform_gen_path(directory, fname, gc);
         if (!retfname)
         {
             msg(M_WARN, "Failed to create temporary filename and path");
@@ -566,7 +564,7 @@
 
         /* Atomically create the file.  Errors out if the file already
          * exists.  */
-        fd = platform_open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR);
+        const int fd = platform_open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR);
         if (fd != -1)
         {
             close(fd);
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 80dec6c..63fc930 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -494,22 +494,21 @@
         for (i = 0; i < pool->size; ++i)
         {
             const struct ifconfig_pool_entry *e = &pool->list[i];
-            struct in6_addr ip6;
-            in_addr_t ip;
-            const char *ip6_str = "";
-            const char *ip_str = "";
 
             if (e->common_name)
             {
+                const char *ip6_str = "";
+                const char *ip_str = "";
+
                 if (pool->ipv4.enabled)
                 {
-                    ip = ifconfig_pool_handle_to_ip_base(pool, i);
+                    const in_addr_t ip = ifconfig_pool_handle_to_ip_base(pool, i);
                     ip_str = print_in_addr_t(ip, 0, &gc);
                 }
 
                 if (pool->ipv6.enabled)
                 {
-                    ip6 = ifconfig_pool_handle_to_ipv6_base(pool, i);
+                    const struct in6_addr ip6 = ifconfig_pool_handle_to_ipv6_base(pool, i);
                     ip6_str = print_in6_addr(ip6, 0, &gc);
                 }
 
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 785c021..2cdb147 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -39,7 +39,6 @@
 is_ipv_X(int tunnel_type, struct buffer *buf, int ip_ver)
 {
     int offset;
-    uint16_t proto;
     const struct openvpn_iphdr *ih;
 
     verify_align_4(buf);
@@ -61,7 +60,7 @@
         eh = (const struct openvpn_ethhdr *)BPTR(buf);
 
         /* start by assuming this is a standard Eth fram */
-        proto = eh->proto;
+        uint16_t proto = eh->proto;
         offset = sizeof(struct openvpn_ethhdr);
 
         /* if this is a 802.1q frame, parse the header using the according
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index a514d92a..8dfe0d5 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1155,7 +1155,6 @@
         while (e)
         {
             char *p[MAX_PARMS + 1];
-            bool enable = true;
 
             /* parse the push item */
             CLEAR(p);
@@ -1163,6 +1162,8 @@
                 && parse_line(e->option, p, SIZE(p) - 1, "[PUSH_ROUTE_REMOVE]", 1, D_ROUTE_DEBUG,
                               &gc))
             {
+                bool enable = true;
+
                 /* is the push item a route directive? */
                 if (p[0] && !strcmp(p[0], "route") && !p[3] && o->iroutes)
                 {
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index b8bac7a..4830a5b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2773,7 +2773,6 @@
 {
     struct gc_arena gc = gc_new();
     bool ret = false;
-    DWORD status;
     const DWORD if_index = windows_route_find_if_index(r, tt);
 
     if (if_index != TUN_ADAPTER_INDEX_INVALID)
@@ -2787,8 +2786,7 @@
         fr.dwForwardNextHop = htonl(r->gateway);
         fr.dwForwardIfIndex = if_index;
 
-        status = DeleteIpForwardEntry(&fr);
-
+        const DWORD status = DeleteIpForwardEntry(&fr);
         if (status == NO_ERROR)
         {
             ret = true;
@@ -3826,12 +3824,11 @@
 bool
 netmask_to_netbits(const in_addr_t network, const in_addr_t netmask, int *netbits)
 {
-    int i;
     const int addrlen = sizeof(in_addr_t) * 8;
 
     if ((network & netmask) == network)
     {
-        for (i = 0; i <= addrlen; ++i)
+        for (int i = 0; i <= addrlen; ++i)
         {
             in_addr_t mask = netbits_to_netmask(i);
             if (mask == netmask)
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 905caa3..0e36dad 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -176,14 +176,13 @@
 #if defined(ENABLE_FEATURE_EXECVE)
         if (openvpn_execve_allowed(flags))
         {
-            const char *cmd = a->argv[0];
-            char *const *argv = a->argv;
             char *const *envp = (char *const *)make_env_array(es, true, &gc);
-            pid_t pid;
 
-            pid = fork();
+            const pid_t pid = fork();
             if (pid == (pid_t)0) /* child side */
             {
+                const char *cmd = a->argv[0];
+                char *const *argv = a->argv;
                 execve(cmd, argv, envp);
                 exit(OPENVPN_EXECVE_FAILURE);
             }
@@ -283,17 +282,17 @@
         static bool warn_shown = false;
         if (script_security() >= SSEC_BUILT_IN)
         {
-            const char *cmd = a->argv[0];
-            char *const *argv = a->argv;
             char *const *envp = (char *const *)make_env_array(es, true, &gc);
-            pid_t pid;
+            const char *cmd = a->argv[0];
             int pipe_stdout[2];
 
             if (pipe(pipe_stdout) == 0)
             {
-                pid = fork();
-                if (pid == (pid_t)0)       /* child side */
+                const pid_t pid = fork();
+                if (pid == (pid_t)0) /* child side */
                 {
+                    char *const *argv = a->argv;
+
                     close(pipe_stdout[0]); /* Close read end */
                     dup2(pipe_stdout[1], 1);
                     execve(cmd, argv, envp);
diff --git a/src/openvpn/siphash_reference.c b/src/openvpn/siphash_reference.c
index 5f0adb9..9240ab0 100644
--- a/src/openvpn/siphash_reference.c
+++ b/src/openvpn/siphash_reference.c
@@ -113,7 +113,6 @@
     uint64_t v3 = UINT64_C(0x7465646279746573);
     uint64_t k0 = U8TO64_LE(kk);
     uint64_t k1 = U8TO64_LE(kk + 8);
-    uint64_t m;
     int i;
     const unsigned char *end = ni + inlen - (inlen % sizeof(uint64_t));
     const int left = inlen & 7;
@@ -130,7 +129,7 @@
 
     for (; ni != end; ni += 8)
     {
-        m = U8TO64_LE(ni);
+        uint64_t m = U8TO64_LE(ni);
         v3 ^= m;
 
         TRACE;
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index cddf856..b60a8f0 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1014,12 +1014,12 @@
 tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 {
 #if MBEDTLS_VERSION_NUMBER < 0x04000000
-    static char old_sha256_hash[32] = { 0 };
-    unsigned char sha256_hash[32] = { 0 };
     mbedtls_ctr_drbg_context *cd_ctx = rand_ctx_get();
 
     if (NULL != ctx->crt_chain)
     {
+        static char old_sha256_hash[32] = { 0 };
+        unsigned char sha256_hash[32] = { 0 };
         mbedtls_x509_crt *cert = ctx->crt_chain;
         const mbedtls_md_info_t *kt = md_get("SHA256");
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index cb3de65..afda4d9 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1784,10 +1784,7 @@
 {
     STACK_OF(X509_INFO) *info_stack = NULL;
     STACK_OF(X509_NAME) *cert_names = NULL;
-    X509_LOOKUP *lookup = NULL;
     X509_STORE *store = NULL;
-    BIO *in = NULL;
-    openssl_stack_size_t added = 0, prev = 0;
 
     ASSERT(NULL != ctx);
 
@@ -1800,6 +1797,9 @@
     /* Try to add certificates and CRLs from ca_file */
     if (ca_file)
     {
+        openssl_stack_size_t added = 0;
+        BIO *in = NULL;
+
         if (ca_file_inline)
         {
             in = BIO_new_mem_buf((char *)ca_file, -1);
@@ -1816,6 +1816,8 @@
 
         if (info_stack)
         {
+            openssl_stack_size_t prev = 0;
+
             for (openssl_stack_size_t i = 0; i < sk_X509_INFO_num(info_stack); i++)
             {
                 X509_INFO *info = sk_X509_INFO_value(info_stack, i);
@@ -1916,7 +1918,7 @@
     /* Set a store for certs (CA & CRL) with a lookup on the "capath" hash directory */
     if (ca_path)
     {
-        lookup = X509_STORE_add_lookup(store, X509_LOOKUP_hash_dir());
+        X509_LOOKUP *lookup = X509_STORE_add_lookup(store, X509_LOOKUP_hash_dir());
         if (lookup && X509_LOOKUP_add_dir(lookup, ca_path, X509_FILETYPE_PEM))
         {
             msg(M_WARN, "WARNING: experimental option --capath %s", ca_path);
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 79d2b23..f78782f 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -74,8 +74,6 @@
 
         int e1, e2;
         uint8_t *b = BPTR(buf);
-        uint8_t buf1[SWAP_BUF_SIZE];
-        uint8_t buf2[SWAP_BUF_SIZE];
 
         if (incoming)
         {
@@ -92,6 +90,9 @@
 
         if (buf->len >= e1 + e2)
         {
+            uint8_t buf1[SWAP_BUF_SIZE];
+            uint8_t buf2[SWAP_BUF_SIZE];
+
             memcpy(buf1, b, e1);
             memcpy(buf2, b + e1, e2);
             memcpy(b, buf2, e2);
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index c4bae40..b9a36a6 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -701,7 +701,6 @@
 void
 x509_setenv(struct env_set *es, int cert_depth, mbedtls_x509_crt *cert)
 {
-    unsigned char c;
     const mbedtls_x509_name *name;
     char s[128] = { 0 };
 
@@ -729,7 +728,7 @@
                 break;
             }
 
-            c = name->val.p[i];
+            const unsigned char c = name->val.p[i];
             if (c < 32 || c == 127 || (c > 128 && c < 160))
             {
                 s[i] = '?';
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 85b3074..2d375a8 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1893,7 +1893,6 @@
                      openvpn_net_ctx_t *ctx)
 {
     char dynamic_name[256];
-    bool dynamic_opened = false;
 
     /*
      * unlike "open_tun_generic()", DCO on Linux and FreeBSD follows
@@ -1905,6 +1904,8 @@
 
     if (strcmp(dev, "tun") == 0)
     {
+        bool dynamic_opened = false;
+
         for (int i = 0; i < 256; ++i)
         {
             snprintf(dynamic_name, sizeof(dynamic_name), "%s%d", dev, i);
@@ -3263,7 +3264,6 @@
     if (tt->reads.iostate == IOSTATE_INITIAL)
     {
         BOOL status;
-        int err;
 
         /* reset buf to its initial state */
         tt->reads.buf = tt->reads.buf_init;
@@ -3290,7 +3290,7 @@
         }
         else
         {
-            err = GetLastError();
+            const int err = GetLastError();
             if (err == ERROR_IO_PENDING) /* operation queued? */
             {
                 tt->reads.iostate = IOSTATE_QUEUED;
@@ -3318,7 +3318,6 @@
     if (tt->writes.iostate == IOSTATE_INITIAL)
     {
         BOOL status;
-        int err;
 
         /* make a private copy of buf */
         tt->writes.buf = tt->writes.buf_init;
@@ -3345,7 +3344,7 @@
         }
         else
         {
-            err = GetLastError();
+            const int err = GetLastError();
             if (err == ERROR_IO_PENDING) /* operation queued? */
             {
                 tt->writes.iostate = IOSTATE_QUEUED;
@@ -3542,8 +3541,6 @@
         char enum_name[256];
         char unit_string[256];
         HKEY unit_key;
-        char component_id_string[] = "ComponentId";
-        char component_id[256];
         const char net_cfg_instance_id_string[] = "NetCfgInstanceId";
         BYTE net_cfg_instance_id[256];
         DWORD data_type;
@@ -3573,6 +3570,8 @@
         }
         else
         {
+            const char component_id_string[] = "ComponentId";
+            char component_id[256];
             len = sizeof(component_id);
             status = RegQueryValueEx(unit_key, component_id_string, NULL, &data_type,
                                      (LPBYTE)component_id, &len);
@@ -3657,7 +3656,6 @@
         char enum_name[256];
         char connection_string[256];
         HKEY connection_key;
-        WCHAR name_data[256];
         DWORD name_type;
         const WCHAR name_string[] = L"Name";
 
@@ -3689,6 +3687,7 @@
         }
         else
         {
+            WCHAR name_data[256];
             len = sizeof(name_data);
             status = RegQueryValueExW(connection_key, name_string, NULL, &name_type,
                                       (LPBYTE)name_data, &len);
@@ -3813,8 +3812,6 @@
     bool warn_panel_dup = false;
     bool warn_tap_dup = false;
 
-    int links;
-
     const struct tap_reg *tr;
     const struct tap_reg *tr1;
     const struct panel_reg *pr;
@@ -3827,7 +3824,7 @@
     /* loop through each TAP-Windows adapter registry entry */
     for (tr = tap_reg; tr != NULL; tr = tr->next)
     {
-        links = 0;
+        int links = 0;
 
         /* loop through each network connections entry in the control panel */
         for (pr = panel_reg; pr != NULL; pr = pr->next)
@@ -4110,10 +4107,11 @@
 {
     ULONG size = 0;
     IP_PER_ADAPTER_INFO *pi = NULL;
-    DWORD status;
 
     if (index != TUN_ADAPTER_INDEX_INVALID)
     {
+        DWORD status;
+
         if ((status = GetPerAdapterInfo(index, NULL, &size)) != ERROR_BUFFER_OVERFLOW)
         {
             msg(M_INFO, "GetPerAdapterInfo #1 failed (status=%lu) : %s", status,
@@ -4308,7 +4306,6 @@
 bool
 is_adapter_up(const struct tuntap *tt, const IP_ADAPTER_INFO *list)
 {
-    int i;
     bool ret = false;
 
     const IP_ADAPTER_INFO *ai = get_tun_adapter(tt, list);
@@ -4318,7 +4315,7 @@
         const int n = get_adapter_n_ip_netmask(ai);
 
         /* loop once for every IP/netmask assigned to adapter */
-        for (i = 0; i < n; ++i)
+        for (int i = 0; i < n; ++i)
         {
             in_addr_t ip, netmask;
             if (get_adapter_ip_netmask(ai, i, &ip, &netmask))
@@ -4352,7 +4349,6 @@
 bool
 is_ip_in_adapter_subnet(const IP_ADAPTER_INFO *ai, const in_addr_t ip, in_addr_t *highest_netmask)
 {
-    int i;
     bool ret = false;
 
     if (highest_netmask)
@@ -4363,7 +4359,7 @@
     if (ai)
     {
         const int n = get_adapter_n_ip_netmask(ai);
-        for (i = 0; i < n; ++i)
+        for (int i = 0; i < n; ++i)
         {
             in_addr_t adapter_ip, adapter_netmask;
             if (get_adapter_ip_netmask(ai, i, &adapter_ip, &adapter_netmask))
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 4c511a9..fde6412 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1042,7 +1042,6 @@
 openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags)
 {
     int ret = OPENVPN_EXECVE_ERROR;
-    static bool exec_warn = false;
 
     if (a && a->argv[0])
     {
@@ -1093,6 +1092,8 @@
         }
         else
         {
+            static bool exec_warn = false;
+
             ret = OPENVPN_EXECVE_NOT_ALLOWED;
             if (!exec_warn && (script_security() < SSEC_SCRIPTS))
             {
@@ -1489,11 +1490,10 @@
 static void
 set_openssl_env_vars(void)
 {
-    const WCHAR *ssl_fallback_dir = L"C:\\Windows\\System32";
-
     WCHAR install_path[MAX_PATH] = { 0 };
     if (!get_openvpn_reg_value(NULL, install_path, _countof(install_path)))
     {
+        const WCHAR *ssl_fallback_dir = L"C:\\Windows\\System32";
         /* if we cannot find installation path from the registry,
          * use Windows directory as a fallback
          */
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index cce5318..7a23d41 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -254,10 +254,8 @@
 MsgToEventLog(DWORD flags, LPCWSTR format, ...)
 {
     HANDLE hEventSource;
-    WCHAR msg[2][256];
     DWORD error = 0;
     LPCWSTR err_msg = L"";
-    va_list arglist;
 
     if (flags & MSG_FLAGS_SYS_CODE)
     {
@@ -268,6 +266,9 @@
     hEventSource = RegisterEventSource(NULL, APPNAME);
     if (hEventSource != NULL)
     {
+        va_list arglist;
+        WCHAR msg[2][256];
+
         swprintf(msg[0], _countof(msg[0]), L"%ls%ls%ls: %ls", APPNAME, service_instance,
                  (flags & MSG_FLAGS_ERROR) ? L" error" : L"", err_msg);
 
@@ -311,10 +312,10 @@
 const wchar_t *
 get_win_sys_path(void)
 {
-    const wchar_t *default_sys_path = L"C:\\Windows\\system32";
-
     if (!GetSystemDirectoryW(win_sys_path, _countof(win_sys_path)))
     {
+        const wchar_t *default_sys_path = L"C:\\Windows\\system32";
+
         wcscpy_s(win_sys_path, _countof(win_sys_path), default_sys_path);
         win_sys_path[_countof(win_sys_path) - 1] = L'\0';
     }
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 026d5aa..d8cf6e1 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -933,7 +933,6 @@
 RegisterDNS(LPVOID unused)
 {
     DWORD err;
-    size_t i;
     DWORD timeout = RDNS_TIMEOUT * 1000; /* in milliseconds */
 
     /* path of ipconfig command */
@@ -956,7 +955,7 @@
     if (WaitForMultipleObjects(2, wait_handles, FALSE, timeout) == WAIT_OBJECT_0)
     {
         /* Semaphore locked */
-        for (i = 0; i < _countof(cmds); ++i)
+        for (size_t i = 0; i < _countof(cmds); ++i)
         {
             ExecCommand(cmds[i].argv0, cmds[i].cmdline, cmds[i].timeout);
         }
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index 04b20d7..2913f63 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -21,7 +21,6 @@
 BOOL
 ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status)
 {
-    static DWORD dwCheckPoint = 1;
     BOOL res = TRUE;
 
     if (status->dwCurrentState == SERVICE_START_PENDING)
@@ -39,6 +38,7 @@
     }
     else
     {
+        static DWORD dwCheckPoint = 1;
         status->dwCheckPoint = dwCheckPoint++;
     }
 
@@ -55,7 +55,6 @@
 static int
 CmdInstallServices(void)
 {
-    SC_HANDLE service;
     SC_HANDLE svc_ctl_mgr;
     WCHAR path[512];
     int i, ret = _service_max;
@@ -78,7 +77,7 @@
 
     for (i = 0; i < _service_max; i++)
     {
-        service = CreateService(
+        SC_HANDLE service = CreateService(
             svc_ctl_mgr, openvpn_service[i].name, openvpn_service[i].display_name,
             SERVICE_QUERY_STATUS, SERVICE_WIN32_SHARE_PROCESS, openvpn_service[i].start_type,
             SERVICE_ERROR_NORMAL, path, NULL, NULL, openvpn_service[i].dependencies, NULL, NULL);
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 5619f36..e5562ee 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -378,12 +378,11 @@
 static void
 xkey_provider_test_generic_sign_cb(void **state)
 {
-    EVP_PKEY *pubkey;
     const char *dummy = "xkey_handle"; /* a dummy handle for the external key */
 
     for (size_t i = 0; i < _countof(pubkeys); i++)
     {
-        pubkey = load_pubkey(pubkeys[i]);
+        EVP_PKEY *pubkey = load_pubkey(pubkeys[i]);
         assert_non_null(pubkey);
 
         EVP_PKEY *privkey =


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
