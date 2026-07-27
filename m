Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F18C531D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nzrSIpUwi3KJBdguY7Kt5cqucmpsnTMGV/+1Zh8hZ44=; b=ZzFIFjicnrf/Stpir92prDnCfg
	z9/HioGglpzqEQUvtyRm/50fOodQE+pc6Se9u2Dx9nqQhwYpSaVCvcYnr3Vl2RnOl2USv1vvA1C28
	Arm41421OghKed9v3L7HjlHUXaBl/2qMJH4vTrmsl91gb9uw/CxAReNcgY2Z3j/92pjE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woLc5-0001VJ-HG;
	Mon, 27 Jul 2026 13:43:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woLc4-0001VC-96
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 13:43:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pxbicLzPOPqHBMGctIAj0UO0L9kNwyrVu4PKKrKVQuc=; b=JMqj6y0cczr+wa2E5U80XP3nQ2
 /l11R0FKnXYyilGF/tln0CnMYzR75I0ZklUAmNP/jlkNpQ2sYRXSUh6EiIdoPYOOOXI00uUU1+JEb
 c2uj4CCcP4Gl8REnMZ9gSPhIQLxke/sWGJomFiOkGuecHuyLcGnkK0DDpho7WIJc85W8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pxbicLzPOPqHBMGctIAj0UO0L9kNwyrVu4PKKrKVQuc=; b=E
 n7iIOwgSFP1QRqg9ul5ZgFRdfm4BdakL5KK6JMSOlBy96e6pHridcpl8AKYf/FiDnHli8gxt3TXxj
 zpw7Pn7/grdKpaDvQXstAq3hs4qh+NGEmGrmSR0uzqlQW2MwTd6TgAqWEPaZ1+k5QKl84Ot6jvwFN
 G7aIzDGFdsNA8aCU=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woLc3-0008NW-Pq for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 13:43:24 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso23497395e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785159794; x=1785764594; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pxbicLzPOPqHBMGctIAj0UO0L9kNwyrVu4PKKrKVQuc=;
 b=Ptki3oa+C4wUepvlSHj9/yVLQS3RsERhAcFCqtps3s+EViYjEuxG5VyHckdON2aH4b
 8F1lliAdzYGhF+p6XKCpPgvpsSBlqrWEDE3Sl4VMgFz/0V5PPXamSNjLsUWyDKwLV2pP
 UT+wN+lrI3ATQbmUy5Jv227poAEMNrHM8RBIFBRdsYGv2sskQ+xtPJwbn/NMpWIM9uJ4
 WtBGDXDdi2P+mRDk6ukkD+vOqlzVGuLqHofxYbmk/jUCsY/Lu32oKjNI02U6T+UZxfL1
 oNOcOZPGLtllf6+bWYzwiPeOinJPKkdH2/5WcMKyc3hl4iQIFN0zAMs1C6P6Hj57G21Q
 hrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785159794; x=1785764594;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pxbicLzPOPqHBMGctIAj0UO0L9kNwyrVu4PKKrKVQuc=;
 b=OB7bd6DMP4wf+pALMAV2t50z9/Z4eKnyZYXcDuYgGq1mO2vgwtLA74pVOwalUAil4b
 PW8ZCAVKvVbuhybxGhNu38Ks5IVfhK11YAdKE58Q5T/Fj2b628Gtkuh8cR6xsvJ1yZtT
 CcaRQCOh6mDYb26vSYb3qkMPHq9gIcvxJogOASFdmobqA1YkKwOZr9aoEjOGaSvIKols
 3JEY2myw0WRwwWKgAxA5O1CGocIQyhkTt9N31xmcSyg8VwaFjpWSjn0FF2xletupwAq0
 yij0OHrmQ/Y204vFFYj9TwGBa76pWhtYtnTqZ/cALjMYBnyOU8G77ch19MmJIwDFjPX8
 VHFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rovzld7oIM0MFvxwoyX16FJow7/aD5PRpj/6tXFos3I+13j08t/rxlQBKTM8adqStsCXVVUgQxc9brBwr4d@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywx5SR6xAwOW8hoU4w7yTxI/XTg/PBz3GYdz0JtYPbQHHBbZqnv
 ZzNIWkATsz5vDOo7YvWGz9oxcowiRk9SmFXZtFv8pxoNHCpXTwsgLoZ2rQy2b0V7LErp1CDpSCD
 Iie5atL6Nhpd2ryuJjzUSMiP40Ws4tRtlW7ILnRDgtZReqY7askhg353+p2WyLZ3KT9Aj
X-Gm-Gg: AR+sD13wIiNLCifPRhhzpaPYPiL9zLPMmfl+pQrw69JADw4+3x0j0NeLQ1doS34ussF
 PkBdBL6RApGEgKw01gtk/177FPZc4pJq5ApQJEngrXTYFcuZlILtDmXYcNAi3mzwJ5rgYbvtrWS
 6jVVuFqhB8WEo0c9IIc+3ykahk/0pg0TDEWjMfBi87PX9W9SUTpnsfpTd6Ww/YszHT2ihNbc2cY
 Y+giiXtFKYz65C1RvRgRytlvi+IUYYozXIKOuTD3eujO1TT+9k2IJzvocurZqABClzDQ9D7plTG
 ns/v3hVjySD+N93VW7URFGsyymBPFVaM0dbCwOZ8tcn6ih3epB5UhhEjthzTGScTihH5Umag1hY
 gK1U1GgZelqJTkVtpIKNYj5jEJnDVGFeOxyWidMK09sJj/cqH7QCrq3X85yvGbUmGsSJ4RzS2md
 mWVjqWP3iY33J/zacIFOh8gzPUdMlCgG4kfv1m4b7FskiTrsixv1l2zUu22YZ3cTB2lIBC2oS/M
 l+AVGb5Ehvf+mlggA2OcnrwgkakwfXtticuxcLaO2J7duZjNL8VzULfykMy4b6URIMkllME0WlH
 lgE=
X-Received: by 2002:a05:600c:4444:b0:495:6b4c:fccc with SMTP id
 5b1f17b1804b1-496b5c7182amr103191695e9.10.1785159793523; 
 Mon, 27 Jul 2026 06:43:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b499cc49sm252597835e9.9.2026.07.27.06.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:43:13 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 13:43:10 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 25f3955efd71e5c7ab54e0da3d4181610cb0b5c9
X-Gerrit-Comment-Date: Mon, 27 Jul 2026 13:43:10 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1356e36f48c7c77629a5fbef4b75c45f3f453a22-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woLc3-0008NW-Pq
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
Reply-To: arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5721731443729880392=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5721731443729880392==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JwJhUGh5Q0c="; charset=UTF-8

--JwJhUGh5Q0c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, ordex=
=2E

plaisthos has posted comments on this change by its_Giaan=2E ( http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: mult=
ipeer: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 27:

(1 comment)

File src/openvpn/ssl=2E=
c:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/9ccc98c0_fc4e3b5=
3?usp=3Demail :
PS27, Line 1193:             uint8_t peerid[3];
> please re=
write using `multi->rx_peer_id =3D get_random() & 0xffffff` - shorter, easi=
er to understand=2E [=E2=80=A6]
I would vote for the `get_random() % (MAX_P=
EER_ID-1)` method=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerr=
it-PatchSet: 27
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-=
Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: cron2 <gert@greeni=
e=2Emuc=2Ede>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerri=
t-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ordex=
 <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 27 Jul 2026 13:43:10 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cro=
n2 <gert@greenie=2Emuc=2Ede>

--JwJhUGh5Q0c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, its_Giaan, ordex=2E </p>
<p><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Cha=
nge</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1089/comment/9ccc98c0_fc4e3b53?usp=3Demail">Patch Set #2=
7, Line 1193:</a> <code style=3D"font-family:monospace,monospace">         =
   uint8_t peerid[3];</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">please rewrite using `multi-&gt=
;rx_peer_id =3D get_random() &amp; 0xffffff` - shorter, easier to understan=
d=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">I would vote for the `get_random() % (MAX=
_PEER_ID-1)` method=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 1089</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90=
b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
7 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: c=
ron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Mon, 27 Jul 2026 13:43:10 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body=
></html>
--JwJhUGh5Q0c=--


--===============5721731443729880392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5721731443729880392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5721731443729880392==--

