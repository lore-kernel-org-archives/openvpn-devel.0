Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E5DCA601D
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=guMmjd1/QOZPo8ZAOzFcin30lWFiCLu7bRR+woHDKm4=; b=IzRnE90vSjVr4gpMtgzhiX7mFW
	teNtU1+yZINk2UeKgJcc1HatuZ41wQOe1vPZm9efgkBoHiNaR8mxszuSH+8wqlzZQd1EXxq5qWhZV
	v9O9NGiFV30mfQFPPdH0hPkS3z1mB1pLO+ixyiIXAxL1/4EBDu+RExH/mQTBGREqwtgM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFBzM-0000mn-87;
	Fri, 09 Oct 2026 14:54:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <berni@birkenwald.de>) id 1xFBzK-0000mg-0q
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 14:54:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:From
 :To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4mI4RB/OT/GWmkzPKi2Lk3zE6cYX3cwjofiqWG9lCq0=; b=TSVD3jMHKfRWrUjms53E1Wxmat
 Cz/XcUSCxmE7k6F25VVfSwda7aRBfLbERUNIyXvb2dtTbIPS7eXotIxAlAbyU5oib8IpBYIBpIgrl
 hrA82Fm/W7SGSTsaLFP6MDRd6THWQfwuW5t0RevDvVjhirD8/mGkBfmkwGYSRltixovw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4mI4RB/OT/GWmkzPKi2Lk3zE6cYX3cwjofiqWG9lCq0=; b=U
 aBYb5Zj14h55ZE8gb1gIyzXrd9Lx7KBeOcUVBeCmoZZpQSBzbJVJYWh4aNQA65PHyH8lVWjgrEY6p
 tj/gxQQlNeJDBnqCBwQ6SLs8zPWy8+CziYOAsi9wupGQy8JHGtVVq/J5Fz5e1/NNqnJ+OWYrKPE1N
 H09kOGRuhADEYxkA=;
Received: from mail.svr02.mucip.net ([83.170.6.69] helo=mailout.mucip.net)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFBzH-0002yO-S5 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 14:54:21 +0000
Received: from localhost (mail.svr02.mucip.net [127.0.0.1])
 by mailout.mucip.net (Postfix) with ESMTP id D5E95755B
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 16:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birkenwald.de; h=
 content-transfer-encoding:content-type:content-type:subject
 :subject:from:from:content-language:user-agent:mime-version:date
 :date:message-id:received:received; s=mailout2020; t=1791556471;
 bh=4iK0K7vTRZrdgQv3qrS9HmCeaL9f24kSB9kwOxmvM/A=; b=AUtNM9WwPvLU
 dKGG7DxSMEXnZ+JDUw6mFIM/k3aD/hYJR+atxwjY5ODHKeDiPuELsmvSAncWKe9U
 I1vVE8NMBbc823zMcnotS3+ugn9EtuA/m+FNUF2QP56oRYFktb9se0NLKGlmwUwH
 PzpC4UNbMhj2IuhG95xK9a1+uHnW1BX/pL6+exxcNjkFBpI3eTCjg9R0oDUpWCAl
 ch5H770QSIVPkqc5LF1kr/OJX+T7kF/aQNRivBza8Zf4h0xnZ/59wbiuZl2hisLp
 xgY6nvqjGsbSNaRqxH6oFz1mX/mXJS+HizcioxCkwW5IE/Ze3eR4B0l5TgOXieh3
 FKp63pVJbA==
Received: from mailout.mucip.net ([127.0.0.1])
 by localhost (mail.svr02.mucip.net [127.0.0.1]) (amavis, port 10125)
 with ESMTP id JMSIoAPjV_dp for <openvpn-devel@lists.sourceforge.net>;
 Fri,  9 Oct 2026 16:34:31 +0200 (CEST)
Received: from [IPV6:2a01:170:1181:0:6600:6aff:fe6a:9cf4] (unknown
 [IPv6:2a01:170:1181:0:6600:6aff:fe6a:9cf4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (Client did not present a certificate)
 by mailout.mucip.net (Postfix) with ESMTPSA id ACF92678B
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 16:34:31 +0200 (CEST)
Message-ID: <ea6e57f3-3d91-4d3f-9c28-471dc1021bcd@birkenwald.de>
Date: Fri, 9 Oct 2026 16:34:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
From: Bernhard Schmidt <berni@birkenwald.de>
Autocrypt: addr=berni@birkenwald.de; keydata=
 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 4Q==
X-Headers-End: 1xFBzH-0002yO-S5
Subject: [Openvpn-devel] Real world experience with OpenVPN 2.7 + DCO
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi,

this is not quite -devel topic, but I figure the correct recipients of 
the following message are primarily reading this list.

TL;DR: THANK YOU so much for OpenVPN 2.7 + DCO

We operate several large EduVPN clusters for German Universities. 
Although the upstream EduVPN maintainers are primarily looking at 
Wireguard these days, we have been in the OpenVPN camp forever (possibly 
because I am the Debian OpenVPN maintainer :-) ).

We had been trying 2.6+dco a couple of times last year, but always 
observed weird crashes and lockups and went back to the normal stuff. 
EduVPN works around the single-core limitation of OpenVPN by splitting 
the pools in several chunks and distributing them on several UDP ports, 
while we also set aside one chunk for 443/udp and 443/tcp each. This 
worked well enough without DCO.

For sudden reasons not caused by us, our concurrent VPN users increased 
by more than 800% this week. We have mostly been hit by an overload of 
our designated VPN user pools, which could not be easily increased. It 
was additionally worsened by the pool splits, which meant that parts of 
the pools were running hot, while others still had spare capacity (most 
notably the 443/tcp one). So we needed some change.

We had asked the EduVPN maintainers to support the OpenVPN 2.7 
multi-socket feature, which they happily did about 6 months ago. It 
basically drops all this pool splitting thing and runs a single OpenVPN 
process, listening to multiple sockets using multi-socket support in 
2.7. To overcome the single-core limitation DCO is recommended.

https://docs.eduvpn.org/server/v3/openvpn.html#single-process

Anyway, long story short. We now have 8000 concurrent OpenVPN users in 
our setup. They are distributed to four nodes, each running

* Debian 13, Nutanix VM, 2vCPU, 4GB RAM
* official trixie-backports OpenVPN 2.7.7-1~bpo13 distribution package
* official trixie-backports kernel 7.1.13-1~bpo13+1 with the in-tree DCO
* multi-socket single process, listening to 7 UDP + 1 TCP port on both 
IPv4 and IPv6

and it just works. I don't think we're close to hitting a wall yet, even 
under peak load with almost 2000 users on that single process the 
connection is snappy. I just spun a test VM and ran a non-DCO openvpn 
against that production cluster, and it happily reaches 400+ Mbit/s 
through iperf3. I think that's limited by the test VM. The load of the 
server is around 0.20 .

We have seen two segfaults during the night, but I hope they go away 
upgrading to 2.7.8. If not I will report here. The process was restarted 
by systemd and noone noticed.

Thank you all for making OpenVPN 2.7 and ovpn DCO and all the 
surrounding stuff possible! And kudos to the EduVPN maintainers as well 
of course.

Best Regards and have a nice weekend,
Bernhard


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
