Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA419C624C6
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Foh7WsUlSepWGl5YZGHMju1CV/p8nqxg83Q0a9AROa8=; b=JozzA81xifXDmxvNDIejLHWcQ0
	1q6/a9z5Cez28uFUevehbIEq4HiXtCQ7lcWhlHvVgwQcbmknWX/+2eT7m++ypSBJzbHbCaJMPWv02
	ZVYbd8vme2dbTeR0XsyyCZ+nRIA+eItx3ZSGMOQjeIyKNHgRS79VeekgSA/cRdi7RF0c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0xTd-0005nQ-O3;
	Mon, 31 Aug 2026 08:34:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0xTN-0005nC-4X
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:34:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=o3az9l8Zcs/lnJBOxKtIZprgCfO0x3ppvO3K9DwD0KE=; b=iwxoDSbJZHRMj+iY7GIu71Vo/u
 0+kz34IF3UEkVfLhqSiFmDz6ByfGYCd34AkdUJsNddqMXY98SQs9EKII1mT9JmMc+rHHesq+ZH23c
 4zHMqvww63/NvmO5fdozQk9hNbbnyQBcCC1sz0/Tk2nRJ5sDtgEPOAy5YeuFKArcqYyI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=o3az9l8Zcs/lnJBOxKtIZprgCfO0x3ppvO3K9DwD0KE=; b=F
 J5tWVmhbbzoR/lr03GA3q5/H5K1nvGgMQMyldDa1YlVVZ/lmRE3hUKK2qcfwtg1ts1aypu7Nu4wLB
 5KIcU9dIXvrqxHYilnkdvAleVLguoSzGYVkbbqRQ4NUk7ogmXMxckuZd9lT3oL1HxWn7D9xA5WNh2
 qqyz0s2PtkCE0QXQ=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0xTM-0004v3-F7 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:34:33 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-482e4998d28so2187841f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 01:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788165266; x=1788770066; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o3az9l8Zcs/lnJBOxKtIZprgCfO0x3ppvO3K9DwD0KE=;
 b=G+3XzFtNdeakgQQvmocuFzBbL6KbRNc4qZDIcljCsMUqU0qU8XNOGAVv09N3NElo/w
 +Lt5CJ1Mvwh/jk1yFdde338wRsU9GFJQP2m7GpM04KNV++30+UMuo0C184IpqMgM89Sy
 KQyYD+XNPTuX6VH16L20ZlFelBrt1xl9aL6YeYBKLSH98MawQ/kxEq9SMLS1iSr/MPEy
 l4vLMGTtzEyMoo2k3EGHRJunlp/m7iZkyuLJSO/3th43hpp0g4lhh2WpMXIiOfGZaDvT
 4KrS2mdmcxbBwnu+4q+1+N5DrazH13uDBVsw8wGkyPndexwuj2YKUApJe1F7VYp9zc89
 5tEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788165266; x=1788770066;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o3az9l8Zcs/lnJBOxKtIZprgCfO0x3ppvO3K9DwD0KE=;
 b=GrUz/yTZYsRGOEG/kurA8QjihC1UbfVxo8lxSP4ZvSqqhCx/mb5SDm+dLPeyYuU8RH
 YuX0xyDMEo3OhHpBpZoadDXyvyNa4ZJ/By1uPAh5bASwnWp+I+UlIvuS9D/Qq6LP+lbf
 mP2CT9D5cfNuiQQLWdXOH1VCACB6FRdN24fxZRMQljZ1sQ7GZ8yz5X7qecV37VL6xDeP
 RJX+NVpLd/CdJlrvxgjphlFtI6OlKaMj6uIFTnAEsIFChdqj5Z+utbzin1gSAjTbHvzv
 UfY+qXZIwpSVgreq1yZngvmeFE+qpjgoMWKjoRF8SH0eJebeJUf5ZGLkV0Db6L9uZDv9
 2w6A==
X-Forwarded-Encrypted: i=1;
 AKwUvByNeVmaGPSq67UmK9GXanPkVlq2w/Idt34nB9c8IcUGWw52MvbKiwISzMJxwZcxWoQJPCXIRHET/DlNq7+a@lists.sourceforge.net
X-Gm-Message-State: AFuF++lcMO3dKUpR9PcWLuw8JJCOv1Elrdxzo0rMyFURww/pedgYz1Sn
 hA2fsIkfcOSWEK7cyPh3lCpo8rVaEPu8gZiK9tr0wvsN0tOL/wU8/qLxuHay1/G+I4ZBKxecFkq
 xQyaelHXqpInPp/VX2KlyZsL9vy2PsSijn/W8a06nLJ/kl8tbb4se3kOtZ0i/D0rk4ifj0yPg6G
 vjxo/35w==
X-Gm-Gg: AYBFou1gKr8hSOrPAjSUdtMurUX5GxBTgiAlSvbeDeotsT2WJ8ED6C6QgaWLhqTuF0x
 3pWUXVHcPM8rPPLd3i0xRvs1nJhxO5Sao92VQdFY6k/veMrLltSTqHUzb/3RQyaYFIPwE39Jt8+
 yqP9qm4c/iWeKt+Ny7XLRPPeiGwneOrgeJlo2KLYOvrypuWWWsLdRK1uqU6SNwg3OMntjXQzxAu
 xDDGjQOXwqreElt1MZePIhT5s0gruQSeOgZ9efS3AIIWR1hkPXIWjovuRfOfwI4kSahArmnGE2Q
 CQ0jt9wWW2EmxTxWdCpTCd0GTvWMnemPkHDljHoGkwfhqELaoN3ld0tAXdXbwSvZybAc6XZEQk0
 x7zdpazQkofeLFDtbx71UdLiuPSNAVzzjOyRkYCRCV0pmqvRzsRFlYJJke8b7tz47u8aU5oPdT7
 JsR4w7rKgrmEUQE9E4Gb8Jojf23PLxc0PLXUv5EE0q9ideTjIaGrT5GbXbzGvZvBoRZd0Q81XKP
 Kgfkz+bSvQeiuJ5V+1PuZiuIO/OvKdyU5Tv1LEltdXFSBlBPsK6FnvUtX4Fx266cgKsOm+ZVly4
 pxQMwyVWy2pivtCW28twLmWx+1Ds/QQYvm4f0uvcoHbGM+9M5OY=
X-Received: by 2002:a05:6000:4911:b0:483:9f9d:59dd with SMTP id
 ffacd0b85a97d-4839f9d6235mr29591323f8f.19.1788165265676; 
 Mon, 31 Aug 2026 01:34:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f16sm23570360f8f.1.2026.08.31.01.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:34:24 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 08:34:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
X-Gerrit-Change-Number: 1884
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1884?usp=email>
X-Gerrit-Commit: 77f457a7dfea2bb62967dea5c43be238d4249be0
X-Gerrit-Comment-Date: Mon, 31 Aug 2026 08:34:24 +0000
In-Reply-To: <gerrit.1788120407000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
References: <gerrit.1788120407000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTIwNDA3MDAwLkk2YTg4NmExY2FjMmQ0NzI1ODU5ZGFiMjMyNWNkMzYyMzEyZGRjNjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ae91ab2e80927d7a02e564b10b9224b48aef131f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0xTM-0004v3-F7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dhcp: Fix off-by-one
 in write_dhcp_search_str() temp buffer guard
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7323095593333258851=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7323095593333258851==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oJ+rJ53ntcc="; charset=UTF-8

--oJ+rJ53ntcc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

cron2 has posted commen=
ts on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
884?usp=3Demail )

Change subject: dhcp: Fix off-by-one in write_dhcp_searc=
h_str() temp buffer guard
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1884?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
Gerrit-Chan=
ge-Number: 1884
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Comment-Date: Mon, 31 Aug 2026 08:34:24 +0000
Gerrit-HasC=
omments: No
Gerrit-Has-Labels: Yes

--oJ+rJ53ntcc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1884?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1884?usp=3Demail">change 1884</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6a886a1cac2d47258=
59dab2325cd362312ddc659 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1884 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gr=
eenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Mon, 31 Aug 2026 08:34:24 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>

</body></html>
--oJ+rJ53ntcc=--


--===============7323095593333258851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7323095593333258851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7323095593333258851==--

