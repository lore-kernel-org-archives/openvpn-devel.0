Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5C7C43458
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zQR45EiWN0P2MCZwdpFCajAYaEoQs+OpHKx7OMGtSxs=; b=RrR2ALaWY5dosEs4cX6Nbap8OU
	vlvNK2oogC+gmryNMYU2dLBQq9Hqnjip7RD7iJptMXZ50s8awpUk4qmO9i/KoCdP1wfOt7gBIvHOe
	YWapq3qVb1ZRa0r35tavMPkuiD+fopS3CSw8jrqude280gyPBsu5GUM6bs8cYHKn7WBc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgiK9-00059n-AB;
	Mon, 06 Jul 2026 12:21:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgiK1-000593-T3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:21:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/FPX42H1HhBinssfDd90pTkRkW7ufzI7Wlv7RTUINZs=; b=EeGOqKB+WuuPDBXwG5nKjdLYX3
 D8wnW2NZ0KrX7VagrOgUbvGWfeU8EKdRmdhZDPV6hj7Ww5WM+aTorz2TZGXaEk30xY97Qpg3vXWOS
 zgx2mwNE1Zs/XZJ/5lKFJWZ6gZy0mjfvAAxNjRWYI5PV59yerNVUAm6SjoVSNu0uELLE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/FPX42H1HhBinssfDd90pTkRkW7ufzI7Wlv7RTUINZs=; b=J
 xCSny6w7jfHHkukth3r6DVBbNVakBz67dJJSnowluHOIFbutNbDY91nA/n4pNjM55GJQwqC7I4PSx
 Th9zk1EIiJuu5DotqllA2InReF4pIjtgd6JDmQEnmQZWch+qqwnh2WH73ehhcpn7gQ11+HwD/5W8v
 yBzG0WqYfPsfC3GQ=;
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgiK0-0004OQ-IM for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:21:14 +0000
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c12758e75afso355227866b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 06 Jul 2026 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783340461; x=1783945261; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/FPX42H1HhBinssfDd90pTkRkW7ufzI7Wlv7RTUINZs=;
 b=MW+SH8eNyEjEjgnK33SYdlKvxOEihreiIPpI2+58T8RMP+IVBf5ZJ9Mw5Wn1MIK4xa
 rvFa0m4a4JtoSufXiTb7d6mTlwUQ1/mKx5tUYWjpLKrK9cNqP3dsP7w5z/ix7zy3jkNn
 0MdXcXK3tR+uLyrwBmEG5jScjXHGXNkCckepF6pjyYs/8Sz7tbDc0yh9JH10eDnT+mTP
 eF0cb5sA9Pi0eXiHZtdSwL2wyWGHoHAj1McejqEYMCTx0xfKyHaX1vveSCP4YeXlwfvm
 ShFsa7XKulaTwqmfcpy5mnKFSC8gT90LuHeX9HFlUUVMRD/lbXfqsLCLp5b8RXgkPwGL
 gYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783340461; x=1783945261;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/FPX42H1HhBinssfDd90pTkRkW7ufzI7Wlv7RTUINZs=;
 b=DEr14WTxgUqu4xgiL6oJCVWI36U/UdkKlXgTYKJVB4mmzbR63oqSr5FF9/NPekVqex
 Zl2D4ivMOzWV5uX30JcwP1e3/E5pQujYLcDnqCnoiaIy0tb1xs0IbDAqJSz9A6j3ilaV
 CoPsOkNnX3RA4JcyVzQhHE/ZRAgZQBGt2jz070X1BHt/YlM0DkcBfasP2p5NFMUlBMaI
 nX7QSB9I+/evnztqNC4pMz+HTo7z/xWcNDg4RWwHMvAr60Pu+VDMzCNYBQgEDLbZwSDb
 C0r5V6mOJ9JQa6apKTuD9Bb/OvnsoFXy3v4//6LCK8MKUeA0DFzP3TT0OamIUJsrhJUB
 r7aQ==
X-Gm-Message-State: AOJu0YyCmX29iANxGeaZXYEvp2rLaHMF1FkZ9HsB5YflTxuSNfKCCntV
 1PLe/ix7szNoBvyf9qjH6LNMZSgJTMWgPIcS0hjBSP0aoXNzWmZLfASvPQNRqpYuZdJuh4IT/ig
 KLdSXy28UtfyljbTeEzNodMGwR/1mnLeEJl12tLcTBWMOUtYSpKMRe1YNBnolE5k0GEb+
X-Gm-Gg: AfdE7cnhaxeComzcdIi1moKXMmBHVm7a9hc8G7J0kMYwO0M4XMBd0BgJ00Y8OWu92ja
 9yepf2S2MSdpM3k7KCLwYoYLFGYf0e32uMk8LDEKqgkWFuhedpsPlBD2MdhmZsvNArVolN1XNsu
 dqUS0rKhN+AtyDDUYRBiVlHnnEun+dw7BdK0nR6fJkun26YVizISxdxgY6NKhqer/348Yv/WRPU
 ytAZoiBosjIuzrcBb1Cz+XrN5G/fMwek5glQ4QM143/ZipbHFHXYAhQdipLOIZSKe4yQ88GhdMd
 5dLh2lrRfDZzp1qbvhO2pUntjs6ODdjyR3gRonY7zA48eu4dJR6l9HEkm5hMQ5Je3u8etbsl2xu
 igfN/7SjYVjb5jnv8039oiVgPvAc7YEnBKQMJviYvgmOu8uiSpRtRI6P37wnqBYUvpRIeJUgZyO
 Pkm5YNzAYlRX1FpiLsRzTU3esqYASRjwQo8xvQ2foctplLR8Yp4MVqaZYy4lQXyMltWhCHFhN8/
 zuPTRz1Gs9mOqjWvrCWCAc1eOskQXoCUDhTEkRP/LHpxmabVFLMdefp+3etHRnjwN+FcX2pzmx7
 qgGvS5GJBF2LNg==
X-Received: by 2002:a17:906:af69:b0:c12:80f6:7fac with SMTP id
 a640c23a62f3a-c15a687ac6cmr11298866b.36.1783340461185; 
 Mon, 06 Jul 2026 05:21:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e6ccsm25015362f8f.5.2026.07.06.05.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:21:00 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 12:20:59 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
X-Gerrit-Change-Number: 1724
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1724?usp=email>
X-Gerrit-Commit: d642b9938c4c502b162b72b040473201841eaabf
X-Gerrit-Comment-Date: Mon, 6 Jul 2026 12:20:59 +0000
In-Reply-To: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
References: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkllNTUyMDg0NjM4MzIwYjNiYWNlNzZiZTJmNTg5MDEzZjEyYWYzYzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <54ab8d555c9bff97d60c6d7d42dec00df5975fe5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgiK0-0004OQ-IM
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add check that
 username is identical to multi float
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5164764932239459941=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5164764932239459941==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vNvlQ5VEWeo="; charset=UTF-8

--vNvlQ5VEWeo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1724?usp=3Demail )

Change subject: Add check that username is id=
entical to multi float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
Gerrit-Chang=
e-Number: 1724
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 06 Jul =
2026 12:20:59 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--vNvlQ5VEWeo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 3:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1724?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail">change 1724</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie552084638320b3ba=
ce76be2f589013f12af3c46 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1724 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Mon, 06 Jul 2026 12:20:59 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--vNvlQ5VEWeo=--


--===============5164764932239459941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5164764932239459941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5164764932239459941==--

