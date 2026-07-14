Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346DFC43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H6Sn9va8BllNu257m2p1QTjBlXelUuzOF7eaAZwIlb0=; b=CGH/fOH+YqP9S+ZbK8wvs2D2yL
	0t+YqG6VXsSn7EToD912B9luFepOXbl+i7V70krv6D7INvw+NgbNdnJ9ji1FpEzSY5OnhSrCMvO7T
	yukjBlKcx38NbduxVm8DOOy+BWzT9PecEesciF9IQABkgoHD+WteFAeSoGNeiAj9F1Ds=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjYJ0-00017F-Fd;
	Tue, 14 Jul 2026 08:15:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjYIs-00014W-BX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 08:15:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NL4XgR3dLSsmnTFu/Eo9SAuXroSMWT51CeSDog5SnK4=; b=j2Gs0icn6yudILeMIfD39jx3uP
 Rhh8BS9edUZ96t96xt8qnmrQVAND9IoUQQ7rYlUlHOrxN89FQxkSX6fg4CdMK7yV5UyyGhOwBNHHM
 87sq3wlt23T2a+avTXYJNZI4O4oPlNTkm5AUWBGT9sGmaR9qGSzTmUGuYIvRZgreL+Hc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NL4XgR3dLSsmnTFu/Eo9SAuXroSMWT51CeSDog5SnK4=; b=P
 XI0x3o5gxOTp8QbfGfVpF+r15ZzM2YL6OvtJN8lGGRJ8jpG7WeebPUro86Bxsvnm4jI4JXcXKwcVv
 Yibn6EN1lVrice3kxRkk6pGuXQ/G50L3oGIn4Kj4zpQyBOb6IGscbEKt7ha8vSVK8PZsYny1vSE1j
 Vsk1ro8auoeUrxZQ=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjYIo-0002kY-Bc for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 08:15:43 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso2677701f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 01:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784016931; x=1784621731; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NL4XgR3dLSsmnTFu/Eo9SAuXroSMWT51CeSDog5SnK4=;
 b=CO5vQBO3oOvXDa6i1RGs6YMZHcclJrxqCsFfzm+PT4DdnUyrAg1JDQmb3zfI5MC4Df
 fuijAGlh6groVrfuRcnpRdGFQ54MSbVTA8o4072xvA2Rwf4jkBotKwo9pRzsBoypLZEq
 uyDpFReo/pmKaP9Ry5XtBu/zLL7odVe43ck0DCeSw1x6AE2zZTxCzvWREY2Y7+0cygF8
 vvQ61dHqEisKuqOVgR3UDbqwmH3L486XpfQezUkGc0kKGGVB8IavtM2+pTeu0QK0DCEi
 kwd15fOxzMRThrHJhS7ztvP0kf868ZsfG6jeBwluDFCYtbU/LnR9RGJH6liHdc2HQUgF
 zobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784016931; x=1784621731;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NL4XgR3dLSsmnTFu/Eo9SAuXroSMWT51CeSDog5SnK4=;
 b=PkAFuvyDuWnSXvWdlAdZRII7BpdZvkSoUyMDZUukhq0cXBElm2ZqMLb+9I1b+g2zHM
 PlRdwpOJMICfwB8fIJm00BVDtKtGKgTyiPc74q9TziF44J9QwRa/AchjOiYftLIYAJyx
 qSjucZbPHq4269b7yT4Ou7jPgfQFlODxzt3dROICUzy1DVQYzSODmsj/jCFqkHl33KsZ
 7nSdUKiKEp6A6s13LqaYYghgMBFqIK9RkkryqU0aUN+jXsaBGsGMcBk8gQMpmLblmpKB
 GW5gOYDWaRKsZyv+/e7y+2NddpPOIVbcZb0EJeBmyN5TRiEcGhGdLCZA8kyVUDFr6Uyw
 tIPg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoACYWftWbFu9GGQrEHE5M9DTTdxgFY5IRm2J2XDuPdYivUR+k39rSNQqKYAdONkhJW8zWXwXJL0cA610Ie@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz9z9PvxU0LWJL03GNhoC9O00hMqyMsOlGfCIRkXI3a5OjvdZ0C
 +TwvP7by3k7wIvovfP7sJoI3YpO1nEe0ivL7taNps3UxVRP+NPOJrCfmYkQsq24R/bHuT78eWho
 ycXoldOk/PMcqx+DK3V1le2eREu1Wt2ngRSde+dhvvKWPcleGM1a7iF5/029cssPg/qeS
X-Gm-Gg: AfdE7cn5hCgxPqDoIXAoApLdQgeeitpnOJAC7bxEkjsc9jDWspKpoVyjr6F5998Lu/f
 nPZxfSNttkLn/fSniy1QpM9uN2yGvuFvSzUXUi6Jm2J3JT15pRnXTg73hODlQ+fPpOiAyCBDuRC
 YUs2HYqFKELODnebIJOiOGUIWCF0rj7dnPZHJ2aUU7gstZPszpDXDx15JxSqIWFjlh61mL5tADm
 3KvAgne/r/K2LmeZsd3lucWUhHHuOejciE42MBcDEhuPVd4nwhmOZLytn0ge8GHiBCJRmf2ihPx
 7lKwNoVwdSxf4RpViTVHNbuR8lYRpfCk5EqOLXGLcA5QjjIjgxoultuFRfkhA5vNa+IUWl7oSgj
 0wd+R2cBio0BDK76ZddBcb7IwEDg7AzE7ndoqg5SMiKrwAhk4dkSTBus0Mh7Q+G656eXPRy0MP8
 mW4tCMECUgZx3qBDGlPMd7KWHQ45gIOsmnnX4SHVcOY1tFGNO+xrWA0AMVHLB/8ZSe0DffAeH5Q
 Z/H61Qzf97OqWP3gkVZHcSnW+2TqZuf1c95NBdwTjdWrILXrdVqc7+Epfsyea5FZpuqlGTtelIZ
 juzwJeqZX72WAA==
X-Received: by 2002:a05:600c:1d0a:b0:493:c389:d43c with SMTP id
 5b1f17b1804b1-4951831b33bmr29732315e9.34.1784016930736; 
 Tue, 14 Jul 2026 01:15:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2f9402sm61926075e9.13.2026.07.14.01.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 01:15:30 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 08:15:28 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
X-Gerrit-Change-Number: 1740
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1740?usp=email>
X-Gerrit-Commit: 837260c57e6dee5b2eb106534d12f05f3e7dbbc0
X-Gerrit-Comment-Date: Tue, 14 Jul 2026 08:15:28 +0000
In-Reply-To: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNjc3ZjQzZmMzZWIwMDUyZjhlODBkOWE3ZjA5OGQzNGFkMDNkZmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <57522a1085f21eb9997f317ab6f899b75eb4c23a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjYIo-0002kY-Bc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Add
 buf_read_u64() and buf_write_u64()
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4057127011112067724=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4057127011112067724==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D/1UcUgFhUU="; charset=UTF-8

--D/1UcUgFhUU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos=2E

st=
ipa has posted comments on this change by stipa=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1740?usp=3Demail )

Change subject: buffer: Add buf_rea=
d_u64() and buf_write_u64()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Patchset:

PS2: 
> The code is=
 probably good, but the commit message does not make sense - it talks about=
 "no portable  [=E2=80=A6]
Yeah that's an old message from pre-htonll=2E Fi=
xed=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic677f43fc3e=
b0052f8e80d9a7f098d34ad03dfe1
Gerrit-Change-Number: 1740
Gerrit-PatchSet: 2=

Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: cron2 <gert@g=
reenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comm=
ent-Date: Tue, 14 Jul 2026 08:15:28 +0000
Gerrit-HasComments: Yes
Gerrit-Ha=
s-Labels: No
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>

--D/1UcUgFhUU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos=2E </p>
<p><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail">View Change</a>=
</p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?=
tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The code=
 is probably good, but the commit message does not make sense - it talks ab=
out &quot;no portable  [=E2=80=A6]</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Yeah that&#39;s an old =
message from pre-htonll=2E Fixed=2E</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail">ch=
ange 1740</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1740 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Tue, 14 Jul 2026 08:15:28 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-=
To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--D/1UcUgFhUU=--


--===============4057127011112067724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4057127011112067724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4057127011112067724==--

