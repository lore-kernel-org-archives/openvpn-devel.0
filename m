Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4FAC88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=of/7wn5bFHOlMO4ygORWrM1ZlbHD5EQw80BDUPhYcR4=; b=C1lVpKFBsfe4n8sS4sfnXfcF+b
	ICnZgj+naPfs50p+j8spN0KgS7OhUOEOIHYv0lnJ/Pr71kA7BCYmZezlYV7yxjIUAacTvzdEYu82H
	HktpY/R8xpjA7Xvpg8hvjoIov/1FJkTj4nWuyoxCApnDu7djkK4BLGygjlPLYKslSdsI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x76o2-0007Ri-JE;
	Thu, 17 Sep 2026 07:45:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x76o1-0007Rb-9a
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:45:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CawofcMpMd7RvREoTr2slsZsb1DuDv3tQtwT9AYr3kg=; b=LYUWuyPQNEilO00ICUw+EQkXRI
 sxIvJG8tFH34psjUvnMfYb/EJfAS7PY0n6KzIxW0jGBZngH5fFQCHTuHJYAIaBXdwjjXz7Sv6aJOw
 sHR/aUS+dqesOiDM5RQpaRiDqqJbmgny06FPJEEEsUWCE73VENd/I/PVHbCe2+nnrHAE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CawofcMpMd7RvREoTr2slsZsb1DuDv3tQtwT9AYr3kg=; b=Y
 IS6KfiyH8ZvlLGesPik9jm39rWZO/mIlKbrgPGo1FhDxb2ZLJ0YxjSQFZWucR2Q7fTCAOFlBKcF/u
 pORX+6eySaPWHRyrjpDovhUBImSEF45zlBElWf+aUUTYXC1yoKZyK991GOeUpcArMzLu0fH6BeKV0
 KgjgsRwmloLfA78g=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x76o1-0004lo-BD for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:45:17 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ccead2aecso2258295e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789631111; x=1790235911; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CawofcMpMd7RvREoTr2slsZsb1DuDv3tQtwT9AYr3kg=;
 b=UjsEizaXk++VlZTFDILl7mi0GzBHU0v3ps9chIGGPRMeQzAJtC0f8bFrtfuPeHmpn3
 neUutP3NyDUFTSwMXM1xYCeAp+rmETTK1+8++tI4wT11dleLvohyWaQjf7cI/v5truJo
 aODd1Ac6LPWsPeT5fmgtOAjNeeAmhPQAmlNDoUzuApG7ygmd9IHy07EXzTpJoLHQ/fIm
 7CrTC9CWmXs685N0k+9IGgVtWnvoCjlZuKNN3XFG6SpHq9qlvqUDcSDnGxXzO81MGGfd
 6wdc0+ILDNuxdZLUFSVVyePacTbGz/MA/J8yS3t9Bys2s5EG8RUyZv4rGpyCElCybD+n
 WaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631111; x=1790235911;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CawofcMpMd7RvREoTr2slsZsb1DuDv3tQtwT9AYr3kg=;
 b=O3nLNQBdkx04nzXwSXkENFNsoF0+fGy07T0O7Y74UMNcBpRTzPggl9d/fOTd7COSUl
 tmZ0Z/yEmWflwpDvH+yG1DrdePLwRtsRmA5zDsFx/eIFRH0q8911W1hM/X2qCorMgeE7
 StTAc0ZX4g3PVIkYSkUQU3W4OpnK+23eRZaoAb5TfMPAIhFAgSFo99erh9fq4memuTph
 h3MCmxOY9IpncxmBzpTg39CXzxHiGLkMgxvOx1uaVPylQjl9fTzIcMfx8RB4ggQZQ9No
 4/zyU6CpeazcdRaTlHaVIm7ce7rvsJnCrZpW/813AhpReHZRYKdecfraSGugxLzyFyEx
 NN2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaTu/78ptU1lKuc92vzqm7byDPcrx9xDUQhzLxalL0t+TzPEvhWAQkRFZUUytxz7T8oJUsVz8Q0wgbHrPJ@lists.sourceforge.net
X-Gm-Message-State: AFuF++lFxcs8z4nKattStDWB0vwG+VwbtknfnwhOVFP7HxfL2jSRV52k
 XQ+28LpFFLxaZYoBV7l8avMKeglGmdEoKHSUFq6T7bhNtXtT3C2vfPOWIMpS/wzwYILh+SYSnow
 DnqglqHAc7eIxRpQIdrhgwmTiwcsbTg3eSiqOy+RiBfXgqCjf3F4YO4tADM7zQ+SXB42nOCzFm0
 VTVyDEdg==
X-Gm-Gg: AYBFou2/i+rpnRAXc+pIm/KfQjunf/OaA8xr5NkvgwYlbIa92+XIxXk3uB1I25TTYrg
 sTMAosPwryxW8QNnzNHFHX8YEitzvdhsW2jIyLu+971Dm2zNF16pMt4uXuRZRp0LSt+C4NF+Kav
 9fYNWpK+FjHp8Ij2/SjmS9YyG4PGtxdQPyENGIvbFv62wfua960ChI6j/sLqgw69yZ4y3XA2ae/
 jQMUPrx7AeTCMuF5dDpkyfRjU24ODl9JFtYEAhUA7ILEFGf1+RmPJNXGsaqMkVuW/hlYOu3ab+g
 ckK60yshIGMK8vKO5wWdPiErRjinXMTvwUjDx6cutEkSnCU3L9ofLdNiUmXanStrJlfuIMnZDrv
 xfM/KemTjQwwtn3sHDVoXo3aKIl2gyVsMukDdGhcdtmzfxRpA82Shoaa0sVbkPh4X9XmdpFrzTG
 nek4NoaCyi2WUHwvBi5KsJqaOimOmhyAiUtu7fNNSUcKu9+W061iA9oCbv9NSOdkWdNppnBqrge
 y6tpW57DivMFbLxaRzfjxkR1j+2vYnmiZnvrLQTH8okVH73jf6C3wVBSMAXcrmxUbFzEsKC7XqO
 Zef+0ui9t0wcU+JjcZJCwGPrUwaAe073kM54FLffDNmFOTXzSYvaLKggwiY4bA==
X-Received: by 2002:a05:600c:540e:b0:49c:fc6c:be03 with SMTP id
 5b1f17b1804b1-49eb732c347mr61018875e9.26.1789631110535; 
 Thu, 17 Sep 2026 00:45:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbfd935cfsm19140785e9.0.2026.09.17.00.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:45:09 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:45:07 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 9d09b1b1a84e4c39a54d1f9e4b3e2a741ca71678
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 07:45:07 +0000
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <442fc045a80781080a509533563f851fa9e8f94e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x76o1-0004lo-BD
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 --server-probe to order client remotes by probe
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0207986745078024008=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0207986745078024008==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4zxPH76e69Y="; charset=UTF-8

--4zxPH76e69Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1747?usp=3Demail )

Change subject: oob: Add --server-probe to or=
der client remotes by probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 24:

(1 comment)

File doc/man-sections/client-=
options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/fe30=
56fb_7ab02426?usp=3Demail :
PS22, Line 632:   client whose clock is badly w=
rong receives no replies and keeps the
> Implementation is the one which di=
ffers=2E [=E2=80=A6]
Allowance added in 1742/1744 and man page now describe=
s it=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/174=
7?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5a7e9e13b9=
f9548b7ff717daae2b4a9cde3c06f2
Gerrit-Change-Number: 1747
Gerrit-PatchSet: =
24
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_=
lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Thu, 17 Sep 2026 07:45:07 =
+0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: stipa <lstipakov@=
gmail=2Ecom>

--4zxPH76e69Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File doc/man-sections/client-options=2Erst:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1747/comment/fe3056fb_7ab02426?usp=3Demail">Patch Set #2=
2, Line 632:</a> <code style=3D"font-family:monospace,monospace">  client w=
hose clock is badly wrong receives no replies and keeps the</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">Implementation is the one which differs=2E [=E2=80=A6]</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Allowance added in 1742/1744 and man page now describes it=2E</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1747?usp=3Demail">change 1747</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1747?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c0=
6f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1747 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 24 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;r=
alf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;=
ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Thu, 17 Sep 2026 07:45:07 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comme=
nt-In-Reply-To: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--4zxPH76e69Y=--


--===============0207986745078024008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0207986745078024008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0207986745078024008==--

