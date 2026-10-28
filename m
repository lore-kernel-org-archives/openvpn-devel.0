Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5188D606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Stv/SDSF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kmL8wRKm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kq0nwiqm;
	dkim=neutral header.d=birkenwald.de header.i=@birkenwald.de header.a=rsa-sha256 header.s=mailout2020 header.b=oJdWSxMD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=aW3PDYJ485CAfWH8tWvP/CikW55FiphMoiw2jpUH4Fs=; b=Stv/SDSFZZc3i286ZVQDOwDnRC
	CUSzPKEsVBb3f2UCTLt85De8WxQPo5N3qY4yZJc1o8N3L1xpqxsFEeZZZWHxNk7IYFbCzOhQAAVuy
	s7KUDce33IFyFKkJMYTmNpGWgsStMBwGBzgRwTC9yDJBlts2nE+3w9Zswjbv9v5NSRbc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMBtM-000000005aL-3V3C;
	Wed, 28 Oct 2026 22:13:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <berni@birkenwald.de>) id 1xMBtK-000000005ZA-1Fra
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 22:13:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TtMG6UKbupxe2bV3qEFlawbkfOCRYCJFhoc5Rnmb5w8=; b=kmL8wRKm2JDA85gMbkGh7oiO+e
 0yd+EvaR90pM4zSrAn3sEO4nkg+loVY5hYj0sDA4pBO/yYeYIfuWZxOvtH5ETOXYjW3kkdXVYOoL3
 Vixob9rgl9pqJy6pnaxy6TZeVk+ZizEfAkpCzT6er5gaY4szezo+OnSbhRkw2UstOCfs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TtMG6UKbupxe2bV3qEFlawbkfOCRYCJFhoc5Rnmb5w8=; b=kq0nwiqm9AIDPucTXblRluNO9J
 JaQz6HW2N/xfSNFQAu6UQ3Nu0eC9E8pTry489uTsgQ+Rq8rEtPwc1lDpzXja5e4iu/vyguZiE33Mb
 MASNohaSasPCHmmPnS+dVpVppTpDDr78ISUj7yoNV6DzcU9UMYyHTDIHuCumz42DMheg=;
Received: from mail.svr02.mucip.net ([83.170.6.69] helo=mailout.mucip.net)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMBt5-000000005q1-3bNL for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 22:12:53 +0000
Received: from localhost (mail.svr02.mucip.net [127.0.0.1])
 by mailout.mucip.net (Postfix) with ESMTP id C54E26A05;
 Wed, 28 Oct 2026 23:12:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birkenwald.de; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :from:from:references:content-language:subject:subject
 :user-agent:mime-version:date:date:message-id:received:received;
 s=mailout2020; t=1793225564; bh=v8uG+/ZJz+MYN5xVbRLLnNFV90K3uds
 mi9/cJyfkXVc=; b=oJdWSxMDu9edGxmzWujlwP+Ffv/bJwzviZ+tIG7KN9PniRd
 mMYcvD+49LdsobjAPEPTKRmeog6R7StJRXPYLTD53zj2rfbKCk0G9dAAiuyi4gaB
 cKlANC02zKd1SZ09M3dOHxO58HihAlgYPP453UlDX29JK1Dv/4ygMqDvj0yKks6y
 M076P1Kivf79YjWVNm76qv1ro1BfTLDvacyooEOuOI6lPrqw5lL9vGDXidUsLINd
 Wo52NLtLRKdBXWk9RZ0EQoRvk3qWuVIKGUkIXUUlhycVB/DNKJkQn/pFtnirfLoL
 s+lQkSX5GF1xxTdBPvE1m8qrB46ahk16l+ya+Kg==
Received: from mailout.mucip.net ([127.0.0.1])
 by localhost (mail.svr02.mucip.net [127.0.0.1]) (amavis, port 10125)
 with ESMTP id dmmtigC2k105; Wed, 28 Oct 2026 23:12:44 +0100 (CET)
Received: from [IPV6:2a01:170:1181:0:6600:6aff:fe6a:9cf4] (unknown
 [IPv6:2a01:170:1181:0:6600:6aff:fe6a:9cf4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (Client did not present a certificate)
 by mailout.mucip.net (Postfix) with ESMTPSA id 9C6686A00;
 Wed, 28 Oct 2026 23:12:44 +0100 (CET)
Message-ID: <1707fc36-2665-4942-b663-fdfec32c7d59@birkenwald.de>
Date: Wed, 28 Oct 2026 23:12:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Antonio Quartulli <a@unstable.cc>
References: <ea6e57f3-3d91-4d3f-9c28-471dc1021bcd@birkenwald.de>
 <auJj5Ld6uMjPb2eS@fliwatuet.svr02.mucip.net>
 <60758dd9-bc8e-4cda-b62c-11aeca9230a1@unstable.cc>
 <auJvKPCANjcH5OMd@fliwatuet.svr02.mucip.net>
 <7739d9ee-d0cd-4226-afbb-6e3703d68727@unstable.cc>
From: Bernhard Schmidt <berni@birkenwald.de>
Autocrypt: addr=berni@birkenwald.de; keydata=
 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 4Q==
In-Reply-To: <7739d9ee-d0cd-4226-afbb-6e3703d68727@unstable.cc>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMBt5-000000005q1-3bNL
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

Hi,

>> Indeed, that's the culprit. I missed it, but the last connect before the
>> lockup is coming from the address assigned to the client.
> 
> Thanks for confirming the theory.

Could this be caused by running two OpenVPN processes with the same 
configuration file/client cert? eduVPN does not use duplicate-cn, so the 
second connection would be routed through the first and then attempt to 
take over the session after an successful handshake.

Bernhard


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
