Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB54C9830B
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wdtacoNsxEH60/qgw3qUHsWNnjfrxLVrSduGkXwAanI=; b=Ov1pJVY+a4fKFHgbzeZ6Vrs6kc
	b8XAwldPbSI6RQ3zzYRVH6jwE/v61Z/efxMGDBIWBf0K8HqkOQUbrPvK/G2yVuiehzrSIkkwYF1Lt
	m77P9CBMLWfIlJSpfvpf9K3Y4pdnYC+Zsv031lAQP3aiOmCiFf2ZZ7rCRRIkos2E2vaw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9Txu-0007wl-Ea;
	Wed, 23 Sep 2026 20:53:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9Txt-0007wd-4m
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 20:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dkO5lDz7krqPicF5dhcdGOOEstjjYPksOq5qDoqfPng=; b=I2bcyXhNDsKzA6l52ul6+qOJof
 Vd2KoNdfewuqcrCp4n0MXM387qxa5F2tZY7BfsJAASsoQdPokwSj+Z5Dgi3y3Lt9r+BY/rwF5mmik
 q3db5uh2zy+jrWmCgYK2mUGw8RUg33A9aH7+XQDb5tP/Errmp9qyNg7iQkRFFqJdMNNI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dkO5lDz7krqPicF5dhcdGOOEstjjYPksOq5qDoqfPng=; b=R
 eVdm7A23na0zJXhFe0mlFWWWIbLS1sVij5p0WYCq8EL9uwyYvTyMeqt4n5iPolZ+3b4HCyAiPZJPE
 pS/4BFQPziGdPg/yFZYFOZnzjU3cQ2vqrqbjG7tz+bKHOljfwhSgK2e97jTd4yDhrkmIxNeU+K/h7
 NAXdYmzdOyOwOwLU=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9Txp-00020Y-0P for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 20:53:15 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so1016782f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 13:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790196786; x=1790801586; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dkO5lDz7krqPicF5dhcdGOOEstjjYPksOq5qDoqfPng=;
 b=LGnA1Zvrw2gLXwNmgFVyBMR4U0JvD63Hs3g0Gm8XvVv72klQpqTvPI6oBovDGzxVKw
 jJ1zeYtNfzmg9I8be5xvyg96H8S5qJwWu7Oh9glcE9buDgRBFZcNkO8LH9kVG7GWdfvG
 prChpmf8wIGGd9Cxr5weSfTZqGZjx1CwjSduO2A12DgocpG9jdByMjWZD6KvqGnPm9st
 08HLJLvumCPbQ9RYMGUUzM6zVsaw2laRS4vFhoz8LpLECq0eLQLVMCxmxBL5y32b/nWg
 QmFnlPyqaL5NtQq8Ylmu5xVRWQhRKlibq2WnA9tmw05pmGKsleaqmHEfOQXdMXNCgRIV
 mWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790196786; x=1790801586;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dkO5lDz7krqPicF5dhcdGOOEstjjYPksOq5qDoqfPng=;
 b=IxT9GaJ0d1iz4RiL4Z5Cug3izAZuH2g1QMSx9pXL1LwKr/qrtNJkM67IO2jbws3wHg
 /F0uVmdgNFK1H744uABam6d9SykH/b6/PRnnaAhnw4tqNsJqrvRW5aQD6SH3dwCKGybS
 cbVwC3R/vC50v19hJB1housA7MJbauChKHwieizGYcHw4UocKdKKRYVJT/JORXeVeXTb
 BU+ickfIf+Tc8/eeNJbWoeHWOGVcX4sCMPvLhnfm88DiSLfB7EKZSdZ4W76vZ/BhNJSE
 7mJOd14eLZEcCbU7M+qsI1A7mvvtZsP/6BLEVUHwTaRjVRdeUbSyCvV2YTSIbLtJ+brN
 7qJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQrzZbj8NdNNm9cS4gJyr+bh1HXS+VVmyzUItAr1f7uTZ6X99+8HFa0xOxIB7JPIQJheWmnh9sfNvO11QI@lists.sourceforge.net
X-Gm-Message-State: AFuF++kos2LPi6xEg1HrwCVngAdrpeh99w4HCgiV87CcFiDowtDhTkkF
 T/uvmxJlZTmpgJIlwUPfqAg9qLEVZlMKclCbthZifpSJ2gJIAklGvJmLhVw8B7BuEBCmyWm3Fp1
 7IfQgsdrpVN2n/D9+vjFo4ow5o0o2kTDLhb6X+R4xNqd1sPD3fh7Vcf0p0Hno09FjwP27dlA0Fy
 jGN7ndjg==
X-Gm-Gg: AYBFou09C+XoBDPf34//dIfxiYykGFgsUFuyZa72EaGqChl2ct9+40uuQ+WPzzzd+Kj
 a7QZs1T4/8Q+BG3v+aRaRsGUp69rGZ4pTdhAOeteq6v1MiazANwudNgkaNb9ljtaN497DbuVSFy
 ybL6PaAWp+vs8LMH+xS/kKzFpPt9nkLR+14ABWRMjzRln4b9JHyNA5ot4RYpQ71m1k2gQ2AbUCG
 0a+7Udc20G734woGnzOIKfktqjgs4JauGfU2c1yNZmTDuGs9/mqXdBuuXFQAAuovYk/fyu3r9Jn
 /2FrMI4ccRPlon9k+OuovCAdoXKS3GzN5FNfH4zHZpmRfWt66J+47w+EXkSZZHY722nf1x5repD
 rYFkh4MVhBP/eiCbxWfECsHgJYZ6FQjCU9PT7And9EL7t39dEeHGnXxpHG07vhm4UXGrOF5jXPQ
 LRmvaWLWVd4eOFLMRX892Ydoc/XW8crdkNAOqOsG7bvj9K+aeWSwtEm+PrxH/sdgVO4No08kmYw
 Qr0sqlcGPK1U8WeyRdU58W9bSYI36abWNbEIZB2iNAKreW7q7ugqh+G6Ss/+Jwj4Nx6b7ID0aIT
 3f1r1rV/NKLv9D1FBvq0YK2O9AQqtTntNGW0s9Td5GcVEjf+tb0GMUZcfS8i
X-Received: by 2002:a05:600c:4e86:b0:49f:bc0d:2e9 with SMTP id
 5b1f17b1804b1-49fe668419dmr6917095e9.0.1790196786268; 
 Wed, 23 Sep 2026 13:53:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd3d5csm12627975e9.14.2026.09.23.13.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:53:05 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 20:53:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
X-Gerrit-Change-Number: 890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/890?usp=email>
X-Gerrit-Commit: e064870a823d64266e703fb724cb088f366f593f
X-Gerrit-Comment-Date: Wed, 23 Sep 2026 20:53:03 +0000
In-Reply-To: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzM5MzYxMjA0MDAwLkkyMmU0YjczZTc0NGM3NjVhNDNiZGIyOWY2ZTE4ODEzZDEwM2VhNzU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <66948821efa2c2bf508fb8c44105394fa760f196-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9Txp-00020Y-0P
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Always use a
 0.0.0.0/0 default on Android instead of def1
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8399591101815072755=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8399591101815072755==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GzhMBLvFmkM="; charset=UTF-8

--GzhMBLvFmkM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos=2E

ra=
zvanc has posted comments on this change by plaisthos=2E ( http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/890?usp=3Demail )

Change subject: Always use a 0=
=2E0=2E0=2E0/0 default on Android instead of def1
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: -Code-Review

(1 commen=
t)

Patchset:

PS3: 
> Yeah, my client has shipped with this patch or a var=
iation of that (the older version used to ignore [=E2=80=A6]
Fair enough, I=
 will withdraw my -1 and you guys can +2 and merge as you see fit=2E



-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6=
e18813d103ea757
Gerrit-Change-Number: 890
Gerrit-PatchSet: 3
Gerrit-Owner: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=
=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-A=
ttention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, =
23 Sep 2026 20:53:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
C=
omment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>
Comment-In-Reply-To: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: cron2 <gert@green=
ie=2Emuc=2Ede>

--GzhMBLvFmkM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos=2E </p>
<p>razvanc has=
 posted comments on this change by plaisthos=2E</p><p>Patch set 3:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #ddd;">-Code-Review</span></p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?tab=3Dcomments=
&amp;usp=3Demail">Patch Set #3:</a> </p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Yeah, my client has shi=
pped with this patch or a variation of that (the older version used to igno=
re [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Fair enough, I will withdraw my -1 and you =
guys can +2 and merge as you see fit=2E</p></li></ul></li></ul><p>To view, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail"=
>change 890</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>
=

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 890 </div>
<div style=3D"display:none"> Gerri=
t-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>
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
 Gerrit-Comment-Date: Wed, 23 Sep 2026 20:53:03 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>

</body></html>
--GzhMBLvFmkM=--


--===============8399591101815072755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8399591101815072755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8399591101815072755==--

