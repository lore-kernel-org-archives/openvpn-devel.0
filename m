Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43227C4452B
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cK1gTjRo6dUjgrZQb/6I9URVbgeWFSDcuCTDwZhJyjE=; b=l/qAsqQ2AOv9iIEd4YAjqDpmAk
	agYyATCSSDcbmGNL5P83dOhNjzA0Ky5s8IYj8I7H4W1PXBFqURuOraQe1Y81rSMbrdsJWwMwIViVC
	f6QRTP5Gwx65mJ9Yjv1U5BMb9kfAPB6nKuHS++oHawopkomBl7+N+ue9H1sT72b9lEUk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmE1f-0000P1-Er;
	Tue, 21 Jul 2026 17:13:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmE1d-0000Ot-9s
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 17:13:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=q+RwnpNWOuVsPy/+syqF8/a+eBRpUvsIoRm9lcdCgBQ=; b=KfkURwoOZ+FGqpDDsFu6gYBuGz
 6WGcGOPghtZ/fddaMu4h2ZUoIEXxYj+ovmlRUhgnckkapSU8pvqDamKR7XiSEktZFfK/5HQrOsJ/U
 cZqwogo3PiaT0eruLemSUvBbLiYWsK3VqISOIPDj1lvAJoai8ptg+PmImFHtECvlJhkM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q+RwnpNWOuVsPy/+syqF8/a+eBRpUvsIoRm9lcdCgBQ=; b=Z
 cDmJvauvX8dFZ27QQ7xnI8LvYgEMfkYTXFsIEYjyf1K1GJzA5qbugb2L1DzX8Z9lbLl77KOAYAvih
 vBUIexnqI1EcCgZbmEgyZVUst4A+lGTKrgYSutvKisgy7Tyj4vlvgQ9pvuzrstk9hUGin//8pf9DQ
 4CWosXmgkMNQIkT4=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmE1a-0006wz-6K for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 17:13:01 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso15124395e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784653972; x=1785258772; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q+RwnpNWOuVsPy/+syqF8/a+eBRpUvsIoRm9lcdCgBQ=;
 b=FeQJ+wCjqJ8GBgV4tIOFk73++bfLetv2o7Dt6KGUS73W7XT9PdVfyzzKt6uVyLRY2l
 1ki3fy12Wb/onjKo/+OhqvRUy6glztBzWdmNCOMir+4B47YbHdySRZ/sRhy8ovHAbJKy
 /GRs4OpEjcdPHbjYfa2lcx86teGV3Q8lTY9+I8nsmtdTF6On3Xjfz7zaW+cl7OFj6oQC
 tIyxnhn2nC7ewc8tA09xz4aQe5dmS63q4ot5HS13BEFXEXOUZZ2fR1LCgyQguKSRD04k
 DM4bb6u1qUXaLJ0HA4blPq0w1IJFPMT6fka18mycM45TPmm6lJ6F1sRB9PcFRQG3b3MA
 blJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784653972; x=1785258772;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=q+RwnpNWOuVsPy/+syqF8/a+eBRpUvsIoRm9lcdCgBQ=;
 b=anMAeiRbue5Rdkj2FPfEmrpcIsKxU7k+VkLxJw2W9DMDA8KWxebPtudarXEQzZftQJ
 nwUCz+BP1G21R2NvFn+vDJIP7jKlz495F0fZ4j2/4UeGwcy53QWq0aYQhK4GhG6HadYM
 WQv5rq3jm6KRPqoAh7HZiPxWvoEuar9NPgXpj2PS0oogHl4wWZuYy66rSnW3ZtSmwWx9
 g7CPHp2E4Wtoq163tR+xn2xWnJdAgDAXHYRCSXdL5UAccGVdvGL3e8PEYd6u5MVKYnl8
 jy6FrnwUCiQj+KGSsn0dTf/s+BXbowq3yVQjLdfHCmeVL1GPu15Ba9ugh1auLtGYcQY9
 mR2A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rov5KFBAWmDHXrvfRdGlZOuFMlUNh0z0Jnay55BIwMYIlqJhLMt0MjS0oUfoP64eCyyOzjrJ/+/SfdzYOJx@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx+0b/m0lITRpa7HFjbitzgQiVc5Erdfefy9S9LrdhYKfjTRM/T
 rA/b8xL4vLOAyzOsL11lHZN2QckW3jy+qLCrmAIAW/+EnFVRx/1ePCwPpMHA42Q2wWZn2wihniN
 FQ9ABSmerWoBBkDsGHt69MUkQ5b/3vPMGZC2Xuxm0xW4s8nM2lzEgXHAw52zsKkjpcPynLgmKzQ
 PuGNMGtw==
X-Gm-Gg: AfdE7ckpV4NMJV5cumzabZnGH+aFXDfGXfH873EzWuXPoYWwUZj+m21AMBnULQyv/AF
 rysLBtl8NOLS7d9ptN4rqXI/DTlGBvJYXM1vmq+KISxPGB7UBEycQGl3HKg1m4U+tUvdRJTzIV2
 SsOu1lD2cCerODD/QR6NFsDrCAip2eJ8JN2ShHC0PYXU1LXK1qdcq8EGeK1Py9+Z3GzdOSIUxzE
 u5n014EJYsYd2gXpyQ5m3dhzhwfwZuy9VeW/RsWNotdNMZiHksvpclNf55FAP/F7u5TPsUdukfJ
 FZsZlekwGQB0CVoUxYXe+WQCbuixh4FLEH1OG/jssBNkeuvhCrrAAGoyXTaStPiFOlmZ7FtaAEM
 sBHzp841os6zKp2Pkkj5zAno3xCXPdF/uAI0BT/qgTobHju3xT43h0Yo3DgZo+7AHG2oy4XWi6X
 2hRdzrKHwiN8HjVpL+AP3RzC2B1fietRdF0uHgymQZ49tMajaturq8UhMDn2/1xd5YKq/5MBVVD
 4F5uXhfku2keSlEsnpKGI03ZlzR8fhspqadxpRHwSW11+gkJs+I/FcooZg5rrMe+5bH
X-Received: by 2002:a05:600c:3143:b0:493:e79e:da98 with SMTP id
 5b1f17b1804b1-4954a413071mr231510385e9.39.1784653971458; 
 Tue, 21 Jul 2026 10:12:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ee0086sm43646596f8f.30.2026.07.21.10.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 10:12:51 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 17:12:49 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
X-Gerrit-Change-Number: 1795
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1795?usp=email>
X-Gerrit-Commit: 542284246bc45f683d0ebf05c4b930607ff62da3
X-Gerrit-Comment-Date: Tue, 21 Jul 2026 17:12:49 +0000
In-Reply-To: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
References: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzkwMTU4MDAwLkk0ZDA4ODc4MzliNGExM2E5MmU5MjI1MGQxYjMxNWRlYzk0OTY5OGYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bfd05c7137b25ca3c04f2ee5376854bd4c705439-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmE1a-0006wz-6K
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: make key state
 desync recoverable
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6255106111238526780=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6255106111238526780==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iURf3ZXb8Fg="; charset=UTF-8

--iURf3ZXb8Fg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

ordex has po=
sted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1795?usp=3Demail )

Change subject: dco: make key state desyn=
c recoverable
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1795?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
Gerrit-Change-Number: =
1795
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerr=
it-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue=
, 21 Jul 2026 17:12:49 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--iURf3ZXb8Fg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>Patch set 3:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail">View Change</a></p><u=
l style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail">change 1795</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d088=
7839b4a13a92e92250d1b315dec949698f3 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1795 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: orde=
x &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Tue, 21 Jul 2026 17:12:49 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--iURf3ZXb8Fg=--


--===============6255106111238526780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6255106111238526780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6255106111238526780==--

