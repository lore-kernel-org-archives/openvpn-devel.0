Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34055C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NGce7bOvpKvk7wz+RmbpAuD3fxP/CWH1mLcQZ9dfYQg=; b=IrXD4u3NVocRWsNUg5O0Rl4a/+
	3gRFZyVg6yAQweI7/CrDfw4N5x4X+vVWbmevGlt0RFW2HsXVNNt4Cz2UyZsPg7IwxXSPyImRzFlbV
	TUdgvwJUGU888aIC31XDEaPUtLIFC5qw70OHSgr0YJWCCJBXzoiQSs4PqUvIAqvLab1A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wexIY-0003z2-Vj;
	Wed, 01 Jul 2026 15:56:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wexIX-0003yw-Qv
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:56:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LVWhjjHBJcax8XqXyAmog6wOXotdA/Giebka4CNe++Y=; b=bdM3RgppTtO9AbwPvvcJxbi80F
 Tz+NiQBmsoqQcQecruO9SbU8vuvMsBUQS0+Zoclm4u3CmsYTFbGJltMRJamZnesxiP/anpAknyCJd
 Tk8XN1kKtpb4g5iYXXZDBkIjO83mTSRZDn5xio1XGwNjPhbcqEaca0sqSSwSCKlmZmLI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LVWhjjHBJcax8XqXyAmog6wOXotdA/Giebka4CNe++Y=; b=l
 KMWl7NMMMqJDKD6Why3dU9He3QUcZb6mGhIVzHNINfNiTEC3jPXiWoTBOEFJ33C3RCz7sviRBU558
 bHMvF31D3DEKQeuHX9MDUKk4SWyFfWvE5qB9auoHDeNbWt1xHupmmk/9138rwZ0AwYN8z7aBRO2eD
 6OpI+wiXy1GX1YWI=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wexIW-0003K6-3C for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:56:26 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so3548945e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782921372; x=1783526172; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LVWhjjHBJcax8XqXyAmog6wOXotdA/Giebka4CNe++Y=;
 b=DCX6ECKckIqn7TpL+7J08JKXx1gARyLUe5JxqdZXomv33Z0PHEuRQd79gssYMveOPF
 02SMKl/xmLPDh7wtmYpG0CuDgQLUj41GD/BieUFdYfXlDWin7/XLjxRxFUWnE8at66MH
 DzYMQZWz1/1ipFhhJr1wOMqkPTDsu78zS7d1FV8MkwoYjC3VMZ7GD8rQwkGHjUUbD02E
 z0QlrWlPv9VT+Y5qyEiXnvofFj9vH1IkBBO9XTkA4uJ4kAjZu73DrRINDCuykapp0j1U
 xByaVgGTuy+ZZFY4/YYIblPqiq24Ix6Gr6zN0fKbhEjHa23DI6uCtdHhxeOeCvtmB8Tf
 HfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782921372; x=1783526172;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LVWhjjHBJcax8XqXyAmog6wOXotdA/Giebka4CNe++Y=;
 b=E3KoDAQsLmpxlSI29TyFl+Uz8K2VeNY7w2bBFkCikJ8+cVrvBTwTKdc1kQx2pI4vj5
 +1QkVE4Q5iX+F7XIjvole9IByRRwNscyk6tDnfYQGpwMKzI3xfs/HWszkxzUrwUKjHFD
 5mtC4WsbjO10i+RcKJxUH9R8yUzpWM1UJAad7BEQ6AL3fRfxtVZ+Dblu9CG/d8aZiTmi
 tac1YsvM9jezyCo6RrDIwMUpz+U9GakuF/mQA4Msn0kXxwgfhtPfOnz7G/kBS58Wj2bw
 4VeeAHC9RHGx6Yq34zkGPwyXGCPujyZRIL7A6W2pBlxmJ0z/+cMtXSYV0lRSjhrvR5Zo
 crCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AH+2QRfSvRNkr41dbSBffvaAQQb49o0R7lVed7Tqrl3vw7bnJx16G/o+PMgvgjS/QXV7VQXmAVyjxSF5q@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyoai2ZC6NtAOF5ULDNTcMm8B5B9BqytYY/WeOgoXmsxPT1lh5Z
 gJjWU0gyc2Q2JDuuCCOmaorMwSh0TJc9wMgiciCiyBmXJk3DbgXTMN1aBCcvN3xASo11kOi5cQF
 +j6woVBRYFmLAL0elEwSQBhwq/4hLkSZnKH7EIKxXbbsAcDocGs0cexT04BysOXAHU6u7
X-Gm-Gg: AfdE7cmrAYbvnN8b+7NFKoq2ogD02NalDPzme+H1HHf6SqiO+ye4Eec6AEUYbFfKdnf
 z/2OW085M3yN1rsz3jUCPIYhc7Ivv1aU0o3xnXz5F8jwtCs1/aMbjiLJRQcbDXcI623eXTzqC3T
 TJB+qW2K0RjJgq9xGaiRbFtTXocQ7v1rifj/nHIPcLWYAgFJ8Vtz7tvu0xUWK4/u7YFzYmo6Jko
 PMVKnTcG/g8UexMK/QFdXPQublbtF3NFyHMAmhrkztc2WGMJrt54Z5ioPl41qqaw0ZCpPDkY5ze
 JAjwJY7VgR4ElLTYQ5W4BhftxA+CC524gkV/39OcBIJarsfANBmBR45T0wATshF5jWJ1aprbP2P
 9e83F601RB3tl8CqhpfllgkvovtKKLUXwsH/YecbcLAjxuEoK+xeMtjevmy/7KMROZYf2qo47FD
 CJKdthpz09btZwSsNp+OHpkmW0PCNcOVMzBzg60Cxc1Wl+TXskLX++UOJkOTNyxMHugOKh5UgX8
 skCfQeUp4ZMclHNkNJAMaSKGdg+RRFV7w8+N0Or/GZhwBeUK1kjuwdxAjK4YzhBe6iZVRHwYLC+
 oKQ=
X-Received: by 2002:a05:600c:4e56:b0:493:b730:8d78 with SMTP id
 5b1f17b1804b1-493c2b9f22amr29533505e9.31.1782921372252; 
 Wed, 01 Jul 2026 08:56:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4d2bc5sm88455345e9.5.2026.07.01.08.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 08:56:11 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 15:56:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic8c83132a4de64f27e6453ddb90ebcf137500db2
X-Gerrit-Change-Number: 1735
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1735?usp=email>
X-Gerrit-Commit: f0a65c3eb248ff25a418ac3403cd603bd5364782
X-Gerrit-Comment-Date: Wed, 1 Jul 2026 15:56:10 +0000
In-Reply-To: <gerrit.1782545314000.Ic8c83132a4de64f27e6453ddb90ebcf137500db2@gerrit.openvpn.net>
References: <gerrit.1782545314000.Ic8c83132a4de64f27e6453ddb90ebcf137500db2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkljOGM4MzEzMmE0ZGU2NGYyN2U2NDUzZGRiOTBlYmNmMTM3NTAwZGIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <db9d78190285964d9eccff31a44ada47e18e6060-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wexIW-0003K6-3C
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: create and
 destroy Linux DCO devices with --mktun/--rmtun
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4978757504838702416=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4978757504838702416==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JVmri7w2IwI="; charset=UTF-8

--JVmri7w2IwI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

ralf_lici has posted co=
mments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1735?usp=3Demail )

Change subject: init: create and destroy Linux D=
CO devices with --mktun/--rmtun
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
> you coul=
d make the argument to mktun optional=2E [=E2=80=A6]
I see a few potential =
issues with this approach:  
`--mktun dco-p2p --mode server`,  
`--mktun dc=
o-server --mode p2p`,  
`--mktun dco-* --disable-dco`,  
`--mktun tun --dev=
 tap` (which would be the only way to create a TAP device, but it=E2=80=99s=
 not very intuitive)=2E  

All of these cases can be handled, but they woul=
d add extra edge=E2=80=91case logic in `options=2Ec`, and the resulting beh=
avior might not be very clear to users=2E

The main question is whether we =
accept that, in 2=2E8, `--mktun` will default to DCO when available=2E If y=
es, then adding new options or arguments doesn=E2=80=99t seem necessary, si=
nce the existing flags already cover the needed combinations=2E If not, I=
=E2=80=99d avoid encoding `--mode` inside `--mktun`=2E



-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Ic8c83132a4de64f27e6453ddb90ebcf137500d=
b2
Gerrit-Change-Number: 1735
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <r=
alf@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed=
, 01 Jul 2026 15:56:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
=
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Repl=
y-To: ralf_lici <ralf@mandelbit=2Ecom>

--JVmri7w2IwI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1735?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">you could make the argument to =
mktun optional=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">I see a few potential issues=
 with this approach:  <br>`--mktun dco-p2p --mode server`,  <br>`--mktun dc=
o-server --mode p2p`,  <br>`--mktun dco-* --disable-dco`,  <br>`--mktun tun=
 --dev tap` (which would be the only way to create a TAP device, but it=E2=
=80=99s not very intuitive)=2E  </p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">All of these cases can be handled, but=
 they would add extra edge=E2=80=91case logic in `options=2Ec`, and the res=
ulting behavior might not be very clear to users=2E</p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">The main question i=
s whether we accept that, in 2=2E8, `--mktun` will default to DCO when avai=
lable=2E If yes, then adding new options or arguments doesn=E2=80=99t seem =
necessary, since the existing flags already cover the needed combinations=
=2E If not, I=E2=80=99d avoid encoding `--mode` inside `--mktun`=2E</p></li=
></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1735?usp=3Demail">change 1735</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1735?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ic8c83132a4de64f27e6453ddb90ebcf137500=
db2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1735 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 01 Jul 2026 15:56:1=
0 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
=
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"dis=
play:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;r=
alf@mandelbit=2Ecom&gt; </div>

</body></html>
--JVmri7w2IwI=--


--===============4978757504838702416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4978757504838702416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4978757504838702416==--

