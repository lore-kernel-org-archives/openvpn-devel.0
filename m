Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819DB606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GbJCK3qT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jgWNho7p;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RK/ButuD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rbEV/WKVxzCFQ2//tGBJ3H/3S97E7Pxe/6GbgCTp4Pw=; b=GbJCK3qTiQcbTX
	reTsyhtOJQ9G9ohxGDnSyMlyJumbyjt8BACkFyNJalvDZHVBJ4b+xRpuHNidGKGG+ERbCE61AWRXN
	kpN2WTcjSd2ArDmWPUjKcr1RKbS2FesxmESUFABqJZPPKzW6EuL3sa27RdpZYfZxUwKR/lummsBvK
	htY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPMiT-000000002qV-3XEk;
	Fri, 06 Nov 2026 16:23:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xPMiR-000000002qJ-37vq for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 16:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e7tqP4F54dJ/QBh3d6C/qFjfwEv/tt1/pjOsI2VcH68=; b=jgWNho7pPGJpDnBI2KtvNDcKWc
 giilfLVy3exDvAwAmQcV/Q109S84PzjxgDJ9gTzmzulT22dxUT7qCG+kNRuWy2d0qXrCXSkAbQKal
 OBFTh+5cvqEcbVRJeBwMGUKVgAN8nXm0OrZFVRNm1Kzq7y8VJkfA6/GiVGoE+ugHcBNE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e7tqP4F54dJ/QBh3d6C/qFjfwEv/tt1/pjOsI2VcH68=; b=RK/ButuDbDybYP+OtFq7BUxBXy
 6Bw1T61v8LcCda7R5HZ50fGQt2bYkl40GU9g5QqWZv7cQP7jMmewPMfjJ7EVtGtbISNpTm803RlMs
 QkCTDCUYzPFq0MHwht/oWMoxx20cUmbcujj8lcBScyynXD/SF3VgdbLV6rjBg7sestCc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPMiQ-000000007Pu-1r4M for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 16:22:59 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A6GMpMS002942
 for <openvpn-devel@lists.sourceforge.net>; Fri, 6 Nov 2026 17:22:51 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A6GMpcJ002941
 for openvpn-devel@lists.sourceforge.net; Fri, 6 Nov 2026 17:22:51 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  6 Nov 2026 17:22:44 +0100
Message-ID: <20261106162251.2926-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793955802000.Ib7b9f2994ca828ea699bc6e5b08193dd30965926@gerrit.openvpn.net>
References: <gerrit.1793955802000.Ib7b9f2994ca828ea699bc6e5b08193dd30965926@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xPMiQ-000000007Pu-1r4M
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: close the NRPT base key in
 HandleDNSConfigNrptMessage()
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

The key opened by OpenNrptBaseKey() was never closed, leaking a
registry handle on every NRPT add message. Close it at the common
exit, and return directly if opening fails, as the key is not set
then.

Broken since 0f3b7d17 ("win: implement --dns option support with
NRPT").

Change-Id: Ib7b9f2994ca828ea699bc6e5b08193dd30965926
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2144
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2144
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 6a83bac..81205d6 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3014,7 +3014,7 @@
     LSTATUS err = OpenNrptBaseKey(&key, &gpol_nrpt);
     if (err)
     {
-        goto out;
+        return err;
     }
 
     /* Add undo information first in case there's no heap left */
@@ -3065,6 +3065,7 @@
     ApplyDnsSettings(gpol_nrpt || gpol_list);
 
 out:
+    RegCloseKey(key);
     return err;
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
