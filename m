Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240B6CD8C9F
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rUWQF8SNLD3wFAs7D7NWrVe1YnReAFzszAGiE/rgB48=; b=UhRjEu4aMoZxq2d2dbcy3pvWhR
	a9d0G6VHSrnyfRHU+ugHALS7hdHKFZpXmtjt4ZkoEWnuPW3jJJe8JVCd7JFhJsuv1alPjZ7nRDgVM
	5d/+RnM2Y8nArHmAhaRTIguU61IZUcgD0RRNStCdtDf8QK7jtF5M319EGEj8H67u4xMU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWa6K-0001wK-BE;
	Mon, 08 Jun 2026 13:33:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wWa6J-0001wC-D4
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:33:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oUrXqBhmSv6hUIjm7a15fhpW2j0ChPArt7p7zWguUEE=; b=GE3CaN4JLtwDXlqa7ikyV5y1X/
 5bzp6Y1lxSttg4tLedoYaYgXQbiBVomm4no0G+M0XxCf2cokDADaFlJ3KYRMLb9EFdHr73dTWzIue
 rf7lDIOgzo3ZIykmC5oazXxO4g+qMpkRlwe30MUtdweDjtIdDukPRmasCT64ROhaxZNw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oUrXqBhmSv6hUIjm7a15fhpW2j0ChPArt7p7zWguUEE=; b=kTBhqr2xmOGuLGXcbAb5eCQ1/W
 Zj4rt75W0A+G0P9G3zkeUVKuidg9RYviaZD3gzAaZvgIJS/bv7c9IkCYT8XhRQ0qgO0R9k5wkWJ5F
 jFB4DIOwrZntg5hmx9089+Cm0fDcA0kyJzkhZZMaEcIAnn1u8sqnhb91vU0GM8R9ZEzk=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWa6F-0004wS-38 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:33:08 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gYtJq6Nztz9thr;
 Mon,  8 Jun 2026 15:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1780925579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oUrXqBhmSv6hUIjm7a15fhpW2j0ChPArt7p7zWguUEE=;
 b=G2M/i67quH8YxhFkZeZGTvlh+kMGwTHt5vghTDvL5jZrltKV6/SWG87YfjdOXMcncEYVHc
 Md2IdQMJOj9Mp2IZAvXveoht6VEHYUMAghkZNPP8AeGBZEz0xElZMaimGsUyyRuXRf2HPN
 9ZmI9ERLaU17XeD7JZZNveE3Qw7ZmHX59GnfMTQam/NWh1J/6TmSWptnH4cAv9idRwtjYa
 g1WVxhTEd/Al7i/yz2z0raeuPNzdsKVZwHAPjriNGe1dDbnxnfm1E5CPMsvgo8PvzRIcY9
 uwCyx/GyKudpdXgkbRBZIS9KJvK1KNDBoNbdGC1xlLZ0k0vTSsSrX5s5sUwJaA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  8 Jun 2026 15:32:51 +0200
Message-ID: <20260608133251.3128542-9-a@unstable.cc>
In-Reply-To: <20260608133251.3128542-1-a@unstable.cc>
References: <20260608133251.3128542-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gYtJq6Nztz9thr
X-Headers-End: 1wWa6F-0004wS-38
Subject: [Openvpn-devel] [PATCH ovpn net v2 9/9] ovpn: ensure TCP vars are
 initialized first
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
Cc: Antonio Quartulli <antonio@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Antonio Quartulli <antonio@openvpn.net>

Netlink calls may access TCP global vars (i.e. when attaching
a TCP socket), therefore we need to make sure the
latters are initialized beforehand.

For this reason move the global TCP initialization at the top
of the module init function.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index a881510aaac0..0a88ca6bbf97 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -244,8 +244,14 @@ static struct rtnl_link_ops ovpn_link_ops = {
 
 static int __init ovpn_init(void)
 {
-	int err = rtnl_link_register(&ovpn_link_ops);
+	int err;
 
+	/* init TCP first so that any subsequent netlink operation
+	 * is ensured to access initialized TCP global vars
+	 */
+	ovpn_tcp_init();
+
+	err = rtnl_link_register(&ovpn_link_ops);
 	if (err) {
 		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
 		return err;
@@ -257,8 +263,6 @@ static int __init ovpn_init(void)
 		goto unreg_rtnl;
 	}
 
-	ovpn_tcp_init();
-
 	return 0;
 
 unreg_rtnl:
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
