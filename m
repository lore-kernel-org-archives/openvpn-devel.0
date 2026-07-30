Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82021C55162
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M4oqoHVDah4AmqmXQX9k1DC5YAHsuY96Kzqz03g4TTc=; b=Y/kuVqB2G3kCVg/7oQWgufnLrI
	gkNolqN1KB6TGq6nNbN0PWz3hPVfnl4GtI/89orguOXZRPcC8t5uG3GbpfnXp1IU5nkeM4ZLts8TB
	0HA0RzUepJx2RZndedtR/qLbDTsIFaK52BvJSZmA7I/1cwZeRBgJY576nlOxVmc8cC84=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpP6j-0005d2-2D;
	Thu, 30 Jul 2026 11:39:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpP6h-0005cu-WE
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 11:39:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+hkM7ug2NO4xQmyRhfPcaNT78yGxp/iJrj7N2DcZp70=; b=YQ53KAZL3JfSPoMZ5YbCrXuAp/
 XUoMqABuboXxtwdwhC+bkDNPqTcRUT3LqPIcUIV78YdJridkfHbrHHJ1sjODWyHYgwBbpedD8rp9N
 SarH+w6t4zKEAud7GIYoXu8T8qqyzkmYt9BsjBPtbYL93KaTjPhehChRtAF3sjKOAw8s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+hkM7ug2NO4xQmyRhfPcaNT78yGxp/iJrj7N2DcZp70=; b=S
 s5xrMDe1cevG60nxrxTGgkzcQyGIqdUQnbZsYgCZ/jt78VDqXrukGeJUvZhAKa49+uxaD+nhLWdYF
 Ip7jXBCOSOcH89ov5LR2PPPCc0AFIpVbVUwVQ6wn9DwwEvOGhBMjP5nkp8jatsMK0XY3iMGvLjzh5
 gdHpvnB5Pxc6R8qI=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpP6l-0005kc-Fw for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 11:39:24 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so18521295e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785411557; x=1786016357; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+hkM7ug2NO4xQmyRhfPcaNT78yGxp/iJrj7N2DcZp70=;
 b=X+rn+B5JMIlTKJt/bYoGhXzhaUg9OvYgQ7eDFwBUKGJgaMrQmyCIOfJZcj+/X4sI02
 1mkb5A9NEw2TPtnF5acgijfRktptJF/io8+k/5oaKaAb9sL2ARTadlW+JASvrrO92Ec8
 bBjb+Bv5RxOPtCstAeOQWaVGnQ+RG5WOU+5ntQrMxonlwDt8jKFw7sDlvmYBYrmn2H3h
 kkfcOiK2nKB4pW+w+BBLGoCAHj71QDSYtIFxZnT0bN5BXFy8Iwemnwa4mvsDTH4DxTGE
 MLZX9HLUbfCTEhigb7O8uUDJJfXBfuoWw4l3Em6RzN58nzL6FTP/rliZvrKAiwp1KrcY
 m/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785411557; x=1786016357;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+hkM7ug2NO4xQmyRhfPcaNT78yGxp/iJrj7N2DcZp70=;
 b=FTDLmOJNWDgD8PE1yZgjQDSYMSXsHJWyF512TOPmz2pBSPn4ObF8sPJezDVJUL4xac
 ISIrm7lVek/+jZLlXU5MXEsoPeLkpKj8KPws3fEd01CdXfZ/iRFqgGxRJcdVwpylJCpv
 DNATsDXyYykQz8QHht7qnD9ctNSxD/nXMXW71XPtruPj0XGiRAVoo0tbv+5PqBWsngcK
 PjO+hwj2XQW7BwXdAm+AzDwc9vVIWwd5hHYdDK5smF7dL0Lj/KaWGbNEElfQPXKU7PTN
 boIht/vdYdLv0+R3PLEFF4TXbxCOvOpgZzHSxrK0A6yhsOsH6W6lOpEcpjzIE8Tl45Of
 mDWA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rog9DxvsOQloJw7BCqMBcqCliJRIdi71ueG3++dlZCeo9ITEm0eQqI5New/334H1Ls8PLHkJalcwxdx3ECK@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzskluSivDfaJPCwlvOFZPwuZoddYRScazmphu941YGEQZ0aPNP
 HQWAsQQoTRs4wyrlRNZDB0FJ+ifdZwmiliCHmVrg5bXK5nw1R3DpWhzqbpvZVVTOWr2RFOCmITc
 /XIIRGYqIxMiDaU7RlZc0sWc8NwrQzd8A4bnyNl/YhmuSN/jQNMRp6lPimFKdXJ8sQ8zbNAwcQf
 rh6y2rrg==
X-Gm-Gg: AR+sD10uXpS2VQZqTMLjQbdO/lTkX6zrM1JmxccV344jC2ixb0bAaA/mOKAoSyMzVuU
 J1b8Dy397biTic4TiyuX6v+/cp1j9sbqhr+UKPM8EAjXEBc1h3cMfdiM4BVXYoiMLkdDrM/rHws
 NkwRqrBIWk550wbcEeGpJe9IFoEi3NxrOgd1qMCPOFfSHFtyYmEGaswpNCWxQlXmRJ8MEvPa34C
 y7RPjBVk3h/gNto7+NN+tTfD6/VCUnE10ZUR1Liym+hl/IIdP8RTCWYZ6XkLLgRqgd8aGzbhbuY
 l37Bxqs+sJTcTccGLQlr4BOlTRlF9DO6ysYoB/6nY7Hxf0L/6HvxUm90VvoWjlmAVKhgrlrpTh2
 2VUE4pX4Mt9W/OV9aKFqrJbdQi7VdNT6U6aSh1zuN2WKNmOLsAqL45NlV5jZwKOQeig2x1JZImd
 XoiZ+a9F5nWvjpu3GhXIq8o/9g6Pt3qH94Sxb92mQPoO0pDs1XwpL5aZ2CMip1dEJjI+/Zus1qb
 qzUT4OBSSS81ibzTx6TbLEmuXRtRRyPtoKMPymr1ybcDHTClhu9RUsdZDyUz6IYWhcBFmuhh0ws
 kWPBUR4OZU7X6cWD0sWIeI4/jMVTyJYlXpQizZbvDS5DsluxDTU=
X-Received: by 2002:a05:600c:4512:b0:496:b34b:baea with SMTP id
 5b1f17b1804b1-49800e6d4famr27378945e9.8.1785411557228; 
 Thu, 30 Jul 2026 04:39:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011feca8sm56807625e9.8.2026.07.30.04.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:39:16 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 11:39:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
X-Gerrit-Change-Number: 1572
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1572?usp=email>
X-Gerrit-Commit: f225b8088e3f1528e265249674dda2449e83ad3e
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 11:39:14 +0000
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkkwNWUyMGY4YzgyNDk0ZTRhYmY5NmZlMWUzYTczZTFjN2I5MTAxYWY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5f21d441013ff5df75ff49b149662d3bb90424b0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpP6l-0005kc-Fw
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add aws-lc siphash
 implementation
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1943219345383298973=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1943219345383298973==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RMEMc8Vtnlc="; charset=UTF-8

--RMEMc8Vtnlc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1572?usp=3Demail )

Change subject: Add aws-lc siphash implementa=
tion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 21:

(2 comments)

File src/openvpn/siphash=2Eh:

http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1572/comment/269bfc1b_1414f2fd?usp=3Demail :
PS21, Lin=
e 43:  * @param   in: pointer to input data (read-only)
> I don't think the=
 ":" makes sense in doxygen
Acknowledged


http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1572/comment/fc523b81_b0ba030d?usp=3Demail :
PS21, Line 57:     r=
eturn 0;
> Can we please have a documentation for the return value=2E Also =
above in siphash_reference=2E
I removed the return type as we no longer use=
 OpenSSL and the other two implementation cannot fail and need no return ty=
pe=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I05e20f8c8249=
4e4abf96fe1e3a73e1c7b9101af6
Gerrit-Change-Number: 1572
Gerrit-PatchSet: 21=

Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Thu, 30 Jul 2026 11:39:14 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@l=
ichtenheld=2Ecom>

--RMEMc8Vtnlc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1572?usp=3Demail">View Change</a></p><p>2 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/siphash=2Eh:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/157=
2/comment/269bfc1b_1414f2fd?usp=3Demail">Patch Set #21, Line 43:</a> <code =
style=3D"font-family:monospace,monospace"> * @param   in: pointer to input =
data (read-only)</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">I don&#39;t think the &quot;:&quot; =
makes sense in doxygen</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572/comment/fc523b81_b0ba030d?u=
sp=3Demail">Patch Set #21, Line 57:</a> <code style=3D"font-family:monospac=
e,monospace">    return 0;</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">Can we please have a docum=
entation for the return value=2E Also above in siphash_reference=2E</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">I removed the return type as we no longer use OpenSSL and the oth=
er two implementation cannot fail and need no return type=2E</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1572?usp=3Demail">change 1572</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1572?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1572 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"=
> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 30 Jul 2026 11:39:1=
4 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
=
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"dis=
play:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>

</body></html>
--RMEMc8Vtnlc=--


--===============1943219345383298973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1943219345383298973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1943219345383298973==--

