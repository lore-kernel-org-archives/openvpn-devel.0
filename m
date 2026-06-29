Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CD5C43327
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y3+w5Qa/h0FY5EBY/nbmr722mbYFWKYQDYH9AJAi1fU=; b=F/qPtqm6gXXcYktWOCwt7O9kA5
	0a1prcZ4Wze5ZUcfE4g65JzYKVui+DTdUEwby80bBNrkOYc47c+S2uX8W3rU9mpSxvpC+6Th2maSw
	6xyHdUIMLKKaqeoyBJMmlp17nzjnEk055vUnpGrjIfYDJskoW+cH6AucXOkNuAdttlMc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weBFI-00073u-Up;
	Mon, 29 Jun 2026 12:37:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weBFH-00073j-Ta
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:37:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Grhqk8rdRsBT1p2gJUACfBzdvXZ0OoGdY5IT6tEX8Gs=; b=A+w5vzId7vjfaD7iuleizuje8m
 zM9JAwRVcQdqu7oIs6sHXbfnTlabGsz+TDxiLnHZNbpyt1jZckc00wwCGPZWWzq2/YMPIHmvFvJtt
 BqcdZGpgVYs2fjBGOh6vaIbjihepf7eeS2FOLa3VQW0qRcfl7Sj62VeIq+iCd32lFJ1w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Grhqk8rdRsBT1p2gJUACfBzdvXZ0OoGdY5IT6tEX8Gs=; b=e
 9HQNKMzadbsu7gz4emVuJb0KEv8SBX6l2g5m9+HuM7BuoJidAaaeP8pInetgXVxLiag9ptY7QLiJq
 aoowHQINUjJ9zgIyAazv/bn54vZR0kbuhsXSq39654agh8g2LwTrJdVXqv0ZcQUEgz9WnlGSJ2n8L
 gPrrPDZCQgtRYK5w=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weBFG-0003M1-KU for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:37:52 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so27145135e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 05:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782736659; x=1783341459; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Grhqk8rdRsBT1p2gJUACfBzdvXZ0OoGdY5IT6tEX8Gs=;
 b=aJJG3bsBm9SAoolGPagRpzeScoDRSu9eYCR2HD7VvNJJU1P8nmGUN28GPvc4K7CetR
 JP9JOkdt7bd+ZA1XLQY6Q4TEzihwM3oBl/zTiaA2SnhCFJzLheCULqjPpmoj2nE6v/jh
 96/aimqQw6geUpuFSsYhKibdpQOXRZ0RvQiQMhy63775zIcw3mgLHz2bXKKXqYx6Ttc/
 ku1X0cID6LaGBUgtOm23eCHYour6KO0V0S6tuo19DuymWnrf56kgeLWc/0hLpHOydF7o
 sVi1cswrGv8LVlcJHLUBgYeMOHIhvviI49WY/5VQEejMyX6AoJSQmyeB/zXJjv1g2j++
 iLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782736659; x=1783341459;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Grhqk8rdRsBT1p2gJUACfBzdvXZ0OoGdY5IT6tEX8Gs=;
 b=KBeh6J7Z+7e/MEnpMcn0IhtXYw7WCxzeKzkpFU3jX/ypwLCmU5HPW9KuJxN/1cMN9J
 9by/zjLnPODum9GmoLTgj83OL/eKib6cKmIfTfIQgca8RhCZ1IjsopaD6jKEy7vx70ks
 +LldwJCmQP2R2Amcmk+Xy452nKkD7YbCzYTlZJE9BAoVKl/iPNVTzqDnKJvOPcGA9xAU
 5FdUUK2UaoPA6MYi4sTR/AiX/U1/gh30sZN59/12xJagHdzOgORNbzOh909IvhPZVSME
 7WxT1yEcCBWuwMf20thnJMDGr/s6XcdewQ174j29CKsvBkpBH4HLbGCiBAt6APLCvogS
 tD9A==
X-Gm-Message-State: AOJu0Yzndz+7aJY8SxsnRN4xXmNkynASZQHXh54kHkEBLLHk+Ki8m1gi
 9kURQgO1fYsKmTfbooNWvoOPRev7q9NrYMYuin5Sw3Os1BO02kPtxqp+UmoxumX/HGDK5WRa6nS
 uvtQr/j1yxwYJvxCPXot1WWb62g/1uj+tOrNUrmVaQxgUlPeQ4DzMZLQPXuYT5Lk+RAHdE6fJDB
 jrBkfneQ==
X-Gm-Gg: AfdE7ckhL96Z+mOBhTxC5tSXTX/9Gi00OQG4aVOWGqetE+umzrK942lPckkvmhKjK9o
 WquMiyq5TdYQJWpG5EJN7IebnXIef8LDK8Q/tvkoW/sPE+HA/6ekfDHiBhYC8t5mmxbP8krS+IH
 cSCMuugBLoUNpAeFWcvqWFeJzcEd8t23CI2hWEf2LnEL4SEpDUNhkTM32FVDjfwGkcYquxYaf4P
 5/Fmd6mXZrbOa1nk9ihispnAGPZPRz8AwB4qD+qdQSMoXXRSqnzgOjzBcFtpBSpw9oAr2dDAHgD
 W2MKp/Jc0pAdBlgVwQhYQEbpRYwgv7ZkHFZVnprE1qXXCXHKpmHJV6IPM69zpZz1o+08xqweGfO
 TIvP7m0mT5bs/xctVDmR0NcMO8f7wK27QYQvjVex20JPy+impEWrun71AAcJtwtOm4RZCZTLJYo
 5WSaaWIb0SM0DRTwiefuuRU9elCsFx+sTy4ylRNFYVx7CImtzVI/ZGj77AqMyp3qn8+6uY9ETW7
 twGwQMIhjywf4x94PmABqBi/eYOUGpGgbY5xVf4URjcipTbksgP8xY1mvjPem7xit/pAgEsCXKw
 2Os=
X-Received: by 2002:a05:6000:703:b0:46e:6201:3ebc with SMTP id
 ffacd0b85a97d-47501231efbmr501719f8f.41.1782736659411; 
 Mon, 29 Jun 2026 05:37:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46d86960983sm42398291f8f.4.2026.06.29.05.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:37:39 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 12:37:37 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
X-Gerrit-Change-Number: 1736
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1736?usp=email>
X-Gerrit-Commit: d809e5626304963ddaff0a8b8ff1e3a6b2db8c09
X-Gerrit-Comment-Date: Mon, 29 Jun 2026 12:37:37 +0000
In-Reply-To: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
References: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTU2MDk5MDAwLkliN2Y5YzljZTVlZDc3ODE5MDQ0NWNjNGNmYWE4ZjNjZDVkMTExMGJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <45b14ddbd3d3fcb4b7c23648596ebd2aa765b6d5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weBFG-0003M1-KU
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win32: fix plugin
 trusted-dir check prefix bypass
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
 lstipakov@gmail.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3860530592127851511=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3860530592127851511==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rRFfniXlJ64="; charset=UTF-8

--rRFfniXlJ64=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, stipa=2E

plaisthos has posted=
 comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1736?usp=3Demail )

Change subject: win32: fix plugin trusted-dir che=
ck prefix bypass
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1736?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
Gerrit-Change-Number=
: 1736
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: cron2 <gert@g=
reenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attenti=
on: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Mon, 29 Jun 2026 12:=
37:37 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--rRFfniXlJ64=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, stipa=2E </p>
<p>Patch set 2:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail">change 1736</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib7f9c9ce5ed778=
190445cc4cfaa8f3cd5d1110bc </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1736 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div=
>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa=
 &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Mon, 29 Jun 2026 12:37:37 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has=
-Labels: Yes </div>

</body></html>
--rRFfniXlJ64=--


--===============3860530592127851511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3860530592127851511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3860530592127851511==--

