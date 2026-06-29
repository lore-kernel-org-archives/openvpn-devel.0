Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97B1C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=va0XwUF02aIgOQU+jMyqooSSIPelw+ob6fTyCmROzCw=; b=efd00pyacBoMDDipmFb2u5+Hn+
	oBNvyhwHyvgJDzkq4cVeTJjainqzv/GxHfOXjPbrVIFG2uGX+XdUpB764vX6/nGTABazi2kfLtAjA
	hCNtTre2/1iAF523UOk17Q996c4Ir167UOaFn2WLcWet6VI45vqhotBFNtwiW9Kpp8VI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weCHL-0000uw-4c;
	Mon, 29 Jun 2026 13:44:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weCHJ-0000un-94
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:44:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gHjY6jnXxou7yb/FX0L1AymkbNE+mMNBx9pF2Zts68Q=; b=dAYzJflpB0rQAza2dE1pb4O6mA
 UM2dJFLZasE3gr/kHzFxv9mr/dnIyHhS1ocXAb3302nZsEeZrbueGGsnToXKVHdcJhnQ2rOpEHZZS
 YWI1qt21VoBRSN6NgEMS/jdBYIIO+HPblLE7r7iEmKBVZIArqnOczoD7spPVjdplftV8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gHjY6jnXxou7yb/FX0L1AymkbNE+mMNBx9pF2Zts68Q=; b=a
 EZ/AZtyGGWlwwW2xXQrHpTRgpCQ9hngEKxjXHen8fsoeE/ZF3rNl9RIZCotGMN70A4HEiALBXmyuB
 gTKGnY95BNHq9RZR8kffMLJrxMDIrguDc3bBx4OEn99k04wfgs2m0s08zrr361AOBfTKEdwuTM9AW
 /2gLPjqGW8qmIF4U=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weCHG-0000Ay-62 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:44:01 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so5247165e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782740632; x=1783345432; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gHjY6jnXxou7yb/FX0L1AymkbNE+mMNBx9pF2Zts68Q=;
 b=UCxv+HKGkM9VqgxvW8DgyYK2appsZohI2LOPOmfSvGtn+GZJu44v/o9xQv4hu90ULP
 RebQN6n89COg7YgVw6ISPYBVvbKBfC938WIYz2dMv8hqC4FvKb3hB8Z8yk+fnHT3MhHA
 gVr/PAOL2DyYWC/SHifZqOto9AMhuPtKQMGHKs6GvgjR+Knw682EHCPs6F5tAZxRTsux
 YZoBWnNpSesj5J18A16mhs+KXmdLgCzsDqmlRxZOo77vG+jvBl4k9eqoGZNuONteSAIq
 5y25B+9VbZm3LL07rEHqPyqZERnEXtqUp1Kw+16yTL89l8fYRmlH65mxbUYoPSE7lySS
 KSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740632; x=1783345432;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHjY6jnXxou7yb/FX0L1AymkbNE+mMNBx9pF2Zts68Q=;
 b=d6/Xmlb91UAH3X7XHeO4+Qf3kjgcBIHxTgT97Fq3U1ZvxuHSzbOmEj+khjH2Vlu2ev
 YYMLSeRER0Df1UFfIUq4yEqqxSnosiubUcTQLdYv2j/534YtOwZHbS1kWmCqzWNAFNjQ
 qgBDJUNpikAD1mgaVVCgbe7wTST33nMOr51JzN0jmgD/KSHSz9SwqaZBDHxNhQ2XpxHm
 tVP//2V69bieu/qnnoj1IeiRtOsi/VAEBu7d959zEF8TNE4OusP8a2vC83WAPrPVE8sL
 ft6oTDn9CPssoH3xcW4rAw/YM7fov39MYm759Rm8CYxGrA9G2w5LlxrFIeuoQlM0E40u
 XpwA==
X-Gm-Message-State: AOJu0Ywr8ULkvFtgcBT36nwn7Cq2vlJSplj13++ueey5WXxU3Jyqk9/A
 EqGT8WlRcEgtllrbmYqJErCnoudWAPdrqb62mheOCYWRqvv2qFXiDj2gJH9yEHuRcbphhjLnGEw
 /KDWFGWtq6ZfIvpetkfrgcsvhPKnepXWsaklZt73hoAgGse7PWyZxBdst43BUNjETEv1NmsP4p0
 /NOI+0xA==
X-Gm-Gg: AfdE7cnv6V/NdTd4ipSj/2oJ/D8oKKnsNN3gReBZ3WWfcvhR/673ISn/vCQXLTVg+ON
 i0/ECKavyPjpUQeEYQrbVX5GpK+vLyey0rQE3/zznPMq6athGVpQM8YuQMviWBsGNen3AUOhZkM
 5qd9flZjf2fgQ/1Ljfco11XvOoHdJLanCjqqbal+aXoJR+dkyzxPXF33YfoTDwYyNXbz7JtxdCn
 IlZVjKplIum5Gg8+2rV2rErRZEeh+C3MtyU6JUIDZFxA7u9NaL0n98M6goHlePChWeTRm6EeuOH
 IMtQtBJONQeOVXT9J4Ny0MLlyhK0z8hVlBbZkLOKyjfUhSqAgP1s8cuK9xlmQ4Pn6y8VqxU1Q9D
 5knovpAIr2dA7qNTO82y8ZKj75R6Eo2+KZdiLsXvHml9gJgCHsz2KZ8ZhtULCvWjKaBHu6LNetx
 GEKJGOcQSvdkBjr4qITc/rnJ+GCZhs2jgku+C1prS3wHrI7m8vr6MV4zUGezGUqkNIS4B86qikq
 S0uC/rHm3+6r3ZoHU/E2DTYTlJcfVsQ5ArH+RNtjHdM3Eme5DmVC+9bqePUzcFuQRi3KxS7p/5i
 kP4=
X-Received: by 2002:a05:600c:e54a:10b0:490:b8ee:d6a5 with SMTP id
 5b1f17b1804b1-4926683b8ebmr172465605e9.6.1782740631753; 
 Mon, 29 Jun 2026 06:43:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268ffe204sm323137825e9.7.2026.06.29.06.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:43:51 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 13:43:50 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d
X-Gerrit-Change-Number: 1754
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1754?usp=email>
X-Gerrit-Commit: 438ec4d558136e24dad22269dc2421e55c47dafb
X-Gerrit-Comment-Date: Mon, 29 Jun 2026 13:43:50 +0000
In-Reply-To: <gerrit.1782740317000.Icbcf4c79d577d9cf089a92378be9253b1e94825d@gerrit.openvpn.net>
References: <gerrit.1782740317000.Icbcf4c79d577d9cf089a92378be9253b1e94825d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQwMzE3MDAwLkljYmNmNGM3OWQ1NzdkOWNmMDg5YTkyMzc4YmU5MjUzYjFlOTQ4MjVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1d0afeadd4f970516f68fb4b525e841d16ee293f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weCHG-0000Ay-62
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: GHA:
 Cherry-pick changes from master to keep working
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
Content-Type: multipart/mixed; boundary="===============1504900991990507061=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1504900991990507061==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j1C3QlWjklk="; charset=UTF-8

--j1C3QlWjklk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1754?usp=3Demail )

Change subject: GHA: Cherry-pick changes f=
rom master to keep working
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
Do you have gith=
ub run link so I can see that this works?



-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: re=
lease/2=2E6
Gerrit-Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d
Ger=
rit-Change-Number: 1754
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon=
, 29 Jun 2026 13:43:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--j1C3QlWjklk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1754?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?tab=3Dcomments&amp;=
usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Do you have github run link so I can se=
e that this works?</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Demail">change 1754</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icbcf4=
c79d577d9cf089a92378be9253b1e94825d </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1754 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Co=
mment-Date: Mon, 29 Jun 2026 13:43:50 +0000 </div>
<div style=3D"display:no=
ne"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has=
-Labels: No </div>

</body></html>
--j1C3QlWjklk=--


--===============1504900991990507061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1504900991990507061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1504900991990507061==--

