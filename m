Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84604606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=k3IoriYm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SJOLAPV6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HIfd2OZa;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=X11yu/Yj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=Zr0kv8LD9SqVDDLWA1VfMIFAdsmTV9n7vlEreT9tue0=; b=k3IoriYmVCVpqnLXStKZ65gNKu
	ZGVqJUmslq9x0NRad1ftFjBpjh6aQEMvbs2YwPL2WtAWCTalrvE82iH0pfSPFqhSTWrQF947ccw/J
	lQd2ohaA17yj+LtRNIfpF9U2CoB1XWTdhqUhoL23BQNu4D+lFX7r7HqCyJAhj0DjyBag=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMC0I-0000000009y-0ydX;
	Wed, 28 Oct 2026 22:20:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xMC04-0000000009H-1WYm
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 22:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BBZUUYLx6T5llIUkVYJ55g32uNPTQQItKpuLH/Qfb00=; b=SJOLAPV62bZVTMcNW7Ahm8neuB
 iq/5OWFrEvJd6b2D04/ymvdhQ0oj/ImrVJh9UQW8LrgU5GZ4ffASxnpBMC0sz73QHw/gP+w6Xq5Zh
 MkqvzNdpdzAo47ZUMNuTHw6D+P6HAHOC+8VrfWmieCA23cg3STLXFMOnX/H38XPTCAmk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BBZUUYLx6T5llIUkVYJ55g32uNPTQQItKpuLH/Qfb00=; b=HIfd2OZaEQMiXNYFm0eKwEhC4L
 /07Fu6OjQ8oO/7Je3XeBnJr2+QVk75akerrsya1BSHM/XzRdc5FfkdWaVE7ve2E3hkn7OXoctciHm
 SJmi5TWSWGBdFJvWIUxkWuxqo0prCjE8uIN1AqCDK73YZ0HQMpawGjA34zOnKZP0rC+Y=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMC02-000000005xy-2Oqq for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 22:20:04 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jFMHH1SVDzMldP;
 Wed, 28 Oct 2026 23:19:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1793225995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBZUUYLx6T5llIUkVYJ55g32uNPTQQItKpuLH/Qfb00=;
 b=X11yu/YjlwsAlzyWmDImYdjLrmB6S4FUHLVBGQhrpMYulp6y9/FV06tA8nuTy/32MfZGZI
 iMiDeNH4U8AZfaGcR/FMcfTm6ALpRqrki4fbRHtbNlMPCb934gx4YBPnjRDti4rnzN8LXW
 P1CMFcIPiIRYOrvQg3tyLOeJQQxLomPHwFq41F9ov+lg26djV5tbd+9yNCkee+RxPKPuIo
 LMUbbIlZABkTuJl99lE0hQ4SEpX4IyVguHJBmchE22F5MRJQ88DWTtrav/LExnZY60Eooe
 jA5JuRujmj/NYVEFDi+NXHce6pE1eiHuvQ6Tde46Qvg26wHbalKtdJHroenM3w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <e902170b-bccb-4d46-825f-4f3dab15802b@unstable.cc>
Date: Wed, 28 Oct 2026 23:19:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bernhard Schmidt <berni@birkenwald.de>
References: <ea6e57f3-3d91-4d3f-9c28-471dc1021bcd@birkenwald.de>
 <auJj5Ld6uMjPb2eS@fliwatuet.svr02.mucip.net>
 <60758dd9-bc8e-4cda-b62c-11aeca9230a1@unstable.cc>
 <auJvKPCANjcH5OMd@fliwatuet.svr02.mucip.net>
 <7739d9ee-d0cd-4226-afbb-6e3703d68727@unstable.cc>
 <1707fc36-2665-4942-b663-fdfec32c7d59@birkenwald.de>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <1707fc36-2665-4942-b663-fdfec32c7d59@birkenwald.de>
X-Rspamd-Queue-Id: 4jFMHH1SVDzMldP
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMC02-000000005xy-2Oqq
Subject: Re: [Openvpn-devel] Kernel lockup in ovpn ovpn_tcp_send_skb
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/10/2026 23:12, Bernhard Schmidt wrote:
> Hi,
> 
>>> Indeed, that's the culprit. I missed it, but the last connect before the
>>> lockup is coming from the address assigned to the client.
>>
>> Thanks for confirming the theory.
> 
> Could this be caused by running two OpenVPN processes with the same 
> configuration file/client cert? eduVPN does not use duplicate-cn, so the 
> second connection would be routed through the first and then attempt to 
> take over the session after an successful handshake.

That's what I was thinking too, yes.

The user starts a second client with the same config and the handshake 
takes place over the old tunnel.

I am thinking about the impact of duplicate-cn, but I believe it does 
not make a difference.

When the server sends its first packet back to the client after having 
recorded the "bogus" transport IP, the old session is still there and 
the packet is routed through the "old" socket, which triggers the lock.


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
