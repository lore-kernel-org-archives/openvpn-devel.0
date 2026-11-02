Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285C606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=htv+M06c;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ED247vDM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HmFPEWrp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FWPA3c7Qr+ZO+ygckGz7mERhytcmt6h5BgPcydd4L7M=; b=htv+M06c/8pacn
	3C8O4ZvIyYpBe7hZn+UcjHAwEq+jdtIU9v4zFOqfFvB/xv7mLVJpskVlV7y10VjUqxT1/XiLss470
	YaXwYxEbDFxBEpPPYzCTzm1fe4YprnlZP9YynNlohrwR7Tp4P6scGYov2sV0hZoNE26SJ0D/ohPm+
	GT4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNstl-000000008RU-2Msz;
	Mon, 02 Nov 2026 14:20:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNstU-000000008R1-1tKd for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:20:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TKu3Pzfom8EsoHKeN4Zm7+GbiAYYc9bQlJDA9ST9mr0=; b=ED247vDMPBMaGFmW645K0sJwoW
 pMG5A0GwaQhSMJj6+LQTqAz8UcV3eA4Ln6hcsSgujuOUc5Lrtt2pobs9eN4waEoD6KuiUULdhfJm/
 OYdlhdmEWTBnOgAltv8+pFldJJSyEpVa1TR6Tu4FC3EzzNcEmcYo1u1yfNvszNR02iCs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TKu3Pzfom8EsoHKeN4Zm7+GbiAYYc9bQlJDA9ST9mr0=; b=HmFPEWrpWqK/jCzx98u3wJDw+T
 bnMaU4iM4LPzxaesCdtXj3VQ3AHjsUm8vz4stwQgx13wsbF9mRdXrwx6MYqaGj5MQyQEckKRMZ2WR
 Sel1TKldpZvH142PQsbf8r1hY8m4JjvMNJnscXgaaS4F4Ud4r3DsjJVeQo2oR+clBI7I=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNstM-000000001PN-0M65 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:20:08 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A2EK1uV030481
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 15:20:01 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2EK1Bm030480
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 15:20:01 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 15:19:55 +0100
Message-ID: <20261102142000.30467-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793619336000.I73cebcb7649e7c2bfdd29fee955b192f143a5ab9@gerrit.openvpn.net>
References: <gerrit.1793619336000.I73cebcb7649e7c2bfdd29fee955b192f143a5ab9@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNstM-000000001PN-0M65
Subject: [Openvpn-devel] [PATCH v1] route: print net_gateway info instead of
 unset rgi/rgi6
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

init_route_list() and init_route_ipv6_list() print rgi/rgi6 before
they are filled, so ROUTE_GATEWAY/ROUTE6_GATEWAY were never logged.
Print ngi/ngi6, which the surrounding block checks and exports.

Broken since 2777cdd3 ("route: handle default gateway (net_gateway)
and nexthop towards VPN server separately").

Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2086
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2086
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 0bce966..7a475a6 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -619,7 +619,7 @@
     {
         setenv_route_addr(es, "net_gateway", rl->ngi.gateway.addr, -1);
 #ifndef ENABLE_SMALL
-        print_default_gateway(D_ROUTE, &rl->rgi, NULL);
+        print_default_gateway(D_ROUTE, &rl->ngi, NULL);
 #endif
     }
     else
@@ -770,7 +770,7 @@
     {
         setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->ngi6.gateway.addr_ipv6, 0, &gc));
 #ifndef ENABLE_SMALL
-        print_default_gateway(D_ROUTE, NULL, &rl6->rgi6);
+        print_default_gateway(D_ROUTE, NULL, &rl6->ngi6);
 #endif
     }
     else


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
