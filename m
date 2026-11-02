Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3260A381A
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=V7XLJzBP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YfByiIOU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mcY/kL9s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wEH7cKwFTln4if+B0iM7qkrFadi435+6pPJ9Wo42YR4=; b=V7XLJzBPuLxZt1
	K3SjhepQZW1GPORMpKkPI7u5yxipVLXKjvU/Udkz+SQcaBVPquC9HV0R9sGZ+lPDv2vnUo2bnVCk/
	Z0v6kV1JfM9q1flHfF0CnxPm28mN5ahr9WWIZwdO+jtGwx2QsYnRRu3UqsUN1/Ab6xfcaqxQuInOH
	/lU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNsXj-000000006uI-2KJx;
	Mon, 02 Nov 2026 13:57:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNsXh-000000006uB-31Qy for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cXMS1zTlu+b3e1nSwA7Q7P9ymm04uBP2wXtgE4gKlxE=; b=YfByiIOUsgU88OkDgUR/V1/t0j
 wRAe7bK970VjqvwlM6JK10KJdfFDTs0Fpm1bWiZDEOUPteZRdGDvfS431CgsmO5cpfQr1ZgzjhK4i
 C3zUT/O3HK6rmfTEa6VIbJW2FxCJC2AW9rUxDTVeffEa4gWxuifQAgdTIWnS7z7VhOZ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cXMS1zTlu+b3e1nSwA7Q7P9ymm04uBP2wXtgE4gKlxE=; b=mcY/kL9sUxkeOuQIVaHWgTDbs1
 OSyDcKq/KnNWgv+wxXMqwA1XlNQpyukFsekwKAArIppto36HTQYMSoTVvt/wm5Pvlj+JeV+onltvG
 cSJ8qYkccjPmhxk1RUlJklF+W3uxGSBANtAijdSP6kPNtwZgZxb4fdnAqwrhuxh2W0+0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNsXf-000000000lh-3KMr for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:57:45 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A2DvbWb027403
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 14:57:37 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2Dvbe0027402
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 14:57:37 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 14:57:31 +0100
Message-ID: <20261102135736.27372-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
References: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNsXf-000000000lh-3KMr
Subject: [Openvpn-devel] [PATCH v2] init: check parameters for NULL before
 strlen() in send_cc_message
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

management_callback_send_cc_message() called strlen(parameters) before
its own NULL check. Only count parameters and the separator when set,
and drop the cppcheck suppression for it.

Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2085
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2085
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/dev-tools/cppcheck-suppressions.xml b/dev-tools/cppcheck-suppressions.xml
index 33337cf..926ecde 100644
--- a/dev-tools/cppcheck-suppressions.xml
+++ b/dev-tools/cppcheck-suppressions.xml
@@ -198,12 +198,6 @@
     <fileName>src/openvpn/dco_freebsd.c</fileName>
     <symbolName>buf</symbolName>
   </suppress>
-  <!-- IGN: strlen(NULL) is not nice code, but seems to work -->
-  <suppress>
-    <id>nullPointerRedundantCheck</id>
-    <fileName>src/openvpn/init.c</fileName>
-    <symbolName>parameters</symbolName>
-  </suppress>
   <!-- FP: cppcheck doesn't understand ZeroMemory -->
   <suppress>
     <id>redundantAssignment</id>
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 24cf532..6c87865 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -299,7 +299,11 @@
 management_callback_send_cc_message(void *arg, const char *command, const char *parameters)
 {
     struct context *c = (struct context *)arg;
-    size_t len = strlen(command) + 1 + strlen(parameters) + 1;
+    size_t len = strlen(command) + 1;
+    if (parameters)
+    {
+        len += 1 + strlen(parameters);
+    }
     if (len > PUSH_BUNDLE_SIZE)
     {
         return false;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
