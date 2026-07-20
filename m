Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6847BC44515
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z3aPNkgx1+LMOheiwM+PlVd/RYfg/V/UoqRjIbEBs4s=; b=VJizqgtP6GcOQHepiQOjzIeT8V
	31LFA6DwfzqlgDBWEyl8+SAH3HiyzjEMZBnCMES73U4y/PWrE1wOJBN3NxGYimGxPukX6QX+HqVHs
	QUkbA3oviubcWeplnGBLI8jcNbHFG2A/zTU/bvAO77HpI+3+8kvM7aINP7ykRZQ6CGQY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wllGl-0006vb-Kg;
	Mon, 20 Jul 2026 10:30:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wllGW-0006vN-VQ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 10:30:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qdcltMOj2NIbuod0OxFIzpwsjSb8FZcuvCLiICuRPzA=; b=BsiSYIIegK2qXkeDk3Ol1cZEPp
 JYateA6jY56Rp2/nZNXjaTfn8BTrBOI26ZTGaXqbZVCNSKu7AYgTQOhaZhPKLEVxqiDGKOlKZqv2/
 Y3UNKFyjTNgJbfyvUrnFlDYTtNxXgAfwSsScxll7i5r9xCea5MFn5zZyqL3m2Mso/H6U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qdcltMOj2NIbuod0OxFIzpwsjSb8FZcuvCLiICuRPzA=; b=f
 ZPBFVTWRABazlsGKz8C+4yB86HvJpSbqy50LLzph7fSyxA3bSMP4B+isO2KDmqCtjPuxIXubvFfjt
 L/gvuP6EVv0jVbPEBWw4zRHxP/e3Vb93Qm/sL+ec0zMKDxbNfidUKjRmiBFrIbaUialQhSUH0+dvR
 /Xu58J4G1FePOxHk=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wllGQ-0003Wq-Q4 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 10:30:26 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so2585828f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 03:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784543411; x=1785148211; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qdcltMOj2NIbuod0OxFIzpwsjSb8FZcuvCLiICuRPzA=;
 b=X6UZEf6DYUty0zsxJxSyEtTykmw+VTpvb8UmSyo7qiCic7rDPfhAnkawmmcftsn10A
 lHfQdAfZ2WGojvrVz4mHCRtuOqUvPMCBfUlmGy8WNSs9WwUO4U4ZcSF80tGDVoJQGHot
 iXDzbyEaR2Ur0CMrvjF2DRJzbPbKbzC8+CvDnAIiEFYR9PSK64vV0O87EgGbvps2fhqF
 a6XBBoU3B6ALHO8pJa1g56FvNoMQFmiDIHstEdOClcEPxg7U7HUvtoi8E0D6FHHQIHJG
 92TAYhlPROGuN2x2nIw044R6ZFG8kcbDJ9GH1pvVpDCZAJBZxF38Ly+LYXPGvMftme6p
 9dJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784543411; x=1785148211;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qdcltMOj2NIbuod0OxFIzpwsjSb8FZcuvCLiICuRPzA=;
 b=J73u8p/Ms17xGKvud93JTVICTEVV8uW1/rWRHRx6BefkVc+2PlJv9bgxsZuiYP0O7x
 960hVR2hObIVkwzEnONey0ilUvOd0g79pU3aPeSZ6iIK5W1voCYDmu/fGKP3opdOVg47
 mkKG4GRdvX3vSZgo19mfDPvo041yPL69Ov8zyuPNKWPPRO++g6Hbcq3lappUYijEFJhH
 uTc5p2XX0Fz8Nbp16l+Iz0CWyBSB4pOOpj6tZiywK7YqXl8otjAhOrsOwetMlHRDhwqd
 6NQB2J9BANPmcJuNZi2/ElHZ9AZO84qpF/sPSDj0Zw0yGRQyFqN24RSiXxv5AGHVsnhR
 tX0g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2VxgMlyoQe72vEoyDBndCcVYncYNsd2SB0JUblWTvPbYaN5Nc8MfFAf0aSRAMIb1ZBwUOoFg4m2uMrQw/@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxj05ZWTKBrfCmCax6mIVPqv+weHYPnygXP1FvZ298t+ygM4sYM
 pYqdGg1v+pFMae2J/qZsxB4IjNanFfbgU2qR9TP9EEBYjk1RUn2ePCF8figS6A87Vg6CpWBI0++
 mmbHTfhlXxJ/NQlsVXTuVPugSdtC+Ac7X/oPEF4bmpkjRvmJShC5dcrzKIUw5/D3wbTC4
X-Gm-Gg: AR+sD11Letk7W10wmyTKcGJKZTd/xU9SHQgdcWhw4pzprk7IZxwgRmEAJcDO5aixI5Q
 fQWwmCGwyhr+jTv/DWvpC0+O6suD5oSswbxneTGbY0kxY12/88S5kXKdIuRUkS96UQmoa08UDE8
 LenMDO5z8Lzo7n9sz4T6IFHzRpP9LOIszDvTy0ZunvbUrl9grqHF+JXjATvUfVQ/D427DNMA/7p
 EIHsZ2kHaAR8kOb5luixsJym06WElF0iD+Oj6z2R7H45fMW+o9An9AGWK0Vj/ZNwWpd4gbCzLFV
 T2T0xOIUZBcO8+f73bmLRp8hkiS6tDNv+eYYDx+TkcSwlG10/33XRFN21x1AKoO7cl7Hy9GBqHH
 IdsFz0xMQIB6cXgYwoa4xXVZRJ7P39dKG521Qbicy4GGK5QDU1O8w/QHHyCxLJnjCsJmSr/sUhw
 OQDDoNjsfk+RHPhfeuFOTysoyMIbROerT8RJvvZ5/saouQX4mlAqx/OWKQci/5Woqe34uDuXJHr
 ROeB8s/xKYpF4f8YpI3i8HrQWeqsSf7HHzSDXKiOvKXE+V+M+MSAancWeiByFpRbIpJ
X-Received: by 2002:a05:6000:25f7:b0:47f:4fbf:7b21 with SMTP id
 ffacd0b85a97d-47f622fcd69mr16027053f8f.12.1784543410953; 
 Mon, 20 Jul 2026 03:30:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e496ffsm28262419f8f.3.2026.07.20.03.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 03:30:10 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 10:30:07 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5295e5d26c5bf60cd9607da4c804d04f2144634a
X-Gerrit-Change-Number: 1796
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1796?usp=email>
X-Gerrit-Commit: 316652044266c047e9199abb3e831c67f0edfbeb
X-Gerrit-Comment-Date: Mon, 20 Jul 2026 10:30:07 +0000
In-Reply-To: <gerrit.1784537981000.I5295e5d26c5bf60cd9607da4c804d04f2144634a@gerrit.openvpn.net>
References: <gerrit.1784537981000.I5295e5d26c5bf60cd9607da4c804d04f2144634a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTM3OTgxMDAwLkk1Mjk1ZTVkMjZjNWJmNjBjZDk2MDdkYTRjODA0ZDA0ZjIxNDQ2MzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ef853ece5af67d0f84d51034c660e9fde3daa1ea-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wllGQ-0003Wq-Q4
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: silence autoconf
 warnings about openvpnserv_testdriver_CFLAGS etc
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4776263477108531919=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4776263477108531919==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Lf2zAQkjiDk="; charset=UTF-8

--Lf2zAQkjiDk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

flichtenheld has=
 posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1796?usp=3Demail )

Change subject: silence autoconf warnings =
about openvpnserv_testdriver_CFLAGS etc
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1796?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I5295e5d26c5bf60cd9607da4c804d04f21446=
34a
Gerrit-Change-Number: 1796
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert=
@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Comment-Date: Mon, 20 Jul 2026 10:30:07 +0000
Gerrit-HasComme=
nts: No
Gerrit-Has-Labels: Yes

--Lf2zAQkjiDk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1796?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1796?usp=3Demail">change 1796</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1796?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5295e5d2=
6c5bf60cd9607da4c804d04f2144634a </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1796 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Jul 2026 10:30:07 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Lf2zAQkjiDk=--


--===============4776263477108531919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4776263477108531919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4776263477108531919==--

