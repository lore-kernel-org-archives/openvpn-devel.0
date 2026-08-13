Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC823C5CFEB
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VgCjy/ecnsqvxH5VfcYNRBKoK35z3P636BGs50S4x9A=; b=a1XcLMsHDTKa06TDlXKEQUAz5X
	nsQvtA/ZSEiKRHNFFqYV0YFk+tujJapmR1xf1Zkgab7ru0Kb65DrfshEMXGdC4o6tJ6KKjILZsLyo
	4/BUcfwVMsKURqWuUYI730Ydm4p8SX+wgR7bMgtY+/+EQbGQzzjOTlaMZ9eXQtnTW24I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuWmL-0002vV-QS;
	Thu, 13 Aug 2026 14:51:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wuWmK-0002vD-0Y
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:51:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bl5/OZqCfi2lA/l2YVq8RwOHacAiYQbhWCihyn9Hqqk=; b=QnYRpFYv5d7+v00nfxOcn3HVK/
 cJo6lFg5UrHIAiaeB2HGRVTU8ZgWl28oPcJKkvaC+pmTqtjel8mcfzmqIMBv/MbzDdTRgjdpjtMhA
 6wtTUQAWqU11Cq/LOFcGyJ1Y0kCP16M/XAVQJl8js99x2in63dCoJXiI5yqbY5mYVuu8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bl5/OZqCfi2lA/l2YVq8RwOHacAiYQbhWCihyn9Hqqk=; b=IKKzQoYWEAQMSfH3HAHhzsc7ws
 zCZeJUtBzhCxey5N/MdPqSY0ADjlBxgbPlHkCvD1r8iLmInfr/9qE7s1+VTHjTQ1QwERi+C3bjmWS
 ZsScih+ALHwdmvOe4X+q4TrDcvTgqYa8P9LJAmQl5GwNpYZMYAuDdaHKN7PiHHEOf18M=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuWmL-0003zd-Gd for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:51:31 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67DEpNBw014620
 for <openvpn-devel@lists.sourceforge.net>; Thu, 13 Aug 2026 16:51:23 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DEpN1T014619
 for openvpn-devel@lists.sourceforge.net; Thu, 13 Aug 2026 16:51:23 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 13 Aug 2026 16:51:17 +0200
Message-ID: <20260813145122.14606-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1786632384000.Id8524d9c36ea913d557d3f43f1f62acc4186b4eb@gerrit.openvpn.net>
References: <gerrit.1786632384000.Id8524d9c36ea913d557d3f43f1f62acc4186b4eb@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wuWmL-0003zd-Gd
Subject: [Openvpn-devel] [PATCH v1] Fix format string specifier for size_t
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

From: Max Fillinger <maximilian.fillinger@sentyron.com>

size_t being the same as unsigned long is true on Linux, but this
produces a warning when cross-compiling for Windows. Replace %lu with
the correct format specifier %zu.

Change-Id: Id8524d9c36ea913d557d3f43f1f62acc4186b4eb
Signed-off-by: Max Fillinger <maximilian.fillinger@sentyron.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1843
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1843
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index bf9d953..2183217 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -64,7 +64,7 @@
 
     if (cert_blob_size > max_cert_size)
     {
-        msg(M_WARN, "PKCS#11: Certificate too large: %lu bytes, maximum is %lu", cert_blob_size, max_cert_size);
+        msg(M_WARN, "PKCS#11: Certificate too large: %zu bytes, maximum is %zu", cert_blob_size, max_cert_size);
         goto cleanup;
     }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
