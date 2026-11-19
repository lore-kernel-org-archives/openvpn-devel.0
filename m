Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58015606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EydzUlNB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nDt8H24T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ir6HZewF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Iv9Kr1SR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GqgPM7jCE/MxDuJ6cnaL2sbGGqleuTG1tyuHDwuyODw=; b=EydzUlNBm9he85vY9iljUIztaO
	iBSuit3BUqUgJiZV0qxnCp4X/LdP9yPsBWbDngmRFezyj1MZ00FV4XW5e277FDXoiNY8zNh4oubME
	r0Ri+Fod9JAeBV/s5pN9oWPpGHwwWLj6AuqNUWLAPf8gZNYa03WfaekrZXZ7SWc+Cb1s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU1rF-0000000087l-2L5M;
	Thu, 19 Nov 2026 13:07:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU1rE-0000000087c-3SJ2
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:07:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r16dHH4gX88wJxv/LRwuircSS/thfKXE2qKapDX4f/M=; b=nDt8H24TSawRnqDSQ7KRZxXi4a
 +8oH/jR0JSTo0R2gXQS88y4+2t7ZyNYgIUZ/qEj7YuaBmx6dTJIecy+bwou+KeL0UUsNLYJiINnJo
 Tr8RvxgPe3STNn0CgcZnES/I/MEBU2QoGjJkSgLZ/1JAZBI9TkYljtqmKgRYnNGFUUxw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r16dHH4gX88wJxv/LRwuircSS/thfKXE2qKapDX4f/M=; b=ir6HZewFi+5o4wouWgiLOBU218
 cboyTiLCQQtoam+upSZuGef2OSjwikH5dRNNGIQouzlifnmFWG7ePB3SfpPUqNipDleiv/OIKHGiP
 0fQnUaMoFfIcitvNtg/zkES84xdP7m0HYfGs4uNHmmoOfcW1F38vp8S8CT13tLx2OweI=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU1rD-0000000017D-09mp for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:07:20 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so1509625f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 05:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795093632; x=1795698432; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=r16dHH4gX88wJxv/LRwuircSS/thfKXE2qKapDX4f/M=;
 b=Iv9Kr1SROqgk+xkt0rXvHkz0QLcJWXqpWzxyKCYTccyYZBuPHVRmmv0xj6NesDejWi
 BiBIJuZVxoYHhvyiz3TNgWoJVBHqXG0GcE1H/PqKbPrXxGmBuBZoD03nCDTJvVzXeoOR
 A7tGySKbWsWtHfIXi25bqyjIt5e+yZs0HzzjI1U/Gzk2W5GBF6u5FPUdyxyOLQ4yRDgs
 hR2wqrSwnk4crQ8V0uJtRpk3zwEydFQ2vvTji11ht07Csc7/d6gV1JaQJzt1l/fAnPHw
 7+YZ8iJ2XDoaBZrbu8L35dzgk4P7vclva+flNxdY60G+DgXYACqqFglH/oOP3LK0MVwz
 Kj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795093632; x=1795698432;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r16dHH4gX88wJxv/LRwuircSS/thfKXE2qKapDX4f/M=;
 b=JvTmC3HZB5QfLPsTGq3WOQtFLLXskNLTIS/7smwtWbJAOhIT/qQm1mbuZQltxcv6PN
 5Of0UtaJLhVR1+1vqaF3vEcmQblIPJnMNqng+qLPB21JJMx+3NDtpR6D1EMotObwPYWD
 fYifN+POBso1vNalTO16jxhddfi3KTj0L9yGQMqqxlZLqc0nK/KtBPX0HWAu9kQUj915
 HnG1B1OpwiKdBVuTfLJzvx7Z3NVcSNg0/2r+DDXMbjrOxd/0EMeW7xm/2zUiuhHmS+as
 aK/uGJ/YuMMJsXgz8Nm60HSa6vIqAnAsGSMQam9YTPQO+dEw/PL/VoHQOfzAPle2xZBA
 X6aQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGo2hg5NsHnC1tAKXhn2crlFn/OHtiIqptUIuFkBJDO/bzE0A+DeYt8Z/3hr6BWjHW1D+/H0J8SyV+P47W+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+hUBVdDayNwYUqD3+3V2Xx8lnmlM73Zu0kOE6VfoZPenzqWTsl
 GRJoFYyhCrRPRVpA+W/Yhmgzog3fuwBR7mhkgU66Bne7pGJEqvpYl9JA+yMnqkm11TtjqMlDJNx
 Bg/0yJWf8ZTV9koIcqBLvIxu+XCOO43xRd+x7E/vN16z8EG0BC4ROrX+g/LfgzOOxJuId
X-Gm-Gg: AZFdTZd0/a087xYqa3569yVGl83K7d0sjTZ8BlpBEy0Kz5ZOgAhvdX7em5bqFhaj92F
 xpINxuLBUFSIs3eYA1yFT+OTjef/mMA5E2pm8P2NDoek/WD+UTda3qoJCmBAzJv07L19tNm1FEe
 nRq2RKX1tLNSz5L2lap26HV74s9iEq5tIjnDOOMyuUlr3M++J9Jakrk/c4YuzgnRYuwrRPyJoor
 3+nNeawAlaTVhZmF2UK5zBuze7g6d4rMTg6UultW6+vNZRj1OjKi5EvoLAH3hB53GsFxu2WsvEP
 35iGL2vfqWqzfPe7nHYS45uPnv76m956SaFQCqPipQ8OxKTDXJ804eSsPFZW/0M1ZvC+YOjFuMg
 EoxovNKmXKCgEE/Yv3VBuFQ3YH8kv9U7uXwxj+mb6N1QCUwVU0pIcDFcG8FJYv8oB0lFfkJwLw+
 tMco2GQK+VXu2TLyaWiViboDBn0dxfiQks9F8jEGwbsSkY/mq3hTucf7VDZygn6f5owp5tg0eqR
 1Icfgm82S4MgpnRTkA5Z/ngFdKWDn3o5eAO4PzsUozVIGNH4svdBZVkU26V90Mgid+X0AU3XWz8
 250CmX6JWRbOZfJnINr3w0pKfTUbvHX3eb05Vx6cQn166DI2CF14nHe81oQ+25CPWXkqy5vS0On
 gNLgqxsGHdKzgBBNuVCUSTh80WsW0y1AMeY1wLKshrlAfMWCfePpkaAmiED8ZAd+bqVf24HZ32y
 EEqOUn7G0bcJ38nbE=
X-Received: by 2002:a05:6000:4027:b0:4a7:5eea:fd1b with SMTP id
 ffacd0b85a97d-4a75eeafdd1mr11065495f8f.49.1795093632161; 
 Thu, 19 Nov 2026 05:07:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6569338acsm10630613f8f.45.2026.11.19.05.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 05:07:11 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 13:07:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2088345f10a630241fbddde68336ea7c1f7b449d
X-Gerrit-Change-Number: 2204
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2204?usp=email>
X-Gerrit-Commit: fe644a439bcc2f81b94365444a6b5ccca68879b3
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 13:07:10 +0000
In-Reply-To: <gerrit.1794861212000.I2088345f10a630241fbddde68336ea7c1f7b449d@gerrit.openvpn.net>
References: <gerrit.1794861212000.I2088345f10a630241fbddde68336ea7c1f7b449d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODYxMjEyMDAwLkkyMDg4MzQ1ZjEwYTYzMDI0MWZiZGRkZTY4MzM2ZWE3YzFmN2I0NDlkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dc251356870c9ca217f9614a63b68c43ed4eadfa-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xU1rD-0000000017D-09mp
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: don't access
 tls_multi in dco_get_peer_stats() during a restart
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, bailetti.tommaso@gmail.com,
 antonio@mandelbit.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Tommaso Bailetti <bailetti.tommaso@gmail.com>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7044819164338371922=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7044819164338371922==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CKW4TTjkx3Y="; charset=UTF-8

--CKW4TTjkx3Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

L=
ev Stipakov has posted comments on this change by Antonio Quartulli=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2204?usp=3Demail )

Change subject=
: dco: don't access tls_multi in dco_get_peer_stats() during a restart
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review+2

(1 comment)

Patchset:

PS1: 
LGTM=2E

I verified on Windows (=
access violation on unpatched, survives patched) and FreeBSD on EC2 (ASSERT=
 on unpatched, survives patched)=2E

A small nit is -1 return for Linux/Win=
dows and -EINVAL for FreeBSD=2E



-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2204?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I2088345f10a630241fbddde68336ea7c1f7b449d
Gerrit-Change-Numb=
er: 2204
Gerrit-PatchSet: 1
Gerrit-Owner: Antonio Quartulli <antonio@mandel=
bit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-CC: Tommaso Bailett=
i <bailetti=2Etommaso@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@man=
delbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Comment-Date: Thu, 19 Nov 2026 13:07:10 +0000
Gerrit-HasComments: Yes=

Gerrit-Has-Labels: Yes

--CKW4TTjkx3Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Lev Stipak=
ov has posted comments on this change by Antonio Quartulli=2E</p><p>Patch s=
et 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2p=
x; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2204?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2204?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">LGTM=2E</p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>I verified on Windows (access violation on unpatched, survives patched) an=
d FreeBSD on EC2 (ASSERT on unpatched, survives patched)=2E</p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">A small nit=
 is -1 return for Linux/Windows and -EINVAL for FreeBSD=2E</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2204?usp=3Demail">change 2204</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2204?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I2088345f10a630241fbddde68336ea7c1f7b449d </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2204 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev St=
ipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: Tommaso Bailetti &lt;bailetti=2Etommaso@gmail=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 19 Nov =
2026 13:07:10 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments:=
 Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</b=
ody></html>
--CKW4TTjkx3Y=--


--===============7044819164338371922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7044819164338371922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7044819164338371922==--

