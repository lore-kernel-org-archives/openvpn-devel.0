Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67286C61DD3
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X+4e4aujioQTGBxpt6Q0Gk7t39BSIdrYIxTrZsPOF3w=; b=DxMQscnvNjpSl03bBR4LKA6la6
	O71HlT38egZoqsfbxkNeMheEGvv3Mi4bznNgi60EmNLdu0yYYy3w/T/Ypb5fTf+E+kHm6x74OQWM9
	IN18cJPuLkpgtSagk2EkGYvhcnaowLdtNewYkrRAHgmayqXCNB+tA0TqAkWnrdFjB1lg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2930-0001Hg-2W;
	Thu, 03 Sep 2026 15:08:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x292y-0001Ha-2f
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 15:08:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Fy0zQV0NhwEf64W5caZTieQddHv+1sSj85D1nZCa8po=; b=cTySQM2U8qQNfEwtRREOLMUa5A
 ixp2GjEjHm33gizrs7h8KdZPrrJrn4WZRfUZrp2ONz5y2puk6nCcBC8zMF5ZPDrjeaFw1lbkgo1YS
 h40rJ70cvjVasTGUt4/DqCR0TP91sOjFISSwJB4jI9JhqL8vnjUlrXOB6M1Mm2xo6uAg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Fy0zQV0NhwEf64W5caZTieQddHv+1sSj85D1nZCa8po=; b=b
 OpdVueGAHWQmZ9c5LEpmaxFBZEj7c+ChCC8e7GSJZsvWEN0hJ+uvXqt8mrPr1ZrF44PEOniEQp9dM
 UNfw6aonURAFwhCXckMGYOKKZPR/yImPc+dr+4weYJlNfG0El9AO2d8NNwRpPpD8H7ND/3gyAuWl2
 sY0dQag3BXwEjTA4=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x292u-0002AL-9f for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 15:08:09 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so6518875e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788448082; x=1789052882; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Fy0zQV0NhwEf64W5caZTieQddHv+1sSj85D1nZCa8po=;
 b=b/SUAfLllcCt3Qmc1PqBK4L+//vLGzfP4zRb8p4NUfzLM6JNgW36fK0KVEccKiSWrn
 2r83XeVrjYeOzsH91ikh/FGdciq1U7qdXMf1W3nbZh6UGsQzPnpHzyowntAk2UwKlyvY
 CzplOPOyiudrtASwhMWZyhHSomI62RWQY9P9njauoW9cgK/byh7KyU40Asfnn4O/MqPB
 c0jzQCzf7k58uH7FnNZrea4rroIqSi7g/BpV83T2o+bWpPjlGf4rU2b1Ni9spe6qkfbg
 P1v3Jg65pfIzP8GQ62/M3HDFo10pItu5yVz88pfkQfj/C6td4YwwpEA1lUduNziw/Ngv
 5hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788448082; x=1789052882;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Fy0zQV0NhwEf64W5caZTieQddHv+1sSj85D1nZCa8po=;
 b=R74JAyr6A2CezBZ5GBOMOsFw9LuBOHO35eGRwWEU2iKbP4Ir19PecURLIKMe56GdL4
 2zR8p9cTkJpSV9yy64QBfA+7P7Cg5Tvpd/4GNZxP+0rLDCOplhelTpQkREKH8e/Nux6s
 zid/t58YZ/7/tXJIV5tJ8UtiJW7bJwJhplRzJfp6CEpYnqqfw55OFyOnWRHJHHpgQXhn
 6Ozvm8SWZebtYWTku55cucYOImMHUww4r1s50nbowQu58/GJCX6JmlaKuiI+IuIAybB6
 8SRcRlAUlZZ3VxD+gRq7Sv8nRjs3e8RejDGwrfsEc8i/8s0zSocjh5JMrxCHvOew/orL
 rz3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVI8tcjImsECiqYSq5FRF9L6tbaox/ZddL95qgThgc1gE+pgWbuZFwgFPTwRWRphSrqOuORrlI8cxrcyv6@lists.sourceforge.net
X-Gm-Message-State: AFuF++kz+wm/YxY8axK1n7NkwI4ddexj25PsJS0u81CgK/VrlxHx7vyN
 XynLdNp4OxF8V8Hw/KRHyHnvkApR+/yxzaacPrk85V4CpIF4+IdBwtsdMwY/oQRAxM4LkaTs/12
 G5jlyiNSHCT3twOt2CdOop7eWoKKy08pR7Vq7sllgBTNZZXUTVC9691NdZpqWotoCVLHM
X-Gm-Gg: AYBFou04DLcWWjbsAyCy3AS/XhESZmeFZWLQyRGQcsY67qS0KCR6Kgf7mrKHgkQ/oCs
 MnPq9nCbUMSAam7wo23sQ1ssKX76XSxmvuwXKRliZTOEL8V29ZVTccaBNKmGPp3kRgahALCaWgV
 xlGALveBDntsSMiJnpjVNq4mIu4shI6pFXyS61Ax8iCGXUIalIWZmUrnCfP1Da14TFhtyZfJcfN
 M6cnl1h6NYG9mkw83dskp+270TdxppOEEglJifowh6k/bWcDNKUmSTS8DwZziKPiq/LhIJtNJ4l
 CFvtAAsCgribGMbnZ4VUar+C+0er+8wXh84R5rYYXT2QBoDPFlpd8fOJKTqsxoscSQMkzY7d5qB
 RpT0160jTdgOKm8m8Aye3fCUihznqTO/Yy0xWwJPuKfFgqpGik5L6t/vLtPU9ohQ8Uiz8u2Xd89
 OD0qFWQMEW0fwjLb5i6zqhYn5facyeve1XuhmvyuGGdSeko57KBq6qHhc24BRYOtX0z2RGoBOAY
 nUpSFHhVtGPwGkBsD90Y0EDVYoVmsavDNp/H/nozXG64AUhUd2JvtLIQmEJtXIBpLuAlc1bcntA
 35OmpvQm8FFYfXRVzJsrozW1tzGKb8NmlUcFS/Mc6+wl6SvQ7fs=
X-Received: by 2002:a05:600c:46c6:b0:49c:799a:177b with SMTP id
 5b1f17b1804b1-49cf1576df1mr43715035e9.2.1788448081454; 
 Thu, 03 Sep 2026 08:08:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60d9c6sm79614535e9.11.2026.09.03.08.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 08:08:00 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 15:07:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
X-Gerrit-Change-Number: 1734
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1734?usp=email>
X-Gerrit-Commit: 2902b94906e9b21e9288d9e43b24a3c6b5775e17
X-Gerrit-Comment-Date: Thu, 3 Sep 2026 15:07:59 +0000
In-Reply-To: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkk3MjMwMjQwM2JkZGVlNGIwYjBlZTI0NDFhZTllMjQ2ZjQ4ZDBiYzgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4ae7aa839ab5874130701b4bde6e0b45c8a54894-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x292u-0002AL-9f
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Support pre-existing
 Linux DCO interfaces
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2156679362173018564=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2156679362173018564==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CDjIQ0Jy99Y="; charset=UTF-8

--CDjIQ0Jy99Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

ralf_lici has po=
sted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1734?usp=3Demail )

Change subject: Support pre-existing Linu=
x DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 1:

(3 comments)

File src/openvpn/dco_linux=2Ec:

http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1734/comment/0d2aac5f_5d49223f?usp=3Demai=
l :
PS1, Line 516:     else if (ret =3D=3D -EEXIST)
> else not needed=2E [=
=E2=80=A6]
The else branch is actually needed because ret could also be 0 s=
o this portion of the code has to execute only when there's a pre-existing =
inteface available=2E If we remove the else branch and execute unconditiona=
lly we'd query the just created interface, which should work but is not rea=
lly useful=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734/comment/3e85=
b0cf_71e2304b?usp=3Demail :
PS1, Line 518:         const char *expected =3D=
 tt->dco=2Eifmode =3D=3D OVPN_MODE_MP ? "server" : "p2p";
> move this only =
inside the if-block where we use it
Acknowledged


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1734/comment/b853ea66_9f7911b6?usp=3Demail :
PS1, Line 5=
20:         int mode_ret =3D net_iface_ovpn_mode(ctx, dev, &mode);
> how ab=
out moving the (re)definition of `enum ovpn_mode` (and its ifla friends) to=
 networking_sitnl=2E [=E2=80=A6]
Acknowledged



-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
Gerrit=
-Change-Number: 1734
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@mande=
lbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: orde=
x <antonio@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-=
Date: Thu, 03 Sep 2026 15:07:59 +0000
Gerrit-HasComments: Yes
Gerrit-Has-La=
bels: No
Comment-In-Reply-To: ordex <antonio@mandelbit=2Ecom>

--CDjIQ0Jy99Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">View Change</a></p><p>3 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/dco_linux=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1734/comment/0d2aac5f_5d49223f?usp=3Demail">Patch Set #1, Line 516:</a>=
 <code style=3D"font-family:monospace,monospace">    else if (ret =3D=3D -E=
EXIST)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">else not needed=2E [=E2=80=A6]</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">The else branch is actually needed because ret could also be 0 so this po=
rtion of the code has to execute only when there&#39;s a pre-existing intef=
ace available=2E If we remove the else branch and execute unconditionally w=
e&#39;d query the just created interface, which should work but is not real=
ly useful=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1734/comment/3e85b0cf_71e2304b?usp=3Demail">Patch Set #1, Line 518:</a> =
<code style=3D"font-family:monospace,monospace">        const char *expecte=
d =3D tt-&gt;dco=2Eifmode =3D=3D OVPN_MODE_MP ? &quot;server&quot; : &quot;=
p2p&quot;;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">move this only inside the if-block where w=
e use it</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1734/comment/b853ea66_9f7911b6?usp=3Demail">Pa=
tch Set #1, Line 520:</a> <code style=3D"font-family:monospace,monospace"> =
       int mode_ret =3D net_iface_ovpn_mode(ctx, dev, &amp;mode);</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">how about moving the (re)definition of `enum ovpn_mode` (and i=
ts ifla friends) to networking_sitnl=2E [=E2=80=A6]</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknow=
ledged</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1734?usp=3Demail">change 1734</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I72302403bddee4b0b0ee2=
441ae9e246f48d0bc81 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1734 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ord=
ex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Thu, 03 Sep 2026 15:07:59 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: o=
rdex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--CDjIQ0Jy99Y=--


--===============2156679362173018564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2156679362173018564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2156679362173018564==--

