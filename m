Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706B606A324
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KAIiUgRt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KUX9gDcT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VHuR71wW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=htifoprLngVM26+4nIinxd8LsrL+uOcibJ9FoUncDQw=; b=KAIiUgRt30Jht0
	E7zSFvGvA+qMFDl+Tow9kflbJG76hpPD621K313LGG6qq/ui0brsIBTJlvQYWlpgBXuhcLzlnYwfj
	v+hNMt9nvj9MgOUEHCDKE3hvS5mb7ZNsJvKLlg5l+idfbUFiXbfOUboMhU35U4dqiROHq7LokvZ2T
	0mw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNdOB-000000001Aj-17R2;
	Sun, 01 Nov 2026 21:46:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNdO9-000000001Ac-3xO2 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 21:46:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y2dw5RbSd3j60/WF8sZqkT4Es72rbw/AMxUzw0+etMI=; b=KUX9gDcTbilM5MW44/hCz5tL7c
 MY/5yTa053yya1KkDz7s1H77bNJdUuDL9HT6YZu3SI/6J8MsiIiqnK7I/nEkI68f94itSDrYnnihM
 8Z/CDXFxNt8TZqmsQ9fDR2dvumZdHIKk3LzmPqOwdi3HpGwAhZqwcTMfNIXzaIqlEdzI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y2dw5RbSd3j60/WF8sZqkT4Es72rbw/AMxUzw0+etMI=; b=VHuR71wWlPwb8LSlotsyzgM1iz
 m4AO8HQiw6J5gKLfYEr91gDBb2FQ6NnT57vQfyvqf859jR1N3t2gPcf1le4/AeT9etCglKOfJ3dLG
 O69Mb63FL3WGRXpzijWvlXBdn5eYvGcooRT50DIIVLvqmuTBxgmsZzDJtJo+z6l6LKyc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNdO8-0000000030i-3Ghq for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 21:46:53 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A1Lkjll022376
 for <openvpn-devel@lists.sourceforge.net>; Sun, 1 Nov 2026 22:46:45 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A1Lkjb2022375
 for openvpn-devel@lists.sourceforge.net; Sun, 1 Nov 2026 22:46:45 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun,  1 Nov 2026 22:46:40 +0100
Message-ID: <20261101214645.22350-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
References: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNdO8-0000000030i-3Ghq
Subject: [Openvpn-devel] [PATCH v1] crypto_openssl: Clear PEM decoded key
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
PEM_read_bio() with OPENSSL_free(). Use OPENSSL_clear_free() instead.

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
Signed-off-by: Hansaem Wi <hansaemw@gmail.com>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2077
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2077
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index e6abd8f..e6873bb 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -528,7 +528,7 @@
 cleanup:
     OPENSSL_free(name_read);
     OPENSSL_free(header_read);
-    OPENSSL_free(data_read);
+    OPENSSL_clear_free(data_read, data_read_len);
     if (!BIO_free(bio))
     {
         ret = false;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
