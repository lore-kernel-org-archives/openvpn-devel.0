Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0574AC61DD3
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=85+UVOPOZXmNHHurbUFWX5fJxKhn3Y8sWkmuZ4jWd/U=; b=OSJZR4SPRU6uVUD2fCiCJodb9w
	Xro0FW/QQVWv4vBhSYKzuAPFFpsyKBDNjkFA611FBH9Fzoh2kKjywV3HKUsvU4DEKgG/xAUHzdGhr
	V5Q3Q1CtCdvFZDNqiW9kKQqyTDj0IwOZDfQa2JRQvkEVTs4hs893H0hJeYhpqr0CVYzE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x29gJ-0003QZ-9C;
	Thu, 03 Sep 2026 15:48:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x29gH-0003QI-3c
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 15:48:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Sara68Tdlx6nF96MDeLe2bNN90NwNEVVYnsmbT7Fqck=; b=His6M8ZLoenRA6sdP3jLXwVUeE
 ZewaWv7oik0aywLMDxmGTl2+0LTazCwJUgVk+8UzPNTATDeP7j756DhueYO7qlQ7pL/Zu4pH7uNw+
 eNO8/RVSUnOT0WgKf+0N/BSjtDvI9BWZEB+0QFFHDoGjoo2F7zKpjwpt8y+KjfxlrU3U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Sara68Tdlx6nF96MDeLe2bNN90NwNEVVYnsmbT7Fqck=; b=U
 5FFWsObCdP3SvH5ELbu8jz1CVKH6vNiDVWlzJ+dW1KuIyFJd1XRiKnQGbZYHFJepmzQV2p8SOQ8rj
 ixhR93m5jQi1V6us9JZzOUVmyvEv6XmB5TiuK4LLMt6IvPG+ff3ALlyenK+ya9JVG6TJgK0KeFTFS
 yfm6fgyKiP51wy/c=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x29gF-0000bg-94 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 15:48:49 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4843f205a5bso15825f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788450521; x=1789055321; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Sara68Tdlx6nF96MDeLe2bNN90NwNEVVYnsmbT7Fqck=;
 b=Cl++yes6a+PVjOBn6y4fL/QXFa91lsxlBrSVk1tWvrpP8BSlBLslwpvV1ufRPjovS3
 9zCa6+7XGdnC7kyCmEeSW3wVsRb8EfWSY0cPIs6RD+0qDz3lreSYnkKYNrqDu4aWNLlw
 wvvfHYpHAkK7KYcrjSKW46ojErqijeGdEMTzeeYWA0f1xw5YnyUGMBGIbqCmgB4Go1ea
 oGSqJo+JUqEqXRl8JjpOo1z2kldo5KPiExrtXmnUZFyCxaNeLZWbr1ipLJKZowLxDvXl
 QOEAxLok1XeIu3V2/Cd8vN+KARCDDW4aiQb1eWlxoM9mh/oPcyj6XUYomot2t4Y9OsOz
 iAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788450521; x=1789055321;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Sara68Tdlx6nF96MDeLe2bNN90NwNEVVYnsmbT7Fqck=;
 b=fMO7V1mSEGXrX8hJ1/UQEALj5UQGUy2PM0YKs92Swnxx7VAWeZbVFQJhbRDx/RLF0c
 aFWh414oP3JvQeFjGnIDi+mIbeERciZmZtz7MhRZc/HUWXUMP1Eg7eRvt7G/jxFBB4Fo
 CHLrw/VTTrnbCdDr/85u/B3loifsNx8/2YubUklJbaXm3nz4n6K972QzihtWMs13hnaf
 9zSepDgur2m8rk38zARi0hdLjyPsgTg5owFpHg/LTFcmWbWov7SC/WTwLkaiax3ASKme
 FAI/3fvLN+ZwqUqDbZSrRtu2JuxW2b5EyVUCdCrZfjcKg2gLYbip3ILkOKFv7DuWOreH
 FRaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzs+SxuyQb+EyR/gSPZnwaBxaUkmNj/uvb5BcQgnR93wAIkvyqtOaKMm1Oat+aXP4YUT5rluDJKwahDaidx@lists.sourceforge.net
X-Gm-Message-State: AFuF++k32JqOEZkBPdMztj56Llg2sY94vJLTs7YKZcAvN8A4iX6j7K1x
 TZdSmmKfT2jfmsdHkmemJsMNCwyjk3FjHkytcY7/CKCe2TIN74kvWKUM1/Uc/+7CjDIzf6ZksQf
 HcWSsbWSATYXapXzX3FK/KAW4tv19EVm38eWKCYUvtk2dgewiEuERwsryo6yRm3BUjBM4pFiNQC
 lRA9v3Qg==
X-Gm-Gg: AYBFou2u4HSYzBSNOkUASGJuy1R8sN6c7kkxt/RgvY/gyrJm/kvcxn3yen34F4k0A5m
 fvlPyVjmsPYnS7v+0Tq5r90EDV86gTvb0X9iXawyV1hgPJOV7P2M4h0Hka4Dz8G98t5HxLh8uoA
 p8vy4aj7GD2fXLuEB0HTwoJy5rgWHKGYMC0KL8Ze6KMEoM4ZwjCIMci9HvTQicIm9DEOEdcfKz/
 bdKwQh3TfNBNusCo52sNt8NicWRSXnw977asgN5h1dR8NMhEjyp0j44rN2WTutA0yoBqy9EN8OH
 CCKo2rWhZTn791A82LmHNlXeUXQ3ZINeMEVdRI3kYpIdQeiPvtAqogSP3tHMsnmwXtAXOOzJOvV
 doJPmLbGNgEe9kl0gpSzC2YJtGCcPCg1tF1WXBrVxk2EkaSF8v+aqfoR3sWeiaOOW94DJjC9sg+
 fOX4S++v+G/T0fcxh+1dG/MrCDc8Y3/uItbWecVwZV7sOS6Rs7gNjiHTqefGGOADMV5ingFR2J6
 9/PTo5odPmIELrjsT3O6IgILed2xrFnWlR0tymR+YytUfd0F/i8h8/U8G1WRBFQ9DRfnfciLSio
 lV48ZzI+bPIwAzC05BPcyFBrMH5mzgeJXMAitwt5VcZqs2NWlac=
X-Received: by 2002:a05:6000:4b11:b0:485:81a8:6f09 with SMTP id
 ffacd0b85a97d-48581a870femr11444166f8f.9.1788450520495; 
 Thu, 03 Sep 2026 08:48:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eea468sm15478177f8f.26.2026.09.03.08.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 08:48:40 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 15:48:39 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
X-Gerrit-Change-Number: 1734
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1734?usp=email>
X-Gerrit-Commit: 2902b94906e9b21e9288d9e43b24a3c6b5775e17
X-Gerrit-Comment-Date: Thu, 3 Sep 2026 15:48:39 +0000
In-Reply-To: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkk3MjMwMjQwM2JkZGVlNGIwYjBlZTI0NDFhZTllMjQ2ZjQ4ZDBiYzgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <24a3b8308990992cf41dd4a41f8855f4bc5844aa-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x29gF-0000bg-94
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
Content-Type: multipart/mixed; boundary="===============3775180243157181264=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3775180243157181264==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pwSZ7BKoaL8="; charset=UTF-8

--pwSZ7BKoaL8=
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

(1 comment)

File src/openvpn/dco_linux=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1734/comment/3609d16f_f769a7df?usp=3Demail=
 :
PS1, Line 516:     else if (ret =3D=3D -EEXIST)
> I didn't mean to remov=
e the else branch, but only the keyword "else", because the if branch ends =
wit [=E2=80=A6]
Ah got it, sorry for the misunderstanding=2E



-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f=
48d0bc81
Gerrit-Change-Number: 1734
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_l=
ici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
=
Gerrit-Comment-Date: Thu, 03 Sep 2026 15:48:39 +0000
Gerrit-HasComments: Ye=
s
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@mandelbit=2Ecom=
>
Comment-In-Reply-To: ralf_lici <ralf@mandelbit=2Ecom>

--pwSZ7BKoaL8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/dco_linux=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1734/comment/3609d16f_f769a7df?usp=3Demail">Patch Set #1, Line 516:</a> =
<code style=3D"font-family:monospace,monospace">    else if (ret =3D=3D -EE=
XIST)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">I didn&#39;t mean to remove the else branch, bu=
t only the keyword &quot;else&quot;, because the if branch ends wit [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Ah got it, sorry for the misunderstanding=2E</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1734?usp=3Demail">change 1734</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1734?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0b=
c81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1734 </div>
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
one"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Thu, 03 Sep 2026 15:48:39 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;anton=
io@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--pwSZ7BKoaL8=--


--===============3775180243157181264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3775180243157181264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3775180243157181264==--

