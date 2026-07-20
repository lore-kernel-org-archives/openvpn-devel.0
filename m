Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03937C44520
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 23:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZSpiIpo+hnm4bfSMTQxjWfJ6TxUIHfFp8ULlJY05bGA=; b=OWUpVh7cUmsjHi2IAWu7z2T70z
	lYQqQf3Mf2K42YqN6RapuMvJy6Vv053NmG1CKEE8gOl5Nj+mUT/r0JiS8Lf/YFD1J95gwNFTYCvRo
	ZmN3YYl6iOkYXc9ImUgDPZGuAVQjavh1i6gZYkIw8rlLTouhBhlYfy0JmyKIN6krx+IM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wlxlu-00036J-9R;
	Mon, 20 Jul 2026 23:51:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wlxlt-00036C-8J
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 23:51:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JtQISTHJguCdNg0nQh04HQHU0JBrqsm/zGHZgaa+lCw=; b=KRRSyNQ/+1bv8IbVAeiggB2DaV
 NRg5ITe7illeF+BzGVSs13De1G7EJl3IjE3Y5LOFbZ/k8UkRmqIUdRoN7D0GFAyBUDk7alMYdrG5T
 UDizINZyhfknkeuFf459IKqZYAhKiqYbGjgkvWHbKoUryMmfY4DsjHYy07qIuc9I8K2g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JtQISTHJguCdNg0nQh04HQHU0JBrqsm/zGHZgaa+lCw=; b=m
 GpUgYpZEHIts3YPHFkz2IVgY4g681GnqmiuP0I5hmKLVhp8zg9jvj953vouWsAD/s4nkSr/PVWs5l
 hBlDfnzn6zpf9iz3sIO1HcS5oXCfFEcokgPCmWWeOuqQv58ZSS0KUs4934p/mOLRlXWew6v0kG6Be
 c+4F/vWgAeLfn5w4=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wlxlp-0000V5-Qh for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 23:51:38 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f707e5d75so1223354f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 16:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784591486; x=1785196286; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JtQISTHJguCdNg0nQh04HQHU0JBrqsm/zGHZgaa+lCw=;
 b=TuAMAybHZ+jShoIdO/+5c97zToamN6D9KX4QL7wHZPoWr2yBsEZTtA6jD4L5znZhU7
 uX0d0v3+v/mOvLn/i8QV3tzOJsLhtFNgg6VCqShli6+x6/iPVRXnPh7pMmogeVZyno32
 ubnbp/Oi6MEVarKdbEj46J07e8oMk2ZzuIdkILz8IKvBbPwjSdsKFmsR+pcr4g2p8yi0
 qkT17tspefdhRTxfNDYGWE6TXY9dLj4nmUCMpotrsNCgCml8MhUgiSkjpuIoOn9M4/iX
 Xs+ooPpgXsgAP4Mrn9/LKoqL2Scg/u/MbWj9UpvTtrpkgBypJca1IbXtZx3cMeL8YfKj
 WvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784591486; x=1785196286;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JtQISTHJguCdNg0nQh04HQHU0JBrqsm/zGHZgaa+lCw=;
 b=pcBOOWcbSRVPqzT6tMFBq0vkzFttOuMzRnwgZ7mscDgo1ya9xgeb5uu/IM+0zzH13/
 fIrvoTFOompa/7sD+lPkgxWsW8De7VOHvQl+G2MMDIjWbR0DoVNg0bi3yoPkVkbkOxFw
 zoSo7NAji1Ldoj8DwYvpesRMIJniFRbPvLNdYMiFdHDB/Bzr4EfGAFcVwrVAqkVWJmsA
 NoODFqOuizDrXpeMDQtuUz4RaL2ySBYdtnJsTCt5cRMYJXjR0FJWg/JSxswxYANcne34
 SE1ivRxljyy3rSBnIcXAF7zvcpboHGZ0JtftcWUkhpv4cWkH7WTkHWr/ru0oStcdn1ga
 HfYA==
X-Gm-Message-State: AOJu0YwZ1h44XHVOQDwkIKElvFJGeNFAa0lhk3FHtv8izbZvkCAUViqP
 8cq2qNaf6kyPNhUsIwJi/Mqm3H7l4vP7xKVMf04TW0uiEB238dmKYBWTNN/yNYLsklPhfPF0QnX
 ABbAjslwFjV7Np0n1wQLAYYdRw2feBH0h94/tYClco90dxLTnLHtz91mQVmo9Oo4M1yV7d2E/Af
 NlSI9mIQ==
X-Gm-Gg: AR+sD124uyQLKm62QGGffb2Vh2rr/6+oOX6rCyu5u4QRm8TFCc8nhhmpa6NyGGIv3Fo
 dD+IA2d+eyIy2VNH3B1AF7SpSPgD+v5oW0cZQnyjqptCsJ0BS8D4VLuwaSmAZLDTxm+xBcTnDFV
 3V/7CLXbelVM1TfDhxeWoUolLhzM72z2rbNJ7OVm+LFYkEKMkv5FMmQ9cMFWutLBvBthUG/A37c
 wAPZ53tf4Nr55H+gdVyQKYo5LwOnM3hKjJrzMRL0KdgRrb0TWncM3Ru5Kxi0PSpWOzdXFhcEOJK
 Nk7FDceXjlQK/yszlu0favKtxLt60zdbq3LTAVknfnWhbHuTmJTQr27V52lk+XrxKfrm/CVEGWk
 4eNtpMshXT4T0OOZkbrFy+rmoFyoAqinWQGCfCcXcG+FmXosohJ5/mfxo9W1PoLuaL0OsGjyBbt
 Che+ujtXLRC+H3iLu0/qdwUf2ljXzfc8+rdNj9HR3leBGmmp+CBZjd8W7GjvY6jadN+3S4Bfa4w
 aZ1cbfcgyUDQJMoj46dWC5eIW9FkAup/of66MHqMzqODUlO2MuPrPpL62/Ql8RjxGSl
X-Received: by 2002:a5d:5e8f:0:b0:47f:4893:d198 with SMTP id
 ffacd0b85a97d-47f6233ef03mr21373763f8f.56.1784591486193; 
 Mon, 20 Jul 2026 16:51:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e496ffsm33386419f8f.3.2026.07.20.16.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 16:51:25 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 23:51:23 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
X-Gerrit-Change-Number: 1797
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1797?usp=email>
X-Gerrit-Commit: 3f3d4b30df229e59ffa72bd725fcc167d64284de
X-Gerrit-Comment-Date: Mon, 20 Jul 2026 23:51:23 +0000
In-Reply-To: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
References: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTg2MDY2MDAwLkk0MzRhNTM3M2Y3N2IwZjc1NzBhNmEyYWFmZTBlYWY5NzBlMmVhYmU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f47d759ea46c90c141ab635f22273bef8ba22a31-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wlxlp-0000V5-Qh
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Enable TCP_NODELAY
 by default and deprecate --tcp-nodelay
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7758286771651206668=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7758286771651206668==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7MRfJXjXzqI="; charset=UTF-8

--7MRfJXjXzqI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex=2E

plaisthos has posted commen=
ts on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
797?usp=3Demail )

Change subject: Enable TCP_NODELAY by default and deprec=
ate --tcp-nodelay
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1797?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
Gerrit-Change-Number=
: 1797
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ordex <anton=
io@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 20 Jul 2026 23:51:23 +0000
Ge=
rrit-HasComments: No
Gerrit-Has-Labels: Yes

--7MRfJXjXzqI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex=2E </p>
<p>Patch set 2:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1797?usp=3Demail">View Change</a></p><ul style=3D"list=
-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail">change 1797</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I434a5373f77b0f7570a6a=
2aafe0eaf970e2eabe7 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1797 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Jul 2026 2=
3:51:23 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></h=
tml>
--7MRfJXjXzqI=--


--===============7758286771651206668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7758286771651206668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7758286771651206668==--

