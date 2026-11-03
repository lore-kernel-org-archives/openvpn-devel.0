Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DDE606D805
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lBUWJkIl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mnva3t6k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PtCHFKi2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bNHSAMcJyWWm33rkv8EPre8PTQcuadcy7N995ih8jtc=; b=lBUWJkIlUJjWDI
	wQY5LNfjHdR6asucltcmH13LiBYCPptZzPODi2eUJDn1TzWha6cNDLZmRJy8JxYPa/U7oAFSwKdAn
	WhUsojEwLzM54VrM6/MfAnh0OHwkW3bPzWjYt6Agz0MBD2RuApYfvm/nhmoZ7CX9v26zbS05sKmOv
	qOQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODhT-000000000h9-0vTI;
	Tue, 03 Nov 2026 12:33:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xODhS-000000000h3-1nFf for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:33:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=whFidAckB0Tsb+DfxlQGIubD8tfRKFVWDQXdp8PAGrE=; b=mnva3t6kamMUBq5rL/jUseNzcq
 L1il53VMpJnQyiN6I/Vyq+k7NXyFGCn9qc0XKB3p9uQwtXV5M8rRoBanISeUEO6PaudsCwjEw4ZfN
 o3BV5pF/B/SEtmxQS25XH6z/vN6AJmzZoYmKp7R6dnhLMN5Wi7YhR/QlwWA6dmF3zu/8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=whFidAckB0Tsb+DfxlQGIubD8tfRKFVWDQXdp8PAGrE=; b=PtCHFKi2iRJsr105p5T020tGOR
 3hfGJLXndLahgjQBzFI6lHe+hRMJ0DEbI1I/z912ld6wDURDE+Xt+Rc2aZYjNi8FfY6pH4A2RMD3N
 YigA7cxwUbh0OMHzday+JUWhXxT4u9QVk8Fe4a3AOHD583h7nxPmNHsmeJzuoEAdKx8A=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xODhR-0000000027W-1dia for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:33:14 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A3CX6BY003892
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 13:33:06 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3CX6YS003891
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 13:33:06 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 13:32:58 +0100
Message-ID: <20261103123306.3866-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793686618000.Ie6c1fa663978eedca2391f1250129bc46738faa0@gerrit.openvpn.net>
References: <gerrit.1793686618000.Ie6c1fa663978eedca2391f1250129bc46738faa0@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xODhR-0000000027W-1dia
Subject: [Openvpn-devel] [PATCH v2] Remove unused local variables
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

- tls_session_generate_dynamic_tls_crypt_key(): kds
- socks_proxy_recv_char(): reads fd_set
- verify_cert_call_command(): gc
- man_dispatch_command(): gc, the unused nparms parameter and the
  done label, which only served gc_free()

Change-Id: Ie6c1fa663978eedca2391f1250129bc46738faa0
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2098
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2098
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 16864c8..102f96e 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1478,16 +1478,12 @@
 }
 
 static void
-man_dispatch_command(struct management *man, struct status_output *so, const char **p,
-                     const int nparms)
+man_dispatch_command(struct management *man, struct status_output *so, const char **p)
 {
-    struct gc_arena gc = gc_new();
-
     ASSERT(p[0]);
     if (streq(p[0], "exit") || streq(p[0], "quit"))
     {
         man->connection.halt = true;
-        goto done;
     }
     else if (streq(p[0], "help"))
     {
@@ -1841,9 +1837,6 @@
     {
         msg(M_CLIENT, "ERROR: unknown command [%s], enter 'help' for more options", p[0]);
     }
-
-done:
-    gc_free(&gc);
 }
 
 #ifdef _WIN32
@@ -2250,7 +2243,7 @@
 
         if (nparms > 0)
         {
-            man_dispatch_command(man, so, (const char **)parms, nparms);
+            man_dispatch_command(man, so, (const char **)parms);
         }
     }
 
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index cab9af6..a8c9fd3 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -86,10 +86,6 @@
                       const struct event_timeout *server_poll_timeout,
                       volatile int *signal_received)
 {
-    fd_set reads;
-    FD_ZERO(&reads);
-    openvpn_fd_set(sd, &reads);
-
     struct timeval tv;
     tv.tv_sec = get_server_poll_remaining_time(server_poll_timeout);
     tv.tv_usec = 0;
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 73e3696..167e659 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -515,7 +515,6 @@
                          char *subject)
 {
     int ret;
-    struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
 
     setenv_str(es, "script_type", "tls-verify");
@@ -526,7 +525,6 @@
     argv_msg_prefix(D_TLS_DEBUG, &argv, "TLS: executing verify command");
     ret = openvpn_run_script(&argv, es, 0, "--tls-verify script");
 
-    gc_free(&gc);
     argv_free(&argv);
 
     if (ret)
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 23c7975..447262c 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -121,9 +121,6 @@
 
     const int key_direction = session->opt->server ? KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
 
-    struct key_direction_state kds;
-    key_direction_state_init(&kds, key_direction);
-
     struct key_type kt = tls_crypt_kt();
 
     init_key_ctx_bi(&session->tls_wrap_reneg.opt.key_ctx_bi, &rengokeys, key_direction, &kt,


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
