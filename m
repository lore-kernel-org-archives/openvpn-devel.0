Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F05A606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MN4YBlR8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hf2Ltdd8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FOoGafRj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ALqeMGeQ5gq3ghFFwes7dcTJXA612O42xyMIZcfFJqk=; b=MN4YBlR8lIfdxl
	sOhjd/ELVyklIAYhtOy8ay8rtC6TLAF6P90QwWBj2jJVdAB/uE0OS1nAl0HdSf5CamGeowhXDkJJD
	b1HVOd+kT2aTGy9QUtkobhAOmT3AFCX8W8x16M8xGzlNraY+U1Q+wkUFLP5pfZOqLt1759RrJAk+W
	qDM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX0RW-000000007PF-2npJ;
	Fri, 27 Nov 2026 18:13:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xX0RV-000000007P7-0LEt for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 18:13:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EQOYnm1eNHn9S5iywNCQW3MQXi5EyNM4XxINyyH9C9w=; b=hf2Ltdd8KM6mYaL8dpvlYMINbS
 6aygSMargA7BbyXQezMQIDmCAjMBC9R0/Tnz1Px/FaUl3SiRWMkmFfhtkxwJm/kqj+8zg78D9LN+K
 5l1pN2qVneuZie1wGiW+c8TrFu6eWQnoXb0H5rV0ubsJ9dzoJl2Pm+JYHOfufBo+AZWU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EQOYnm1eNHn9S5iywNCQW3MQXi5EyNM4XxINyyH9C9w=; b=FOoGafRjv33UO1mb4fyvkCfVaN
 lKnQDw4bKVRDOKcvmUOE6A1eMZ+KWGd78l0kbjZUt6+2/KirAibnT/qt65Bn/GZV7yRHNXUOPLCAN
 dqSsPxcgUMVBV9Bo59A5Cfw3gtSed305iZFQsgIN63kayxyR6wmL+qMAfXJFggduwLew=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xX0RS-000000002EC-1Amj for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 18:13:03 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ARICtcZ025154
 for <openvpn-devel@lists.sourceforge.net>; Fri, 27 Nov 2026 19:12:55 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ARICtYW025153
 for openvpn-devel@lists.sourceforge.net; Fri, 27 Nov 2026 19:12:55 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 27 Nov 2026 19:12:50 +0100
Message-ID: <20261127181255.25132-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795790419000.Ib7c79652a694313fa398852353bd1719f6ce7634@gerrit.openvpn.net>
References: <gerrit.1795790419000.Ib7c79652a694313fa398852353bd1719f6ce7634@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xX0RS-000000002EC-1Amj
Subject: [Openvpn-devel] [PATCH v1] openvpnmsica: don't reuse the freed
 adapter address list
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

If GetAdaptersAddresses() overflowed on both attempts, find_adapters()
freed the buffer, then walked and freed it again. Fail instead.

Change-Id: Ib7c79652a694313fa398852353bd1719f6ce7634
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2361
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2361
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index d2fd9af..0ae8992 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -183,6 +183,7 @@
         }
 
         free(pAdapterAdresses);
+        pAdapterAdresses = NULL;
         if (ulResult != ERROR_BUFFER_OVERFLOW)
         {
             /* MSDN does not mention GetAdaptersAddresses() to set GetLastError().
@@ -193,6 +194,12 @@
             goto cleanup_pAdapterList;
         }
     }
+    if (pAdapterAdresses == NULL)
+    {
+        msg(M_NONFATAL, "%s: GetAdaptersAddresses() kept overflowing", __FUNCTION__);
+        uiResult = ERROR_BUFFER_OVERFLOW;
+        goto cleanup_pAdapterList;
+    }
 
     /* Count adapters. */
     size_t adapter_count = 0;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
