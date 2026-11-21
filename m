Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F870606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gETWmUTU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=es3QO0tB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iI6Eqryi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/8356g9T9qeer8VrXPiW7mN/nMdViVqgRCjnm5BF4XQ=; b=gETWmUTUELhhDc
	DyBET1W+P4CJ4X5GXekBEff2y8guUhunjWsXxJQasfLa1l3G+qfKUsssulu6Jdrg4X01hi5f4OiaC
	MjE02/qByk64kQqZ9Lcjn+qoE5g/nbw+RY+wBFhG+8JboO1UICNwLFYi50fa1zU4ca7F3vtHDcKQ6
	vgg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUhhS-000000000DL-0G9F;
	Sat, 21 Nov 2026 09:48:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xUhhQ-000000000DB-2rBa for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 09:48:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E30bz6LnRgw93dwI96BTY0vMEx+qmNNKDW+8AUrxZ+Q=; b=es3QO0tBFWMgpUAbM99cas+mzM
 NLI5MBmgOhIJSId5rS+cEfRJSX79wrp49ZfAr42T8QrQe2AEgqqWeDzUn9k6ADl2bpc4SmuvIqJE7
 5y3wqLWHXPIL2t2RaRobbQVG2o72+pHzNF/sVdW3OwfvOYCXJnN5cwgZ+zvZc5yBerJk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E30bz6LnRgw93dwI96BTY0vMEx+qmNNKDW+8AUrxZ+Q=; b=iI6Eqryi0JHmcmTxTC9UrLX9So
 GfGACBsiLvfYTa7Fuo10cpKrJ730u5nQlixaYnEtNODn4yqxt1gs7X7wzmMK5zAm0DpldXMwm2I1r
 lmyDYK1u3cNCd9YBehVgvmI1Xqn11ZBDw+KkfLeBKPrFeetQT3cfXe/nXxgMIKOQ7A7w=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUhhP-00000000345-32Z4 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 09:48:00 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AL9lrFi028760
 for <openvpn-devel@lists.sourceforge.net>; Sat, 21 Nov 2026 10:47:53 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AL9lr8a028759
 for openvpn-devel@lists.sourceforge.net; Sat, 21 Nov 2026 10:47:53 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 21 Nov 2026 10:47:46 +0100
Message-ID: <20261121094752.28750-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795207472000.Ia359824eea8780805a59d19146740afe3630fa0c@gerrit.openvpn.net>
References: <gerrit.1795207472000.Ia359824eea8780805a59d19146740afe3630fa0c@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xUhhP-00000000345-32Z4
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: don't use stale data for
 NRPT exclude rules
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

From: Heiko Hund <heiko@ist.eigentlich.net>

If the last interface GetNrptExcludeData() looked at was not usable, its
entry was left with the domains set, and SetNrptExcludeRules() created
a rule from it. Clear the unused entry when done.

Change-Id: Ia359824eea8780805a59d19146740afe3630fa0c
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2233
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2233
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 354fe09..24705a9 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2521,13 +2521,13 @@
 {
     HKEY v4_itfs = INVALID_HANDLE_VALUE;
     HKEY v6_itfs = INVALID_HANDLE_VALUE;
+    size_t i = 0;
 
     if (!GetInterfacesKey(AF_INET, &v4_itfs) || !GetInterfacesKey(AF_INET6, &v6_itfs))
     {
         goto out;
     }
 
-    size_t i = 0;
     DWORD enum_index = 0;
     while (i < data_size)
     {
@@ -2627,6 +2627,11 @@
     }
 
 out:
+    /* Clear data left by an interface that was not usable */
+    if (i < data_size)
+    {
+        ZeroMemory(&data[i], sizeof(data[i]));
+    }
     RegCloseKey(v6_itfs);
     RegCloseKey(v4_itfs);
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
