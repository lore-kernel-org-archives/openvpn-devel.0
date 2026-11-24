Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5DF606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cH7DvuT0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=V7W2Brie;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HLrAkqAC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=x0t1cCAvaI+w/VUGzQIJ0v4/pLZ33K5RixqreFB+pL4=; b=cH7DvuT0mFSWj4
	3grp6B4fHeTZ5duu009yLkFdweVMqDmQfchkyd3lpZq456CA5rJUXARDqc191ijfgLdN9+aZzYQkF
	enFGB5rfWsu40+b8lhKLsYHoxzaajEyg58tmIGs0/Oks2yG4SqS+ylhGdBwUeOBanxuWdVyeOGNXG
	woc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVvqk-000000006Vx-11az;
	Tue, 24 Nov 2026 19:06:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVvqi-000000006Vp-2GDY for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:06:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hokgQrmBsas4JamcnyhVBetepn2feT2sSy4OsOzqRho=; b=V7W2BrieI9DtF2+99ApDRqt5Gk
 NryxZkA31dEYtLKn1iibW0bS0Ovq0ZYrJ2U6Z0rlrOmINXW+mGIbtLM0U/DXBo5fReIE1FOOGX6bK
 sne/g5ZcBDovb62YPxnWU0ge3MZB8xEGH7M/8M5kwaMj/rZTMvfoxRia2NjBOQpzrsAo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hokgQrmBsas4JamcnyhVBetepn2feT2sSy4OsOzqRho=; b=HLrAkqAC/xJErog3+eSempvTp/
 AaFvmry0Nuch+CzMfYlm6+GRZl6nMSqnFNlemcRUuwe1N9mDYUdbjOswGl22T45TUJTCyKcFT+yic
 DodjPAI7V9y5eGtSmUP84zHrm3b/2NpXu/hDYJMYjs4BJ24ZD4PCNeYENZ23gNqfrwhM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVvqg-0000000023y-1wCF for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:06:40 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AOJ6V45016713
 for <openvpn-devel@lists.sourceforge.net>; Tue, 24 Nov 2026 20:06:31 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOJ6VJr016712
 for openvpn-devel@lists.sourceforge.net; Tue, 24 Nov 2026 20:06:31 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 24 Nov 2026 20:06:25 +0100
Message-ID: <20261124190631.16700-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795539493000.Id5152a5aacdd50f2fa9c5b3dfab92be8887541db@gerrit.openvpn.net>
References: <gerrit.1795539493000.Id5152a5aacdd50f2fa9c5b3dfab92be8887541db@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVvqg-0000000023y-1wCF
Subject: [Openvpn-devel] [PATCH v1] argv: Fix conversion warnings in
 argv_printf_arglist
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

From: Frank Lichtenheld <frank@lichtenheld.com>

Due to the int return of vsnprintf this is always
going to be somewhat ugly.

Change-Id: Id5152a5aacdd50f2fa9c5b3dfab92be8887541db
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2340
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2340
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index c716e5b0..cf841a5 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -323,11 +323,6 @@
     return f;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 /**
  *  Create a struct argv based on a format string
  *
@@ -378,9 +373,9 @@
      */
     va_list tmplist;
     va_copy(tmplist, arglist);
-    int len = vsnprintf(NULL, 0, f, tmplist);
+    int test_len = vsnprintf(NULL, 0, f, tmplist);
     va_end(tmplist);
-    if (len < 0)
+    if (test_len < 0)
     {
         goto out;
     }
@@ -389,10 +384,10 @@
      *  Do the actual vsnprintf() operation, which expands the format
      *  string with the provided arguments.
      */
-    int size = len + 1;
+    size_t size = (size_t)test_len + 1;
     char *buf = gc_malloc(size, false, &argres->gc);
-    len = vsnprintf(buf, size, f, arglist);
-    if (len < 0 || len >= size)
+    int len = vsnprintf(buf, size, f, arglist);
+    if (len < 0 || len > test_len)
     {
         goto out;
     }
@@ -423,10 +418,6 @@
     return res;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  *  printf() variant which populates a struct argv.  It processes the
  *  format string with the provided arguments.  For each space separator found


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
