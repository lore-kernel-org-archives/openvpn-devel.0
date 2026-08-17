Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60512C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=durbClGoXF3a/iEBEPW9Fq1bcbSAgMrL4fQRSfTKhEk=; b=ZajqLlUPO6xU6Sz1rB4dLn9/rL
	ibTqqFantqFABhiSAX/uB1Y/m84rY0ic/W1jIPUcGCfFYzEBRxOnLRdxKelgK8a9UMmN1Fgj59F7b
	J/Eb7Eg3ZB+Lh8RxwVOivK3Kz7/RZANwBuQ0mlDytkC+qxYOVJn3qIsmSYhZ0N7pngUY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvyGw-0004lG-2S;
	Mon, 17 Aug 2026 14:25:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvyGv-0004l7-0A
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:25:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+RteVihy8d9A+o0obMBWozM8nnSvIFuGBzmdmrqQ/d4=; b=l1fTqTLL9jdz2hl86VqX3H0yD6
 JJ4mNq+Hc9F3MRaVUAEcD+6/rGcNhc6P3PVXqmoWYDU4zY/dUVqWPnccKAQnL9XQ+5h1+kPpkJBBn
 m36df8r+sgftI3a4RoJR4QQfU7fj+XPapZ10Zi0MkeRpFqx0OzGPZ3avomwJHVf3Etdg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+RteVihy8d9A+o0obMBWozM8nnSvIFuGBzmdmrqQ/d4=; b=f
 Neuxxkrz2yhtdhLVeWBb/AX6SxctM/emTyf+zIRYDhFMYMsKrWy9JoSPwLoYPh2WnBNoWiLGhwE9T
 rdePiFuxpFux5qPxIjsXvwU4w8VErXi25LPU6t+vWTxkGj6Dhk3vhWtC26o28uoU5EKdYeGCYNhxS
 sbc0mpSuziA0oj3g=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvyGx-00008f-39 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:25:04 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4813ea321cdso2947075f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786976697; x=1787581497; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+RteVihy8d9A+o0obMBWozM8nnSvIFuGBzmdmrqQ/d4=;
 b=XCfH17k8ntQbnrufeYLJEUYXwttoRjJJgexTHR12YTowRi1DknKFvq4xnbf/BhH8o5
 XYlThysP+vQxhKYb/jPHeXYl6irtNFhnhoGk/EBKWJplrvOrteHdMYtaXXou6vjIJ9OD
 lE/H9AI8egO1xj0VnzzA4o1AqiTv3UYp8MI5c9iHXpdPABFN/Fv4cAg75K6zWdqPrgzC
 2CA4nGfFwe+2Pi65cZgWWbahXjWw/9Yqi39PA2rDz8u5BXkIMZFJ1y1NNJTtcQVN5Uti
 hNGqOJhFjyhrYcqm5Gd3wjb3t/2sqq+Dd/Jq99FJ9D+hLXSwPRIMUri6IQmLE52imO4+
 GHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976697; x=1787581497;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+RteVihy8d9A+o0obMBWozM8nnSvIFuGBzmdmrqQ/d4=;
 b=fQUJbZB9/F1YjQlQUecr91ZDReWvYXPW3A5bLG0yWNaYweZjX/MXtd0myCFxcV5Cp5
 U++V5wrT84mUf7Rl3XzkLeZsYndgcH8aI+Otl/HqbCle8qIECn4WUAORaojqGHMMr66X
 W12EZD7daw0aHzF44746/+s7orziDe2Ir7aQjK9MnSNZyJ4iKYfICdNdlLIsjcbyZHJc
 McFitcf7nbJIVhueEbZkq0FeSaiRH+8rVq49LSjwdv78n1pKsZkdrOtVG6uS+uJa7iYp
 lukYeknOPKm90rZUDgYouZJE4QCX4YtjBsNN3g7tNYm5mbaMTjCVhHU5Y4J+BJdRTbcA
 G6XA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVyt+1DDtCP/Sg7g9k9CUTybagE7UGIO/i6UrBpB86s3t/1/J0DZib9qz6LBqYmfiiyoU1zM75ikOyFS2y@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzII/dDHlyIaI0jskOzZXN1aOvn0k0aaD6ZVJhIzfIv7adMVCyj
 E/PGai6YHpNdI6mMyEfo5PP6IWpWBg9lJ0BXCNC0utj5EX0C1chUymTGZpTezVKJLx/lWaCzomL
 oPsLXTXKTGvch3p2OXah2VXrgqYhF3Encf+77rN+VBHGT790NaNwUTGKoS9L1lDLDS9kg
X-Gm-Gg: AR+sD138Awvnzfw6ckf0YNsx9vKRG/lKqfaAkbUiAH6FQ2QtBgWiPbR+JNuU42fVg4o
 +j6V9oClMGIWGkXDUxVVGj1Lly7biCux4WqEHAqBFnLOFURnCXoPFXV3nEhE8U1aVvnjKmWu048
 P0kdnBxklV+GwugQ5ptXjpNNBDnxTCvPHl0hAD7FnAwzKcDR0Sxpxwhnj7zoqnSyM6fJ9kc2Iri
 JYaPAZ/gJoUpmheFz5lFt9m+TgoA7/o1+nwMEAuRTwwPegzimif4KnpdtNuy0nk/rFMN8Gc3lFw
 8PAOTNK81H72H6nBcwoOAqq1aF0TbetxUPvOdKdSa1TIi9doG2UTOZdieUB7Nz1V+38+nri5GLj
 zryomv7d3W5VI/h9vfATO1jZHhC4sJYkwz0IjG1GXyrgCE66y7Yng5fL8pj1FLrOS8pEi1GV6lM
 46CLwg5ilon+tMkZQaYr0o+w7/Zw0TIHx/sDeisn54MnBQo4BP5BdFuaukc/ZRWHxSsdnIinSur
 XLM1Ks3IzlCf9begktZAro45FMdzZuyoFNTqC/6HJKzMiwEBF4/CWHJbEXiwy5sdLLPtXdB3f2l
 bE2GNve/0+CqwP65b6z9YPVNVRyCK9OHFX92kXOH58LF52vSbl4=
X-Received: by 2002:a05:6000:4108:b0:47f:8b0f:7172 with SMTP id
 ffacd0b85a97d-4815a4f9996mr45333829f8f.6.1786976696709; 
 Mon, 17 Aug 2026 07:24:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b77f41sm4108110f8f.27.2026.08.17.07.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:24:56 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 14:24:53 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
X-Gerrit-Change-Number: 1776
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1776?usp=email>
X-Gerrit-Commit: eb5de4531a82503632d5090558a5844c2fa41ac5
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 14:24:53 +0000
In-Reply-To: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
References: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjEzMzg0MDAwLkliMTIzYjdiZjU4MzE3YTFiZTVhZjFhMWQ0NWRlY2I4ZjMxZjJlYzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ab7eb0b61c2d76038bde9e0efa7dbc20484f5082-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvyGx-00008f-39
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Start a new document
 CODE_CHECKLIST
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1887577799592098580=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1887577799592098580==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NJ/Lrq+Ltf8="; charset=UTF-8

--NJ/Lrq+Ltf8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, razvanc=2E

fli=
chtenheld has posted comments on this change by flichtenheld=2E ( http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail )

Change subject: Start =
a new document CODE_CHECKLIST
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

Patchset:

PS2: 
> JFTR, amusi=
ngly Sashiko (the kernel AI review bot) picked up this patch and performed =
a review=2E [=E2=80=A6]
Thanks, applied



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
Gerrit-Chang=
e-Number: 1776
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ralf_lici <ralf@mandelbit=2Eco=
m>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attentio=
n: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandel=
bit=2Ecom>
Gerrit-Comment-Date: Mon, 17 Aug 2026 14:24:53 +0000
Gerrit-HasC=
omments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ralf_lici <ralf@man=
delbit=2Ecom>

--NJ/Lrq+Ltf8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, razvanc=2E </p>
<p><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail">View Change</a><=
/p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?=
tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">JFTR, am=
usingly Sashiko (the kernel AI review bot) picked up this patch and perform=
ed a review=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Thanks, applied</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1776?usp=3Demail">change 1776</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1776?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1776 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none">=
 Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 14:24:53 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comm=
ent-In-Reply-To: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></ht=
ml>
--NJ/Lrq+Ltf8=--


--===============1887577799592098580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1887577799592098580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1887577799592098580==--

