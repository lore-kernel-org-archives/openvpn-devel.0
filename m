Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8CE606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RC2FjtJr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kYov7GQk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RggZewUI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=W5GXOekMWRDHS4QndZsMYsiEqgN8EadO76nPqON2aZ8=; b=RC2FjtJromXhSQ
	KUMMRxVXUBNtmcUsV+ZwY/0Tz5TmB0DAaxmN2PLQzf0rDG5SGLlAyBuf3C1m3GEoazcbQW30MKgJ5
	xs6eZhdFiuwCJpydWEx3u0S5C2xDCJ6F2zQIlqxHXV5UZ8h4iyEd/bmWXAElbJPYeH8E+ZL3xBGBH
	lSE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMRAZ-000000007F6-0POJ;
	Thu, 29 Oct 2026 14:31:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xMRAY-000000007Ev-0q57 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 14:31:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cRkErXX0lj6ZYYDVueBcNd+Dke67GwRbPLqEqFnHP/0=; b=kYov7GQkoehfTmh+Jek43H2T4W
 AFEPEZuNEMJDEtZ6+zdZ5hZxvTFokHhHzFd1sX7UhfVCgwXXOIGNprNm9WxdkrzSPQDgEsLgG+Elt
 UN8REDTW1J2XXcGPxedsWyUeUuP7ZZdQn4j+M1YOlNJNN+aBhMUILmino8WilD6kFqZ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cRkErXX0lj6ZYYDVueBcNd+Dke67GwRbPLqEqFnHP/0=; b=RggZewUI1t/BJHdAUSFEqtmXTq
 G0/WvBMmDqaRdO9llcO1uCvES3tWQVDIqz5oKSQbn8V+h9IHJHhetR8uYrnM1rJgaSZP0om9SiuOa
 YsQ1Tq7vTI2hVKjNiookW/S8EUdyV1jAqRDqEyZnTgHcXxvq60kzorvFLYgYGzrOTFsw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMRAV-000000004WW-1ORo for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 14:31:54 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69TEVhkJ019650
 for <openvpn-devel@lists.sourceforge.net>; Thu, 29 Oct 2026 15:31:43 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69TEVhXo019649
 for openvpn-devel@lists.sourceforge.net; Thu, 29 Oct 2026 15:31:43 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 29 Oct 2026 15:31:37 +0100
Message-ID: <20261029143143.19636-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793281941000.If33596abef4e97aa9b58f12cd866a5cded17fd4f@gerrit.openvpn.net>
References: <gerrit.1793281941000.If33596abef4e97aa9b58f12cd866a5cded17fd4f@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xMRAV-000000004WW-1ORo
Subject: [Openvpn-devel] [PATCH v1] test_provider: Fix compiler warning with
 clang 23
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

With --disable-management it complains
"variable 'mgmt_callback_called' set but not used
[-Werror,-Wunused-but-set-global]".

Change-Id: If33596abef4e97aa9b58f12cd866a5cded17fd4f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2070
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2070
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index e5562ee..5d31da3 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -42,7 +42,9 @@
 #include "test_common.h"
 
 struct management *management; /* global */
+#ifdef ENABLE_MANAGEMENT
 static int mgmt_callback_called;
+#endif
 
 #ifndef _countof
 #define _countof(x) sizeof((x)) / sizeof(*(x))
@@ -156,8 +158,9 @@
     char *out = NULL;
 
     /* indicate entry to the callback */
+#ifdef ENABLE_MANAGEMENT
     mgmt_callback_called = 1;
-
+#endif
     const char *expected_tbs = test_digest_b64;
     if (strstr(algorithm, "data=message"))
     {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
