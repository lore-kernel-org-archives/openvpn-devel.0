Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB607C5AD55
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kj9xEx+bkQVhnmLN/S18aUGM2KIUf7k1ihAtCTxpVQI=; b=kCNLR7khi5u6jhNqhIzYDU78ll
	RM1fGf9njuvUVQwYhrE3ZZ2RGmtuT6Hy3otgl56PkmCExYlB6AWcHwQa/Qgimc3HuJ2VB9lVxNnPn
	mUUa21UL8RJg732lBCc0179b4SlOHgHswKjba9G53/722EpPzCWDJ41jCjUmXx4Po6ZU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtOiN-0006FP-Rm;
	Mon, 10 Aug 2026 12:02:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtOiM-0006FI-QN
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:02:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NFdZPBkI2xLTCNgr0SkV+NZ8IdT4ifTP41ziORzgx/Q=; b=ZFKi/95K+MXUmTS0xCDMSDrJEv
 moe5ATJ0CQNl0fh/NLvNAqYfepS7P81zKNi4YopBnO+HI/sRJlVw+Eq9t5c5/YY1WE9oDZ4CfA1np
 C3pzA6RL6bAYAeAohORbT4IlQJLprRuC0/BgcnNsZgWQwCJSGzhF4R04z3ddiIcFpgzg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NFdZPBkI2xLTCNgr0SkV+NZ8IdT4ifTP41ziORzgx/Q=; b=k
 6rtncSRpDOnQ0lR5AiYi8VzRUGi6fkeIk7LqwK4b6m+eBZnQ8J+CiibeidIBO/4C2WECRbdNK6w2y
 MavS6PtBwr8cYtfuL5ABlS4HbOjJwf6UlYuz1kznGLzOA+NKFxkBQSd+KyBzyokahQfX0hW0GwPLh
 UhQVKFs1/RUXF7t0=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtOiJ-0001QK-BR for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:02:46 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso8328965e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786363353; x=1786968153; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NFdZPBkI2xLTCNgr0SkV+NZ8IdT4ifTP41ziORzgx/Q=;
 b=JwGa6rh72ex0Sq3yoMlaPvygeMOsHnQPZn1cbAAUPwdZpSZBguQWsZnq/ulGutEmuj
 vUoSlH8cUVrn7WYeqre3Jf4X4jT2yx8M6SDoSgedrccLZuhRD7sys53KjFyAyyNShpiu
 I4XipJcLnMibavIQ97og95elO0pIq2NWX/YJxTC/wQ6tjZJWtEAR/6U1/yDCsw9uTi3T
 z7ClGA9ljdfQZ7zrdfn0amVy5DYGSCJlgpV5DpLzDK/5oEyaEBNDVtTVdVSHX9zjltlX
 GtgJUDL6If//53JiNlmtABIoKr3Y1Mz5MFiGUvBdOobCLa4mj2pM5lNNhbwMBZlVQ9/y
 c0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786363353; x=1786968153;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NFdZPBkI2xLTCNgr0SkV+NZ8IdT4ifTP41ziORzgx/Q=;
 b=FEBVuJcrs0xOcB3HZJkKZcjtNeDIXOturR0ExXEGnX6IoDOHb3xQMb8S3O0fZayCeU
 jdBmO5dLcNA1eL2SLkbvvb8LWhqW3YCGUS3LvpK1f8+99wIo0MiniUmKlHp+HeVOf6qR
 /IUR4sN9yVaimQl5wzmZ4Qx6lFKnkQgpUu+aityvkqkc9WGQVAX5yn9Ixpe5RvgQ9LgB
 OrMEfASh7UsTyN6jWqqepJzXX53IFtiWc92y5s3JwCyqNHnhnkjZB5/F1Ah/L+s3uAZA
 ndgwX4JhvmVdQ3gOpiPkfiCxB+bzex7WwT5vFVODTOLeGUipxxsGMli9XsKcE4DTH06T
 wvqA==
X-Gm-Message-State: AOJu0YwXqLeHe0oG41xQ+oZ9hevUfxgEE1of9NzODP+lxyAiEZNSY8+E
 SrlIac1ztBRQmEb+DAIXCFr2FuKjEx9WVL0qoObL/Ri3PItgN+197wC2OYiyKVcr5S3awfe4haM
 BLPFz8AY08v0Rb/GCyC9xCkoyJRPu2CZXmxKv6tqbsrewc2NR89iIvlXeDGs/BBv2CTjgbxpqFS
 s/hiR2Ag==
X-Gm-Gg: AR+sD10Dw3wU155x3E7/R7gb+0o9KkAKyPN8SkubSEyEXtuFHgZ90J3ZS8r6/hEcqBg
 Eh8mqAHroGF57dKSAb+jZXGSGG3UbXqcJ6b3AC/GEzAX1RdZFIGXxunI5Oy7PwJas27fi533GbC
 5RxFkdRnKEGQm4f40bv6n14EK6G9A5kSZM26y4CZjsX4P2dwTmx7EhdqX/r1H4qYH0VOXvlVe1F
 oYI7S4suM9Jd/uEVvvrEa7kWROJoNZ6tLkqFUBY5juqqjNa+UDGfKgkFQ/NnNaZfn00L3ItdUVq
 4QQe50eXT2zlbvEWu2bC+i7ig/XNus7zTrBh5HdhYxwewW7taL0enb6Tkr2o2WRSwNdRegOtCXJ
 b36eA0vWy2YSA2+MN4Oc8bJR4dHiJ6xBahZZ/WtbcZkYXbowcZyCxCbpbSTuUAt5zXIRYoPy3LN
 rDQCW3QGl6ocISoitTEjogFimxDDm02qsHX5FBA0Oc4YzSi4fi5WdLIdq+ipjyjUhCfDuwdR562
 HCGKNuis/M03/S+fWXpQlTIOM1irS+oGi4nDqVpwlAuPkQWIB/GHaWFAdWws4zvO+s4Dc2rPc3J
 2pZqEAtrTgmHAuMhpAdN8GfT1NJFMzPjzOCF6g58lowAvIiiv0c3XbbN8hLNtw==
X-Received: by 2002:a05:600c:8b51:b0:495:6b55:f938 with SMTP id
 5b1f17b1804b1-4994e7ba99emr622128785e9.10.1786363353032; 
 Mon, 10 Aug 2026 05:02:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021457ebsm34141460f8f.6.2026.08.10.05.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 05:02:31 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 10 Aug 2026 12:02:29 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff
X-Gerrit-Change-Number: 1581
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1581?usp=email>
X-Gerrit-Commit: 3f9752c66048ef840eaa0641294544606994e16c
X-Gerrit-Comment-Date: Mon, 10 Aug 2026 12:02:29 +0000
In-Reply-To: <gerrit.1773842036000.I350ca5b08379ede1480b81055d35dd9a33e30cff@gerrit.openvpn.net>
References: <gerrit.1773842036000.I350ca5b08379ede1480b81055d35dd9a33e30cff@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczODQyMDM2MDAwLkkzNTBjYTViMDgzNzllZGUxNDgwYjgxMDU1ZDM1ZGQ5YTMzZTMwY2ZmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <25de1aced890f57a4b82763f35d58b28d6b2e222-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtOiJ-0001QK-BR
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: doc: add Doxygen
 documentation to buffer.h
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7360325437233573540=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7360325437233573540==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FL3FDjOUBY4="; charset=UTF-8

--FL3FDjOUBY4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1581?usp=3Demail )

Change subject: doc: add Doxygen documenta=
tion to buffer=2Eh
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 4: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1581?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff
Gerrit-Change-Num=
ber: 1581
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 10 Aug 2026=
 12:02:29 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--FL3FDjOUBY4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 4:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1581?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1581?usp=3Demail">change 1581</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1581?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I350ca5b08379ed=
e1480b81055d35dd9a33e30cff </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1581 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Mon, 10 Aug 2026 12:02:29 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--FL3FDjOUBY4=--


--===============7360325437233573540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7360325437233573540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7360325437233573540==--

