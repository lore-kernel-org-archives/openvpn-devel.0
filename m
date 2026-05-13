Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8E5CD4851
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 09:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FCQeDX5vL9BGoABn5hLbELkadRM6PZIE0fsYc5kBI8I=; b=aYXwlivKbsWUvN7CuaQdhzBF8k
	USrSjIL1OnWK0PbOQQyULtHDcPbG6YHSyNJXhH+dDV9pJr9lqcx0bppp2iXbaPCWioECN1Y6nj4Ek
	xZ6x9akmH78PbTCQzB8r7iJs9dnTtTQItShVPkYaYd5dlNXZ0PJksChRTNE4ULjL/c7w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wN5j2-0008On-RS;
	Wed, 13 May 2026 09:17:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wN5ik-0008Nf-Gs
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:17:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5QXAoMN9kay65Xy2Aqc6cg3NAEQZOE8g4+eRzjClxRQ=; b=k+sraCg44ymQg4vwKDOuq/k56B
 nJmEoVRbYKTXAlK88wWxTwthpNzDsEqRhsCSlKMOAkf2sKBE5C9+j3nHn2nnoBERbKKIsfpc0MS38
 T3tQwz9tz+LxzrieEyRTrYXzttHxBU7r6eb/F7X2sSfSVM12JR+GC8/X11UPy83xJQE4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5QXAoMN9kay65Xy2Aqc6cg3NAEQZOE8g4+eRzjClxRQ=; b=ElFKwEnOcmFrXPlAw7+2cYSFSs
 KHFvY3b6vow8FGEn2a7VT6T2ZK38qaHc/dIa8MEOOvATqMUKuDU6U91UgkjN/zV4jzGX4MeCpOwXl
 y3tgJrpHcJugy3pYQn/vPdeoctEifU7EIaVfuJcnKTpbgEbfVo6Br/IWxaV6kubPGlrM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wN5iU-0003oB-7l for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:17:24 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 64D9HARh028398
 for <openvpn-devel@lists.sourceforge.net>; Wed, 13 May 2026 11:17:10 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.1/8.18.1/Submit) id 64D9HA57028397
 for openvpn-devel@lists.sourceforge.net; Wed, 13 May 2026 11:17:10 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 13 May 2026 11:17:05 +0200
Message-ID: <20260513091710.28378-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <gerrit.1778102459000.If58bb807842b7b95aeffe6849e7a7344e4925762@gerrit.openvpn.net>
References: <gerrit.1778102459000.If58bb807842b7b95aeffe6849e7a7344e4925762@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wN5iU-0003oB-7l
Subject: [Openvpn-devel] [PATCH v3] multi: Remove useless checks
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

If mi is NULL, the previous code lines already
segfaulted.

Identified by cppcheck.

Change-Id: If58bb807842b7b95aeffe6849e7a7344e4925762
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1667
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1667
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 06e3758..a957fdf 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3054,8 +3054,8 @@
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("POST %s[%d] to=%d lo=%d/%d w=%" PRIi64 "/%ld\n", id(mi), (int)(mi == m->pending),
-               mi ? mi->context.c2.to_tun.len : -1, mi ? mi->context.c2.to_link.len : -1,
-               (mi && mi->context.c2.fragment) ? mi->context.c2.fragment->outgoing.len : -1,
+               mi->context.c2.to_tun.len, mi->context.c2.to_link.len,
+               mi->context.c2.fragment ? mi->context.c2.fragment->outgoing.len : -1,
                (int64_t)mi->context.c2.timeval.tv_sec, (long)mi->context.c2.timeval.tv_usec);
 #endif
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
