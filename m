Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AEA606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cN9pTrjp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KFyyne0Q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KFub5E+H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hFm4sSJuKfUHiN458cSFztx4y10+PPJtnbJUim5hCfE=; b=cN9pTrjp8zLsDY
	OkGcxV7hIPzvOTDtCtstDMqxJSH990XqdpS1krK0hWPYQHD3Ou3zlcYULgFYucsL9iZdwr/3zZfU2
	Lfjknh9x47xcPPMJnHr0R3vPnA8J5J+K6jGQnH1vZlP/2G3cSO5j9C5iejDMuUBLnl02ayem+Us6G
	T/k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOYh5-000000007fu-182T;
	Wed, 04 Nov 2026 10:58:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOYgb-000000007fM-3zXh for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WWb+IOKYGWtuIFlQ44e0l/Tk0NnrW7EpHJUZHo3w62s=; b=KFyyne0QsVI6WHNi2bcvCAsSyK
 p9Cf6XrqB3DTVERSYx0bZZ3vReFbXGp5554jl5/wGbQj6R//omL6RtESYn0rsfz5nrjeQcdqEWMvf
 mflVPiB46IMPW4mPunWbsykRzoE8gOAXTzJQ4Y+22hdeJ7Zhr/FViUPSzP0Oe4KvTOZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WWb+IOKYGWtuIFlQ44e0l/Tk0NnrW7EpHJUZHo3w62s=; b=KFub5E+HUP0APTWuBY60qgqqYR
 NMJPf3vU1MXyeUENTCto6qteocOBgMAJv/q9HG90/jIpBEJ+i7SyX8iQiF1TNh7rnuwTWExepJkWH
 UnYeIO4lFc0uK5d/4DHnAE8LM0iGMBupzcq+wkj6IuFXY4QlpR04+2EqmvnB+eV4vkbQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOYga-000000008Ra-2kIk for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:57:45 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A4Avcio007367
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 11:57:38 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4AvcBG007366
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 11:57:38 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 11:57:32 +0100
Message-ID: <20261104105737.7333-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793782065000.I5542520825112dfd64aab332bd76333b74d7fec0@gerrit.openvpn.net>
References: <gerrit.1793782065000.I5542520825112dfd64aab332bd76333b74d7fec0@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOYga-000000008Ra-2kIk
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: don't return freed token
 groups from GetTokenGroups()
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

When the second GetTokenInformation() call failed, the freed buffer was
returned. IsUserInGroup() then read it and IsAuthorizedUser() freed it
again. Return NULL, which IsUserInGroup() already handles by skipping
the token group check.

Broken since e82733a1 ("Fix user's group membership check in
interactive service to work with domains").

Change-Id: I5542520825112dfd64aab332bd76333b74d7fec0
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2128
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2128
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 6a13a06..2858f62 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -227,6 +227,7 @@
     {
         MsgToEventLog(M_SYSERR, L"GetTokenInformation");
         free(groups);
+        groups = NULL;
     }
     return groups;
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
