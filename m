Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB91606EBAD
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ReywhTCZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dk1UiWZ7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lSuDQGwL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2V7WyquN8CcgZKs72yUnesuwjNXkJ05nqEtlzVGQgPQ=; b=ReywhTCZduHRDc
	4Xk8TRcapz7SU19TqOudiOzoM4uwCqAv39Ke5loxrbSdpQvtzbZorLk366n9w5s9O6fva0tBhHaMG
	Gek2diz9g5eNwtHy12o9iwY8THykVOMSQdkheruCo2JCqGgjgn+J/yFJ/V4cudnTJU7dMM/idRGWV
	Hj0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRttv-000000006Dy-3zmq;
	Fri, 13 Nov 2026 16:13:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRttu-000000006Dk-1LJq for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:13:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ctMpZLHiTdJfgAbSog/NF21EFjjQbooVPpLxiSO8rcc=; b=dk1UiWZ7k85q+H86gVYMc4M4d0
 UDCL9OZ/48meYQUYt/jKL5cpBOqp/1BPPtDyykz8wglyUCz7qCvchjMad9N65AtkFrt3uJDqWhIN7
 Q7kEE0mnL6QUm0EkfIEjwI413ziVQfil+mZhCz+2wxUguQ4KdnML9suOBA7Y8SAT+9cY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ctMpZLHiTdJfgAbSog/NF21EFjjQbooVPpLxiSO8rcc=; b=lSuDQGwL7Sswk5WOCEvYnwPjzT
 0lVPXxvAFkS1Mf5zfmBp6s8IOScvciKtgbp9l3lc0SXvYYYLVCLKWm0OQLTKpeJAmokzz+JSnJ/sV
 a440Nz58EQ/Xy2VmW6o6SlOwdhGAQTYBlgg2RjesMdEs8IQDjGDCrti7xUEN0ZIWpogo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRtts-000000000Cj-3GJZ for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:13:18 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ADGD9aY024493
 for <openvpn-devel@lists.sourceforge.net>; Fri, 13 Nov 2026 17:13:09 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADGD9KF024492
 for openvpn-devel@lists.sourceforge.net; Fri, 13 Nov 2026 17:13:09 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 13 Nov 2026 17:13:01 +0100
Message-ID: <20261113161309.24472-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794571077000.I387f652ecba92283a272610ff0780273c4902996@gerrit.openvpn.net>
References: <gerrit.1794571077000.I387f652ecba92283a272610ff0780273c4902996@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRtts-000000000Cj-3GJZ
Subject: [Openvpn-devel] [PATCH v1] ssl_openssl: free what PKCS12_parse()
 returns
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

tls_ctx_load_pkcs12() never released its references to the
certificate, key and CA stack, leaking them on every SSL context
setup. The context takes its own references, except for extra chain
certificates, which it takes over.

Change-Id: I387f652ecba92283a272610ff0780273c4902996
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2183
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2183
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index fe2bfda..bb51d96 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1009,6 +1009,7 @@
                 }
             }
         }
+        sk_X509_pop_free(ca, X509_free);
     }
     else
     {
@@ -1029,7 +1030,11 @@
                 }
             }
         }
+        /* the certs now belong to ctx */
+        sk_X509_free(ca);
     }
+    X509_free(cert);
+    EVP_PKEY_free(pkey);
     return 0;
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
