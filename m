Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE266CD8CAA
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=klD3OIxq9uDS02aRmvcF4YzCsYco45TVaFqWmwpDzHg=; b=itWH7ctYsepURfE9RR7s1cAYAm
	6jXpIy6rCwzOATdNNK85OFW/qsAAuz8ckUgEcbO2Ks6ypDPaVfa7HpvGV4tXUl0kiaxndCNgmurZm
	bD0b/xFgLNDlq5Cm13gjUvIg8dSR2MXFaqXWhO1s39v+X13MHnUeX1gi+K/+g7CDdEGE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWyGE-0006qq-7L;
	Tue, 09 Jun 2026 15:21:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wWyGC-0006qb-IY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:21:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vNYK67eOwObvrtx6n69Na9ScWNt41f3nmpeKPZkcWn0=; b=fe9/KFU4BgTIx8LTarzPsqP09g
 k3SEnSiaGxZjGBAhmVAiR3NHrkuKMdVfdS5IwHVCGb5p8iI6nfhpDIz2mUtKfPwL8OvMSdsbr6lVd
 jMu+DQmG0CUFtizr7vYNHbEXJbDJjI5in/yR1qcPwtu/7NCkUy8hrQZwomw4ft+s2Yuo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vNYK67eOwObvrtx6n69Na9ScWNt41f3nmpeKPZkcWn0=; b=AQX7WsWEKL7tapBrqiyYcYDRdX
 6NBNrk4OKnsqhJf1PJdyuQBkJmEUVqRJnsYg2BoilF4LtEnwjo67M1ppctTRpH4s4velssYICg0Oo
 XJh5NRj3DcNs/iV9tyUqaBWffB4B1VIjm2yxDgu/UkmyrmdMy31m6dCOG2MM78TKhxmU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWyG9-0003cU-1E for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:21:00 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 659FKjEj027403
 for <openvpn-devel@lists.sourceforge.net>; Tue, 9 Jun 2026 17:20:45 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 659FKjKn027402
 for openvpn-devel@lists.sourceforge.net; Tue, 9 Jun 2026 17:20:45 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  9 Jun 2026 17:20:38 +0200
Message-ID: <20260609152045.27384-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1781017122000.I668b96afae9dda5692c46db14634b3b8c03056e5@gerrit.openvpn.net>
References: <gerrit.1781017122000.I668b96afae9dda5692c46db14634b3b8c03056e5@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wWyG9-0003cU-1E
Subject: [Openvpn-devel] [PATCH v1] renovate: Fix typo in regex manager
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

From: Frank Lichtenheld <frank@lichtenheld.com>

Broken since commit 8485518dce6b7ebeda6295fcdf3bc7476b7b9117
("GHA: Factor out building SSL libs to a reusable workflow")

Change-Id: I668b96afae9dda5692c46db14634b3b8c03056e5
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1709
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1709
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/renovate.json b/renovate.json
index 3bd0917..5b6e0d0 100644
--- a/renovate.json
+++ b/renovate.json
@@ -40,7 +40,7 @@
                 "/^\\.github/workflows/.+\\.ya?ml$/"
             ],
             "matchStrings": [
-                "versioning=(?<versioning>.*?)\\n\\s*ghrepo:\\s*(?<depName>.*?)\\n\\s*gitrepo:\\s*(?<currentValue>.*?)\\n"
+                "versioning=(?<versioning>.*?)\\n\\s*ghrepo:\\s*(?<depName>.*?)\\n\\s*gitref:\\s*(?<currentValue>.*?)\\n"
             ],
             "datasourceTemplate": "github-tags"
         }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
