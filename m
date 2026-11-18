Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B1606A320
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gZcqEbRE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m2n2AJcd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LxsnouBc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GKDjb5juOJXaSX7BCA8kSFEFT+NCCf5lROvs8ZzkFYs=; b=gZcqEbREWd8Sx7
	hLu5SqN1swW0ez6sRzxFCdZ4n5JKJYVrT3Fhe7grHjpSwlOmDiPDrRzvSuqdBUxw2CR047xC6QdFU
	fB6CCpRQA4REdaVk1xM6brta72pjsHsptQ69LcJnlTQzIdMi4kKeiyUEv30XYb6815ncW2Lmt08XI
	mn0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xThCO-000000000F2-1u8K;
	Wed, 18 Nov 2026 15:03:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xThCI-000000000Er-1NOR for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:03:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QBqiBB8dCX+HWT/rthrl3rK4UQDksrJoZuZGoViB81k=; b=m2n2AJcdT6ffC0BorBfi+fBxLy
 Oh8HfL0Ged3x7g2hHidm/zetnulvNzdcNR+yLTs95Ofp1WeU4Q7ff3zpbVdWiHTjv8+gITlOdVLmG
 SrRmw7KeNeGDk2HCDmKelVRWyij/VQUbDJrdN3legWZSfRRU3STAmfoMmNXhWbxF+b58=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QBqiBB8dCX+HWT/rthrl3rK4UQDksrJoZuZGoViB81k=; b=LxsnouBcLpwDO5kJ2Y4tCqGz+N
 hyzsLUDvLBXpHwi0YcmkxcqyQlosBH+WxB3eZ+54RsFbjJn8hbkCUNPuU9KkYcUZMA5ZArPfatco7
 DHYcjmTJmLr9zZP3962vmxnWPJcwsnnzRV3h+K17unKiwOdFw6x4YKlVMBqnHs/R0NEs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xThCG-000000001or-0X4p for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:03:41 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AIF3Xrw013974
 for <openvpn-devel@lists.sourceforge.net>; Wed, 18 Nov 2026 16:03:33 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AIF3XBu013973
 for openvpn-devel@lists.sourceforge.net; Wed, 18 Nov 2026 16:03:33 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 18 Nov 2026 16:03:27 +0100
Message-ID: <20261118150332.13954-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1762026034000.Ifb4e9d79c167337fb780b53141d080abf55f3f5e@gerrit.openvpn.net>
References: <gerrit.1762026034000.Ifb4e9d79c167337fb780b53141d080abf55f3f5e@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xThCG-000000001or-0X4p
Subject: [Openvpn-devel] [PATCH v2] CONTRIBUTING: add Gerrit option + links
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
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: chesain <cvanteddu1@gmail.com>

- Add Gerrit as an alternative review path

- Add links: signup, web UI, best practices

- Final patches still go to openvpn-devel

Change-Id: Ifb4e9d79c167337fb780b53141d080abf55f3f5e
Signed-off-by: chesain <cvanteddu1@gmail.com>
Acked-by: Yuriy Darnobyt <yura.uddr@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1338
Refs: openvpn/openvpn#845
Link: https://github.com/OpenVPN/openvpn/issues/845
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1338
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@gmail.com>

        
diff --git a/CONTRIBUTING.rst b/CONTRIBUTING.rst
index 67baa4e..e7afeafe 100644
--- a/CONTRIBUTING.rst
+++ b/CONTRIBUTING.rst
@@ -8,6 +8,13 @@
 
 - https://lists.sourceforge.net/lists/listinfo/openvpn-devel
 
+Alternatively, you can use Gerrit for code review:
+
+- Web UI: https://gerrit.openvpn.net/
+- Best practices & account setup: https://community.openvpn.net/Development/GerritBestPractices
+
+Note: final, approved patches are still sent to the mailing list.
+
 While we do not merge GitHub pull requests as-is, we do allow their use for code
 review purposes. After the patch has been ACKed (reviewed and accepted), it must
 be sent to the mailing list. This last step does not necessarily need to be done


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
