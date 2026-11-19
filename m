Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735F606A326
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Lk7eyrtM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ehw+YutD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DIuxNqHg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5O19HiSHXKEg2v8GPvNeBYagc8AuNCx5CK3jiRzJ7cU=; b=Lk7eyrtMisdxYD
	nW3QjlFwLtQSK702PkaltaL3zhM4eguYMRoTHSZx4wMDH132FlgfhbeuSkVp+1hiDZ21q8IGkMzA3
	w4KhbsQxU75AxxQKli00KGaexYuxZJam65JEeDMeRiRClF8HFNuRKlmH31MbbzlXXuA7XFnZXHlO2
	X2s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU9eK-000000006NC-17ND;
	Thu, 19 Nov 2026 21:26:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xU9eJ-000000006N6-0iCj for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:26:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dRqW/FK6rFNOXVKNEONqUP8qdQrzDLo12dSa9o2os+I=; b=ehw+YutDfdplnlFNaSWcZxjsak
 pwaZqP2R1+wEE01iYcXnO3FSGU/Y7Risz+JBUxk/SFwnvmPhsSQ7lLhiEAfVhjjJ/cS5nW18NeqMY
 zVBLMuMfc8mU7k9qOeJRLyE34r7ZJqNS2fbDjNjz984JI9qNc8CcTQELD9AmE6a83z+U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dRqW/FK6rFNOXVKNEONqUP8qdQrzDLo12dSa9o2os+I=; b=DIuxNqHg1dg/cRZF/nHZngG/N2
 fPd/QBBIxyKTFBTUGUNbKaXAb3qtso99EzajDsEvgTAJ5H4hL69kXYZ7b8+UY1CbeS8CH+sItdh5T
 pEBmK+hC20OUUuHNAG7slUVZnma7mVKet3CERH82i279bBSzEVqLbLqKHSSykN/8GYdk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xU9eH-000000004R6-1hDH for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:26:31 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AJLQMku005865
 for <openvpn-devel@lists.sourceforge.net>; Thu, 19 Nov 2026 22:26:22 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AJLQMDC005864
 for openvpn-devel@lists.sourceforge.net; Thu, 19 Nov 2026 22:26:22 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 19 Nov 2026 22:26:17 +0100
Message-ID: <20261119212622.5852-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795024630000.I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3@gerrit.openvpn.net>
References: <gerrit.1795024630000.I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xU9eH-000000004R6-1hDH
Subject: [Openvpn-devel] [PATCH v1] ssl: fix MSVC C4047 in
 key_method_2_read()
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

Assigning strstr()'s result to the bool remote_usescomp warns under
MSVC and fails the /WX build. Compare against NULL.

Change-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2220
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2220
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e06659a..d5ae13d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2409,7 +2409,7 @@
 
     free(multi->remote_ciphername);
     multi->remote_ciphername = options_string_extract_option(options, "cipher", NULL);
-    multi->remote_usescomp = strstr(options, ",comp-lzo,");
+    multi->remote_usescomp = (strstr(options, ",comp-lzo,") != NULL);
 
     /* In OCC we send '[null-cipher]' instead 'none' */
     if (multi->remote_ciphername && strcmp(multi->remote_ciphername, "[null-cipher]") == 0)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
