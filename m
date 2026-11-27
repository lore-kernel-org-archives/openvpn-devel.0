Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9ED606A326
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j+BWNut+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NSjnl6z5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UANWzvFX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2uuIIl0qibO6WvWpZdphgMElp5I75PoU4D3FSZbXARI=; b=j+BWNut+hlk7Wa
	kJXsAr6u91yFIirymhHGJe52aH1jm6uZ3Bxh98a2vT6xHnNl+AnPmxCkhretbO0AQZxoz2NgIyFhh
	GuoDSci7318lYO7i2YSptEZA3I9kU8lsSLybm0O78r4ICJCqRzPk+M+PLElE3Dm6idHeMOrk9xEzZ
	sSk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX0Qu-0000000038w-3NFw;
	Fri, 27 Nov 2026 18:12:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xX0Qs-0000000038n-3e4n for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 18:12:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PzepixJ9kdaB209thdVwHbZKar2SfJCG6n7/wgu7hgA=; b=NSjnl6z5QTqQNQ7seLeAHR2Zzs
 t/QKbsF2NuG+LIb8LxwAQV+5AA3FvEwbkMGGJfWB7nGMS6AQT1MCcAYBm2Qi8/FllEPelJUPIWWz/
 r/Zdimntmn/Nt5ZgMySH0IMsUioXqVD54lgjg4sO0cgLAILq1UeXZonq0SX515iVR0uY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PzepixJ9kdaB209thdVwHbZKar2SfJCG6n7/wgu7hgA=; b=UANWzvFXhWI3bg0LKkTyyxCxmU
 9PlEBJlhznlMdrJ3hSckPF/5IkumyiYjcTvXQuBQI6ioMDPz6rGPJJZXojUfANzaC+8R5zdJnjiXc
 6otg9KP81DE4AKtO3gmBF+O3pf7V+OCTDarQcB8VKjMUtyIGIaTR/YHMsY+yEFUqidU4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xX0Qr-000000002DQ-0BMQ for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 18:12:26 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ARICIbk025096
 for <openvpn-devel@lists.sourceforge.net>; Fri, 27 Nov 2026 19:12:18 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ARICIsm025095
 for openvpn-devel@lists.sourceforge.net; Fri, 27 Nov 2026 19:12:18 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 27 Nov 2026 19:12:12 +0100
Message-ID: <20261127181217.25083-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795791606000.I7aa7e2f15d63e8e5dc2449c46db075e179627ced@gerrit.openvpn.net>
References: <gerrit.1795791606000.I7aa7e2f15d63e8e5dc2449c46db075e179627ced@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xX0Qr-000000002DQ-0BMQ
Subject: [Openvpn-devel] [PATCH v1] pkcs11_openssl: free the BIO in
 pkcs11_certificate_serial()
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

The memory BIO holding the serial number was never freed, leaking it
for every certificate listed by --show-pkcs11-ids.

Change-Id: I7aa7e2f15d63e8e5dc2449c46db075e179627ced
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2364
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2364
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index c5974fce..ebf13f5 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -442,6 +442,7 @@
     ret = 0;
 
 cleanup:
+    BIO_free(bio);
     X509_free(x509);
     x509 = NULL;
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
