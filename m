Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F47606A598
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=P5Xbb8Wp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RAzd1J1E;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FGTqEVTZ;
	dkim=neutral header.d=lichtenheld.com header.i=@lichtenheld.com header.a=rsa-sha256 header.s=MBO0001 header.b=Jzp/WSWE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=eCDg1nCoyfEW/fA+KeSh/ogff6BZIubB10XYXfuC2kU=; b=P5Xbb8WpD6AfNs
	eP8pknI89MmhhSY+HcBk8ZFinGvhyodomIF2tAk80KYP0kT+/IIe2Nb97veEPIToM4eK4NixnGDCp
	DJtdobXIB2bh3HInd5WrbSIfbD4sw30yJx4n8CrH2Cn7YFMWs0TTpJ3Yb+9Nml3S/WvuzG3jIU1cJ
	ns0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNvQn-000000003Mt-3Ohl;
	Mon, 02 Nov 2026 17:02:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <frank@lichtenheld.com>) id 1xNvQm-000000003Ml-2Ccn
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:02:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EQIsNLxooBkj07ui0xSofQRUXcYx652HLugoigo2z9s=; b=RAzd1J1EDwUzeeW1kgJK9ZOsCh
 BsnUfu9wNEi7C0GdeS1L2vNNq9956VC4+jF+xfyL+4B79tRYWxdDJM5I+Khin4YSQi0S1u1vD49kn
 fHDlyU7rFomBwHe2JQf/A7CW4EVgKT/WjwvjJWS26NDTjIFhb6aLQt8hLcEoaHgn0XHU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EQIsNLxooBkj07ui0xSofQRUXcYx652HLugoigo2z9s=; b=FGTqEVTZ2cJxFm/RBHSPgqHL24
 cMq4WzKZRFIe/DKKbJVrlzb/WcSeFBAfZ3G3TGiSfNj9YDWPa8SkEkYFICmhkI+vVwMjOQD+VQC7d
 bu87+2yKuNv3MVy2fagKhtubX/cxINwguPleXy6OQ7vCkQrpdkrFhcu1qR8uW9pNVzdo=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNvQl-0000000060d-3Xxa for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:02:48 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jJJ0v54HszMlHd
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 18:02:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1793638959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQIsNLxooBkj07ui0xSofQRUXcYx652HLugoigo2z9s=;
 b=Jzp/WSWEL3PvnWvc+DEgHq7uAT/brM0vzI5EnN8+TyyPHNdFkENco0qolkzl48vSvEratL
 /+tyAzBItX7IbJIQCvc9CIe8/GAIfKzpKWFVbGu4V0ycfcPxhL611CUDBp3fio42Z/1l14
 x6L/OwbSLaaMdtDMKn73ZLM0pgBeknDZmSMbWgKirpVZAX89qAanScUD5Eklm6yKq+aHf1
 f1HLhQaF6KNQjnLDL7vWuTb8hXFwm5V0HQwJlLBFvv/ozyxTRcy0d3roHqsRa7wWUS7Xxe
 lLI5YAlZdCUJgkqiB7hERO65eViVANwwaKVnEpJWV/q4f6jIyGQxqOLpbSM28A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 18:02:38 +0100
Message-ID: <20261102170238.111437-1-frank@lichtenheld.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <gerrit.1793624563000.I97a14086258c08b47e37f07f103460a9d0bb9afd@gerrit.openvpn.net>
References: <gerrit.1793624563000.I97a14086258c08b47e37f07f103460a9d0bb9afd@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jJJ0v54HszMlHd
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNvQl-0000000060d-3Xxa
Subject: [Openvpn-devel] [PATCH v2] openvpnserv: fix inverted inet_ntop()
 check in GetItfDnsServersV6()
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

inet_ntop() returns NULL on failure, but the check treated success as
an error, so DHCPv6 DNS servers were never returned.

Broken since 0f3b7d17 ("win: implement --dns option support with
NRPT").

Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9afd
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2090
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2090
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index e2f17f0..484f27c 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2217,7 +2217,7 @@
                 s--;
             }
 
-            if (inet_ntop(AF_INET6, &in_addrs[i], pos, s) != NULL)
+            if (inet_ntop(AF_INET6, &in_addrs[i], pos, s) == NULL)
             {
                 *size = 0;
                 return ERROR_MORE_DATA;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
