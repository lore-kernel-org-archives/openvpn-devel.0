Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12238CD8CB9
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z6Nb5N3CWkaEFVOsGd4EUHfkUtxS9uuJzmZtK7HDaUU=; b=Ibqpmqrqqn6A++XMNqwzpWbhgY
	RDGIyMiW+oE1MUJQOEzw1cnFDg/l+T2MoA5ZvalnqeNIgpqFKsMg8JLjnqAli/inwFb5pvjUgw6b4
	Bza35mm2ITNF6O9iXUOSkvkoxEMUQxjo2poW7YglhGAJEyHPWUGN4o2kvLvGIKKh6VoM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWyTM-00042x-Ni;
	Tue, 09 Jun 2026 15:34:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWyTK-00042d-HH
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:34:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6JmoCLoeb00VNrey9bRNHL5UVeFme4QLrIWTRyuKlko=; b=SILqCDjpFc2qANOkr2z3mg/3ta
 T5Y+dsa5mrEOZsqE/2tb/30JXFewaSJcqUwGvNkM+OPi5e8Q4rpNgo1545NqT8ZO83mOQ1hN9CIsV
 w15YkaHYWdt6U26XZfel9AE2jsWVjiig8W0FOX9j+NcKL8u8TLFzr3VFBNcSGfcoj2qM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6JmoCLoeb00VNrey9bRNHL5UVeFme4QLrIWTRyuKlko=; b=M
 b4g1SH2IKf3EdXJ5hKw4GOlh4OcuIjb2++C6hKqPL5Aw7azijEDUUkbKDCrsS1QCosP8GJWku5C90
 thNGnx2uHnLmpQXsI62sKG02PVYEehVH5+8tyHVoMMwyAp1/48dfdEmhw3OBGMOdA+lw+Xgc6ri3a
 BM/PeUDj4LF8CkBs=;
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWyTK-0005kb-2x for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:34:35 +0000
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so10586413a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781019268; x=1781624068; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6JmoCLoeb00VNrey9bRNHL5UVeFme4QLrIWTRyuKlko=;
 b=gIUNhUeYo4SBnpunvU2DYvQhUFdZYc9+wvRU4bVuQABZ3LcWocJ+IhZ2XFEDzCcqFl
 XKfE0UwYtxJhZQ3aYRCI/+7KMs6TMVu4Jfdhza89+OulS6tYLahJCUGl+UK9l1BDFR/i
 j2oqiCwl0JO+l/E0qylf4Ih/iRm5BW6GRIrVGMTKqX3SCRrgwqA+Ww8o84WAL8ZnaSIJ
 60utHaqyBlZOHazzAZJVYQv9TWpZZWeqtsjlZEEfMeUcVV8Y9ulCJX41EKzzO72BtZ2d
 fYHsRcO7vtc4dd6iGEAJKHFz+Dl8Cy+FTmZLurW1NiAtdj/+zlTYbBqn28MwR8ktw+9i
 pqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781019268; x=1781624068;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6JmoCLoeb00VNrey9bRNHL5UVeFme4QLrIWTRyuKlko=;
 b=KR+cz0QfuUGM1Kz6TSP4bx4k4E0sDvPrQFCVfiEdooPaMH9EjrgH25xGGkTmtA3d2u
 8RhWrqh/grooOfz+972nRUmQf6A3ZNy2Z5k2zZmurnf3FAKriMoyknzm7IYU8DyIiD/h
 yF9wbJTT+mX1LyiMiFevxFDUXoSZ3FybaKenlqqXo8JPr7KefAX5YpKn8rruyGc3kkwi
 bQIEOwpPYL4eymEqs1FsvbKbKWts8ZYQglmhJhl0XmL/6VhM5Z8ce6KXAW/G3B5+gJBd
 g8vlqqb2/ntiIHsg3ccdef3B2DmD99xOJQE3LpxZELsPNFWXa5JSCjryclMQ0Dzxr3Fw
 pogQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mPfK5KAKd252kaX0aN17u8OtRm44W/V1/WFk5R+CFdpvIEWVRT/iBaDHpW9USMotKl/zNYd8M9uDmIyIr@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwgZz3SVH3I0RydY4rGnT+eWtWmbnnBUVlLYmMaozlzg2izAzHs
 awTSh6AfF0zvQ1q93J/r3xzPzujoaPFBKUwBQhLMGPwCMY7gXjirsyz65Br3wUhYpNR/yvqHHsW
 cUMzY3v4DMwzhP95cFUQ8rgf9w+fZCMF9zCOYqbYjr1kDwlwHF3slRNYZGpXL/EZ73bXGfB/Ps2
 atbYE2yQ==
X-Gm-Gg: Acq92OGfdwhAfjioUtyvTS5Qlec6KzrseGEheWn/l5orEYlYMlu/S2qM7A9YN/J5CBq
 dX2CzaZVbLRJ4RNmaXSQmdfRXnM88f5lTBWp48Zve1/uS1B78UNODg7Oo9o/4dZCMwtOVrk+3Y6
 Vkv+GQIn6DLkOAmDcNvgROR+94w2+u+p2qZzQE0wTmz1y/LzNykA5kCu4xCvkd86Z+SOKCAhE5e
 T0Ziz/h9HOTzniig310B0GffFWwc6UATs4F4Io1GlnrbAYwtgXKlMzCwZcCsT4xxaeHz91oDVcl
 fxsiegBJHJhJbDMMLzW5ZKgRtqO+N0LUfMICdb8zw1X7v4bT3/aodLgYxyhnr9PK1pp5yHsZLtA
 kZMpZul9oymrIO9beDpqsCB/aeP52HHlxGodT8CVgGhr2/DOInFMeLamzA/deKXxGVrj+t6K6zi
 s7j5C4JT5UxUPFkadPbjrJ/cEIGWDe8xGplBqAK/baxCqWfwuRJJq1QSMxFMxQrZUl/KXENs91O
 SGPk0fFsHhfjfEzImYOm/eNwLBZJRSXdPn6DqGVfC9t8ssGfX6/DClExKf5EHZc431L+B2xgVc4
 KP3aJcjezKtUP6WmpgDvvvHK
X-Received: by 2002:a05:600c:529b:b0:48e:6db3:ff2e with SMTP id
 5b1f17b1804b1-490c4e0219emr268023195e9.15.1781000570787; 
 Tue, 09 Jun 2026 03:22:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fd502sm469690865e9.11.2026.06.09.03.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 03:22:50 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 10:22:49 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
X-Gerrit-Change-Number: 1433
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1433?usp=email>
X-Gerrit-Commit: 1b16bf4f9ec2718923ab9ebcec3b35eab808d81b
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 10:22:49 +0000
In-Reply-To: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@gerrit.openvpn.net>
References: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY1MzgzODQxMDAwLkkxZDRlMDIzM2NmMWNiMDk3MjVkYmQyY2FhMTIxYWNkYmY2MmYwNDUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ddaaae73c2e937e94de3520bf5f4c2a78a807862-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWyTK-0005kb-2x
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbuf: Fix conversion
 warnings in mbuf and related code
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1036372602874601973=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1036372602874601973==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YkT9WZMtHI0="; charset=UTF-8

--YkT9WZMtHI0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1433?usp=3Demail )

Change subject: mbuf: Fix conversio=
n warnings in mbuf and related code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
Ge=
rrit-Change-Number: 1433
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Tue, 09 Jun 2026 10:22:49 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--YkT9WZMtHI0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 5:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Demail">change 1433=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d4e=
0233cf1cb09725dbd2caa121acdbf62f0452 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1433 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 09 Jun 2026 10:=
22:49 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--YkT9WZMtHI0=--


--===============1036372602874601973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1036372602874601973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1036372602874601973==--

