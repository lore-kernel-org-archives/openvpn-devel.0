Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E7DCC6B38
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iitf0LcXWEqmNiF+WH8K+ednQI5xq+U6i2Fz4Z9s2dE=; b=liaPwmfu62FS1/goYIRwpdJN8N
	jfFZTbjJl5WGvAMYX/+zoXlSpScU2E31T3giJnWPXLAAxEJZpdY8mpDugZ7UWVa2lkNQrO8Kr3hUK
	T2FwezV+8qQjElbZfcRtwGc1Fb28XO7dtEQ+IEajZ68xRqao7Gh1jZ1dg3Jgt9FaXK/k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHRej-0006Wh-1G;
	Thu, 15 Oct 2026 20:02:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xHReh-0006WZ-78
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 20:02:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XRS9S3h58rwDblC3Zarnh3OmHr6io+VEymuRbvAQY5g=; b=IZZFXrXFePWanWu8yGKuYaS52S
 mtQyS1K6czwRnl8OUJvCXXTM9Z6GnBztqbILx63Upexj+SZcW2iGmXhoCazaXsTSM6lXdgSyRnI8A
 LVGlqX09TK20A5h42qbEQjZOD2IlqUwK0cGe9lp4KMAY/ZOFcbGQd+jbTAs2IB2v0VJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XRS9S3h58rwDblC3Zarnh3OmHr6io+VEymuRbvAQY5g=; b=UT18o4nv+n2cqG21nxhu0F61ho
 We8Iv0mtuICyhPxjK6xDSIzY1HvN6+qbS3DcwzQnV9H6ZLuXYXqQ34oFel8nSNFLqQQU6ZVbX540d
 ww0jJ/s5vcGM06ZowXEEsb7AXg50ZWS2GF2roVeJA7sDFCJsDya6M2Cvm1r8xpriAgfw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHRef-0001dw-TP for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 20:02:23 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69FK2FKN032019
 for <openvpn-devel@lists.sourceforge.net>; Thu, 15 Oct 2026 22:02:15 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69FK2EDs032018
 for openvpn-devel@lists.sourceforge.net; Thu, 15 Oct 2026 22:02:14 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 15 Oct 2026 22:02:08 +0200
Message-ID: <20261015200214.32007-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792079013000.I9a3598382ecf928aa81f027b55352175ad93165c@gerrit.openvpn.net>
References: <gerrit.1792079013000.I9a3598382ecf928aa81f027b55352175ad93165c@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xHRef-0001dw-TP
Subject: [Openvpn-devel] [PATCH v1] repair const mismatch in
 siphash_openssl_available() prototype
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

commit 571caa34e2f added the "const" to the function declaration but
for whatever reason the necessary change in the prototype was lost, so
"make check" failsed to compile the siphash parts of crypto_testdriver.

Fix.

Change-Id: I9a3598382ecf928aa81f027b55352175ad93165c
Signed-off-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2000
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2000
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/tests/unit_tests/openvpn/siphash_openssl.h b/tests/unit_tests/openvpn/siphash_openssl.h
index 49c6a9d..a44457e 100644
--- a/tests/unit_tests/openvpn/siphash_openssl.h
+++ b/tests/unit_tests/openvpn/siphash_openssl.h
@@ -60,5 +60,5 @@
  *
  */
 bool
-siphash_openssl_available(void *sip_context);
+siphash_openssl_available(const void *sip_context);
 #endif /* ifndef SIPHASH_OPENSSL_H */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
