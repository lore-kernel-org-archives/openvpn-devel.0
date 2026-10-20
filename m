Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682CB606A31F
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F5ztzktm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=b2VNSvgB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D6yhvfid
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qmt0WIUz9HFNf2pBooKZj55lqoK1QOzYeWUhV7mJx6Y=; b=F5ztzktmK0LPCKKSmDdiaSqsc6
	ZyarWOBjWzdn7uv/OUhkm2l8/Wx7Tty39Wjvkx0pSiaQLOr44Ga4/jdhJta+L+NLej8bbaXu2mXCN
	ZrTqqbY3ww0XPjP+1xsIRkvX01qjvsf6PSYS+0MId98e8fmFdtbrQNUIyPHf3wR0sTnA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJBJ1-0007Hp-9F;
	Tue, 20 Oct 2026 14:59:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xJBJ0-0007Hi-2t
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 14:59:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yHYsepMw0I9nc1aF9TeZvx0kgxGP35rHzBYiK+sRwak=; b=b2VNSvgBqZgzuJtZmdd8HUHm/V
 v1CoN4aQOFir6OC6u9nH6x4AN9qlcXkTpvLo2EdsuK9w2wo8IyafvslikkXLAHITBjex72cJ3rUax
 DmoxQyHjbkR7+RyAqVJtm6ruaC7veL9yXARlL2hF1Gbiz5cZKfAL67DbOVDCRccI7Cr8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yHYsepMw0I9nc1aF9TeZvx0kgxGP35rHzBYiK+sRwak=; b=D6yhvfidWzDU6aDBCh3pL87Hsm
 sy4MfR9KLRPvHToqAavdAci+tzfBMOHY6f2XEmTCfcMNrqUaauITSx9mdTx1yzFo/Ea8LNWY/JPQ8
 qiQNdzvn6TMiqwsQp6erp/aSMCApSU6vkwNKxIm7CzlxtWsQXLUg8itqdMjgQuc13opg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xJBIw-0007Wr-Lx for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 14:59:07 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69KEwxix001470
 for <openvpn-devel@lists.sourceforge.net>; Tue, 20 Oct 2026 16:58:59 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69KEwxsr001469
 for openvpn-devel@lists.sourceforge.net; Tue, 20 Oct 2026 16:58:59 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 20 Oct 2026 16:58:54 +0200
Message-ID: <20261020145859.1457-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792426273000.I7f2db60564fa179ce5f56979912c7e484dad1e1d@gerrit.openvpn.net>
References: <gerrit.1792426273000.I7f2db60564fa179ce5f56979912c7e484dad1e1d@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xJBIw-0007Wr-Lx
Subject: [Openvpn-devel] [PATCH v1] Fix broken unit tests after commit
 5c6fbd0a11
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Said commit only cherry-picked the "actual code change" but not the
required adjustments for the unit tests, leading to an unresolved symbol.

Master has all the mock functions in mock_push_dependencies.c which
does not exist in release/2.7, so import "uninit_options()" into the
actual unit test source (as are all the other mocked functions in 2.7)

Change-Id: I7f2db60564fa179ce5f56979912c7e484dad1e1d
Signed-off-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2023
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.7.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2023
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 9b7978e..75b654b 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -48,6 +48,13 @@
     return;
 }
 
+void
+uninit_options(struct options *options)
+{
+    gc_free(&options->gc);
+    gc_free(&options->dns_options.gc);
+}
+
 bool
 options_postprocess_pull(struct options *options, struct env_set *es)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
