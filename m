Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB20C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tXHIklYpd2phEWUeWCVLWnoXrG/+5JZkaeOuEQgiLHI=; b=O2wu1Kjys8pHTBmwACDJ/WXaov
	f3VMh+e03028qqhRI7j+FRq9AKUvi57/8JQB0PEAc7V2D1Okl2hSXBIlSV4FJjvrQ4gH8peeH0BgE
	PDhK2IyeDVsqB+yMX21Zgg2nZBfWHaH40JGx5bGOvJ0bqmczNM13uFu2X1ktGjzhcvFE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuXZ9-0007d8-8L;
	Thu, 13 Aug 2026 15:41:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuXZ7-0007d0-IO
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 15:41:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JO+YZIAT+OTWMz4PLpsZ/uCTI6fNO3nUMfEZzWHO35I=; b=d3aFdNvq37ic77eeLJcViHQPdu
 1s6kpSM3etnnAIwAzboiH6kRld0U0qGi1NYeQp0F6p3I5DNO2YsViP018Ro+vj2UdWdmil0uGWExX
 XuhytBWIY0hrt0y7j5dY14ieLVsLW8mS8jXP5O+nSIvBqE3LmtE1em9ijjD5Ss9YRHPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JO+YZIAT+OTWMz4PLpsZ/uCTI6fNO3nUMfEZzWHO35I=; b=V
 4EU9wwu7pb7siIXSFgR6eRJRPsyGyoSKGGSe0xw8RfKHWKccz2ArUkZjJtRoaRbjKdvVml4wpE938
 pRwbcVXcIyG31xwVGWQaGMxqYD71WwbDk59x5MSGbIW3N3KtfzUzhudlxZ5nmthSzaoO93zJ93NDH
 FXExQHQr8eiUZ4DY=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuXZ7-0005Og-8I for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 15:41:55 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso274595e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786635706; x=1787240506; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JO+YZIAT+OTWMz4PLpsZ/uCTI6fNO3nUMfEZzWHO35I=;
 b=dE2/fMZ9xZJJQ473Dr0Fy6Vkob1al88pDLevZ2BmnD119jsG3VRFCnvIt3mWgHGtJ/
 eXkj/l7FuKi3CR95JposQ6yTpddrBulokyJhBO94z7kJ82HheGiG3CtE6ANXzq44e/jf
 miqrsJM+M9ezhs4A00Du9ePi8NhMQc4/Vry2RA4p1FZj58UULKKBJxDz65cRxeX9vmb2
 vT7OY/3IZWD8Kzlc4ew5gZoBNOXACrIaKPh4YCgey3yPUvq9SUS6zJKETlOkkDz1fj2z
 c6d5pTYy5Wauz1Dq1LAi7/ZRW+K73g9+dTlFzJeLMicabgsbDh9Ndu/RQZZ7Nh5Lt50a
 +2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786635706; x=1787240506;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JO+YZIAT+OTWMz4PLpsZ/uCTI6fNO3nUMfEZzWHO35I=;
 b=X2AxvOsmlKCg3LHl7BW/gHKkRgVByBhJmBWtEHHyECM2kM17oJhvr4b6718OLObe2s
 YUsla8i0x5Jf7oGYw2Q91Vf/eEPE2YHqrKwy3psWbjI8vxIMyTRLYAwFgybzyENv8/Vv
 keAOnWn0iBdj+fDdIEQKJ2hl/TvHOJsgBk36qEoZNk2lcqw8RS/lzAyKZrCQHahdrrE4
 3BlBIT/IXlyKkSz+WqE+jzOJqrBXkzehjDr1iJDB6YITM8I0jW2OTO89ibMJd89AW5UZ
 RnyLBXklsqziioyp0skzwSX2SwRkewDxDwK3/RKCIF7UsfByWFhnGRZyxOPJ1Vd+s2CH
 eoOQ==
X-Gm-Message-State: AOJu0Yx+f0TAAkF24yYQ2VGXw8L5C8z6F/2b47sbBGunacCs+cU7CCP7
 PzmZ9zjPNuwulhBGGmZdya7uiXI8QxDLTORVhNkqLwXlVzKE7dsDj+OM0p9ZzUZg36W1VoAU0iw
 9HrKwDtusc/5PPUgHOe5GKDqskbhyCu5p95j+ubwrftXh6nZmlWiiqw/S/3t0Uq9EbAi/
X-Gm-Gg: AR+sD12ZAlSF0L3TtRzHGzB+KBaejACDHYktf50M+n8YTT8ESADT3sRlzIt68lnpJ+m
 tpSe/ffL7iIqoOpL1E2sAsPf0Fi7kBdUBskw+2MnJV6ABggL16FpqyK7lO69+CxP4AdKl3rLEAr
 MvwU9ASa0i8Uf3armu6F93681DG1cEiCvPWmaEJQj1Eyow39ui4eRj2vbxat2S6CgiONNfRou6B
 Gmbc4y8HeP+j87YOE2Jz03mA1yDgMNv8Bj7MqYVN48yKViLCkd0z13BKZL4vgIND9fw8IuFEJiO
 oac0qd3zsS0vyKNiV5WUXnETe6QlGVKzLWvVLhnnqAGJ7HH7+u2wsRzF6le13hg/rDyEDOJzvJq
 7PkIaD4qU61swOImxmIE28ppfHQMzkAi5ZvnRBoactWBMglgJ+HgG+PN/JSpC4iw1DE7g8pE9Oc
 U5BVpuUSUVvlHJEVKgv+XYjyUwEGm/GBRErCm9rbzEa2pufRZqSD70jDl6Aq46V/28nxTXmkUJ9
 YMJAYPtUlstYVMiUclMibeDk7/zDae/XROgKWJ4daDNgQ4K/tXeEFD+IzxD9P2t4nlEH1YUcENf
 Akh6TcJ//JwngzEPvuurjTDUs74O7QTagIqHtF2YXNrBxawSJeM=
X-Received: by 2002:a05:600c:8010:b0:499:7e2b:8e5 with SMTP id
 5b1f17b1804b1-49982183d3fmr86295365e9.5.1786635706200; 
 Thu, 13 Aug 2026 08:41:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e2e266sm54370205e9.2.2026.08.13.08.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:41:45 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 15:41:44 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f
X-Gerrit-Change-Number: 1840
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1840?usp=email>
X-Gerrit-Commit: f893e6e68b48f09a37edb9ffe0c89c519051017e
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 15:41:44 +0000
In-Reply-To: <gerrit.1786440840000.I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f@gerrit.openvpn.net>
References: <gerrit.1786440840000.I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NDQwODQwMDAwLkkxOTEzYTZlNjRiN2NlMjJiNjZkMjAzNGRmMmEyZmFjMzNmNjBlYTlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1d9934c97d352d23fe89a96e1b67490f0f1f28fa-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuXZ7-0005Og-8I
Subject: [Openvpn-devel] [S] Change in openvpn[master]: OpenSSL: avoid
 resetting the HMAC key on every packet
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4601343567346569640=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4601343567346569640==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q/r4dIrRL18="; charset=UTF-8

--Q/r4dIrRL18=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1840?usp=3Demail )

Change subject: OpenSSL: avoid resetting the HMAC =
key on every packet
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1840?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f
Gerrit-Change-Num=
ber: 1840
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Comment-Date: Thu, 13 Aug 2026 15:41:44 +0000
Gerrit-Has=
Comments: No
Gerrit-Has-Labels: Yes

--Q/r4dIrRL18=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1840?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail">change 1840</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1913a6e64b7ce22b6=
6d2034df2a2fac33f60ea9f </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1840 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Thu, 13 Aug 2026 15:41:44 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit=
-Has-Labels: Yes </div>

</body></html>
--Q/r4dIrRL18=--


--===============4601343567346569640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4601343567346569640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4601343567346569640==--

