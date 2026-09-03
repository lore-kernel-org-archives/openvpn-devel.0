Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0DAC61DD3
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 21:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:Message-Id:To:Date:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7/tgBYdk8GBRMu9bJJhSHvlYuOqk2ur0HiSGWfqGFlw=; b=aBdELddN9qkFM9bxqbqPrFTfnj
	/YizGiz7IT+Q7aZCHqtIv4tFefXwPbLjrdsYbMMxFEauUjB8rRPLzr5HypdIwykgtiYQHswCu/OPw
	IjeHicubvm+WcSMs+/LQufLvk1H1Z8eoPOM0BGjdFnx/0vfjpqnI8zoZKQqfER1MMhpM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2FLP-0001Ps-Dl;
	Thu, 03 Sep 2026 21:51:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <root@fossjon.com>) id 1x2FLN-0001Pk-BY
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 21:51:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:
 Message-Id:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LHq3ix9BJJsn54rmCPIQVaqee6A85CmqF6c6B592u1Q=; b=gXCupzGmU3HDYdXkfhbqyqfMBS
 Azc7fCHapgjvZ2KQZv6t76U9cbSZKZQ68TbWj6FslIDO2HmXuvWE+1sNwdjMqfVcIMgQjK9mmgbgT
 wFDgIuJGO9hjuIjND5GqvpmLB2m8Za8HHfyUXkGg46VrqhKnmqq8bhGgskxvMxvfqYP0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:Message-Id:To:From:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LHq3ix9BJJsn54rmCPIQVaqee6A85CmqF6c6B592u1Q=; b=b
 xCKtyb3uGtA9qDXXKAjo8zhNrllvRTW3UWBvro6T0wZxYwqvpl1Fl/SypuD3h55ol3/6SD4y1gi5x
 n7+DmiJRlR/tkb+vPwOHXJph4mshcotlVLq/OiWpqQ/K1dBAxcyyxHiVPEf+jfcjxe5TDjtFsYILu
 vBxN78lhRsi1dz9s=;
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2FLL-00050w-O0 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 21:51:37 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 2F94A1D00130
 for <openvpn-devel@lists.sourceforge.net>;
 Thu,  3 Sep 2026 17:38:16 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-05.internal (MEProxy); Thu, 03 Sep 2026 17:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fossjon.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1788471496; x=1788557896; bh=LHq3ix9BJJ
 sn54rmCPIQVaqee6A85CmqF6c6B592u1Q=; b=CLWiwhV6wvaWEYDZ3eU02dKAPp
 h6AMx8a795iy5gMoPOyHHCo/H5PdMK2+pq96bIm++twOb8CxkzijdHG48wsZyoe5
 fd0ShtSBLEKCel0TibcE0nAo3niE5VT84U9oNWmW+K8yVgN3/QRIDPz+LLzvMArO
 gQdJHwOz/Ga6ez01uSDkVOUoXMLWU6fn3XKs1T9wA6pSXjL23RPKi9bwCDk75fyT
 eVXFiDKLtdW3ZByoHDVJNGmh9yohLJ40166IuiXDWPh5w3HE+IiuD8ugcDIZss1/
 0LejnXgMxirJSep4wBwvfXoDYyP/aH0pVqyAFt4oWQn+t/XOOSk0O3XorqJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1788471496; x=1788557896; bh=LHq3ix9BJJsn54rmCPIQVaqee6A85CmqF6c
 6B592u1Q=; b=u7laGSvQqN17jg3dia4PE5p6lYdblRxH1gAvzoAJbc9h0BFMhbu
 FDoJ8V49vL/7PvzG31wi08dIPglKVgfNn3T4ild+9kwaq+nUdVdNmOeXn/sHSFfC
 mc1pUDrtgWHhd2HZz6QZWn/XeLKWH6yN99be+x2H/inpZDAIHRf9BEiV/gllo9PQ
 dgcRPYpeKEoGnhWAJCAdTlCOu/G60gCNG7C8bmT97nX/viiLGgBdmmhYmlvso0Oq
 PzKZ2pZtTS4ac503ZZRce+YWvlG41KB4hxU94B2UB2sbMEHcUkRDQM3yNqfUUGXz
 p/Z4aoDnxiqMevg+HB5IE1MWK/QT/AcP26Q==
X-ME-Sender: <xms:x-iZarBi9SNQxvJDiemlR62ci0eSA7Nrn0jHL59HWeGVAGQ_k2bOOA>
 <xme:x-iZasX48zspq8P94F3pmY4wa0ZD_GNIpF0qTqtghq82eLPd2dviEWPiUw_gFoAbk
 rhvKYaC6ON9Mx-NmuXjpzMrwQNhdIAmqaDF3iC0j6-1PpTDG9_R-lwb>
X-ME-Proxy-Cause: dmFkZTGg38mUsv8lbMcitMPM47MTYKKCKDCrW/i8Z/MGbTwUYFDDoI8vR+9+2MLd23ksFV
 EcxtD00yOqPeGMHoFoG7AJANV94R6JNHDl2l87Zlvj853iYjZh3eEnvtQzkWvyedOFkgnu
 djmZ8dxXmL1glw1ONpGUkhTF5O5O5taU/d/QzjF+csyj1TRZfkfRaYpuKOeXbwoIZl/thC
 EEA4AXFu80XA8mgEdkH0L2gFtp56gF37qzuRr0nKKmdyfpxmcEvK0ne1jXGYBnJDZ5TuP9
 pbdRilUeSG+h2GXX4JdSh6gmm/Zm8IaCxF/KaLbW54mfTcT3YYtTjuAaZx/Y57QNUiatWt
 BqVI+vlTrcJjvfvj8XNJxHtLIQCOAGcqeK9EWK8S6SCrDKz6tUHP2m8DMskI6ugrMr8dEH
 BlbTAvljE/qCuBv1pfU5ZY4iIUsCo/G6NRLM/YViHiuR89MwuwvZMgWebYm9csyoa6mckH
 v5HAtHSAGq8d39ONWcooIxXqL3cxBhsY3wXiXJxmzonNnRZQTtC8qzY+xjXtv/PS7RQhKd
 lXxtPD1NMD+RTHWhphD+V10FmwWduuoaMIwioIcGolunFdOUQeH+/dGWTRD8YJzctmMOVM
 7mjzEjmcj7Yg+R1iuOXSYg5MiTyWB2/6D15CrJ4QAF/GEDHAUKH/olwaGWfQ
X-ME-Proxy: <xmx:x-iZagSRRSBe-nT_b8fJOPC9b7BpGMWL2l6w4OpuLG6kcqtfEdOFLg>
 <xmx:x-iZatvXDc6XaqkVQujVzyNq3esI59CkwoE_O0f3g42eWYJD9CKX4Q>
 <xmx:x-iZaquf3LTVe7E8z0CTWRibSI1fye7NlWQu-SRLRplOMyBPHEZZhw>
 <xmx:x-iZaryKsnbcE8j_3AbhrEZ6SurvofIzip7c8OhkewoRcfp1qsqg7g>
 <xmx:yOiZasmzl-DJvLG7reWeGJIlyoiy0Bd7_BSz9C0EinmMhfe_PpZ9Uyye>
Feedback-ID: i961e487e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id C43BD182007E; Thu,  3 Sep 2026 17:38:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 03 Sep 2026 17:37:54 -0400
To: openvpn-devel@lists.sourceforge.net
Message-Id: <b200b1f7-2a43-4d20-89c2-a24a97fd3cb7@app.fastmail.com>
X-Headers-End: 1x2FLL-00050w-O0
Subject: [Openvpn-devel] It's been some time since I've looked at the OVPN
 source code but I found some cool TUN interface flags recently!
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
From: Jon Chiappetta via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Jon Chiappetta <root@fossjon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hey all,

I've been busy in life and I haven't had much time to keep up with the development of the OVPN source code and all the commits and everything (it's been a little while since I last posted). I ended up creating a custom framework for my own personal use that is based on the original modifications I did for OpenVPN (multi-threaded, bulk-reads, TCP-only, standard-MTU). I was able to get over a gigabit speeds on my wifi client with this network-wide VPN solution I have now. 

I found these 2 new-to-me parameters for TUN interfaces which are really cool and I didn't know existed (I also didn't see them last time I checked the source code here) - IFF_MULTI_QUEUE | IFF_VNET_HDR. Obviously the multi-queue flag wouldn't work by default here (since it's not multi-threaded) however this other one is pretty nice if you adjust your buffer sizes to be much bigger :)

For example, I was able to read thousands of bytes of data in one call from TUN if you set the below parameters in C:

ifrq.ifr_flags = (IFF_TUN | IFF_NO_PI | IFF_MULTI_QUEUE | IFF_VNET_HDR);
TUNF[z] = open("/dev/net/tun", O_RDWR);
...
erro = ioctl(TUNF[z], TUNSETIFF, &ifrq);
if (erro < 0) { printf("%s ERRO TUNSETIFF [%d]\n", date(), z); }
...
int leng = sizeof(struct virtio_net_hdr);
erro = ioctl(TUNF[z], TUNSETVNETHDRSZ, &leng);
...
if (erro < 0) { printf("%s ERRO TUNSETVNETHDRSZ [%d]\n", date(), z); }
unsigned int offl = (TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6);
...
erro = ioctl(TUNF[z], TUNSETOFFLOAD, offl);
if (erro < 0) { printf("%s ERRO TUNSETOFFLOAD [%d]\n", date(), z); }

I don't know the full history here yet and am still learning but was this option ever considered to be implemented for OpenVPN?

Thanks again for your support and help and time on this open source project!
I still like it way better than WG haha :)

https://fossjon.com/2026/09/03/finally-got-multi-queue-batch-io-linux-kernel-tun-interface-in-c/

Jon C (root)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
