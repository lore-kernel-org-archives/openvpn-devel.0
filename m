Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AD7C5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FuAtY6kcyWcvipGqg7Simtkwumon5KVmXx5fF8o2WsA=; b=GtMn6TkeqRgyB9hUCCANsh1MWy
	QkLOUYXYRFjGMaoPlEQEKw954gH1KIpZBiUwlg0I/rFNb/naVzqqfYNwd6fbYHPQK+3Cv4Eui0iku
	6plMFb/nFBFIPmNpNwSsGvEjnR/eQ59UO9Emq00ybwx0B4NMlI0JtUN7q10YwBIJl198=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzIkD-0005HT-Gc;
	Wed, 26 Aug 2026 18:53:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wzIkA-0005H2-4c
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:52:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Thga+xoIA+qUIIIU61elqo75lY7AljRjCmsdlq2yYyI=; b=A6hbSsWWye44rnuQRbVK9km6mJ
 mgbIIchKlTxkgQ/Wx2Qoqv+ioYXvdMXdH4xqV2ExJRZSqo319wI4BEaPuVJMKJYVhe3Pvic9r9KqK
 Jrc4nFSd5tb4hCUtQVEdXgQF4vmIh+5NBFMpWF5M6+OvYt4C4rC/2b5FFxwhgVDZDL4I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Thga+xoIA+qUIIIU61elqo75lY7AljRjCmsdlq2yYyI=; b=Yozxx7ugTBHz5ZkY+nIiN4Qr0T
 V5F01apnS2CRvar833AzZW4ZLcgPZjdwzqMao74IuIId9Zs1VBlDfCM1uTcMthxWUFKMzGmMTqnRk
 zTM6mQIYmimP+hJNUZZucLmqqcCJXNQDA0nfc05QDqsaX7yCJE78IElWvFJcGQccQTLA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzIk4-0006OE-9V for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:52:58 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67QIqnle018048
 for <openvpn-devel@lists.sourceforge.net>; Wed, 26 Aug 2026 20:52:49 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67QIqnFk018047
 for openvpn-devel@lists.sourceforge.net; Wed, 26 Aug 2026 20:52:49 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 26 Aug 2026 20:52:43 +0200
Message-ID: <20260826185248.17995-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787327336000.I432df6c69249b49e9b9a3a904803904d134387a0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I432df6c69249b49e9b9a3a904803904d134387a0@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wzIk4-0006OE-9V
Subject: [Openvpn-devel] [PATCH v7] Add mock support for management messages
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

From: Arne Schwabe <arne@rfc2549.org>

Change-Id: I432df6c69249b49e9b9a3a904803904d134387a0
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1857
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1857
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
index 8176d2a..3e73d19 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -43,6 +43,7 @@
 
 
 char mock_msg_buf[MOCK_MSG_BUF];
+char mock_managment_buf[MOCK_MSG_BUF];
 
 
 void
@@ -76,6 +77,14 @@
     {
         printf("FATAL ERROR:");
     }
+
+    if (flags & M_MSG_VIRT_OUT)
+    {
+        CLEAR(mock_managment_buf);
+        vsnprintf(mock_managment_buf, sizeof(mock_managment_buf), format, arglist);
+        return;
+    }
+
     CLEAR(mock_msg_buf);
     vsnprintf(mock_msg_buf, sizeof(mock_msg_buf), format, arglist);
 
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h
index da96b212..41ce48f 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -36,6 +36,8 @@
 
 extern bool fatal_error_triggered;
 extern char mock_msg_buf[MOCK_MSG_BUF];
+extern char mock_managment_buf[MOCK_MSG_BUF];
+
 
 msglvl_t mock_get_debug_level(void);
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
