Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040BAC55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pRVQze/EzF9FleZHp5fyvAOLgvCuGXitGRviTgANJSo=; b=OKLLreqyoJfLQn5dreeFGcQi1X
	Ar6pHWxieg2kPTKEaYilx+nFtzUy3sPDPLm5atcIVUFjtTsEQ5hGKp3rk3UJFOsGw2S46gOnUYXAg
	2Qemzcm8QC8YePPUmWWUoHN12JxdrJE3d/9WPsAVTx+P1gF53MNfstYCkEFkvqthcb8o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrXqq-0001je-KJ;
	Wed, 05 Aug 2026 09:23:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrXqo-0001jM-VN
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 09:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1JR6ZS0yPmLrvm49ZpfDXeX1jYft6sVI6cj9B6CZDDg=; b=AUZX75eb2ClJtREpnDG0lnebu2
 iLGJjIZ1E98GKdMTCvKYJwCoE9W8jXgGriY9VKzvgcD3KRkAVYhWk7INwTv4yASfs6zQ4Bq0Bmf7m
 pCSHHSw2vdOKTFsvKSzv1GQAyfaj65p4xBpSXSFJmoujSgwizSy0bWQ1AXpsdmDHztNs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1JR6ZS0yPmLrvm49ZpfDXeX1jYft6sVI6cj9B6CZDDg=; b=S
 Nn/utbUpQepNwVXNN8LZWPP2/bHuGSWYNsz23s/4brj6Ocnumaag2R9kt3diS1KzSmynsLBR5nV89
 j4hnxzKtJB0CUF4coUblIZeI8ylOf9Q8sdLSYrjMubfdXXZKr9iHqwptJXSJ4PcdBznpSEcCmateD
 dHu0pF7AoizvSudA=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrXqn-0004Ol-T7 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 09:23:51 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so666670f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785921823; x=1786526623; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1JR6ZS0yPmLrvm49ZpfDXeX1jYft6sVI6cj9B6CZDDg=;
 b=Hc0sMGN+C+Z6okN/1WlkDnbeWK0iolfUJZnemNWlmEYb9mmYrm+ECHXdLJeUuEXfP4
 +ZbniS5er8OX3StbeEKifUbSDjecs5+Xj6m/9/AweiK3LiknS9FvQIDjBQzWloEXLCqk
 M5jR1xLMCum2I5PexCLp4wKX2sFDZHcr0fsvkNDxSbkieauUSCYTj8YHBIwVnrZ/Tp7l
 CXFOuPPs05Aq+BDFR8YcEXG/cDUERqWrRfS2HjJxbMsuy89ekG9OnCKszlGFZYJEGvBh
 BzvLFsLjPWHvk6NGixsV0SfjNZ7peiMwhrIM6ueWC5RdzwbW2AfnLSbzLHwsk0cfeeVk
 sDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785921823; x=1786526623;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1JR6ZS0yPmLrvm49ZpfDXeX1jYft6sVI6cj9B6CZDDg=;
 b=NRT7CacSzjqxzoa9QUNvqcni0H+XdQ0rEzk8dQ/FY74Adt8z/826m3wIEcul/fqTiT
 tnS37r4TT3pXSROktTwaLXbOBSEhLjuIoDz88ADj36gROnaoOTDVQlWuJhJimCTjsbkK
 pP3t6/kDlyZ0w+SgRgXPBVhgqrrNnxknyWJvnYj2dVy7RaBlCtoyljIKek2zfLekh1Nq
 K9cCSz6OAqwKtSupZY0iD7/IQbDcwzrf4XZsqM14GxzzREeYRyBKeKriIVU2+lZ6GWBI
 k+gfMPlyPFoKtaQNL0fPbwV3Z77V3lWwpqk1FDzHsqTW+lPqSXKO57uauchD+EX24I4p
 vnow==
X-Gm-Message-State: AOJu0YwC2JJghTM67RFfxcke1qxPYnFnbMy9LTEqTGHetr+/n3WRvgRM
 tJcdCCJrUju8Kc/YL0mZkBd+Q4EWYPKljYSl04ykiZHVual3QVohwXJ3ElBRTv8D2tigCRRusvc
 i68eicM3wz6j0bFARGDWd7tSWrLWCEgfwbZH697wPnlgOugvTK1xITiw/RE8OAbPgSatPnqX4J/
 eielqDdA==
X-Gm-Gg: AR+sD10J6J0ew3Qn5dVbGmO1yoyvEWQZH4Ja3ri1DsTRiJV61fRQ4viWPDZ6vNNQjwN
 CtyHut1jz6skxAjHbgMPFTCaypEsWgQvzBqhuu6ge2JreHrWm1d/gKztQXoGCxS8NzEmXFwa8dz
 KzVYH1A+lYed9bLSxONRdj5LwnJ1vl6HAChLHTsGeVNiR0LpVrqsTBCwPaO4AW0Qvv36sMz8xtF
 7Lb2T59PFh29rP8YTh6Ar7XasEJxiy7d/8ahL93dF64aD+ySMEQgj9rI8Deoi1SGD3ZvCoI9h5H
 uKgSr/e6J/hB7Ttr9Yzo+ZwESVoIhOjLxNw/YN7oyjFSj7/eOFEKIU2TZ0jqoedZDIbr7GZ2NXd
 ui5QdXptFo8SM2W36jsVZClREPfBnRoah9gUGClwKx4h5hPnzoBAaayqr03IP2Ez1m43OMApZe2
 iLoIasDketTJL6r0zAVNM8d5ORiLEF2lM3qLXia1aku4YiCrRPxDN5BYSk+hn/Lgc6eIUGx2Qb6
 nH1YEBl/pE8DDNThehK+Fzh0xbyAuq4xGJxWga0TKXgRThqMkuMxtBgS9jc1zLOGrHSdGA0pHeE
 389XSLcBBMFd8M1qJ6T9ru5pQWoMm/WXHwWvBwYmzPDfSWGcEHE=
X-Received: by 2002:a05:6000:e05:b0:47f:91eb:342 with SMTP id
 ffacd0b85a97d-47fec5051b5mr7036978f8f.13.1785921823095; 
 Wed, 05 Aug 2026 02:23:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47febfda0cbsm7148480f8f.6.2026.08.05.02.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 02:23:42 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 09:23:41 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
X-Gerrit-Change-Number: 1836
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1836?usp=email>
X-Gerrit-Commit: 9c799a5e6b94f273ffc6c70a84ef21a89a53df60
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 09:23:41 +0000
In-Reply-To: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
References: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkljYzA3MjFmZDRhOTEwMTEwNTA3ZDA2YjRlOTQxZTllNmRiYjExZTlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <db35c9f0c67b3351fbdaca53ff45bdb4952afbd5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrXqn-0004Ol-T7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: reject a pushed
 epoch data format tag with a non-AEAD cipher
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
 antonio@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4631405470114536551=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4631405470114536551==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PTKnqtP+YZQ="; charset=UTF-8

--PTKnqtP+YZQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex=2E

plaisthos has posted commen=
ts on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
836?usp=3Demail )

Change subject: ssl: reject a pushed epoch data format t=
ag with a non-AEAD cipher
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
Gerrit-Chan=
ge-Number: 1836
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: o=
rdex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Wed, 05 Aug 2026 09:23:=
41 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--PTKnqtP+YZQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex=2E </p>
<p>Patch set 1:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1836?usp=3Demail">View Change</a></p><ul style=3D"list=
-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Demail">change 1836</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Icc0721fd4a910110507d0=
6b4e941e9e6dbb11e9f </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1836 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 05 Aug 2026 0=
9:23:41 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></h=
tml>
--PTKnqtP+YZQ=--


--===============4631405470114536551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4631405470114536551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4631405470114536551==--

