Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC9606A32D
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mwjrMoMq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OQZDccYe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iOcFO+uZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=U07WBaxX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tsw6OfPTLW94Q9lL2Jc2gCZXs9PNZKYn+RQ5GnaPdyY=; b=mwjrMoMqNmt9qXmFHEXmAWKuDu
	D9+gPW7AXy6IxaXeN4jP2R9/eRK4M/M7agEMOr/dwidAp/8Q7uKQtSnBrqLBWeAQmu5l8w8C7q3Al
	NlQUJf5Fo2U1iBHDJ9x8yNSzf8U6tQ0H4uVInlu2jc8qhP2rdl6O3wjOANZIhGUa+CXI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOcN9-000000004Fp-100i;
	Wed, 04 Nov 2026 14:53:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOcN7-000000004Fc-22bb
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:53:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pc+xDPni9262q5yTgNRR0wYGviq2D1yQLhQpC3qRrTk=; b=OQZDccYeC6slAAxVFubbxOku12
 WbZAjU7k0Msh6etY7hiqyAnM5z734iaDwWwHxy3gB77ao6w9LCB4phFjdwvlmP30s9Y6BJLyScIQZ
 zYShwlN8a5olhNxkSqRjMS4J5J5PZ4Zjba99kmJHvvGTAW/ERjdF7VsYEPma7p7QBr4Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pc+xDPni9262q5yTgNRR0wYGviq2D1yQLhQpC3qRrTk=; b=iOcFO+uZLs2P6qWtod278QaK7D
 ZStYcfWEvdBYDzde8ZE1iEHSfur3s4GO4rzyoN9rvJSwFxjfMzC+nepOQOidk+RA2Zq4Jb1powFa0
 OS3vOFAARQ01HHsHAiVajVW8CF+j5TkBUrZ6mnqp0QXX7Z1J0jMkUlt/Ed2ggM3PjvwA=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOcN5-000000003jP-3ghr for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:53:53 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so752098f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 06:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793804025; x=1794408825; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Pc+xDPni9262q5yTgNRR0wYGviq2D1yQLhQpC3qRrTk=;
 b=U07WBaxXqbs2gV7Yaq3RS2aUc5NRyg27Gbd8524Ip5DPj0mPNWNO6Xka/z+YbrOPvA
 1/yOOtadIMBZe+DNgvDSKTu28VqmiwpGxaxakBEMgpJuVAwxnsPOYQ5rTcdqhUQ/inQp
 HwNeWgsNj3gZX4h3LfMUvuU5JS/DULzwf39yzEov2zfHBYkxAiENKhmrxQfwBNSi0Fd+
 ZKydwqfF+6QMPxw5Un2wWyA/liJvVvQfh8G0Ou9H4o6W/f595UHMeSF1UvNSefJMxANQ
 5Oe1BhUhqHxhnVeaIFsuNYAxUzFLR8HRo+rNfOalrFut8aHw9NNMqbb/ELF/WHIZ/vg6
 vw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804025; x=1794408825;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Pc+xDPni9262q5yTgNRR0wYGviq2D1yQLhQpC3qRrTk=;
 b=GeZohNtvTrIulhUPS/tI7o0rHqWf9BCodOT7wt6X0DAJckQTGbTFZz5nknRUPpzjeY
 I0k48kDT9EwNhVgSxtLQb4gfvDc9zAGWyWfMqrn5/3+R4Q3I2kdEvw9nWnciT5f4YnWg
 TwNRDV6jEJPIM9+AlcrOrVCKFxGek9uunSOIFWvnMdRWNibc0nn1C21TjBxtQ3YshEbZ
 MNZFMo6Nd9NwPmD/ay2Qe00gSqbVmeVPZCn29PTLikT5+5QgtWaAnfSwh9mkkwAt/Ahh
 IbD3JXh9aKvBraOh0WvHrBtsZTELA2Dk6tw8tWe63vaE0wrID7CQ7WB+2hSZJESjNu9+
 LjkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFzCkj/NSDuROW10Nm3GuWvKRGXgSN3EjpvGSb3AaY99tlL2Q8BOl8pRGeVktBeDOAtRxE3Aom9VupCUKC@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9ZqRVHEdJDvNr0IVm2OlbxN0KLklfYn/a62IXHKjWvhaZlZRg0
 pb0nMEdp9qGNpU/ybyDJ4mFe2YFb8kN7Lo2p2fPd+978N/6+itFX2hRLy5hTxmNfFx8hqfxtzGA
 /f8ryb9Z8D+srF3Dww0Z7RKiyNBjYq/JcplSV2+98bXUZD19/OrbWQxml6w19/6Mv3Epa
X-Gm-Gg: AYBFou0mf9tmdUbbCtLBYRoOxHAaWFfyp3ebfSReacDPFPKtXPthLf188URO5c3dpmy
 5NolJMvIY1RAH+Tl0tWRaOllJjRFGHDl/zvXygf0lNxRhacuqHnq5DRzmYUUPaAKwLsVTjwXt3q
 P04Wh6Qsf/JpDlBHfk+JNi51X7pP5wt3Becq3FOwJGM+0G4pOYGf2GtlTHddNOqwkdHYO1f2PbY
 cP815UH5zskBXCWo76tWRvp2ktxrEOHYi821kGi6OM1kM64uEucsrNT1sj55Dr2dnd17GIXZRRY
 lJCah2qpOE0kxaeLetILy7GxCtuF1IogI4yFFa8j3leO7pHQRo7oIpnbXxTG5IIEhqVQqqhzboT
 bYBOT3R2QX1nLIZ98p9s5C9RFY/jvA9fk2CYToWOnJfOQ94Qp/zLr91VIIHjQKm3dYG07zyxmT5
 lzsag2ON/AYKqUeJZ37/CnT1Mv19OFZNr4PE7Bxe8K7+RE5uyBtCaoOy0UqpYF0H6nWGSmxU6pF
 GAqHAnMRtEhJcXX8F2q9FaDxSMe9oaSOSFiiszNzgl9i08LOClRUGG1f1w5NUuU4ZcXYcN6a8gW
 SMYUZUxKp7k1MH00fwWQSfHA3AMf8Yu07n0rkVGYL/tHX1JQzBDlaSqw32X+hL6n0QK6jsafMxP
 crdw0x5roolrHPQZCKBR1Y7XW3auUuJ4/UKnAeouUMfYrya2UJ/xK2PVu9sI+DjJc73c0mwhoki
 CHtsqEDJypjcokdw==
X-Received: by 2002:a05:600c:8b0a:b0:4a1:742e:3 with SMTP id
 5b1f17b1804b1-4ac185bc4a1mr372474405e9.27.1793804025131; 
 Wed, 04 Nov 2026 06:53:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed08536dsm3889191f8f.32.2026.11.04.06.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 06:53:43 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 14:53:41 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2
X-Gerrit-Change-Number: 2133
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2133?usp=email>
X-Gerrit-Commit: fca817003bce8112ad4bbae42db93157919054ce
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 14:53:41 +0000
In-Reply-To: <gerrit.1793802273000.Iba1db32cd130d092e34a31159f14d3aa37db96f2@gerrit.openvpn.net>
References: <gerrit.1793802273000.Iba1db32cd130d092e34a31159f14d3aa37db96f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzODAyMjczMDAwLkliYTFkYjMyY2QxMzBkMDkyZTM0YTMxMTU5ZjE0ZDNhYTM3ZGI5NmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2854a803ed01626177f6f401c5cfd7640368914f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOcN5-000000003jP-3ghr
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: use
 multi_io_delete_event() and drop multi_tcp_delete_event()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1817855265509207141=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1817855265509207141==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="McLpQCQMFhQ="; charset=UTF-8

--McLpQCQMFhQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gianmarco De Gregori has posted comments on this change by R=C4=83zvan Co=
jocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2133?usp=3Demail )

=
Change subject: multi: use multi_io_delete_event() and drop multi_tcp_delet=
e_event()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2133?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2
Gerrit-Change-Number: 21=
33
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 14:53:41 +0000=

Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--McLpQCQMFhQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gianmar=
co De Gregori has posted comments on this change by R=C4=83zvan Cojocaru=2E=
</p><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2133?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2133?usp=3Demail">change 2133</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2133?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2133 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gianmar=
co De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Co=
jocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 14:53:41 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div s=
tyle=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--McLpQCQMFhQ=--


--===============1817855265509207141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1817855265509207141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1817855265509207141==--

