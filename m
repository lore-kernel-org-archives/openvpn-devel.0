Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63A606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RXYUzybS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=N2Wqa0XD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jRbmXBhi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=uIYy1B0N/QZRP0Yn7TGXp2/j4p8pEE5YU2+It8HWTpA=; b=RXYUzybS37gxSx
	+uFMKhlECYGSip90NaFAfLeukFd8wUu+y92/A+HF0iRSsezFmBZWVmjYDHd0BNrttTQy88Ktbk3ZS
	Wsx/8MO6Yhl7kKXkB8PXu0u2PO90uBHx1jv8DIR3GTJXMNmtbj4gXZxwTPBR/rwiAcqk154ZUn6r/
	Y/Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUmTm-000000003xs-2NNS;
	Sat, 21 Nov 2026 14:54:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xUmTm-000000003xl-0e6T for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 14:54:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BL/QwEcqxJj3rVEKsIdGmWXUopJ1I4UKZHNIIcBI5+g=; b=N2Wqa0XDoBe/Ko8KQbIyco4hNd
 +4C8ROAw/4QhJtS6WnyZV8ZiBhzmIJBBE5eBu/gCNBrRB2EfoI7FzzhzOLUQKWsuisl5mOKi2p9js
 yYyWWKqUJ9Ut8hCEEYGV3vzuw6/X8Pi+6DXivSogoK5W5O4ZZ3kYPdJr3NEj0hVP5504=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BL/QwEcqxJj3rVEKsIdGmWXUopJ1I4UKZHNIIcBI5+g=; b=jRbmXBhiJTsVb9Cy41gORKT9lo
 3wc2bXJ59KWy9qsKaABRHt2bvK6iLHqo+8YELeVRFBknp+17QHo7yXuKNILGtLOUKjLQgnbu6RX9i
 l/RMlaHAabnofL7SDRDup2DGLR1/K1AzOApyWh0AbYuG+hLg34lFbJzEP+aFeI6JHJwQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUmTl-000000004Za-11W9 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 14:54:14 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ALEs6Gh027292
 for <openvpn-devel@lists.sourceforge.net>; Sat, 21 Nov 2026 15:54:06 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ALEs6SN027291
 for openvpn-devel@lists.sourceforge.net; Sat, 21 Nov 2026 15:54:06 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 21 Nov 2026 15:53:59 +0100
Message-ID: <20261121145406.27273-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795176368000.Ifc72b3677056dd089b8c6cfae4bd07911b6f8407@gerrit.openvpn.net>
References: <gerrit.1795176368000.Ifc72b3677056dd089b8c6cfae4bd07911b6f8407@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xUmTl-000000004Za-11W9
Subject: [Openvpn-devel] [PATCH v1] options: check permission for
 --route-ipv6-gateway
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

Unlike --route-gateway, the handler never called VERIFY_PERMISSION(),
so the option was accepted in any context (<connection>, ccd, inline)
and was missing from option_types_found. Require OPT_P_ROUTE_EXTRAS,
as --route-gateway does.

Change-Id: Ifc72b3677056dd089b8c6cfae4bd07911b6f8407
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2228
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2228
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e51ece7..2068393 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5350,6 +5350,7 @@
     }
     else if (streq(p[0], "route-ipv6-gateway") && p[1] && !p[2])
     {
+        VERIFY_PERMISSION(OPT_P_ROUTE_EXTRAS);
         if (ipv6_addr_safe(p[1]))
         {
             options->route_ipv6_default_gateway = p[1];


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
