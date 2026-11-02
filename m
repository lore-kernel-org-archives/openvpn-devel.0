Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D060AC6D6
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=k5aYewXEMsmXyvVe9Petr5b8PLTIAwsjD8CpDhzheFI=; b=mjMc/Cu0DCSpYDqskxEEiSpm7s
	UKcqPtymVfDbx9LUAJN/67OHBdj/OtHK6eBqL0q7yV8eBz6PGtnoFiC7/6NBBVy5tMgq5c33FwYJQ
	MDyCJqyynLjTCrEfaYIxsrUmOru3VLp5PUk/AaXqliJHzvasSdXpvfPgyc7OyGY02V9M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNuNA-000000007wm-3EfG;
	Mon, 02 Nov 2026 15:55:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNuN9-000000007we-1Uuc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 15:54:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C71e5uVUWmQMDTZXlJjQnzQ8MxOjkc4TQAleLOQr+Z4=; b=nT7RIHMoYH2yU8ygM6LmCetW6N
 vj4ZsFg91Q+e4E63N8Q25BMTWpioc+CPv7onVngXJgb8Ma4mbtIEZ0pZ5uCqp2u7Dh8XccARZC+Hl
 mJHxQxIFlrfe1lqVfwFiw7MAyTNuvNCpaVTvm3Wt6WBuwuCYmwwH0SrVZarSdxOq43Mk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C71e5uVUWmQMDTZXlJjQnzQ8MxOjkc4TQAleLOQr+Z4=; b=QEqEH+Bi6CWfsc4fFNDEDvEOrp
 JbxyMVJBTkNRRJV5xMU8jQrkGagFjUjDkDUVhux1DaG6emDfEwi2AGAxP1fMhy5bohXuiPcLEjP60
 BYohNww8iKYoaI3+9A/gVAb3W8x8Aek5hG/pv68ABTJf0XqWn8o3Fk4MJD0IuOZj2UPE=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNuN8-000000004AQ-2zQT for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 15:54:59 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso2232440f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 07:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793634892; x=1794239692; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C71e5uVUWmQMDTZXlJjQnzQ8MxOjkc4TQAleLOQr+Z4=;
 b=J4locGPq2UvpkvNExfmoRv3zpzv20AveEuCFA2aeH0Xh1jfb5If9UYZ/m7ek3fz8RI
 YrjnDncSe5mhIHxYS/dFw6joDjZsScHK7gvw8+lxsUJ29zYsuA2sTBb/y5qMak9EU2CX
 b4OrFQG2qZAVSaFPKMKKbf5R+V4/M6Mvy4hPRIc8EVr+a6eObgaaUyzF/1Zvb0btMzsm
 pqKol1f6NNxMuY0OKgB2xo44b1yiG2UWX7quQ04BdGhbU3c9xlzggN/qwTgMHpvMEEXY
 JZ8eqcr4am04PERLsEfV3ydA8vTcFsGv7mKN2smcMO6fr4OaaLZg44gfti7SpQ3I5NLL
 Isjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793634892; x=1794239692;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=C71e5uVUWmQMDTZXlJjQnzQ8MxOjkc4TQAleLOQr+Z4=;
 b=tYCDvy7luZSgzxQ4pVqsqaaCtiilExUjGkEly7e+bBwzHHSnQSvzsBDUgIHYL/XvUL
 6Slg6tf/Yb6/P7zCNZtH0QzAymxV5X7a/eWn87Dd911Lf+ssnjrq+Y921JjpTCYuYeuX
 e8EcR2PLRxAZ5iLDaEnYjVQCIGilpv1+4vFnq8vOYWMDlQuqDHw38BJ3pfnIuXuJOlJS
 Nb+/2huXjBXu0M22KHebVkxhwgCYUZgA9TwOR3/ODcG2aMlRLm6WtUVdLqTHQ8leLhj1
 zTbScT9IiemjRMiDm742Wrac7IA/g5m2iDUdVooRTv9mYOBHCMLQNA3dtQWUM8GE+3S8
 x00Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByb9raMRNOlNIspH4gCYFwBOuckez3lccQ7pdTnkjf36l1kddyE20wOwbCjdbiKhA2G5x0l597j0qY8KwtH@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9bJLP1X6vAPq2BQV1icWQjIORAVn1vCec/VrUY8teem/OOeAYw
 GNKlH24vnqYkypzlstyp27oSAq1y6OwKuz9AFcjqP9SJnZebqXaXD46FLd8mkNOuJkCZ4drN3zl
 shQ/sExW8YS441nhNhNhRH3EtOr0zdQi0cKWBuzoibrM5C14247O9Y/Y2HQ8vvQq836zY
X-Gm-Gg: AYBFou0U6Z1M8ABo0L6b2Y3CnfgeUe6e67Yel9I2P43HUb97UmC3AiICVSGZVMDaltl
 ACD3z0VljXA9CSi3OjMsAysocPz7dM3mX7upZ+ckHAcd58aPgxpMpRxQXgpB7HsBBHVqaUHnUuZ
 Va93NVcVVqLmJMy2xuGCMqM3ySB7OMIBJIQjy+HpHP5LYbs8QxjrDBYIIUVQRju2avDCT5zdVar
 Wbb7HhvW2scSs3q+Lg0uYHelfy7UGQXZ8M0bVwrINDfeU4XF4qk5Hh3JGxF3e0W9HYaqk4PI0Eq
 F9PWsiizGbxUUZ5zfoFgxyDlyk21Get+fRrfTQ1ROozDZnRbhB/F6qvMXgsR/BiPX2NZXR/sFQn
 VPDWIiPiz1GqhXiahTpxlny1jPBf4AzKTBwCf6P2mDihxK7lJPKv7/bdUGg7Z/aMBHFYtRV2uqp
 1WDE2ipFu4+FaKrEAGzR71sGGmFzuR9CZ4Ce45HTk7F+fC7FYDd4MDYlkFsRXN9+057plUNevrO
 TxPa1beTk+d6K2dTnbn7LPh17sRB5GO+MAdU5+2RGpfL6owRXEEBRM3QgByRk7nD1tDIw7+yjO+
 HGBwyjLqPUpEGEbl7Uqq1B9picpgEwCGv7MDx10QGbIxmFB/c/p+4nBxlP//777YE5vBOn9T4yD
 qLFRpYwYmVk5c3EeNzI6Y1cAbjEc72+kJSX2k4ngb22GE8seDU+fag52+cBcZgHRhWgzEjggyo2
 lNFv9j84tOxtgZVQ==
X-Received: by 2002:a05:6000:2488:b0:487:27f9:840 with SMTP id
 ffacd0b85a97d-48e6e50d953mr23187265f8f.53.1793634891925; 
 Mon, 02 Nov 2026 07:54:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba53d7sm26429447f8f.53.2026.11.02.07.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 07:54:51 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 15:54:48 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
X-Gerrit-Change-Number: 2085
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2085?usp=email>
X-Gerrit-Commit: 259326663c8fff86a5680687883f5577ee396aed
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 15:54:48 +0000
In-Reply-To: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
References: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MDcwMDAwLkliOTE2NGUxYzhmNWUwMmEyMjUzYmJiM2IyMzYzYTRmOWYzMWM4YmRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <42fb6fc8d375fdf76d0bb1357a7023e0cf341b6f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNuN8-000000004AQ-2zQT
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: check
 parameters for NULL before strlen() in send_cc_message
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6397875144136030460=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6397875144136030460==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ntj/UTKtA78="; charset=UTF-8

--ntj/UTKtA78=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail )

Cha=
nge subject: init: check parameters for NULL before strlen() in send_cc_mes=
sage
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 3: Code-Review-1


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2085?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
Gerrit-Change-Number: 2085
Ger=
rit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 15:54:48 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--ntj/UTKtA78=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?=
usp=3Demail">change 2085</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2085?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2085 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 15:54:48 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ntj/UTKtA78=--


--===============6397875144136030460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6397875144136030460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6397875144136030460==--

