Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6EE606A32E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TI5ksLk+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dOoVise0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dNh0+w4P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=n919RgrpPDeNHVaMISe8FUxYHiA3b5hnIk6+8CxDEwE=; b=TI5ksLk+ymwGPC
	RrKv7SnakdDBszSeOZdKK8rIwd9Rew+rbw9Wc0/wW3LTXyPv2QYcQUvTOUskSptZgZfuhZlHQk0tQ
	vvD2yF6i/OrZoSGObu6rwcrqMCySTRUZuYHW4znotcS7TDzvTeXo0l01cyDfg/EhjJzoobvXwUeTE
	QYc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWGX2-0000000076v-42ri;
	Wed, 25 Nov 2026 17:11:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWGX1-0000000076g-1pE5 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 17:11:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+wHp2Ex+6AbFFCG3RwlQhtkrTYtgxAbEtzNEXvYjFWU=; b=dOoVise01rUatYp9bo2Y+aLB2C
 MWpycPGkUjwNHH3hj/Olw8pl3li4ZkurIqZcnL7ogRRCEX9bTVgCCMXV7PQlbDfaqlqSpE4mOcwL9
 zK9yQwXyVN0xe+u0eQbOuX4oQzC90NbN/QhWA1W4rTs4W1YuTO8/ynFJNK4a3IVS3KQU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+wHp2Ex+6AbFFCG3RwlQhtkrTYtgxAbEtzNEXvYjFWU=; b=dNh0+w4P3zAPyiwCv+kL4yqtxs
 fF4rLiYdL5gb4FQvnuUPeC17fgO1eiy181LuX+wQW/617n8Q17hTauItvCEB0f5O8cmrnfJ98vqQu
 76feZY6KcS9lLVKNT2LcFRjVxeO7p+WqAaVHQ+DBrl6NgNthjvXEfpZilNt4lwPuh+pg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWGWz-000000005Sw-2l8i for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 17:11:43 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6APHBYvQ021410
 for <openvpn-devel@lists.sourceforge.net>; Wed, 25 Nov 2026 18:11:34 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6APHBYWq021409
 for openvpn-devel@lists.sourceforge.net; Wed, 25 Nov 2026 18:11:34 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 25 Nov 2026 18:11:28 +0100
Message-ID: <20261125171133.21392-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795621690000.I0f659eb20441edd411ec13f4d09f434141b2da32@gerrit.openvpn.net>
References: <gerrit.1795621690000.I0f659eb20441edd411ec13f4d09f434141b2da32@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWGWz-000000005Sw-2l8i
Subject: [Openvpn-devel] [PATCH v2] push: remove dead code
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

- push_option_ex(): drop the "enable" parameter; it was ignored and
  every caller passed true.
- push_remove_option(): drop the NULL check on o, already dereferenced
  by the ifconfig/ifconfig-ipv6 checks above it.
- receive_auth_failed(): drop a repeated no_advance = true and a BLEN()
  check implied by the preceding "CRV1:" prefix match, and the blank
  line hiding that the auth-token check is an else-if of the TEMP one.

Change-Id: I0f659eb20441edd411ec13f4d09f434141b2da32
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2344
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2344
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index eb11107..274f652 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -75,7 +75,6 @@
         parse_auth_failed_temp(&c->options, reason + strlen("TEMP"));
         register_signal(c->sig, SIGUSR1, "auth-temp-failure (server temporary reject)");
     }
-
     /* Before checking how to react on AUTH_FAILED, first check if the
      * failed auth might be the result of an expired auth-token.
      * Note that a server restart will trigger a generic AUTH_FAILED
@@ -85,7 +84,6 @@
     {
         /* SOFT-SIGUSR1 -- Auth failure error */
         register_signal(c->sig, SIGUSR1, "auth-failure (auth-token)");
-        c->options.no_advance = true;
     }
     else
     {
@@ -117,7 +115,7 @@
     /*
      * Save the dynamic-challenge text even when management is defined
      */
-    if (authfail_extended && buf_string_match_head_str(&buf, "CRV1:") && BLEN(&buf))
+    if (authfail_extended && buf_string_match_head_str(&buf, "CRV1:"))
     {
         ssl_put_auth_challenge(CBSTR(&buf));
     }
@@ -931,7 +929,7 @@
 }
 
 static void
-push_option_ex(struct gc_arena *gc, struct push_list *push_list, const char *opt, bool enable,
+push_option_ex(struct gc_arena *gc, struct push_list *push_list, const char *opt,
                msglvl_t msglevel)
 {
     if (!string_class(opt, CC_ANY, CC_COMMA))
@@ -962,7 +960,7 @@
 void
 push_option(struct options *o, const char *opt, msglvl_t msglevel)
 {
-    push_option_ex(&o->gc, &o->push_list, opt, true, msglevel);
+    push_option_ex(&o->gc, &o->push_list, opt, msglevel);
 }
 
 void
@@ -974,7 +972,7 @@
         push_reset(o);
         while (e)
         {
-            push_option_ex(&o->gc, &o->push_list, string_alloc(e->option, &o->gc), true, M_FATAL);
+            push_option_ex(&o->gc, &o->push_list, string_alloc(e->option, &o->gc), M_FATAL);
             e = e->next;
         }
     }
@@ -1002,7 +1000,7 @@
     {
         return false;
     }
-    push_option_ex(gc, push_list, string_alloc(tmp, gc), true, msglevel);
+    push_option_ex(gc, push_list, string_alloc(tmp, gc), msglevel);
     return true;
 }
 
@@ -1031,7 +1029,7 @@
         return;
     }
 
-    if (o && o->push_list.head)
+    if (o->push_list.head)
     {
         struct push_entry *e = o->push_list.head;
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
