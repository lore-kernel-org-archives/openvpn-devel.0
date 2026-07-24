Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB0FC531FA
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wcmx/3pq/ZAzeAoJn2Sp1SPDy6hi209E74amJ50TOWo=; b=lGPuFeDJDMb+MVGC0jD2nboW3j
	brt30CG86NaNirbo8wHWTMTkWeLfY1BTm+ikiHtL/21bVQRjIHtxZ/IfuOChi1AWBKgvcgsHBQ/rS
	4MOrFvhOw9qPFrqK8ihLS+LYd/rw0t+yDN26f3LmIevXmuI0g+exnRF6MePR4JZ3VL0I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnHzf-0001YK-5Q;
	Fri, 24 Jul 2026 15:39:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnHze-0001Y6-1F
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:39:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=e9q9dtuuB3tsCT0lP3XZOnJ+kzmRTnbz7BaycpNTEoM=; b=nGunz12FZ+04487GfzhJYYmHCr
 pU5PGtApXuGqDohF8wOkCtAdnM+oyb93zQY11iR5MN2gCoscjUZnVZu9z/fzDjhHHVyjfoiWjKrIq
 Y1vX2VvaJVIbZzbnfzCEbKS4UPx428vohkj9kbcqoBh/KfGTQBBBrVFFMwF2YOKpbMwo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=e9q9dtuuB3tsCT0lP3XZOnJ+kzmRTnbz7BaycpNTEoM=; b=R
 RtFIMj4ZaSDX4ss54Ta5nx0z5f9tr7C30a7fJtwff1L01Cf9bD6+TxO0xKihnPhhAMP4upyJQCJAt
 en03pXmTuURqIx+1HQJ+uT35Xgv/iNcpntyYNjntFY1e9bZdIw8jbI+agq+ljCVRpZMqzJdOu/Fky
 ZHX4vpvDjY35cXcc=;
Received: from mail-lj1-f172.google.com ([209.85.208.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnHzg-0004f6-VS for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:39:22 +0000
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-39c83acb86eso4793631fa.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 08:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784907555; x=1785512355; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e9q9dtuuB3tsCT0lP3XZOnJ+kzmRTnbz7BaycpNTEoM=;
 b=Ose32XHqFJFV3SwcKF1pMWQL24hb9pP9wEuRy4Zc71JqUw3t98f4MRdDBwSw/CgE4D
 njfWW5DF2tKuObcSI1ySEtMnuWJaDvD/dWWf8B7d6XgJpqZ15uTUYCdURZS/Mq5nwZXz
 /rOQnSIf2cPhA3Q9Ps6DS3d29BtppQtHQI8AzfA2xM8QR478+i6QSHRvBURodgwmDrxS
 1az77jHaW/B4JWK7Kcdw6CyP4KmMQ6fGYFdJ49Rgk/ojtM6so2ymNhXncPowGRS5aiS5
 TIdrW7cyT/1aLjI7Iq6KRBHOIMNMtFGhpUvwp4IX3ULqkVEdSS18N8seYFGsdW0sRMYC
 E6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784907555; x=1785512355;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e9q9dtuuB3tsCT0lP3XZOnJ+kzmRTnbz7BaycpNTEoM=;
 b=sT6ZzL+bpvDPobny9n/JIfmw6Ix+1F8JULWidEiHhHtIPsG6ZKTEknSI2CyR1RDaHz
 ERUx/aI1bJ3ElWarjCOlLnYYme9NWPwexIy7o1LvLi4hXTi0YK6y+3skZd/u79cEE0s1
 70eHgL0Ajvt8nIlNHpQ0xjOx0gj2tnLsiclwrHa6CfjkC8NJ6QGc01xn4FRWBW35SjNh
 AY4SNqPnzx6m+wufvHIFEqQlYZ8vyYbhnylf9U8+Cwi4X7NsWIcKuGd1UCzNwI7BW5GO
 gC7X6w8uxtRclIg9fRCQ5zx8CSoTpgxVaYXJKjGO2/wJ/vbBK83CPASlkatmcLcQq8J3
 fCAA==
X-Gm-Message-State: AOJu0Ywu/x1ZY7VJ8ArVETDDJujPxvj95fikgnKusj2T7AaXQeuLF49F
 61BIPU1SazfqjtSMQNR2mDgajiqr7wDGccgFVOb5YTsxXQi7f8ykHTQRE77XTH4BGgu0MfMrvBE
 hS0Fky8Q3b8waSvBNLacFSPzGeibnTYJrZRAl5eL6DjZFo1lFHym0IGqe59fIV81tArOFdWJOIi
 S29w+Vvw==
X-Gm-Gg: AR+sD11OxeBXWuteNZeacDURsVfkNFLD2Jh0sfACFvX6qIKHfUXkl1XCbvNqURZJHRx
 hP21CcHKeaNkGr4SX4ToP9GqxSxHYQA27p/RdgOcWWiCnD8ErLQYE6D/FC1MjdYU9DdE/OEBxla
 PaXjtlEEzvTbzwUHPcFR/e0pZw+KCNt354PU/luQSvC6uZs9VrJf34MeT02OW2M1BZwGtFuLANg
 yM4UCgNwyxwKEJ67k0p8+r8Y/+qEjhqx0OnaZEy5FPvziEHeEBtZ2DhSExTRxCpOPm4N8oBXHxD
 hz9LTWGAEH9mchyE4MFmYf/SPPPSvuXjszuMBQsr44HD+yHZ+z+fAnOFZrPmmlpm4NPth2Symu9
 XrAjwvqRijWoZaSe5FjfXW3PgPUXP3WtT3Ci2ci4Gb/I2weAhHIrlBed1iDiH0h5EapgwfmFcBU
 l5JajZmnEc+XWMsZgaQuwyu4aLgJQyS8mPNk8FyJ5DzuKKe1hiEaoqJdyJK/J7+eRWQsXV1Z61s
 Z7gjmfTjGvJsjk8wZ5lqzGcpm4rXM6w4AzYJslb0a/hlkObYQOTUYIxMm5qWn5QRHd1
X-Received: by 2002:a05:6000:29cc:b0:47f:90a4:ff41 with SMTP id
 ffacd0b85a97d-47f90a5001emr6377189f8f.58.1784896972343; 
 Fri, 24 Jul 2026 05:42:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c66cebsm23547593f8f.30.2026.07.24.05.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 05:42:51 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 12:42:50 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: 7f223f70b33634472d7e5329855567546ce327ff
X-Gerrit-Comment-Date: Fri, 24 Jul 2026 12:42:50 +0000
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <18fb1c2a37667e92718ed1f3db14633962c6f3df-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnHzg-0004f6-VS
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Allow to use
 OpenSSL's SIPHASH implementation when available
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1181087347222463562=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1181087347222463562==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rOtMaCu96NU="; charset=UTF-8

--rOtMaCu96NU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/31?usp=3Demail )

Change subject: Allow to use OpenSSL's SIPHASH =
implementation when available
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 20: Code-Review-2

(1 comment)

Patchset:

PS20=
: 
Let's discuss this carefully=2E That is lot of code we never intend anyo=
ne to use in the forseeable future=2E=2E=2E



-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Gerrit-Cha=
nge-Number: 31
Gerrit-PatchSet: 20
Gerrit-Owner: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 24 Jul=
 2026 12:42:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--rOtMaCu96NU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 20:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?tab=3Dcomments&amp;us=
p=3Demail">Patch Set #20:</a> </p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Let&#39;s discuss this carefully=2E That=
 is lot of code we never intend anyone to use in the forseeable future=2E=
=2E=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/31?usp=3Demail">change 31</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d5=
4a1c1bf7aa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 31 </=
div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"=
display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 24 Jul=
 2026 12:42:50 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</=
body></html>
--rOtMaCu96NU=--


--===============1181087347222463562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1181087347222463562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1181087347222463562==--

