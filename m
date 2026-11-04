Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3283606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Pc/cHcse;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OKIUXR+x;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RzX1HL6j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=dPNU7pfGHMdzIK3jGCkwW/T6xCwMh2vaz7QiG0Tg8y4=; b=Pc/cHcseSPuhxZ
	hh0Guf3N36RiK/BjkWHyregd5QZAG6koiXkFQjNFDbyGPi3LBRILVOhYMVz0jQ01u0pzEU6UnFiaB
	MqUUXVtpyTJz5spOobXsUdP3Upfzmrf7WDZu9k+RMLgSiX3kDvyniT5ve2vJFk/rT+fnm6KQ31kM4
	8w4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOf1Q-000000008PQ-22YG;
	Wed, 04 Nov 2026 17:43:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOf1N-000000008PH-3iQb for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:43:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P8Mz5vQt/sFQDkYCvgkLMqDEk6EpjR/jbWjRrX2o//k=; b=OKIUXR+xY7n/h9TQfN4RsWJzQc
 PP1vsogdIfOFlsYMD44yn5YZaM31fR+MaHhtKLp7AYublH+DScIDlTSHdnbQrzHh0Ak8nneHWOmam
 DuvAkirOE0pEwUSnVIs1oV8t0lmxbmaD3NU8PBCJcBG6EJhw01ACJIPBOo61lOqm3C34=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P8Mz5vQt/sFQDkYCvgkLMqDEk6EpjR/jbWjRrX2o//k=; b=RzX1HL6j32T9ECdnyuFsi/lp9e
 uNwF4XfnNxK4DUWdEmFAK/6OzEkxTpRixbTTV0O+yh5kputKrzCJ3yfAdw8Wy24ZEuzDCxqNuOXz6
 yFJcTRb7kwegUSfgA/GE3vuATuKoyG1IIznrFY38GmjzQeE/QnQCUR38OIovghe+ezlU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOf1L-000000000OH-0XuW for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:43:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A4HhSdR015235
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 18:43:28 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4HhSwb015234
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 18:43:28 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 18:43:22 +0100
Message-ID: <20261104174327.15221-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793800715000.Ib33ce23448959673affdfd462b4c2cfa9a015f55@gerrit.openvpn.net>
References: <gerrit.1793800715000.Ib33ce23448959673affdfd462b4c2cfa9a015f55@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOf1L-000000000OH-0XuW
Subject: [Openvpn-devel] [PATCH v1] push_util: use string_alloc() instead of
 a local gc_strdup()
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

gc_strdup() duplicated string_alloc() for its only caller. While here,
fix the typos in the message_splitter() comment.

Change-Id: Ib33ce23448959673affdfd462b4c2cfa9a015f55
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2132
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2132
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 34cb26c..0c27575 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -78,17 +78,8 @@
     return buf;
 }
 
-static char *
-gc_strdup(const char *src, struct gc_arena *gc)
-{
-    char *ret = gc_malloc((strlen(src) + 1) * sizeof(char), true, gc);
-
-    strcpy(ret, src);
-    return ret;
-}
-
-/* It split the messagge (if necessary) and fill msgs with the message chunks.
- * Return `false` on failure an `true` on success.
+/* Split the message (if necessary) and fill msgs with the message chunks.
+ * Return `false` on failure and `true` on success.
  */
 static bool
 message_splitter(const char *s, struct buffer_list *msgs, struct gc_arena *gc, const size_t safe_cap)
@@ -98,7 +89,7 @@
         return false;
     }
 
-    char *str = gc_strdup(s, gc);
+    char *str = string_alloc(s, gc);
 
     while (*str)
     {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
