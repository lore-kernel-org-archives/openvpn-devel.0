Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256BDC982D1
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J9gTqa6Rh/NIyCP9mqHAlQahQQPi3Pk82aI6+TJ59M8=; b=IgA0niQJmNarWqNdMjS13yCo6L
	wIINA4HzGfFq6uySj6z8oMG+BkDF6ZWOSdlou62e7pHBk0bvx7aMzYgd44idcM73feusmanEGJjgy
	H3KKhCaPQsU9VpOq7UgiUZxe0KNAZB+dHeW7czk6LjeBBZd+bBhzVTVUJQemmjGa7vFQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7Byv-0006Z4-Jl;
	Thu, 17 Sep 2026 13:16:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7Byt-0006Yw-A1
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:16:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kPG1h7Mo4C7+4o7WqpdjDfTmNF9Bt9NXW/xwlJoy3Ig=; b=fZ7ID2+Ulc0J1+eKZcLaoe0saE
 xrqURYBU9rnntlu5GspqBbuXRAx+nt7K4qFKdQYHdtiABCWQCc/WKiUvNoVy7jm+O7VBe9dR0ih2j
 UzwQ4XwsUOR/X8YPsUcBZxLR4X9LqYe5LAeCm5niaMoFppJI9/th4XgAwM2GDwShsw04=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kPG1h7Mo4C7+4o7WqpdjDfTmNF9Bt9NXW/xwlJoy3Ig=; b=d
 tUiqSAqdHeX0OkIwxeqgW3O/QQ5Bt3GNkZltmPidVhKJLtlFmSM5HIcQWm0R4jXAFDJBDDReRBFOt
 Yw3gk2/owS+7x9xKt30TUbpno0I04MgzUHeunYRZP5IWWzRaRa6jAqbznSy9v6Q7OZPhN3E7zvS6h
 8F/do53E6P+YajrE=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7Byq-0001Vk-NQ for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:16:51 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843172bff4so476612f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 06:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789650977; x=1790255777; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kPG1h7Mo4C7+4o7WqpdjDfTmNF9Bt9NXW/xwlJoy3Ig=;
 b=W1DXdkvk1c0i6E3dj1af2Z9P9suRwukyr8s9Azfb1Taco1ohjQUpSENXLli/R8n/QH
 5PJAMGdeBCZBTLJEdl/bf2F86eu5Zw3XaueiCmDPiNpFQNh6UWCuCaxYRRFf4Lodign4
 q9We4nN/jFSq6Y6ukWpbhb61hFCCeXFVUDRdns2Imxmz071Vk2i9EDj/BAbnUjH1c33d
 LbEfySjYZBnqBTQJG3iVZckr6A54rc7eRT0ve15Mz6UIasuKhSt2CFlQUjLHVznL7tcG
 7yDT9Ll/2Y+v5xp7iBF+3FbVOlgBIrlsglN86hm+gqBUbHDD3B6Mrc3DJFhpysqGFkQ3
 9IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789650977; x=1790255777;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kPG1h7Mo4C7+4o7WqpdjDfTmNF9Bt9NXW/xwlJoy3Ig=;
 b=TFj0QHtSRzU86cWjvQrkfshFXmxsOASB74AvOwGPru49V1C1Z5H+/0TrS73LPRZ+dU
 4a2wdwp9SXLvaa6XoSjdJhNx6yvlzOPs2crY4R+EfyndWP1WQPWK+jbGqydPma71g9Bx
 Nx1525fC4SwTZRflToabrGZYApKlGdZ7GiUAbLPt1RBp+9uImhe4ObqZWqiZL8oH+Tar
 HTKtSfZNPxlqVrCzN0Q1TKweE/C1/LdL9gCj88j1yVFaXUrz5slSSSXvuOOYFc/4AIJs
 DsFtHW3y/l5mrIx3j06DtQBwuqGZmhTOA11DxpSyoHq9FyTUI7ccNyphJ7wYLmoi4KDH
 OQRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwC2jMxw3Qal4H6cB89RDhrnAlrW/1Cx+f1lZpo79HuALzcSF8PVff8jqCwTn3UakplqXmjpD2MuNR0GEFn@lists.sourceforge.net
X-Gm-Message-State: AFuF++kc7HjOt64pxY6uyhke7DXsNicYTz+Fg3GNNADl9wnXAl47/DTU
 WCcZLHYSYZPfrNbbZgeY0N+OkrSMF+78zy8OYpd7QBhJUhP/4Wtqre2I7IalVwsC8QOYN5Gq7+L
 KgNpe5rLq5qGv7LLXBloIpj64AZq3buKTdLYwVKVSzkS/QNBHPXZb34OMqgHyHZIGr4B3
X-Gm-Gg: AYBFou3jbcxHgIsp5qfSXrvNOFtW2F65RisvaJmSSFLeLvjVq9kHxwFWTh7QRVgb4Zp
 aKOliAXfLMEaCFHl200ureKTgkhViqup23OkDUJd+0T6RLIWC0HCpb47EUfP071jL6sI4XHWEez
 HSnpFWoKbnBvpiiet91PmQTr9Clx2QW1PF5t2icXvLGUEw7dj2toDZlvGo85Q4xqrw4rfCKMXG5
 uBwAkNa+aqRuDscBOJRVHt9NqYisXrqosFqRzzWORfXKV3VcLO34dsUUSUjOFS31lGha/fQUUCf
 akdgcQFMKuLCMjVc5qVQfs6RHIZiJYkjDCsVLgElmZ/hZrRZIBoMgf21TuzHgkUtVqT7XexynEJ
 mCUBDaRLC8aKU/QlbXyIFCFu5NGNhshKxhmxq1+o9iZc2xmYzFd6+0fO408S+O/BXq/3p4dqclA
 9OLIBeS0y3u4W+520bauQmz44Zh7QdHIDpKSNsJjkou1palIyqzn9AuLlH7AnEdNEe9ZIufSxfd
 fVtN4nXLDey7rs9Wbys+OcG7lblen2EV7R7GbadtCw2dcakaOHwRX4KcN9yqiXVfm0IJMWQ357Q
 sgBe/fjHcrdau2C5T01FO72hmiehI6L5UOjIn9DYFMB5SeeWuXVtOrhYzBORSw==
X-Received: by 2002:a05:6000:490d:b0:487:342:d142 with SMTP id
 ffacd0b85a97d-4870d16b276mr8080904f8f.44.1789650976434; 
 Thu, 17 Sep 2026 06:16:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bef7678sm16270800f8f.2.2026.09.17.06.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 06:16:16 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 13:16:14 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: a546fb4d13544e6fda8f7fd04249cddbe3925d54
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 13:16:14 +0000
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f79ce70f9bac7ca23eba424fc84ca2806014f49a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7Byq-0001Vk-NQ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Extract
 init_tls_wrap_ctx() control-channel wrap helper
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0827847027952023258=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0827847027952023258==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2HZ4w3Pzy6Y="; charset=UTF-8

--2HZ4w3Pzy6Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1749?usp=3Demail )

Change subject: oob: Extract init_tls_wrap_ct=
x() control-channel wrap helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 26: Code-Review+1


-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
Gerr=
it-Change-Number: 1749
Gerrit-PatchSet: 26
Gerrit-Owner: stipa <lstipakov@g=
mail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Com=
ment-Date: Thu, 17 Sep 2026 13:16:14 +0000
Gerrit-HasComments: No
Gerrit-Ha=
s-Labels: Yes

--2HZ4w3Pzy6Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 26:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">change 1749</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7d8546da=
9ef06c2226ea77e461f9550d24894c61 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1749 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
6 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Thu, 17 Sep 2026 13:16:14 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--2HZ4w3Pzy6Y=--


--===============0827847027952023258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0827847027952023258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0827847027952023258==--

