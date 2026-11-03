Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635CE606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CrGJBbGH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dvyInnxO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ti3XvZh6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JIp99Dzz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P2hnLAWkIL5gD7/yB3WEGu8aL5+Jx1ETlxYM8JOpvCg=; b=CrGJBbGHZjW9XixcWxNNl4F/4l
	vNeP+OPjQ3pwWfAGcOtRoVQFGyzDUMxKYcU690wp1j5znQrzd9QFlBMMb/X8lAkpooWVtamt6+loV
	34bxp+gwjWaeG4PwgQPPFKJqvNpN1MxKlC0KhyYV8UbE7F3JlrgBP5g84KrxHoueCFD0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOFGX-000000005jK-1yHu;
	Tue, 03 Nov 2026 14:13:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOFGW-000000005jD-1P9d
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 14:13:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BjqeM2DmYPjya4IbKgIWVmjamBnND8kjg71q7h9y3GQ=; b=dvyInnxOactOpfXUhLjUcud35B
 J54vDEuIzPsgoU6HwhDnjPbpapaNLEbULiSUMYmcTOEc341x17TWIAx8+RuAQN1sf5UniJFKuRWPX
 6bLg3urY3LserSq/tZvOSVVjVf0MIXinSIrVhM1ADZ4TYGs7Nmzudw2/jLo5VYsK4CPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BjqeM2DmYPjya4IbKgIWVmjamBnND8kjg71q7h9y3GQ=; b=Ti3XvZh6c3d1oJZ6FC+rtzKl5B
 IRUCQDlJv9dIzeIxe2fm5aYEkd80sPPErCVttaBccH6gv3In9ETgn+YwsF0GXcSOKUenB5GBtMHid
 j/Lh+gbL7ZekptkpJMLYlcV8LCbreX9lLKmT0VCkUjIJ9VkgwH/c+5I04HQMYisMEfO8=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOFGU-000000006CJ-38YR for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 14:13:32 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso2010986f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 06:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793715204; x=1794320004; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BjqeM2DmYPjya4IbKgIWVmjamBnND8kjg71q7h9y3GQ=;
 b=JIp99DzzR+mOkcCmArXscpYVvSsLCjLmPWuro8DBDZkTfd78dYMNqsuMIE4gSwUafY
 g8huPZlhYmXAELrRQoo4Y3baoH3UzoY+Jv04G6zyVdscARLtPVrTw+sBewkO6LyW0MTb
 WdR7l6qOAE82JflE71c4mXxnqZ5RiUR5m9am5oIZ4jrgBOEY3TqiNCzTag7VvjqbyCeL
 u2xrd9IkkM2pyPYN8r9yQRZAnrOn1isHAbQemYIXjsSql36kKxZ9J0oCPYN4bb7+TJ59
 hheVVSldv12IOG2kHhcJf/3WHbyPaZO0/7/uM0j9mMWWVJeELBrYnC9IpfS6xumFfk15
 oycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793715204; x=1794320004;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BjqeM2DmYPjya4IbKgIWVmjamBnND8kjg71q7h9y3GQ=;
 b=pAM55BahCfpQ0kUaJLjQN7WIam8xU0p0gYvj/8uKxR7mhsQQ25UXDZPGh8SH5k5CpJ
 HDMgW81jWklKiY03X8tB4LNQQfOp8D9f1XOSDP2LhvRBoKV8vhVtaWpuK0jhdi3wKw+J
 yLg9n70FP2bB5nQdiaxt7Z0pwZzf3XFRxNwyha4dvLl0amBVAHub3v2lRVps/vOZE/QC
 tP3wBuPtb5gsXsTtgAeKzpcLFbhpGrU0AfhI1sXEU2pZ0tSi0NICyckRBdAIrisU4Sax
 +S4kpEF35+fV49aloujMPPKDsL4hEfZndNECMieNLj8QtlBZ/xvMHJDcxHabvvp/VoX+
 qpXw==
X-Gm-Message-State: APuU4Z9MwaGjqB244GdabLjqXItj9CQKpsqD4Tc6P0XB9pnuXVxgovnu
 2FQOcabJW/WcTtD8H43+9CQKNSF2lXSpTxOtPDF7345uY9kTVcIbfl9w+XDuVUmfF3KSKIg6Mib
 B9Z6qrK7u/V682Mo1FIyqo9pVlbf26bQOGlsLcGSRNmRRFt7jHruTBvtGa3Pp57Yns+x0
X-Gm-Gg: AYBFou3yRM7S7DUH4fKNR2cBtfukup6mxnuU1EGMjNsjNzyWcASwXfESabJigp12I/W
 +Nw8GJzDtDWzZojDd7RCG2AqiVXcZJbAHSiklKZdhT3U3OAmz1rCb3nq16Reyf1M4f/odBJ605h
 m/bWepWrKaGQEltJiiPG75VnwG+hdEn2LY56SRek1v0gLUUwVzByf4GHJH52QdoMurGeLV3yqsL
 ySv9tspl87zX8ZvwrdIO+bczKLrMXfUFHPq13FdGkdGawEQWHvfkrA1wt6963MQB0Irks40xBTU
 cET/VFFi3lXscgfkL21pskjfra+imJLfDplRNeTf+D7C49qz46nbwONfwVVlIpHVQnzNHQNaDX0
 WYTZMDhscmlFRbzX9ySRnMU36+i8HGWInJafhAWuSUXe3cpVeiDn2AY/l1KWpAC8l37DhzG3sGR
 izt9HCORo5VFFCZtR+dlM9RmzipxvZKyjc2FLSirxxXiZ+M6xrk4F6L8JWQNSNSJiNQNMo75sT0
 8896MkGhm07UfzZXReMPr2SifBf/MI3yVDrt+6o/6RetpItsdZbwxcZjPn//31wrCikYZZ5WiPg
 Is+K1Y7pCAN+gVWnhQvwoCRNLNkj02LYitxZmbpZELag1sjKyVi2P9jtikfjLRi5wQvS63vyX7F
 xZYewTFrGefGsJkIXuXyGcRWPzMF231ZjiEowValeZ1z0qD9OApPDqNlU5Bt4wCm0WrjHjjSR89
 E2+D6nNoG/sMy+Pg==
X-Received: by 2002:a05:6000:178f:b0:48e:5ea1:25c3 with SMTP id
 ffacd0b85a97d-48e6e2bf21amr28867150f8f.1.1793715203920; 
 Tue, 03 Nov 2026 06:13:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b789ecsm24411410f8f.29.2026.11.03.06.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:13:23 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 14:13:21 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I36430bab897e5fe9b1cfd48de50224395d56d8fc
X-Gerrit-Change-Number: 2107
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2107?usp=email>
X-Gerrit-Commit: 97b46b03aedaa8ebd563c76bc47a2f49daae61d5
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 14:13:21 +0000
In-Reply-To: <gerrit.1793709839000.I36430bab897e5fe9b1cfd48de50224395d56d8fc@gerrit.openvpn.net>
References: <gerrit.1793709839000.I36430bab897e5fe9b1cfd48de50224395d56d8fc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkkzNjQzMGJhYjg5N2U1ZmU5YjFjZmQ0OGRlNTAyMjQzOTVkNTZkOGZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a26fe4626846c03c97f341b0df812d3011648014-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOFGU-000000006CJ-38YR
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Provide minimal
 netlink defines for cppcheck on FreeBSD and macOS
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2587151007754282026=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2587151007754282026==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TAGZJexdFfU="; charset=UTF-8

--TAGZJexdFfU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2107?usp=3Demail )

Change subject: Provide minimal n=
etlink defines for cppcheck on FreeBSD and macOS
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2107?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I36430bab897e5fe9b1cfd48de5=
0224395d56d8fc
Gerrit-Change-Number: 2107
Gerrit-PatchSet: 1
Gerrit-Owner: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Tue, 03 Nov 2026 14:13:21 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--TAGZJexdFfU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2107?usp=3Demail">View Change</a></p><ul st=
yle=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2107?usp=3Demail">change 2107</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2107?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I36430=
bab897e5fe9b1cfd48de50224395d56d8fc </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2107 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Tue, 03 Nov 2026 14:13:21 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>

</body></html>
--TAGZJexdFfU=--


--===============2587151007754282026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2587151007754282026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2587151007754282026==--

