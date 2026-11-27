Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944C606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NKBJ6d7p;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DnviUSNp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ENPAYBFA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tY6Hjad7Lq1E3m8qLxpt/8m+q9KlQ6TYlVIA9eaW7Ww=; b=NKBJ6d7p7jxoel
	n28EIOCq3h6nR+QdWLZ36egJXPbPAcI2uoKex9wbOph5est1fqvXEhKvsYu5Kp3/uNeV3x0LyCz5c
	QYfSJ1P2sRDlj6yRSlB9zFhuvrWBg89RIEm/k6cnrmfsmiVY7EhfgVSfHC2eOk3Deu6UY3PSsGvFz
	5ug=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX0Rm-000000003BY-1wZL;
	Fri, 27 Nov 2026 18:13:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xX0Rl-000000003BQ-2YhU for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 18:13:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g6VfHGOVfiqTYKtYJdk9WAtqrlU+0XCx2XoiW9/ko40=; b=DnviUSNp+lAYHSFvKy41iIOoQt
 zeKgLauO05cUhCohtvQ5YCQy5hPPBaIBa99cF/2eiRNIwQo0TTAAAFwSDUaPSvFtanWQG82ibWK+x
 /bg7sR+LahtdK0uxg4goJhyCJxSlKmZa4LI/5UPTzi48xD4tOIKqZoliQHQjSqxV5AYw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g6VfHGOVfiqTYKtYJdk9WAtqrlU+0XCx2XoiW9/ko40=; b=ENPAYBFA3tihVhnEJVSJZqePtI
 icYpeXUOK9eZLxOfDp2yxuTaTr+UeJb5Bipy+kpne7MEIxYx4BKz93eBVNDZXOIsOQxe2159KQdPC
 DMtrZjBQat5Xgw/kPlL/7v4wnMLKFLPEo3gGqt8VIlDLO8NG2+p3mmg80K6X3STlDEvM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xX0Rj-000000007lJ-42yE for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 18:13:21 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ARIDDNS025190
 for <openvpn-devel@lists.sourceforge.net>; Fri, 27 Nov 2026 19:13:13 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ARIDDb5025189
 for openvpn-devel@lists.sourceforge.net; Fri, 27 Nov 2026 19:13:13 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 27 Nov 2026 19:13:07 +0100
Message-ID: <20261127181312.25173-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795790938000.Ia6731f4e8ebe8b5ac78ec17045b515b6cc9ea016@gerrit.openvpn.net>
References: <gerrit.1795790938000.Ia6731f4e8ebe8b5ac78ec17045b515b6cc9ea016@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xX0Rj-000000007lJ-42yE
Subject: [Openvpn-devel] [PATCH v1] openvpn: unload providers before freeing
 the options
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

uninit_early() passes the --providers names to crypto_unload_provider(),
but uninit_options() has already freed them along with the options gc.
Call uninit_early() first.

Change-Id: Ia6731f4e8ebe8b5ac78ec17045b515b6cc9ea016
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2362
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2362
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 2278266..d9a7c85 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -330,9 +330,9 @@
             } while (signal_reset(c.sig, SIGUSR1) == SIGUSR1);
 
             env_set_destroy(c.es);
+            uninit_early(&c);
             uninit_options(&c.options);
             gc_reset(&c.gc);
-            uninit_early(&c);
         } while (signal_reset(c.sig, SIGHUP) == SIGHUP);
     }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
