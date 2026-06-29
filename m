Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25C4C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wxJxW/ShKNfSjZAM12m67ls2T6QMjUNBvGOwR7ZfghU=; b=nR/TD2cJ0rLTRr1+tVRoLa/9o8
	u9qKvwcVHun78WntdA1dfugPOqE5XUICvi+/tKjqB3eyw97ebx465UYitplCiNcTtHSinQYZJQ5ND
	DbXTyGaQCm4LTcx1Pj4otpbaeub1rA0bJRPMOILi6fazX1rr5Q4cf5vI0eMnkkpVO/po=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weCJK-0004mP-Kk;
	Mon, 29 Jun 2026 13:46:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weCJJ-0004mH-Kt
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:46:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=37rd1JL768L01DbUpLaRkBkgl26UMErlaytwmAa5dyg=; b=IXg8MB0RPCHg+48HbV3ES6498c
 13rxnoDY/asgyres+QDos0GJcvc8yj6CTMwneyQ0VUHaWXr0Nv6xcKeI6K0hcc+/7RJbrHJE1eeEs
 G3GiW2KylTgKWdwKDB5fXCEBVgu+xIb+EDU47+nogmFlefhZgZMj6D7KuCL9GnWxonCI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=37rd1JL768L01DbUpLaRkBkgl26UMErlaytwmAa5dyg=; b=d
 zZ7wTe3BWcbnbXmOihuCsqXYDZrA6qlvfuetvJr7HnNZ4hatnFX9D37Eyx0yJlct5srtB1VLOpPTo
 D6OV1y6GDIBrXqap0Ks7jR1n6fIeaZ6sa+2TWoXg89uWWdOPNBcP5X7jwUYLwvd/4OFBmqy2+NcCs
 xFI+EQNbSPHsvTmk=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weCJG-0000Ui-Ne for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:46:04 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493a54b80a5so22099485e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 06:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782740756; x=1783345556; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=37rd1JL768L01DbUpLaRkBkgl26UMErlaytwmAa5dyg=;
 b=hPj6Kz0vsSpf1NzEt0PxRTgrcyMlFWvvBBKSQhwL/FDVFW8dGG0sR0fPPyo/N+fpeA
 YxT1o+wuVCXaghhcIUPf2XLS0qxttf5AZsEn4Vu98k5pIxYjYyapqz0+smhZY2c53ODV
 hjv0o5Mw9aGq1auL6k+bEje+lb7dLGKQ4EsgVy3dASLymNUqGf5e6v+sZyKVAkOgKV9j
 hXGNXFocbv3GeAJfz/so9fg84kbF2zAqh3HWi6dhZtCNEdDFaZ2tR2FyGYQpN1G99OQS
 PDe+qiFfxH9+XPmmnxeSo7n9bS6+es3amyU7wqP5TIwTy8w3+Cmjg6Es2an3ync0UZdD
 A1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740756; x=1783345556;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=37rd1JL768L01DbUpLaRkBkgl26UMErlaytwmAa5dyg=;
 b=J9dEDqJtPQC2VD0z/YpQkBiZg/NgNdEKG6qyCUGJpWDyRyeGmskSSXT3ZK8GaS7tdQ
 1/BowlFV+NZJVwIK8z1wREpwuUmmEjQ8kSQr6kvrDerpMzRY7yhYk+J4Yhe2rtnpaTaK
 nnqB86nszuLYtkRfz/FyDmPr8TSUGhOmOxKR+0wNGjs2VGSxbL8Rnbcp9V6viuzenNTG
 WZ+9JaXrLJh+aLX2aujGItJsoWsNOUIiuAoWVwPFj6Uw6yAI9bdC9637veYdiB3PKkj0
 MznIESxqeR3X/WeGjVMU6jWoHR6vs9Wx7U9Bk2r43I3WnltI2N/8BKORJc1968w7kZwj
 WZrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6S81rsMa9YsOQ77aSz2nSeMH9mU7gcwlF8CFUcBgSPvTuaVeqhaUhnjsXk3JjbpwTjSNYwj+q9yWV8dbm@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx2rG3Yb454ilYFMD/LA71RKNxWSVS9D4HBHlB2ly9JibxX3b2H
 9eqOz7W4MCGXLXzy3ZF6f39sa+XOY7kRGuclQcDfJlMTfbmw/CDQZk1PBimuriXOeIZU6TYLMv1
 Rr8xm45uv7VyIIWL1HJSuiou6HHss0CCWwPzDmYNXWA2ldFUz9sHBJ0fGQlKk/Rf+M3wK
X-Gm-Gg: AfdE7ckpEoBsPQy47Zhv8RRzYx4lQQa357DbsGg3PI1l/cYMIitsfAZjZiSHgXrrpAt
 r3rFBVB6uHK6f3H9FbViLUUFGeoYLOPpqk3/XPMwgwrQX8Wj4zjeUTLAoXUtc7ytBZrBttucPDA
 SkCyYV7cQEKNGoY6jBc+nDyTsdPRl87IyJZddeuTwudMrYBUMIoIjx9r1vLTWt+8SSrVzWqr6cd
 A1c6axzu00gfehOW+Yr8YH0x3iE+jwSzXbuCsFMNj0ElISMfVcqyvY6WREF2YVFXQO04ae3yWKn
 cnHk9dzNCMLucA1itM3nrn3JpN/FdfLL+EubCMoggmi4oEEJq6rzGiS0N6TzQPtKa6on+4+xnlR
 yg1JA6IiLf85xz+k6uDwfqA4XhMs7RceA00z4lrbpE/Pe9jqAjzVdHUeqEILKCEshh/r3JRfWsc
 c8x0jb8mOMthEAEwNUGD2EbD6UstupBv2eOsLRbf3fsN0ZFWxEBlVEst/m7ANbBuGvyCM7ErTGo
 /hy/kbipjbKx8qeJ5rKeXV4Qh0GlewbvswvlqPemqOicshicRqNw9WP9sELiBGEpJX3LSTXAnUW
 TXV337dF2BiZeg==
X-Received: by 2002:a05:600c:3e88:b0:492:523f:a3df with SMTP id
 5b1f17b1804b1-493b7191900mr12068465e9.5.1782740755529; 
 Mon, 29 Jun 2026 06:45:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f978dc0a9sm26157727f8f.15.2026.06.29.06.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:45:55 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 13:45:52 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d
X-Gerrit-Change-Number: 1754
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1754?usp=email>
X-Gerrit-Commit: 438ec4d558136e24dad22269dc2421e55c47dafb
X-Gerrit-Comment-Date: Mon, 29 Jun 2026 13:45:52 +0000
In-Reply-To: <gerrit.1782740317000.Icbcf4c79d577d9cf089a92378be9253b1e94825d@gerrit.openvpn.net>
References: <gerrit.1782740317000.Icbcf4c79d577d9cf089a92378be9253b1e94825d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQwMzE3MDAwLkljYmNmNGM3OWQ1NzdkOWNmMDg5YTkyMzc4YmU5MjUzYjFlOTQ4MjVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7cee0c7e8220deaa2111d6a064d3af5da692d8ea-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weCJG-0000Ui-Ne
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: GHA:
 Cherry-pick changes from master to keep working
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3177731087403524330=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3177731087403524330==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K5Snwh00fgk="; charset=UTF-8

--K5Snwh00fgk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1754?usp=3Demail )

Change subject: GHA: Cherry-pick changes f=
rom master to keep working
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
> Do you have gi=
thub run link so I can see that this works?
https://github=2Ecom/flichtenhe=
ld/openvpn/actions/runs/28373610163



-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1754?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: release/=
2=2E6
Gerrit-Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d
Gerrit-Ch=
ange-Number: 1754
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 29 J=
un 2026 13:45:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Commen=
t-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>

--K5Snwh00fgk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1754?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">Do you have github run link so =
I can see that this works?</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">https://github=2Ecom/flichtenhe=
ld/openvpn/actions/runs/28373610163</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Demail">ch=
ange 1754</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1754 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Mon, 29 Jun 2026 13:45:52 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-=
In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></=
html>
--K5Snwh00fgk=--


--===============3177731087403524330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3177731087403524330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3177731087403524330==--

