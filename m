Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7C7CD6E79
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 20:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=up5tRZzHllcr+V2VNVgBydnBUOJbmYrm4ANm2C2pHeE=; b=EbX5iaUcfVCgiwG7oAm9QH1h4V
	wg3lFfitgZ8yGCJK4Jrv3ErLaSnmXumhcKz2kJvM1PdoV0abxhlTPPRaJCnDdlKw3Evene/wwfk1X
	mRUQr+1/dwQsTyK8FJ7YvRGhFDC68jzBbE5wuO3AwfJH+Nmg76Gg4N1HKt+blYJQzGlM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWgRf-0000rq-0G;
	Mon, 08 Jun 2026 20:19:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWgRd-0000rk-K7
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 20:19:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=IGRS9bud/CfsnQUHhgcDp+Tkn6DBUOjIbJnyjYZLp5o=; b=YLbWoYQPl+nSzDyIQ9r4/RsBTX
 QFoosGSTX5OTV2To/hb/Vnt6k6CQvBtcKQoPyVWAG4eqr+m/i8uX5T/hiEncAIRL3m4nYwlM6Mz14
 h2kBr49iiCAqypsw6pYAKKDTAKqHxY8l0RwF7zTVO20b+CtAc5RrJs6SByz2gOrVge8w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IGRS9bud/CfsnQUHhgcDp+Tkn6DBUOjIbJnyjYZLp5o=; b=E
 LfnyVCAl1geFKkkqBMzuFdlLJMvkAW4TX3zZxbIWcQgHcBZU0yEmiTLK+lwlmDSG/WBXixMqZLOga
 Nd4Es2Qko7I3kWM76lsoMj/L4/PKMxFVVq0AXibNoXM+hCUMInDqYwnjDQHem9el+LZzV3i3vRGB7
 DYfY2HJxFzn4UBBU=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWgRb-0005Y3-BP for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 20:19:38 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so40420125e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 08 Jun 2026 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780949969; x=1781554769; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IGRS9bud/CfsnQUHhgcDp+Tkn6DBUOjIbJnyjYZLp5o=;
 b=GsQF1PDIaNyt25kHEAvQjozSOhhsmeGfaypoJKQVtkN7naK3FewsnVVP9EmTubuURi
 4h/+xaEU20QEdc5jtGzrtfFsOqf7ijgBrX6ZNjwGskhe4EyvVRSrLS2xA/7D5B1QnJ7p
 i+lDCTFDw+arlT4wvkesQh1YT4M5jmUpiXVa4IPkhIzI5SipkmU3W2ozuvIcfKGK6GwX
 u2dWX9LiclUG8YkAG3ZbOfInuLDb6XhF84dYPHZA6OZCr5l+i80xE91KaElX4uzr0Jbd
 WMsM+/EuqtFjkR6vbgdqSmKfbgBllPqOfuertb9sCH9V4BBFYof+LCKN4/+oaRCgnk5M
 hGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780949969; x=1781554769;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IGRS9bud/CfsnQUHhgcDp+Tkn6DBUOjIbJnyjYZLp5o=;
 b=n2YSQfZg3lpb+zW+Apa18qaDfHe+6ao3qyE6J6wTgbEqXZyZiyi6rHZ7zQYVJTUtL2
 aXKtxGlhttjuK73F73i0S0UM7dFHDmZcAd//l3i25BnH+YEHR2yFGUXKNejwchAPI9Yb
 JFYjokg43sGr7iqJdcqlaXBbgNZyGta5jSyTjU7Dl7/hNvBnItvlf3r0fib9K8H2SwWI
 FkgNgb6k/deUqTjHWAT1bf9oF1WxyfzkWHAKRzv7DXkZYyHXBlKxqEcqGi/S6jQtaNkT
 V6bSDD5D0bAq2aapMRgN1Fg1CZojDyv9bVO4EYHUbGjMxkB6MhJ19yN3RKEEFBeGjNlj
 mLhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4Xuo4dcx8ca/op9JfqeZFtmKxu0Y8v6FECr1YcVcLE60LpdpSCVebg8I9r4+BTZhajV3Rqw89mosYPZ1B@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwxRAUiUWK44OA1KqOzNrxa/KoB6HQDHQqP2M7tGm6A/R4DCONk
 Kz7QeAhjoqrWQXii8ayG3nO94MVT2Ywgfi0OzE00dmrEzv5x2NrovfWjtLuhkZ4XGKjY7cLxbDn
 1XMr0QwAj6IjeR9XFmDq7tI8TcdRdxrMze7+quhUcjDvzUgBGX2ma+aFXIaYGWJjf8Ow5ezFb8h
 3XPbfG+w==
X-Gm-Gg: Acq92OHpORC9Eei4Wujx9zTd6YDzd2Ah9KXVQfgGagy0xwmVsG3N91iWJDBw9Q5uMco
 Mo6BkBR+Y+cyFGKTnJiumnZB0KOZHgKzA+gXS3bUl6OpNyguktjzlz/4weHh27QCvUGr1AZbuJY
 JhtxppeEeB9p69xEa+OOkOODGsC8RUMBS4G8ttPRXOO+xgbYFVPw2ETqw40ksQtPPJI/yiKE4rP
 tiGH+BEIvZ+AfZB4Z62ASpM5gUavpqmU9QA1rKfowMzimJ1XuXnPXH96oftHbbg4KD1zRCeqH/M
 si3UWXyEhEyqvWbNtV6hx03/FO5440F0ppcmaO9pDJRCGum6yWsfb7xYdGCG+zQl+yqzdFrdZUy
 t6dAX+cERjCmNVGTbzENNOBk/JNuZyUbt0pTLhF51sJcwaNDWLxoAh/C/XuxQYwhrWgWlhQw+gR
 rwfWxrm++RXuOJ1159aMn5BggLCooE57+tbGojEJ3fE/WOxuFFsdmJ5eczMeFtxWmWten0XsTqN
 +5FrFHuX87zuSt7oaWPOpbUT2/9tBDu0cbao1g8xu+8jjCzKmru7ICe2Z/WDUUSwnOB9Eys20tw
 yB5gDTxUn9IoAAN9swylI9SV
X-Received: by 2002:a05:600c:3588:b0:490:4b89:5372 with SMTP id
 5b1f17b1804b1-490c2cf5433mr252409595e9.11.1780949969123; 
 Mon, 08 Jun 2026 13:19:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3cbfe4sm429539475e9.7.2026.06.08.13.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 13:19:28 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 8 Jun 2026 20:19:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
X-Gerrit-Change-Number: 1682
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1682?usp=email>
X-Gerrit-Commit: 913767cf436841f1e605089e1b7c2ba5021a335c
X-Gerrit-Comment-Date: Mon, 8 Jun 2026 20:19:27 +0000
In-Reply-To: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
References: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkliNTgzMmRjNTZlYWVjYTFiMTcwMTYzOTY3NjliODRiZGYyYzE1MTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <736b481da4d7049749bede799ec46dd618d7234c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWgRb-0005Y3-BP
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi/dco: simplify
 dco_delete_iroutes call chain
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
 frank@lichtenheld.com, antonio@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1357001073803127757=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1357001073803127757==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Wd2HqjbsPWg="; charset=UTF-8

--Wd2HqjbsPWg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex=2E

plaisthos has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1682?usp=3Demail )

Change subject: multi/dco: simplify dco_de=
lete_iroutes call chain
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
Gerrit-Chang=
e-Number: 1682
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@mandelbit=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-=
Date: Mon, 08 Jun 2026 20:19:27 +0000
Gerrit-HasComments: No
Gerrit-Has-Lab=
els: Yes

--Wd2HqjbsPWg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex=2E </p>
<p>Patch set 3:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">change 1682</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5832dc5=
6eaeca1b17016396769b84bdf2c1513a </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1682 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Comment-Date: Mon, 08 Jun 2026 20:19:27 +0000 </div>
=
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Wd2HqjbsPWg=--


--===============1357001073803127757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1357001073803127757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1357001073803127757==--

