Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43A7C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ud7Od0cp6Tz7V8hGDTRcolxIDbmBK58ZiF2M5olBfE=; b=ixtq8JFmdSTohxyDqVShpz2+6T
	0cab3ThiWf4EIBIbK0PoK2JKCqb4C3RBtk/oHjxTuyvgKMqQ6WtVW6uZmEASwnUTucv0ljLk4utd7
	ggj5xrpKBAwc2qEdKkntdtrMgIJwnsSLsohD+sNAXmhYbLQQISUezY7CFpejW0ONLMZk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weC2s-0004OE-8Z;
	Mon, 29 Jun 2026 13:29:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <arne@rfc2549.org>) id 1weC2q-0004O4-RK
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:29:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P7Bkq1Xp5ogg/0xndzvYy0rR7X/fg4S5kzNKksizslA=; b=ggXZO6iLNlqluTQs6Xyhom358D
 rSSvkMTKyyf/UdPL83OLXs0je2oKj7y+WZyiUhieK587bukAVCSbIkDGOkndarvHVZWcswlWd5eqU
 ojvETAodsufq181afcoaQhNKCPvJP75SZgvz/GQsvj7eea3tZvc1zSNQHc5+eaaIN8xM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P7Bkq1Xp5ogg/0xndzvYy0rR7X/fg4S5kzNKksizslA=; b=Az79NR2W/QifileqyRycguhajI
 Jz2XWjrO822MLDoi+BwCPCOW8116mbopCUMDCoZa6e3qCeOdAdAcBD8Xfd5S6WVLgiuysSaEoWDo2
 MKD2UM1iGKP4ZRJoL4UoXOAWhKCCq83ReI8eiHigweTLV3O9crbzsmkJIcsgxMT8Kmcs=;
Received: from mail.blinkt.de ([192.26.174.232])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weC2q-0007dF-JD for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:29:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rfc2549.org
 ; s=rsa-green;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Cc:Sender:Reply-To;
 bh=P7Bkq1Xp5ogg/0xndzvYy0rR7X/fg4S5kzNKksizslA=; b=EksY2eU383EhdxBOKqS01cInxp
 MNnXGoBiZuFgewRjptY4MxTby/LDaWkgFQs7HRtXmHNbM9rdjyqnyBkAeLZzXogwpN7oLrSWLYOH8
 qSrivc51t0yDI813DQ6yAWvJf5irCIIDn4m4DujymKBwS1uLGWg33ktXoP3Y8C4yBi94LYyV7ncD9
 kzGuOSqzjNCWF2kcrLrIkSMsOxfpp3E1roOih5dIfDvhE+YXKsfCJ9SuKSPbzdTW0n06BsoN2Latz
 G/dmV40HEIDiY9/ciDIRIug6Rjxw+pxa4dNAolJh2jqChWoL1Y1R/lW/QxmYmOHJpUNUosksUZlDo
 2uUmSwRw==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
 d=rfc2549.org; s=ed-green; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Cc:Sender
 :Reply-To; bh=P7Bkq1Xp5ogg/0xndzvYy0rR7X/fg4S5kzNKksizslA=; b=zkCO0t9DXm+QXwJ
 uv8OGJXiA90KdR4o0boUSn0DXhstFljbNuastV6wmYs8+ZmqzMPoEzdW2/9izoxNOvK9lDg==;
Received: from [2a02:908:2220:a200:97a:3044:2b98:e70f]
 by mail.blinkt.de with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.3 (FreeBSD)) (envelope-from <arne@rfc2549.org>)
 id 1weBiX-000000004oW-37X9; Mon, 29 Jun 2026 15:08:05 +0200
Message-ID: <c6e935be-f655-47c6-b968-6962a3cfc58c@rfc2549.org>
Date: Mon, 29 Jun 2026 15:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sami Rusani <samgithub@pm.me>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
References: <q2D43uJoozPKtfJvLVuPcngp0-9sjp_HkGFBfdR3bpOTXmPGoi5Fz__jvpLGvsEWHXC5lBnqny8sXX-kkN3zXoRTJmTLjA0mzKb9yG5A4K4=@pm.me>
Content-Language: en-GB
From: Arne Schwabe <arne@rfc2549.org>
Autocrypt: addr=arne@rfc2549.org; keydata=
 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
In-Reply-To: <q2D43uJoozPKtfJvLVuPcngp0-9sjp_HkGFBfdR3bpOTXmPGoi5Fz__jvpLGvsEWHXC5lBnqny8sXX-kkN3zXoRTJmTLjA0mzKb9yG5A4K4=@pm.me>
X-Headers-End: 1weC2q-0007dF-JD
Subject: Re: [Openvpn-devel] [PATCH] Document --preresolve option
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

Am 27.06.26 um 22:37 schrieb Sami Rusani via Openvpn-devel:
> 
> Hi,
> 
> Please find attached a small documentation patch for OpenVPN/openvpn#532.

Thanks. This is a good start but I think we can improve this to give a 
bit more context:

+--preresolve
+  Resolve configured ``--remote``, ``--local``, ``--http-proxy``, and
+  ``--socks-proxy`` hostnames at startup before opening the connection.
+


I think we should mention that this also causes OpenVPN to never 
reresolve the hostnames on reconnect. Which is a good thing if you use 
something like persist-tun and DNS will not work while the VPN is down 
but maybe is counter-productive if you have a dyndns name for your VPN 
server or roaming to/from DNS64/NAT64 network where the IP address might 
change.

Arne


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
