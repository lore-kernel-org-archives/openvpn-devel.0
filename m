Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5A8CA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xCsUhMdaBZTeenU9Og5EpWASgAV98tcSO/USs44/QJU=; b=kMDhxgOsj+rMiYzEQL5rN/MN9x
	rLW1BrasmE7RBEDbNasWrOUDJ2EqNlWzYj4/EhkOHq0G1eZ5YLXLoy5vIM74VXp1F9+iWhqZB/zka
	Jmo+DkudJ7aJvYHud0Sq3EA64WVo9ncRj0l7eTdpHYavSwh6z/zSHIQTaijdnsMWbTaA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xD3z6-0006DY-3T;
	Sat, 03 Oct 2026 17:57:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xD3z4-0006DM-Fu
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 17:57:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=m+eQfR/7SmjbBN5vXMln0yezEKyQ6PoB+9qgRQc4EXM=; b=Kym1qoTXOMncMVKWVc7MVB2qvA
 fbx7KhdqKxhJV+9KZL6OAtTijotHB8cKimr1TsqH8/PsaTPFurRfZOCkzduANorek1zK01iDJFDZ6
 pHWiqRpQUUdFNNX1dCix57XbESsQD/rRqAv2yuKomT7ENyWiFadATwPvrrs8r5yr6lbs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=m+eQfR/7SmjbBN5vXMln0yezEKyQ6PoB+9qgRQc4EXM=; b=E
 NBMfkBi+mh9PFP1nViFgz4ICeOHj7Xtj4Wqo4lLr6Y9A+RlLcjjoS8rIbfXX3JDpi3fNOemGQhA9V
 ioDrZ1spQfAXwXtxpKcACJM+IMR8oSIrClqoHBadoZ77zftc2Qwaa962EeFJb6A3U1DsJ5iW9tyZW
 ZYHW38Z0ggfndEig=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xD3yr-0003Vy-3b for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 17:57:05 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7d2bb404so2395105e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 03 Oct 2026 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791050218; x=1791655018; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m+eQfR/7SmjbBN5vXMln0yezEKyQ6PoB+9qgRQc4EXM=;
 b=DMc8NkzVqyy2C0kAQbaMe0GQNxwtZSRhVU7uvfz2r7NF17QIVo0PB5XcjsHlJ2TyVq
 ic87FjwfZPea1/F62m4Bfi5cU9nrzpJczxszvE2i0elc3bRmCvnUHYOwsU3t/Gfs/qoO
 PwmV6Crw8IT4rp9QqHODx1fOvabkUb0I+t5qPhtlMKvgOK4AT2DHCiY2rwBTtjLQR7KZ
 ca26ZewhBlnkArE51I3gWJUcRUk3Q+BoZUiIsMT94uHk0zJI0LJ6IB5ACVodHJgkMi3Z
 AC7gJF9tRRzKv4AcG/ValbhEMGfb7h8ywcg9ymdIt6S0HhA8vqdjVpHl6aQwnjA0cA4s
 88pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791050218; x=1791655018;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m+eQfR/7SmjbBN5vXMln0yezEKyQ6PoB+9qgRQc4EXM=;
 b=JQQxVMYY3yasKVrcAQo1FV4SSoUlI2n3R3go0wdmDH4y0yWGgG2G9/2UypPNFu/Mk2
 QJT6R/u7Hq5Hmv/8NB0uxEMIGuDlXaKNk67fVSTKAZnLgZVpr4IhHJYZn5i5QsFbm2KG
 vM+6h299WiWx30VAZJJPWJ15bB+Vt6S70dxa0NAk6m1pmJBk13Kadch7Yi2xhcG+huiU
 G5aZxcz/VYc0kNA5mVUtmJTygu+5SrKMggSg617qA2r7DNSwl/wfTvi+EIxlr3IeErcE
 pw55FrmjRbwoXB3Iq1xa3E1uV5pJYwF3wax3gBabYYUQUVviuWjFC1kEgz2oN3kxUZlt
 dkCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvHxluXqbebs0HsK2nTBitTBt5KX3ry27xVLZvlgrj7me3d/S2YpaBh7S77McCWO3t+MnXDjIwUblSq7Lw@lists.sourceforge.net
X-Gm-Message-State: AFuF++mqKAqQR6/20oVOlfbmaYS/MIjtRH1NkCzTvEs+E7CohTKO/wjE
 etbfE/LHuajuRuyRmhth4wcEhdKCrPK9dQOXMTzKCbOhrK8ANLO8RmdrcT7EZRFP3Dgp+BzNQo/
 pcT8YVKBXnGgaVao9/dzXTVM2oL0AuN9G+/29dAvVkaWQYQEcSTRW2HN4+j5mesjSKLL0
X-Gm-Gg: AYBFou0A8t80aUuNUE8OtQ59w4VVuxjnw7eL0PI8B8xjIEPQOq8rThOXfVB4CcwzyxV
 gcYMaswf4wKr17GYxrOOesaGX55uN4kCv1pUquPOtqicIvL5YkEtXB+KRZKjmFdD01QccvyDMUY
 587yRelLIBGWOFt0FmMXa/9SVehwx8Zh2VmMagz84i51JVQ+6oqPJAwx7YQw2/G7zNKDCOl44I9
 +j/x7qz+FuwNQikJKGw56EgbCtydRNueGfvjVuipksIOW1DaEQOtbrUIzMWWRwDPrvk1brfzF00
 JBUfF/oPhObWP8sPVJb2o07U5efSCJ1fnBaJsH9cKJBheujnFuTDHcAf8gwVz3gBd+JI1v/HcVp
 UoJyxsq53GnMmN9MC/pEoBZ0mRXV6u72aOt4jhdhOTHAL5gTXrZJDV7rw0wb/DpnhmyOHBP4oWS
 FO5uw4YetyvcmrRU6QlfbXVrVp2JDdImBlAqkxmVb4TI56q6ahCCwUlk2A+/qbmaE5P5R72dLvW
 Xx5fLhifXRPEiryM54mZSBDTnul1eHLeNL/9WRHWRe4qBDrcoSjJFA3t8l2gobGZeIAaDJnwFPb
 pMnoO3Qk4loNVBNbmTQ4HpFaEUckD0gXwtoAvHhiaE8FjCgI7aIWEA5m0wan
X-Received: by 2002:a05:600c:3103:b0:4a0:1b14:d009 with SMTP id
 5b1f17b1804b1-4a0274bcaa6mr104491595e9.1.1791050218404; 
 Sat, 03 Oct 2026 10:56:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02770fe4csm196548975e9.7.2026.10.03.10.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 10:56:58 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 3 Oct 2026 17:56:56 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
X-Gerrit-Change-Number: 1955
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1955?usp=email>
X-Gerrit-Commit: 2bbb6f5c84bbb83c2bfb791879f7f6193638cd29
X-Gerrit-Comment-Date: Sat, 3 Oct 2026 17:56:56 +0000
In-Reply-To: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNTk5NjY4MDAwLkk0NGQ3MTcxYzdlNGY4NDk3YmY4YjkwMjM4MGRmOTJhNThiZjhhNzlhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <775242a0e8671c02a14b51f845598a8eef06a262-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xD3yr-0003Vy-3b
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Build against
 Windows 10 API and remove some backwards compatility code
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3685025157634155665=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3685025157634155665==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qP2Srk02n1o="; charset=UTF-8

--qP2Srk02n1o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru, plaisthos=2E

Gert Doering has posted comments on this change by Frank =
Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demai=
l )

Change subject: Build against Windows 10 API and remove some backwards=
 compatility code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 4: Code-Review+2


-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1955?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
Gerrit-Change-Numb=
er: 1955
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-D=
ate: Sat, 03 Oct 2026 17:56:56 +0000
Gerrit-HasComments: No
Gerrit-Has-Labe=
ls: Yes

--qP2Srk02n1o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru, plaisthos=2E=
 </p>
<p>Gert Doering has posted comments on this change by Frank Lichtenhe=
ld=2E</p><p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-=
block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review =
+2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?=
usp=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"=
></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1955?usp=3Demail">change 1955</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1955?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1955 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Sat, 03 Oct 2026 17:56:56 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--qP2Srk02n1o=--


--===============3685025157634155665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3685025157634155665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3685025157634155665==--

