Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C737C5AC67
	for <openvpn-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KfMQwtepzYuiLG/TH44lXSz9148Ji5nXuN5mGJJd93Y=; b=LBhxTcTutwODDVbWL7Jop9iiDl
	rde7IVnFRR5BbIMsjLx2M3CZ7yLEeS0giBxdIo2J1ZRDCXy+iJIp9c4zjpALi97lOU5SimEDafCct
	EQVH91F1gPTEO9QCXGfrPpSTBXRpgW+B0ggRxhhngbUxPyEoZH07FIdwB0o6RONEqp0g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtrSY-0003C0-Ve;
	Tue, 11 Aug 2026 18:44:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wtrSX-0003Bt-Gh
 for openvpn-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 18:44:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6vCBEQ54luY/JIThanv1LZsHctAkD2GctX1ISBWv3Os=; b=If5TjCQm+WbOQAZOUQyYbCOmBf
 noawz/Qq80Yj42rqk4upuTw39vGcbntuHWdDA6IRoG42n+L3TJeSg8zrSyrgVUdTN1wCdDq30CF5q
 hED42Ut0l45qBzARGlCPjM7GyCNeDHH4qkzQhPW0DLoPJzEsouPl66Irq0qZvo2oqhxw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6vCBEQ54luY/JIThanv1LZsHctAkD2GctX1ISBWv3Os=; b=GNu2funCWjE6SJzMkK2unQ2juO
 91o3XSwq+7AkZXNmtCyUUHt/3XLqioNprRdVc6pJiFpkdCJW03X1A7FxKEKATUFKwi6y1ksE+x+lK
 OVfSJ5rogJdUTb5Ntemcj2CKADpRsMc+/rEhB+xnd7UEVyuFsVJaO1Nb9IyquiBeQnAY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtrSS-0004GT-8n for openvpn-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 18:44:18 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67BIi82A003559
 for <openvpn-devel@lists.sourceforge.net>; Tue, 11 Aug 2026 20:44:08 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67BIi8r3003558
 for openvpn-devel@lists.sourceforge.net; Tue, 11 Aug 2026 20:44:08 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 11 Aug 2026 20:44:02 +0200
Message-ID: <20260811184408.3535-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1786465628000.I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7@gerrit.openvpn.net>
References: <gerrit.1786465628000.I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wtrSS-0004GT-8n
Subject: [Openvpn-devel] [PATCH v1] otime: Remove openvpn_time()
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

Using this function seems to be more complicated
than just using now directly.

Suggested by Arne in review of cppcheck fixes.

Change-Id: I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1841
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1841
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index f02cc31..d14f01e 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -93,17 +93,6 @@
 #endif
 }
 
-static inline time_t
-openvpn_time(time_t *t)
-{
-    update_time();
-    if (t)
-    {
-        *t = now;
-    }
-    return now;
-}
-
 static inline void
 tv_clear(struct timeval *tv)
 {
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index cfcd372..8b06fd0 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -42,7 +42,8 @@
 static time_t
 __mytime(void)
 {
-    return openvpn_time(NULL);
+    update_time();
+    return now;
 }
 
 #if !defined(_WIN32)
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index ce2baf2..97f352e 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -999,9 +999,7 @@
     else if (tls_authentication_status(c->c2.tls_multi) == TLS_AUTHENTICATION_SUCCEEDED
              && c->c2.tls_multi->multi_state >= CAS_CONNECT_DONE)
     {
-        time_t now;
-
-        openvpn_time(&now);
+        update_time();
         if (c->c2.sent_push_reply_expiry > now)
         {
             ret = PUSH_MSG_ALREADY_REPLIED;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
