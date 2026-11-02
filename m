Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1C606A32C
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dwv/SBlx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZsgrvStK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=d+nnVeMW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=s34t/5/j90SUPfILCD3P42dm3N4DSFKZQLjf1xIJkDc=; b=dwv/SBlxMeg3hA
	Lxgh32s43lbKrgWUVjAR6A8hKZdh4mN78YoZt4Mb/sVQy+AWiTLCWH1s9tnmWFJu6yyyh5J3EH+V6
	oioIclT/oWR3Gri6HEIcRebSPN9SsozxKizaOh8H31kXZVFgCr2V+4QxadAs5bACIkbOUUorHzadY
	UAE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrra-000000003pz-2iog;
	Mon, 02 Nov 2026 13:14:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNrrZ-000000003ps-1fdg for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:14:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zl50FxwJsfQ1w9ibHvuh+vSmoG1JwYSRD1C5eTvZgfg=; b=ZsgrvStKbvMnAfJmfcY36yUor/
 FtHnEi1nnrdQQPesBbGcF/Pd6XIZ9ZGg/FB6JKWsV+oJXKIUG3d+AxJ3HXwJfNp5foOnhdGfZat+o
 NC1g1XhtWd9DYM/YK9yOkErjmxmX2fWsSQgV+7gzCQ2H/h3TUdOcoA7jOPjrP1+dlUq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zl50FxwJsfQ1w9ibHvuh+vSmoG1JwYSRD1C5eTvZgfg=; b=d+nnVeMWLGIKxR8xJRjXm4sAJa
 J9UaKB0EfHPJeX0k62/A6fpko7quOXWe+qsh4ojgD5wipwNbLH8vtYQbo90ccVcMO0F1VyZQAX+et
 Wldjy6SCCD/aHAqqD8CwMSwuBUc2K+fyp66LNAXRMhYfSPwQ0sYByXdt+7J+GTZ7YIhQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNrrX-0000000080B-24We for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:14:13 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A2DE4mQ021615
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 14:14:04 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2DE4ts021614
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 14:14:04 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 14:13:59 +0100
Message-ID: <20261102131404.21605-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
References: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNrrX-0000000080B-24We
Subject: [Openvpn-devel] [PATCH v2] crypto_openssl: Clear PEM decoded key
 data before freeing it
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

From: Hansaem Wi <hansaemw@gmail.com>

crypto_pem_decode() decodes the tls-crypt-v2 client and server keys
and the auth-token key, and frees the decoded key bytes it got from
PEM_read_bio() with OPENSSL_free(). Clear them with OPENSSL_cleanse()
first. OPENSSL_clear_free() would do both in one call, but LibreSSL
does not provide it.

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
Signed-off-by: Hansaem Wi <hansaemw@gmail.com>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2077
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2077
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index e6abd8f..3c708c2 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -528,6 +528,7 @@
 cleanup:
     OPENSSL_free(name_read);
     OPENSSL_free(header_read);
+    OPENSSL_cleanse(data_read, data_read_len);
     OPENSSL_free(data_read);
     if (!BIO_free(bio))
     {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
