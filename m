Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110F6C5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 21:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4a341YphsYOk0xYR9J76bQgiK+oEhAiUOxtyGgg52ms=; b=Ux4IzqfKv1RQcvtwf0UuUA1oa8
	YroCr31NncEbE5DYRiXs/zdNEA0vjkm5zYAgoUf/YqlyPT1fqoLNfPU54qMGMnWcd9n/OjN57a7x1
	lHnRWb5OFgeGUYocAUT7inU4AeGUAwHVvs807UU/xoHShNNXTye89YCbfDLs9XSGc0gI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwnbf-000207-VO;
	Wed, 19 Aug 2026 21:13:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wwnbf-000200-BZ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 21:13:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i647d7g50HFhKSySZji6873bVvgqprSMiEOMKfKd7Qc=; b=hSRHzK0HpWz6TDBHxnZOE2qqZ7
 nvDnajEckLEJaUs4hhxAUxn6Y+snx8lhL1obLXH2lTttqEIfpYhcpSAZBJAZsTeP6MWyJW2kBihIN
 aKhfizSxPpxELQQqyddIX46huPa7ChwFAb8jxefBtNOaSqA88ic7rctk/XLz8bWBwVmU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i647d7g50HFhKSySZji6873bVvgqprSMiEOMKfKd7Qc=; b=lpK16f8YpK/pMGAyn3PKTa4NIz
 rTefhXgitAifhnt1krdjDPjRxSYXC551xY3SN0rDhm0aBjb2Mk0r4+FvI78hpT+omNmxHakBUWTff
 DhQy9j0lrmbm+XnEH6kzxVaEDGclotHEI3piqvV420Y+TJCUJ4MHsAAfMPnosGeE+KRk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwnbh-0002zt-LH for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 21:13:55 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67JLDlfF002791
 for <openvpn-devel@lists.sourceforge.net>; Wed, 19 Aug 2026 23:13:47 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67JLDl5j002790
 for openvpn-devel@lists.sourceforge.net; Wed, 19 Aug 2026 23:13:47 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 19 Aug 2026 23:13:41 +0200
Message-ID: <20260819211346.2776-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wwnbh-0002zt-LH
Subject: [Openvpn-devel] [PATCH v15] Rename variables that shadow other
 variables or functions
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

Identified by cppcheck.

Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1618
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1618
This mail reflects revision 15 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index f1dccc1..c082f51 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1328,8 +1328,6 @@
 static void
 man_load_stats(struct management *man)
 {
-    extern counter_type link_read_bytes_global;
-    extern counter_type link_write_bytes_global;
     int nclients = 0;
 
     if (man->persist.callback.n_clients)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 147b31e..1de7672 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2080,12 +2080,12 @@
                     "may accept clients which do not present a certificate");
     }
 
-    const unsigned int tls_version_max =
+    const unsigned int tls_ver_max =
         (options->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
-    const unsigned int tls_version_min =
+    const unsigned int tls_ver_min =
         (options->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
 
-    if (tls_version_max > 0 && tls_version_max < tls_version_min)
+    if (tls_ver_max > 0 && tls_ver_max < tls_ver_min)
     {
         msg(M_USAGE, "--tls-version-min bigger than --tls-version-max");
     }
@@ -3032,16 +3032,16 @@
         {
             struct dns_domain **entry = &dns->search_domains;
             ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
-            struct dns_domain *new = *entry;
-            new->name = dhcp->domain;
-            entry = &new->next;
+            struct dns_domain *domain = *entry;
+            domain->name = dhcp->domain;
+            entry = &domain->next;
 
             for (unsigned int i = 0; i < dhcp->domain_search_list_len; ++i)
             {
                 ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
-                struct dns_domain *new = *entry;
-                new->name = dhcp->domain_search_list[i];
-                entry = &new->next;
+                struct dns_domain *search_domain = *entry;
+                search_domain->name = dhcp->domain_search_list[i];
+                entry = &search_domain->next;
             }
 
             struct dns_server *server = dns_server_get(&dns->servers, 0, &dns->gc);
@@ -3134,7 +3134,6 @@
 static void
 options_postprocess_mutate(struct options *o, struct env_set *es)
 {
-    int i;
     /*
      * Process helper-type options which map to other, more complex
      * sequences of options.
@@ -3167,7 +3166,7 @@
          * Convert remotes into connection list
          */
         const struct remote_list *rl = o->remote_list;
-        for (i = 0; i < rl->len; ++i)
+        for (int i = 0; i < rl->len; ++i)
         {
             const struct remote_entry *re = rl->array[i];
             struct connection_entry ce = o->ce;
@@ -3189,14 +3188,14 @@
     }
 
     ASSERT(o->connection_list);
-    for (i = 0; i < o->connection_list->len; ++i)
+    for (int i = 0; i < o->connection_list->len; ++i)
     {
         options_postprocess_mutate_ce(o, o->connection_list->array[i]);
     }
 
     if (o->ce.local_list)
     {
-        for (i = 0; i < o->ce.local_list->len; i++)
+        for (int i = 0; i < o->ce.local_list->len; i++)
         {
             options_postprocess_mutate_le(&o->ce, o->ce.local_list->array[i], o->mode);
         }
@@ -3224,7 +3223,7 @@
     }
 
     /* use the same listen list for every outgoing connection */
-    for (i = 0; i < o->connection_list->len; ++i)
+    for (int i = 0; i < o->connection_list->len; ++i)
     {
         o->connection_list->array[i]->local_list = o->ce.local_list;
     }
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index c3f54ed..be91a99 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -813,9 +813,9 @@
      * Get host's IP address
      */
     struct addrinfo *ai;
-    int status = openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, port,
-                                     0, NULL, AF_UNSPEC, &ai);
-    ASSERT(status == 0);
+    int ga_status = openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, port,
+                                        0, NULL, AF_UNSPEC, &ai);
+    ASSERT(ga_status == 0);
     ASSERT(sizeof(hostaddr.addr) >= ai->ai_addrlen);
     memcpy(&hostaddr.addr.sa, ai->ai_addr, ai->ai_addrlen);
     freeaddrinfo(ai);
@@ -863,8 +863,8 @@
         set_cloexec(fd[0]);
 
         /* wait for background child process to initialize */
-        int status = recv_control(fd[0]);
-        if (status == RESPONSE_INIT_SUCCEEDED)
+        int recv_status = recv_control(fd[0]);
+        if (recv_status == RESPONSE_INIT_SUCCEEDED)
         {
             /* note that this will cause possible EAGAIN when writing to
              * control socket if proxy process is backlogged */
@@ -875,7 +875,7 @@
         }
         else
         {
-            msg(M_ERR, "PORT SHARE: unexpected init recv_control status=%d", status);
+            msg(M_ERR, "PORT SHARE: unexpected init recv_control status=%d", recv_status);
         }
     }
     else
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 3ed72db..47f5ac5 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -776,24 +776,24 @@
     }
 
     /* Sanity check: load client key (as "client") */
-    struct key_ctx_bi test_client_key;
-    struct buffer test_wrapped_client_key;
+    struct key_ctx_bi check_client_key;
+    struct buffer check_wrapped_client_key;
     struct key2 keydata;
     msg(D_GENKEY, "Testing client-side key loading...");
-    tls_crypt_v2_init_client_key(&test_client_key, &keydata, &test_wrapped_client_key, client_file,
+    tls_crypt_v2_init_client_key(&check_client_key, &keydata, &check_wrapped_client_key, client_file,
                                  client_inline);
-    free_key_ctx_bi(&test_client_key);
+    free_key_ctx_bi(&check_client_key);
 
     /* Sanity check: unwrap and load client key (as "server") */
-    struct buffer test_metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &gc);
-    struct key2 test_client_key2 = { 0 };
+    struct buffer check_metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &gc);
+    struct key2 check_client_key2 = { 0 };
     free_key_ctx(&server_key);
     tls_crypt_v2_init_server_key(&server_key, false, server_key_file, server_key_inline);
     msg(D_GENKEY, "Testing server-side key loading...");
-    ASSERT(tls_crypt_v2_unwrap_client_key(&test_client_key2, &test_metadata,
-                                          test_wrapped_client_key, &server_key));
-    secure_memzero(&test_client_key2, sizeof(test_client_key2));
-    free_buf(&test_wrapped_client_key);
+    ASSERT(tls_crypt_v2_unwrap_client_key(&check_client_key2, &check_metadata,
+                                          check_wrapped_client_key, &server_key));
+    secure_memzero(&check_client_key2, sizeof(check_client_key2));
+    free_buf(&check_wrapped_client_key);
 
 cleanup:
     secure_memzero(&client_key, sizeof(client_key));
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 30cfb6a..32c1b9c 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -541,19 +541,19 @@
 static DWORD
 InterfaceLuid(const char *iface_name, PNET_LUID luid)
 {
-    NETIO_STATUS status;
+    NETIO_STATUS convert_status;
     LPWSTR wide_name = utf8to16(iface_name);
 
     if (wide_name)
     {
-        status = ConvertInterfaceAliasToLuid(wide_name, luid);
+        convert_status = ConvertInterfaceAliasToLuid(wide_name, luid);
         free(wide_name);
     }
     else
     {
-        status = ERROR_OUTOFMEMORY;
+        convert_status = ERROR_OUTOFMEMORY;
     }
-    return status;
+    return convert_status;
 }
 
 static BOOL
@@ -1183,8 +1183,8 @@
         goto out;
     }
 
-    SERVICE_STATUS status;
-    if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &status) == 0)
+    SERVICE_STATUS control_status;
+    if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &control_status) == 0)
     {
         MsgToEventLog(M_ERR, L"%S: ControlService call failed (%lu)", __func__, GetLastError());
         goto out;
@@ -3763,12 +3763,12 @@
 static DWORD WINAPI
 ServiceCtrlInteractive(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)
 {
-    SERVICE_STATUS *status = ctx;
+    SERVICE_STATUS *svc_status = ctx;
     switch (ctrl_code)
     {
         case SERVICE_CONTROL_STOP:
-            status->dwCurrentState = SERVICE_STOP_PENDING;
-            ReportStatusToSCMgr(service, status);
+            svc_status->dwCurrentState = SERVICE_STOP_PENDING;
+            ReportStatusToSCMgr(service, svc_status);
             if (exit_event)
             {
                 SetEvent(exit_event);
diff --git a/tests/unit_tests/openvpn/test_dhcp.c b/tests/unit_tests/openvpn/test_dhcp.c
index 150a3aa..104fc9a 100644
--- a/tests/unit_tests/openvpn/test_dhcp.c
+++ b/tests/unit_tests/openvpn/test_dhcp.c
@@ -55,8 +55,8 @@
 {
     struct gc_arena gc = gc_new();
     struct buffer out_buf = alloc_buf_gc(512, &gc);
-    struct buffer clear_buf = alloc_buf_gc(512, &gc);
-    buf_clear(&clear_buf);
+    struct buffer clean_buf = alloc_buf_gc(512, &gc);
+    buf_clear(&clean_buf);
     bool error = false;
 
 #define LONGDOMAIN "a-reaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaally-long-domain"
@@ -79,7 +79,7 @@
     struct buffer small_buf = alloc_buf_gc(sizeof(output_1) - 1, &gc);
     buf_clear(&small_buf);
     write_dhcp_search_str(&small_buf, DHCP_DOMAIN_SEARCH, search_list, 2, &error);
-    assert_memory_equal(BPTR(&small_buf), BPTR(&clear_buf), buf_forward_capacity_total(&small_buf));
+    assert_memory_equal(BPTR(&small_buf), BPTR(&clean_buf), buf_forward_capacity_total(&small_buf));
     assert_true(error);
     error = false;
 
@@ -103,13 +103,13 @@
 
     buf_clear(&out_buf);
     write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list + 5, 1, &error);
-    assert_memory_equal(BPTR(&out_buf), BPTR(&clear_buf), buf_forward_capacity_total(&clear_buf));
+    assert_memory_equal(BPTR(&out_buf), BPTR(&clean_buf), buf_forward_capacity_total(&clean_buf));
     assert_true(error);
     error = false;
 
     buf_clear(&out_buf);
     write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list, 3, &error);
-    assert_memory_equal(BPTR(&out_buf), BPTR(&clear_buf), buf_forward_capacity_total(&clear_buf));
+    assert_memory_equal(BPTR(&out_buf), BPTR(&clean_buf), buf_forward_capacity_total(&clean_buf));
     assert_true(error);
     error = false;
 
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 389fa09..9cb791b 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -344,8 +344,8 @@
 
     /* Message 1: first batch of routes, continuation 2 (more coming) */
     struct buffer buf1 = alloc_buf(512);
-    const char *msg1 = "PUSH_UPDATE, route 10.1.0.0 255.255.0.0, route 10.2.0.0 255.255.0.0, route 10.3.0.0 255.255.0.0,push-continuation 2";
-    buf_write(&buf1, msg1, strlen(msg1));
+    const char *cont_msg1 = "PUSH_UPDATE, route 10.1.0.0 255.255.0.0, route 10.2.0.0 255.255.0.0, route 10.3.0.0 255.255.0.0,push-continuation 2";
+    buf_write(&buf1, cont_msg1, strlen(cont_msg1));
 
     assert_int_equal(process_incoming_push_msg(c, &buf1, c->options.pull, pull_permission_mask(c),
                                                &option_types_found),
@@ -354,8 +354,8 @@
 
     /* Message 2: more routes, continuation 2 (more coming) */
     struct buffer buf2 = alloc_buf(512);
-    const char *msg2 = "PUSH_UPDATE, route 10.4.0.0 255.255.0.0, route 10.5.0.0 255.255.0.0, route 10.6.0.0 255.255.0.0,push-continuation 2";
-    buf_write(&buf2, msg2, strlen(msg2));
+    const char *cont_msg2 = "PUSH_UPDATE, route 10.4.0.0 255.255.0.0, route 10.5.0.0 255.255.0.0, route 10.6.0.0 255.255.0.0,push-continuation 2";
+    buf_write(&buf2, cont_msg2, strlen(cont_msg2));
 
     assert_int_equal(process_incoming_push_msg(c, &buf2, c->options.pull, pull_permission_mask(c),
                                                &option_types_found),
@@ -364,8 +364,8 @@
 
     /* Message 3: final batch of routes, continuation 1 (last message) */
     struct buffer buf3 = alloc_buf(512);
-    const char *msg3 = "PUSH_UPDATE, route 10.7.0.0 255.255.0.0, route 10.8.0.0 255.255.0.0, route 10.9.0.0 255.255.0.0,push-continuation 1";
-    buf_write(&buf3, msg3, strlen(msg3));
+    const char *cont_msg3 = "PUSH_UPDATE, route 10.7.0.0 255.255.0.0, route 10.8.0.0 255.255.0.0, route 10.9.0.0 255.255.0.0,push-continuation 1";
+    buf_write(&buf3, cont_msg3, strlen(cont_msg3));
 
     assert_int_equal(process_incoming_push_msg(c, &buf3, c->options.pull, pull_permission_mask(c),
                                                &option_types_found),


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
