Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD1606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NvP3r6DZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S0+NNRM8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l5K+pGA8;
	dkim=neutral header.d=birkenwald.de header.i=@birkenwald.de header.a=rsa-sha256 header.s=mailout2020 header.b=ng63JVpQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=D94PhWBBH/fje9xrmCPxKhusXQ1pA/EYnyqQbS/9bS0=; b=NvP3r6DZov0uRixTcLQuSM31RD
	LSB8IcIdfRnegaNQ7xAfHKVpC5Cv96729FOYCLV5FbqmKuju93kV/S7kA4rw6hGh4+XRPKmHEhlGy
	N2Bo9W4OJQrjhsN3qVPI/tDam64nTzHq/LduQOJFaLKzxoMPD/mT3msxu648/dQePGQ8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMBbk-000000000EF-3yLF;
	Wed, 28 Oct 2026 21:54:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <berni@birkenwald.de>) id 1xMBbk-000000000E5-1G1g
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:54:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8g7XLCGWZO38udZZqzQ7d+iSsKdJZ7DLTIT+Zx4OUoE=; b=S0+NNRM8OyD4g3gMt5KHSGTa+l
 eaL8O7uNJjlvrYngfirPafNLiqefQUZtUlrwUXcTcw7yjxQ4a+Yo8B9CHAh2FlK5+3OZJyEmeS9jP
 V2vU2T1F8NUfyO5BnZzx6yrkFN6XnfAzjemqn7TAEQR3o+PzU/k1wV+hRzuiHX7m/pMo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8g7XLCGWZO38udZZqzQ7d+iSsKdJZ7DLTIT+Zx4OUoE=; b=l5K+pGA88BHE4mTvETw0zV6KiT
 ksHReptJIyXA6K4D1Z1xzkb+AgfydcFd8TUYUMOCVf0C/T6qz2qctcPd/baq5t83RZqmTIVxvoTfE
 kaYD9O6n+RE12X2Gjf1FIsfi4CQYvuzS25jqqCMK9BbOLKmjbgN29Iug2rZFzHJ6vcP4=;
Received: from mail.svr02.mucip.net ([83.170.6.69] helo=mailout.mucip.net)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMBbj-00000000473-2FYL for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:54:56 +0000
Received: from localhost (mail.svr02.mucip.net [127.0.0.1])
 by mailout.mucip.net (Postfix) with ESMTP id 5542C6A00;
 Wed, 28 Oct 2026 22:54:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birkenwald.de; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received; s=mailout2020; t=1793224489; bh=rM
 ngA/uy7MwbmgO6AcR31K/Wg/hdRjEQimLSRCNO+zA=; b=ng63JVpQtx0nIkgu44
 6l7lzRPCAOAfBO8XHjdY2XtaWxU36tV1w10+7+XtWeIOC1ghkGzDWbW1+58tV2rw
 HisXFmy+VqLVmBT/vLzNJ7b2pfPXvWCr1WPGl7w+DDCet7K3LQBMLbdUf5fS91ms
 ffjs46cSPY3ac3fe5Oo3TLeXqpb48GULKvfJEbYO/Jv74QDVOcdxpyYEUNuRtQxQ
 esLsxV/i4FQjpMVP5gUeDoSv43MFJH02+1hmr4OCLRvg5/IBB0F3CU3KUXobin0H
 QET2WPVG+6/9PX4v9MWshZ2sr4Pg1YCyaircl2tx1R65vkEgrH/8MehQzJn46cS8
 +uoQ==
Received: from mailout.mucip.net ([127.0.0.1])
 by localhost (mail.svr02.mucip.net [127.0.0.1]) (amavis, port 10125)
 with ESMTP id xmBq6cM1kq_o; Wed, 28 Oct 2026 22:54:49 +0100 (CET)
Received: from fliwatuet.svr02.mucip.net (fliwatuet.birkenwald.de
 [IPv6:2001:1b10:1000:0:5054:ff:fe67:68e8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature ECDSA (secp384r1) server-digest
 SHA384) (Client did not present a certificate)
 by mailout.mucip.net (Postfix) with ESMTPSA id 3092B69FE;
 Wed, 28 Oct 2026 22:54:49 +0100 (CET)
Date: Wed, 28 Oct 2026 22:54:48 +0100
From: Bernhard Schmidt <berni@birkenwald.de>
To: Antonio Quartulli <a@unstable.cc>
Message-ID: <auJvKPCANjcH5OMd@fliwatuet.svr02.mucip.net>
References: <ea6e57f3-3d91-4d3f-9c28-471dc1021bcd@birkenwald.de>
 <auJj5Ld6uMjPb2eS@fliwatuet.svr02.mucip.net>
 <60758dd9-bc8e-4cda-b62c-11aeca9230a1@unstable.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <60758dd9-bc8e-4cda-b62c-11aeca9230a1@unstable.cc>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMBbj-00000000473-2FYL
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/10/26 10:42 PM, Antonio Quartulli wrote:

> So, it seems this is a deadlock due to an OpenVPN TCP transport packet that
> is routed back into the ovpn device, thus hitting the lock that was already
> held on the TCP socket.
> 
> We just confirmed the theory locally in a VM by artificially forcing the
> above scenario.
> 
> 
> It may happen when a client with an already established tunnel attempts a
> reconnection to the same server over the existing tunnel (i.e. due to
> traffic redirection).
> 
> This scenario should lead to what you have witnessed because the server
> records the VPN IP as transport IP, thus triggering the re-injection.
> 
> But this is just speculation - you may have hit another case that triggers
> the same "re-injection" behaviour.
> 
> In any case, what triggers it is not important for fixing the bug.
> We basically lack a loop avoidance mechanism for TCP.

Indeed, that's the culprit. I missed it, but the last connect before the
lockup is coming from the address assigned to the client. 

Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: TCP connection established with [AF_INET6]2001:4ca0:4fff:2:4:1:0:1a4:56042
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: Socket flags: TCP_NODELAY=1 succeeded
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 TLS: Initial packet from [AF_INET6]2001:4ca0:4fff:2:4:1:0:1a4:56042, sid=d17693b7 c2498b66
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 VERIFY OK: depth=1, CN=VPN CA
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 VERIFY KU OK
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 Validating certificate extended key usage
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 ++ Certificate has EKU (str) TLS Web Client Authentication, expects TLS Web Client Authentication
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 VERIFY EKU OK
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 VERIFY OK: depth=0, OU=lmu-split-ov, CN=fi/XXXX/0WYZc=
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 peer info: IV_VER=2.7.8
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 peer info: IV_PLAT=mac
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 peer info: IV_TCPNL=1
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 peer info: IV_MTU=1600
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 peer info: IV_CIPHERS=AES-256-GCM:CHACHA20-POLY1305
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 peer info: IV_PROTO=8094
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 peer info: IV_LZO_STUB=1
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 peer info: IV_COMP_STUB=1
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 peer info: IV_COMP_STUBv2=1
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 TLS: move_session: dest=TM_ACTIVE src=TM_INITIAL reinit_src=1
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 TLS: tls_multi_process: initial untrusted session promoted to trusted
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 256 bits ED25519, signature: ED25519, peer temporary ke>
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 [fi/XXXX/0WYZc=] Peer Connection Initiated with [AF_INET6]2001:4ca0:4fff:2:4:1:0:1a4:56042
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: fi/XXXX/0WYZc=/tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042 DCO: attempt removing iroutes from system table
Oct 28 21:56:35 eduvpn-n14 kernel: tun0: deleting peer with id 455, reason 1
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: MULTI: new connection by client 'fi/XXXX/0WYZc=' will cause previous active sessions by this client to be dropped.  Remember to use the --duplicate-cn opti>
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: MULTI_sva: pool returned IPv4=10.208.209.164, IPv6=2001:4ca0:4fff:2:4:1:0:1a4
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: OPTIONS IMPORT: reading client specific options from: /tmp/openvpn_cc_6d3b7acca47e1ff68b8e140c830334a.tmp
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: MULTI: Learn: 10.208.209.164 -> fi/XXXX/0WYZc=/tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: MULTI: primary virtual IP for fi/XXXX/0WYZc=/tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042: 10.208.209.164
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: MULTI: Learn: 2001:4ca0:4fff:2:4:1:0:1a4 -> fi/XXXX/0WYZc=/tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042
Oct 28 21:56:35 eduvpn-n14 openvpn[1140]: MULTI: primary virtual IPv6 for fi/XXXX/0WYZc=/tcp6-server:[2001:4ca0:4fff:2:4:1:0:1a4]:56042: 2001:4ca0:4fff:2:4:1:0:1a4

Bernhard


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
