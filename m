Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35C2CA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YZBhWyJmaTwl1iXZAWrEoA2oINOXDQg/wUZvW8MZZ+4=; b=f9CvAz9mu00aAiFTaoAQtWLB0/
	0pfQbql+xKHQ67jsakEUuaN9p5QIDMJta507Qn/BRlrOKqMgLL6SQquM9rfPpbWZvaWRsaS54sds4
	ShiWNpAp1fFfdCtQ19sTRogpYYYEUkD8Kh7b5fRsGwE99ZPur9Qo6L6uiME2BrQ9Izuk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBCEi-0007KU-DW;
	Mon, 28 Sep 2026 14:21:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBCEg-0007KL-Kr
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:21:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tP8GqWn+0PIk2zgRfa+luL5ebNmVTEatTT6ZzwK7a2o=; b=KKp6RLpGZSnOKlTR3dBLK1KeK9
 EigaSeQqMfseOJXfvgNlEInDLktswDerOejk9oJtGQxt/nHgVsvFpOSm+TQc5NENXGP/4v9yk0KtC
 JVbAzCc1qg8vxlAnE+gl2NgW/Yxsmc2DiZW3ZIu0sJSJ1m351jk34BAx6umch3gE7h5U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tP8GqWn+0PIk2zgRfa+luL5ebNmVTEatTT6ZzwK7a2o=; b=i
 j2OWjTGsndorbw8DlVa6/29BfhiSfzgCbLmNVwCB1WHf3aUYLPz4FLTA2M9/rD5Kydz2DKON/N59v
 ASxEI6DkoFq40oCoJlyK7EQK5/59qrrJp0/1Sz/Rp8GUKx8EH8+GnskCbJc4VhKb47PlbWpoWXSUm
 tRx8uK/zy54iS+ck=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBCEd-0006c6-Fi for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:21:40 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912df756so24479895e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790605293; x=1791210093; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tP8GqWn+0PIk2zgRfa+luL5ebNmVTEatTT6ZzwK7a2o=;
 b=RS01yR5xXdGNhq5L2yBe8TFqsG76OlVKbl51rPoLqOqDVhfNwP6sjx01HWc/MDqoZu
 ifR4WOJ4A3XeEERR3x9dKJmngkn9cGCFfql2XFvTxK8cGnrhq9YeaQ/U/j2VEktBwe8Y
 cD74ijrcjv+izWHUYUyi+B7jyTrWDSzT2ppCFWtLhd2IXxoxmUDqsdyGbZqLtntFfFxB
 ebKnJA/YNyPnr6k8RKdfJi/vUrrVsvltZacdyqZB4V08GJkCEC7JEbBztsCA6iIcbaZu
 nTsfGF9esHj3aIDPcAuYDLZIjeZkJtpPN8tNLa/bhqkgfzn2sP1c47Df2jvCRFCrJ4MJ
 Ljmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790605293; x=1791210093;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tP8GqWn+0PIk2zgRfa+luL5ebNmVTEatTT6ZzwK7a2o=;
 b=b4vhg4zjmX0sSero04fX9L4zv9/Nhtkw4XodBOhp8jV0VSnug/x5QgJs9lPpoCWEar
 Co3rxHqV4kv0iIg4OrBlhmCq3WNJjYUzzTkp9+U6y6wA00OO3HS94dZ6Md27KnjUiqor
 ORL3t8CAIW8imiEkZXuumdsa5lF2C8nT/yZaLu45DWYk6c028p2BCWZKahrQ7EA/YmL4
 kWsK2Uc3nBjsdQ1u8a1GY3kjcVSMrdp4gYJVczGFZG96w5pXFnJulRXobwW63i8Nba3o
 nHLzn+rHu2GIUgqm9o/6rYhsNqUSsX0oSm5+Zz6JjV0jY29GsUucoz+b5xYAU7T3kciO
 Vvuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQKnCiR8IEqFnHPmqkrYFOz00x7Cha1nSIgaSLFI0leFbsPNSnKTRCdqV52BV/6986ajJ4hrvP1CsGOp7c@lists.sourceforge.net
X-Gm-Message-State: AFuF++nwv4dT7mDHBWxZUUs8r8tEQUmME9JoSoiujwjN5QA9HFXcshW/
 nmXp19agUJ8hKSl+fonWViW+BCV0Owd+WhicS5LvMEqQZ4Jzwt7+2rKRWGGSPKxiTue2k+cUrsK
 D2/l1E2VYQHxf3IE6gfLdK9BTfWiRdBOOHmd+fSJ3UHLORRVNXLWBI2s/GpLeG+SeluumNXEWjQ
 kayrlxpA==
X-Gm-Gg: AYBFou1G6q07YYYy3dAr17681HoRPWqplN6Itm/MFyMPZgCZQoOk0bQHNHBy7YbBnA2
 sDMX9fxhtO8eBiPM1E1b5GpQ8fdUzO6/BlmaRg3SthC/jbKOwj4nD8YyobSMNt3qnK4fgKudgLv
 TQvD3nHV937QfThNamTFbpT2D6fSNxlrLXmfq0MdxwLefj8wOO51rNQun0EE/IwZjf/0ZjGivGR
 WSjg+FexERah+gpXrTsJYyqqBCWyJsfJ31ts6TRkEVX12N+MqZaKHZAyT13+Dy5KU6Qx8TYzlGH
 l+uUHhnZkYchMqq9qy16OzhzQbAged2vBg7ivRXsNo+OFY/Bn8Ng1dOJOoGpJ6vgIMP9+KBpZ/a
 qyrNdWPuTKAY6pAvsBsFfjxBJTwMHCNSQZB/0uKW8UuR/XFJJJhYewhX8XePId9r+m1dV9L9X0o
 Hh7KexTwSozIDQqJyuEDF7RZPv5WaKbsHmhz0xKpd8v71UXu+AYP/+k9En8xiCpnsj9R05AiYaX
 iZEGVvC9kp3VDkHLBqXdFt4B1VknlmPEKSKWPWQldHJ9PbttdqwBzROwb/lPVaTYqgYhAO4D4/H
 ZJuan9PSbqNtwVbBoO+0Lq5CniJ8T3jyJ8+LCuB8LpYKl/KFotqElSIaz3zVFA==
X-Received: by 2002:a05:600c:4fc7:b0:49d:433:c3b6 with SMTP id
 5b1f17b1804b1-49fe66eefa4mr248975785e9.27.1790605292676; 
 Mon, 28 Sep 2026 07:21:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm26001817f8f.5.2026.09.28.07.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:21:32 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 14:21:30 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
X-Gerrit-Change-Number: 1955
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1955?usp=email>
X-Gerrit-Commit: 7f48516ea1d96c7a8545cbdb1292def401ac411e
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 14:21:30 +0000
In-Reply-To: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNTk5NjY4MDAwLkk0NGQ3MTcxYzdlNGY4NDk3YmY4YjkwMjM4MGRmOTJhNThiZjhhNzlhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f17fe8cff88d38a18f216926c99688669babc37c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBCEd-0006c6-Fi
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6452601547306403347=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6452601547306403347==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5Z4mH3DAOn4="; charset=UTF-8

--5Z4mH3DAOn4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1955?usp=3Demail )

Change subject: Build against Win=
dows 10 API and remove some backwards compatility code
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Com=
mit Message:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955/comment/594d6e=
be_7e1296e7?usp=3Demail :
PS2, Line 13: versions anymore, so let's also rem=
ove that=2E
Unfortunately, if I'm reading this correctly Microsoft still su=
pports things like Windows Server 2016=2E



-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
Gerrit-Cha=
nge-Number: 1955
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ra=
zvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Comment-Date: Mon, 28 Sep 2026 14:21:30 +0000
Gerrit-HasComments: Yes
Gerr=
it-Has-Labels: No

--5Z4mH3DAOn4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>razvanc has posted=
 comments on this change by flichtenheld=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955/comment/=
594d6ebe_7e1296e7?usp=3Demail">Patch Set #2, Line 13:</a> <code style=3D"fo=
nt-family:monospace,monospace">versions anymore, so let&#39;s also remove t=
hat=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Unfortunately, if I&#39;m reading this correctly Microsof=
t still supports things like Windows Server 2016=2E</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955=
?usp=3Demail">change 1955</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1955?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1955 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon=
, 28 Sep 2026 14:21:30 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </d=
iv>

</body></html>
--5Z4mH3DAOn4=--


--===============6452601547306403347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6452601547306403347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6452601547306403347==--

