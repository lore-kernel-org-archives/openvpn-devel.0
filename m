Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32898CA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 18:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jmaPrAQXLaB60BjMkBKsk47AYnLZyhuHXXn9+pEprts=; b=Q0fYWBuyH3g7CWxzBoToYcx9+6
	EfA09Qa4bHPJvwCWfBYyXEq7VSWntStJ5j4EZhgkk1jN7x3w+b0Hq5HJNrURCkb2aVF3mQC+wzcZ8
	xEi/9yapQMk61EuJTu2fA+0kaUVwDzKfOOY4HTElOb6RZ05e/AFz3pkWKAmHw+Z4Vd0U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xD4Nk-00083d-1W;
	Sat, 03 Oct 2026 18:22:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xD4Ni-00083X-Rk
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 18:22:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4Yl6ABLrc6vtpJlkaywrtBcpZjGYDaU8fB4rdvqZByA=; b=nWZ02k2EKWmiRfyNH6f5E6dFGi
 apOtu7sX/ipp+Poj9BwtG0RPVqXph/ud8Xf8p1J6HHhxSkrbaerDHF6PxjJ+lWwVOGdJiV/kuWSK4
 r4W+qVvXDzLl+jGcJIlzBi+XUYInJbxf39XOHSHyTv8w0aHZ3t9gYpfsjvyS1NtezP4k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4Yl6ABLrc6vtpJlkaywrtBcpZjGYDaU8fB4rdvqZByA=; b=f
 2Duaj3/bVkX2g5fDvUD5PvzHx0D+aplS92uSaek32QZJSqUTVLer3qWKzgCntCAmdszW3MBP0vhAp
 kep2NMdsNlMEwBuIRJ+o8LA0wxcRI0z6AaHbZGuLLqg1WMMhpzrZVtxtxSjDsItXJBHBuM1GPej0u
 x8V9uzc57faWwpU0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xD4Ng-0007xy-4F for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 18:22:46 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso6009945e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 03 Oct 2026 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791051757; x=1791656557; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4Yl6ABLrc6vtpJlkaywrtBcpZjGYDaU8fB4rdvqZByA=;
 b=OlxIofhhzEPZdcc4l10ye2SfFVcwcSSv0c4x0J3jeTMZYxCWUG5PYRDb98eAM66B8v
 2dnKBpMEzFk2cjj1AKWeQMtCe3k8INGpYiOHC/Zs7+bnFIOlb3La+dbkO+/qGLoWlMT8
 Z6uIWHhPPLD8w2+P+sab+aF9G7ztrJSQWCExOevEOjxD7/aVAscSuq7DuDwR9IwUv1ZV
 r8GAUzrmMiZ77SQ4XcqFq0coW1vivv/FJ87PdKB4G0tD00Mi0a+fyUXL7X8ol50XLUyE
 5B/LeTS+UVlC235Ang9duLJ7YejUyhrOrxW87hXYUKHhSYE+wzTOcvxZqRwHCfVNb3n1
 Gcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791051757; x=1791656557;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4Yl6ABLrc6vtpJlkaywrtBcpZjGYDaU8fB4rdvqZByA=;
 b=tQlSbEO75eVO50uC0jA7rLOlL0eLtz92WU+JljKkejinGLYMMkHwWWy4YTRbGz3xgk
 XXUz4iO1zVFczmkGZFfWMG4FuXoyT7GIYVqDIwZbCbocTYuraSbC4pxXSGLhwPkzgOot
 Cn73vatd+efxXAdob4FhxUy97peUl8lJb0RYsOBTGkW3tZU7Y2qm1+eoTkkicgDYc6Uf
 CcsxohsrThx5pNmD99m+cylKOp+Mcmpz0g6Hvg68Fbqm41cJosD/cCfzhjQ9LlLgqFow
 ltHLWmZC2FL7PDPhjJ6DS5vIEs+cMBfKy+6iy1uYE1zybfSGJdNyCoZmZhLDEuh5KH5e
 0VtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+YEMNjyLSDucZp7man8AiiM1T+vCEKRvHgnaaL3u2b7913vNbH3cSWOEwwqHTpeEg4tzL5Lo+jUXo2tt2@lists.sourceforge.net
X-Gm-Message-State: AFuF++n+LOi3xGcjUoVgxFXQ622FbIaZYEvcNZmMAxnLwPn+N4taItv1
 TZItWLKW+rJfPJXSXGLd2hF3Xx65/EjOnGB+baS4WdT3I9TcBKDVRqc7kY4AEu5BD+o67/JP7M8
 P6BMveyleRZKcUsoLjwxoy9qjyz7SnLU1B2M4pbPlitrFnxcNq15xOKfgWSaTGvsKD3vP
X-Gm-Gg: AYBFou31WLdGZRw4G9n8GadooGEt6WOpxtRWHa7XYuIZrsE1Xwo/q+6XUTutfhAnOeL
 iF5b31tzBx0AbXzaV7y00GxTZ/9/BNxXfgtHRT7MSerKfTok6XQOugkedFFHUlgUR0HEM3s/4W4
 ROWmpOLsfZreUOJIPDh/ZfSYUD1F4cZ72BKGP2NLC5apt5BCbygrYgevKRzXMG8ho77ivSEuzAh
 mTyeIbboqN9BZDqY9Y0/6ppccYjL3/waM9DaMgfEAQPDTzC2kGz1Vwv72keid7n9oa21ZximQtP
 +6xgdPTGEk7PfTJiL49FCJJxNB0ZeGQkZsIabGXRvfBzG0/kmXRf8gbMXLqLMxoBowLTCyhKwxD
 1nTLHYs47ZIxl6pogn4vURZu4D6ITIevvFGqGJo59HMnAUwR4iyU2gDS0dAqnP8HM7Z//5QGJ/4
 rSewwrTje7fPhj9MMO5IR1kBfidO5NfEBKweIMrrijdvBQZ5N6oSvHQIoE3YdkF5lRWt/MHp4Qv
 p3spT0NB4MmxDkRQtGHP7cl72LImyTo5Cp+2rISdMslLISJR9tp+36W9MiQM00L/gbDBx3ZTJTp
 /5IFj/ns2n1Vif0kq30Dk7cojoMeEULzgEakV7leSFxO0vByC6GMZdPYv2cM
X-Received: by 2002:a05:600c:c3ce:10b0:4a0:317:1996 with SMTP id
 5b1f17b1804b1-4a02769f2a5mr75821445e9.27.1791051757486; 
 Sat, 03 Oct 2026 11:22:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380facfesm14548848f8f.23.2026.10.03.11.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 11:22:37 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 3 Oct 2026 18:22:35 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3
X-Gerrit-Change-Number: 1958
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1958?usp=email>
X-Gerrit-Commit: df550547ae61be0d65a72108b91014709809fd59
X-Gerrit-Comment-Date: Sat, 3 Oct 2026 18:22:35 +0000
In-Reply-To: <gerrit.1790610390000.I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3@gerrit.openvpn.net>
References: <gerrit.1790610390000.I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEwMzkwMDAwLkkwYjM5ZDZhMGZiMmU2ZGJiNjgzZTk1NTVmMDM2NTM1M2M0ZWRhOGQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0326d5ef29aa9f8bf4a82c5e3c75b8a7643bbe4a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xD4Ng-0007xy-4F
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix all occurrences
 of cppcheck invalidPrintfArgType_sint
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0712794310313281997=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0712794310313281997==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XS0VV8Fy6zY="; charset=UTF-8

--XS0VV8Fy6zY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, plaisthos=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1958?usp=3Demail )

Change su=
bject: Fix all occurrences of cppcheck invalidPrintfArgType_sint
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1958?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0b39d6a0fb2=
e6dbb683e9555f0365353c4eda8d3
Gerrit-Change-Number: 1958
Gerrit-PatchSet: 3=

Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comme=
nt-Date: Sat, 03 Oct 2026 18:22:35 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--XS0VV8Fy6zY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, plaisthos=2E </p>
<p>R=C4=83zvan C=
ojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p>Pa=
tch set 3:<span style=3D"border-radius: 3px; display: inline-block; margin:=
 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1958?usp=3Demail">V=
iew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1958?usp=3D=
email">change 1958</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1958?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1958 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Sat, 03 Oct 2026 18:22:35 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> G=
errit-Has-Labels: Yes </div>

</body></html>
--XS0VV8Fy6zY=--


--===============0712794310313281997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0712794310313281997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0712794310313281997==--

