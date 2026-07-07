Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05EAC43458
	for <openvpn-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EhYML5LhnPQMlZEw4/MDUVXTv/BAnf63enNGKktNth4=; b=S/gjpMYGlJzdEOAN1iEr1CdtCW
	9VSRWq1DtQvW7yMZXHVkGI47gpH3waocy2IMsyC+u3VL/GnRE12IAKH9swItRV1UIwb1Z8UuhRCCi
	JDnETWJQQlU/i5IxSzlij4jcVZCioXYp6LnschooFiVcuTng5gtwgKM+bi/iBSi2BzOo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wh3bi-00021A-VE;
	Tue, 07 Jul 2026 11:04:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wh3bg-00020p-JG
 for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 11:04:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3dib2wbDSHB1Zrj2nkoOL6W4/tptfC2mWhKNU8ulIRI=; b=YjmTdvWQilieP0VsBeTVF4LcCn
 +jsnoTbSBeINMj/bmnF+bCEy3201wcEAlrvnClUhoHPciKe0uPTcw/tHcsDspDOTzwaZjnj06RYdi
 rcfAzhfK59nJHfmPfcLkVt3ZmWmmj7S6kB8mCzW9Yhx1I7aWXkBC6CBpz4lWEpGDjShM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3dib2wbDSHB1Zrj2nkoOL6W4/tptfC2mWhKNU8ulIRI=; b=SMXdsifY4HcFRGnRp+7Au8lolP
 slg4oZy1ZzqwFXlbIvW22EbveMzRJ28ASEX0r4qHkULPo1zjZHo09PYx3pdFMt5qVCsivqJaMIGQ/
 wpiog1rBiUUJhTuoh4h3X3aTjUiW8dX2ZgCKe4A9DbiEzEZUbp9n660DLNvK8ajW+TfI=;
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wh3bd-000227-Mq for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 11:04:53 +0000
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 87315EC0193;
 Tue,  7 Jul 2026 07:04:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 07 Jul 2026 07:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1783422279; x=
 1783508679; bh=3dib2wbDSHB1Zrj2nkoOL6W4/tptfC2mWhKNU8ulIRI=; b=n
 frN6357l+5w9W9vCMTcTFZpsqph0Yk6vpeq9XJR/MIPEKUVWZsxbd02ignomXE2x
 Q6up1bz9ivBjmeSKuXLI/JfiMFXuOCeIx7VkwUVDgfVXn6mSoUhdwBWOCmMpJBr/
 p1kPfhN9A92Z5NR6MNC9b3Cxr5951V+q51f5cYQVVl8sJXMUGY1+rcQwI7kaqvcR
 jEoNcGMvsDGlKEOQMXIYcETYwBLFxwiPpOjsu/9wrYU0fcBDzw1U1+ZhrMR6SJB/
 Zdc8BXgzlr0Z3KaR6JCIVmx8gOHyM+u3LSBzTSBtWY+POUEBwK7TSoXkEIIRyAvD
 iiAmnDUniDH0IRllizMlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1783422279; x=1783508679; bh=3dib2wbDSHB1Zrj2nkoOL6W4/tptfC2mWhK
 NU8ulIRI=; b=UOelspFYfJe6hkSr0JvOHiA+VJi6Vw3T3KnograR98yp7XBlaPa
 crQ+tMHufE/xKNzzTVN+Ujda9hK5s2pe5F6OAZt0tmBOAzchUukxeFKEOuv71AUv
 DyuFsKVYBnME1E8Z0hLjpPvE5bbVKEf9tfK9MheLMu0FeGDTTz/5sEay+qdwPn5l
 fE55KkWppw5G5uYOOJgji4vQ6fLFgVUhW+QD1G1GlIY2y87Mw4LMFt/pm029Aazl
 Uw5XpTBYSUfNkzdJiuEmwuA4hwl4m1Q0YiWUkc4pmsxT1BHhteewqFQwzZCWpnI+
 FHepqfol9zfdynYL3k0sHGOenCIGPBpWWnw==
X-ME-Sender: <xms:R91MavrEXEnUEsR6h-EN0juiIJxDmTbUoa0P5FkCEQ2DNggx66B5OA>
 <xme:R91MavoZhNAPvX88bn1AK22DoX85NQP1ngtqtDd3OpHNSMjS_NWl1bgcK34Q2JkI-
 UY7mhX-fSIY2wwLFTJ6S_pqgPAPyDkzZBpboMOg-IO6Y2ycDUMyqyg>
X-ME-Received: <xmr:R91Map2hVmpk_HYULicFTwVhL2lnAWmihu39WvQygOZ02lEOh7u7iQt-B9k>
X-ME-Proxy-Cause: dmFkZTEM8Lo0PRNZHg3JXu0zX78C1ASeeZG0dN5xE4UUPCp4KdO7btWKJzzEhCZpkWw/eq
 S87/+MqctnZAFQOlzMF8qefBV2m2w38qwCsBvfa9x+N+DkhrGU3BNpn6RHAVqaRhfl4n7M
 52Rv6VGL/75dLcKgy0Gb+yNLa3pNRTfuQ2sOkBx723KF/Ooa0dxk10JmqK8rmUCP9svRKp
 vbrKq1xaLxA1V31s1ylExJJnakPoDVrLFMkQImVeEo7Jh7ZF+PN/xdNQ/FtoiKT8+1+h5B
 QEbvMmYfKZMgNuACzVwmKKRw9T1xURHovD4kvWl37N2pURB9hxlvD4dqHuD7DsQ0uE5HRH
 ZYu0RHIbmrBFfdkO1EmpUCyP57dRyLtNm4W0shmfrLOVQ6NajC5avRxtDLEFLr199HdnI9
 LKO0bCdObB1y1zmMDC8YRQYb92omEItEj+gSsqkvjc0DAS6kIhkSwt9pndqRrfoDAQ9oJ8
 9Tag6xdcbhveVRttv8wNg3oK6lKay/o7CxfHKr7X/jWxIe7M+1/5+nmhXuSUsKyj0q4q/0
 RHGTG+RmdAyin8+Yw7JBThpwKgS6POTw2uZ9hp3kJVtaBur2wfAUlnuWKLvwmphmxFGJp/
 BkWe0G1M8t1FsIooDt9hcpqjRZ64a4d9AyC69LH03rV0GxN4Q9zvaKMpzzqw
X-ME-Proxy: <xmx:R91MauAmrGbAQ4SmabzWutva48RGxolK-H4R_wakAep_YDj_Dh1aFg>
 <xmx:R91MahdLgGIc7CLxvnzixHkKDQiSLcko38uwmvlstQmv-vRu0YJXqg>
 <xmx:R91MajiO4vwmP-gP96iu1J_WHuFmlJNLyABolfLqGeC6ZJLi895R1A>
 <xmx:R91MapqQcb-XIwBYrtJC-ynCyIEr6KPHNmZPA5aO3I1t4pWb1aUMXA>
 <xmx:R91Mal6wcWNvztCriBrQZUcYsbAjktR1xHGFjtShwC9Qw7vki_zWxbMq>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 07:04:38 -0400 (EDT)
Date: Tue, 7 Jul 2026 13:04:37 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Message-ID: <akzdRR4C9dzJ05la@krikkit>
References: <cover.1783336121.git.ralf@mandelbit.com>
 <8f7261c5719fd67b8f0da4d0e89f2c4517fa8168.1783336121.git.ralf@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8f7261c5719fd67b8f0da4d0e89f2c4517fa8168.1783336121.git.ralf@mandelbit.com>
X-Headers-End: 1wh3bd-000227-Mq
Subject: Re: [Openvpn-devel] [PATCH ovpn net v5 3/6] ovpn: initialize TCP
 state before registering UAPI
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
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This fix looks good, just a few small comments:

2026-07-06, 13:34:01 +0200, Ralf Lici wrote:
> ovpn_tcp_init initializes the TCP proto and proto_ops templates used
> when a TCP socket is attached to an ovpn peer but ovpn_init registers
> the rtnl link ops and generic netlink family before initializing those
> templates. Once either interface is visible, userspace can create an

If only the rtnl part is registered, we can create a netdevice but not
attach a socket to it, so the ovpn_tcp_* ops should not be reachable.

> ovpn device and configure a TCP socket while the TCP templates are still
> zero-initialized.
> 
> Initialize the TCP templates before publishing the rtnl and netlink
> interfaces, so externally reachable setup paths can only observe
> initialized TCP state.
> 
> Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> ---
> New patch added in v5.
> 
>  drivers/net/ovpn/main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index 9993c1dfe471..c2c3af0c3c55 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
> @@ -233,8 +233,14 @@ static struct rtnl_link_ops ovpn_link_ops = {
>  
>  static int __init ovpn_init(void)
>  {
> -	int err = rtnl_link_register(&ovpn_link_ops);
> +	int err;
>  
> +	/* initialize the TCP protos before the module is exposed through rtnl
> +	 * or netlink
> +	 */

I don't think that comment adds much. The commit message explains why
this needs to be moved (and why this had to be moved, if someone
touches this later)

> +	ovpn_tcp_init();
> +
> +	err = rtnl_link_register(&ovpn_link_ops);

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
