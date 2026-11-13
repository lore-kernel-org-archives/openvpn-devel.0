Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14380606A336
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kdxIEsM4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jOD9nZmk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=krKXHwoF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AN+6MbI1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/DH7i4aZcJcTOSiJAm0MgvAi6+UdfiKXoBd+F5okxCA=; b=kdxIEsM43KHtZ4i9R2c+i0Kw5Y
	/K8IXhiw5U/3owF1qhp/Q5sWJQRIcJ2Smdd3Vez7+44km4FXZ1WiG26/3Q7iP9VKBAl5Li+P11PU0
	KnaA5q6e7329I2mJrtmhe8WegfcekaT2ZKwzTvNae/Cl5ucKrMZeZdVfr/kDr/rL2aO8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRqx8-000000008O4-1v2N;
	Fri, 13 Nov 2026 13:04:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRqx6-000000008NH-1jgc
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 13:04:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5qyn5Tw0tQHvfxNwEo3nBIiUWzrdKUz0EQ5Kxn3f5S0=; b=jOD9nZmkAo3hXJktj9IzMmO7Lh
 p9RJcr8RQiWGHT2xi0q05yjcasBjVM7hMRpuzoWZx/n0IrivIQGuh43wvju9oVn/mroEOICaA+Z8o
 kq5PBiZw6NFRFmlKaaBRXA3Uao+eCHZWX33vSrR3eidiVUZLWIdAhh/qk9hFnK9VTQvc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5qyn5Tw0tQHvfxNwEo3nBIiUWzrdKUz0EQ5Kxn3f5S0=; b=krKXHwoFVq+qTPXXzU0T7Bh6iR
 nKmGalpW+awXdFV+bjOgwSRiUoCYaMAGvXWAplMBcSnA2HM2ILjQ7WI0WKD6PjmBQrgwdZZsY2xi3
 DmMw3NV6LHqAlYlJ0XK8bmM+8lZov5Lm/AqhHVi6lerk5pceu42epKp82W0aQQrALC9I=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRqwi-000000001lc-1eLs for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 13:04:00 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4918c2d727fso414500f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 05:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794575034; x=1795179834; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5qyn5Tw0tQHvfxNwEo3nBIiUWzrdKUz0EQ5Kxn3f5S0=;
 b=AN+6MbI1f9/oLuG7jKvhli1cjqKVKAGXDDgAEBVYNHdfRzW0Px5Rsup5Nl23bmDa2X
 l4eFQLHjisNenRpJkoNOrdq8vayRNTVk0oAkjdrwyVSv7hfBUZNxgubOhilwXETVOfYw
 E6E522/HybHYxbchU8XOyBGdDUcmCwCq1pz0eON6aYrGM8UlE3c/iQaaWF/2BYu32y2A
 5JoeD5TbA59bcGe4LKosrwM+8iNWIAeuac+adXInEFQPL3YtNaXDuCv8yIVCHF0+kwEz
 BrJDVWv9whVlrRW9CW7DM+GQMP+c/UptYWaSYFB6nrBpVVcrnZ4umONBft6rD6LaNGiU
 qYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794575034; x=1795179834;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5qyn5Tw0tQHvfxNwEo3nBIiUWzrdKUz0EQ5Kxn3f5S0=;
 b=T93qXMxQ7k2LLLjrpE42URnGviFYrtpZSgvqdP1h7FUcQKSs7Uw/30RocQUuR9KoQd
 RHE0i76h6Dl+PbvdPedefumW+o3qZD1C4s80lm0bjJM4eGZ2vMKxHUzqqCn5XukA19uL
 4kHP5OPwabNQnrXqw2FmlDFa9DuisC50dt7mz/BNDZHOlENoQNXRwzMl3f/uiJT5RS3F
 UVyqow+J9cNpPuRskKx87YiDH2VUjZPDt3fgkX9F/NP2GoVtfFj4OsOrcQJM9mAeTrTk
 2z5A25i5BeJw+GAsXDzlaJ//bCK0OOyAfKo/6Xs04IXv339YyiW2ucJb9flI+WYS9dN7
 HGXw==
X-Forwarded-Encrypted: i=1;
 AL+hErHD7bT0yElvPIVcQqZLBl0wD4AFPPdEEidz/hjzPf6iPazXCEX1Dx/TSVNB2J7poW2PnnJTU6VjstJ9xKt/@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8mBUiaOXw4RRHbMlge6YjUK8be53xoRYIt5b68gMwZtUfR/HZV
 7+9uhq65v9Ou9CvR+f/ILxn/B9V/0yusmzTc6HPW1p6g7gZlICphIbb+SHI50dDHoBoaHVHQgyh
 56re5OTbuTAti0UuQiq1ZXlUbQOxR8LpJhtoVOaWRHdS4hBOyQ+ZZF6XapgSByRlJyy+u
X-Gm-Gg: AYBFou1T03GcPtn8ElzvHHm3s/WgiSFKGzjxB1YbkcfwswJEV2P9Xd83cpQy+VaYZK6
 Vf3eQpoUDWqTfwgrrbGgQqKqZ3UACDSq5da5HDYelawPRJT3zSJv69Ynanm4uCKgWrdgP8XVfvn
 0eQuwF8ib0ohQNL+cSAyM27pMV19yxIrw0qIhs+51Zmd71DGJKXzksqXQHHxi4uqrwZEQNX5P9R
 R50okLwJ4ZGBzPaItt3sX4SL+soT9yAFijHVH6YbF4do0lgHVh8bUDviu3O0WN1RtatLRt4RJ4L
 u2ormWupBi8t6iYpajoLMPlTp5rqB01lZGttum+TsBe/Z7fygrTp/LrbhZ01tBxtmyf0FYWvxTr
 tVjjgwdRlhh1uRy1EctzQeVSIbK+EKvtCqjFVCPkZAfoZH91u/3mOQ4ekFqbtuIkuUBHgRJDx3f
 iYGuYV8u18vsNm/3lgcMY2aRc9j298qJZpjY4mwROocVFS3cPj9jEM2Ab+uEc9uT8b8Zs7bYuKm
 jtQsAXTEOMead7Ryt6dZ6IZpHsNx9WNLZgnl2AY3rgpcIxvH3gNrLyxW75C74h8UfWWx9q1+FVh
 a3ZYcKNZvLn2s7gQo9dNRGp4loFbV7Ba2s/ksZfOYPvhLHcvTnykcaLy2g4nWpNwscf4hh6EZL9
 TpUwr5nxdNGrHdac4XPp2eqJLUh2CxnboZsZtOOMLNHvUtUDEvNfub7NHsQq+BrMwSLXS4ppEz3
 DR9OfaXx9PyiuvQ0s=
X-Received: by 2002:a05:6000:46c5:b0:48f:bc05:76fc with SMTP id
 ffacd0b85a97d-49c70ed936cmr3580689f8f.11.1794575033547; 
 Fri, 13 Nov 2026 05:03:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c1797sm5779955f8f.11.2026.11.13.05.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 05:03:50 -0800 (PST)
X-Google-Original-From: "Yuriy Darnobyt (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 13:03:46 +0000
To: chesain <cvanteddu1@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifb4e9d79c167337fb780b53141d080abf55f3f5e
X-Gerrit-Change-Number: 1338
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1338?usp=email>
X-Gerrit-Commit: 39ce613b2f16f8e69ac8d8d8a50ac294e54e132e
X-Gerrit-Comment-Date: Fri, 13 Nov 2026 13:03:46 +0000
In-Reply-To: <gerrit.1762026034000.Ifb4e9d79c167337fb780b53141d080abf55f3f5e@gerrit.openvpn.net>
References: <gerrit.1762026034000.Ifb4e9d79c167337fb780b53141d080abf55f3f5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzYyMDI2MDM0MDAwLklmYjRlOWQ3OWMxNjczMzdmYjc4MGI1MzE0MWQwODBhYmY1NWYzZjVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9df5f37d1200f9e7b85b30326d617ec15d02373e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xRqwi-000000001lc-1eLs
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: CONTRIBUTING:
 add Gerrit option + links
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Yuriy Darnobyt \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: yura.uddr@gmail.com, arne-openvpn@rfc2549.org, cvanteddu1@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Yuriy Darnobyt \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0901556988781072845=="
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0901556988781072845==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NHZyj6ViF+U="; charset=UTF-8

--NHZyj6ViF+U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, ches=
ain=2E

Yuriy Darnobyt has posted comments on this change by chesain=2E ( h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1338?usp=3Demail )

Change subjec=
t: CONTRIBUTING: add Gerrit option + links
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(1 comment)

P=
atchset:

PS2: 
Gerrit has now switched to GitHub login, and the GerritBest=
Practices
(https://community=2Eopenvpn=2Enet/Development/GerritBestPractice=
s) wiki page
describes the new setup=2E So this is good to go=2E

If you'd =
like to make the signup step explicit, feel free to add something like:

- =
Sign in: https://gerrit=2Eopenvpn=2Enet/ (log in with your GitHub account;
=
an account is created on first login)

Otherwise, patch set 2 works as it i=
s, since the wiki link now covers account setup=2E Thanks for your patience=
!

Could you please also upload the same change for release/2=2E7 and maste=
r?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1338?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ger=
rit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: Ifb4e9d=
79c167337fb780b53141d080abf55f3f5e
Gerrit-Change-Number: 1338
Gerrit-PatchS=
et: 2
Gerrit-Owner: chesain <cvanteddu1@gmail=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: Yuriy Darnobyt <yura=2Euddr@gmail=
=2Ecom>
Gerrit-Reviewer: chesain <cvanteddu1@gmail=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Attention: chesain <cvanteddu1@gmail=2Ecom>
Ge=
rrit-Comment-Date: Fri, 13 Nov 2026 13:03:46 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: Yes

--NHZyj6ViF+U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, chesain=2E </p>
<p>Y=
uriy Darnobyt has posted comments on this change by chesain=2E</p><p>Patch =
set 2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2=
px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1338?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1338?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Gerrit has=
 now switched to GitHub login, and the GerritBestPractices<br>(https://comm=
unity=2Eopenvpn=2Enet/Development/GerritBestPractices) wiki page<br>describ=
es the new setup=2E So this is good to go=2E</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">If you&#39;d like to mak=
e the signup step explicit, feel free to add something like:</p><ul class=
=3D"blocks"><li>Sign in: https://gerrit=2Eopenvpn=2Enet/ (log in with your =
GitHub account;</li><li>an account is created on first login)</li></ul><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Oth=
erwise, patch set 2 works as it is, since the wiki link now covers account =
setup=2E Thanks for your patience!</p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Could you please also upload the sam=
e change for release/2=2E7 and master?</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1338?usp=3Demail=
">change 1338</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
338?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:none"> G=
errit-Change-Id: Ifb4e9d79c167337fb780b53141d080abf55f3f5e </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1338 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner=
: chesain &lt;cvanteddu1@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Yu=
riy Darnobyt &lt;yura=2Euddr@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: chesain &lt;cvanteddu1@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: chesain &lt;cvanted=
du1@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Fri, 13 Nov 2026 13:03:46 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--NHZyj6ViF+U=--


--===============0901556988781072845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0901556988781072845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0901556988781072845==--

