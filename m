Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CEEC44508
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nE0IBd8XCYVOhED3ZwyLT2YXp4j/V0+S2BAhJ7n+EcA=; b=W0MsVbLrWffzoVz1V2E/nd909M
	UjpGU6CGnBBuP2JiHbTLZjhq45RkOQjMr42Qhm1GQuykGBHu7oLL11iIk1VFkTr6rcch4F4164RT1
	tQ/YJIpWSeukdgcB5vFzWTAskom6HcMsn4emNNoqDUt959h22qe1Dek0uIOZsiclso7o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1qT-0000e4-Au;
	Wed, 15 Jul 2026 15:48:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1qR-0000ds-Nk
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:48:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XD++Q9TRtMseiEq0aa8ZGFK72yarxB5UQYeXINPoeCo=; b=M+f0M6n+6fGAszOjqGVt08uyJL
 L3ewG40XtaurZ5Hx+8juKU9p8HkT80wqkBWRywvkgFvgey9T44MnNcsUVc9bQBpy7hr1k1xnF6v8D
 J+0UKq+wudrHRsWBZOkP754cDWRo1LEn6stYiFoKgLh1mlU/GeeFxDnM3MB3WGhbgmbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XD++Q9TRtMseiEq0aa8ZGFK72yarxB5UQYeXINPoeCo=; b=a
 ZJKp3n3ayD2voIy/jyi/ar0I6CTPdU1+cvzWU5BXMzUIyv0ZvaJZLrrIeeegdp528qRSkWE0d+HxH
 Y4WQNZldbTU4S/jjrOo+XHHZrUfjhKt8Uuxnn/Ei//KFoU4cKIEVFGTFY4EQEETK587ko1B51Yihv
 8gcnbOgDPuA9bsaI=;
Received: from mail-lj1-f169.google.com ([209.85.208.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1qQ-0001BU-Ru for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:48:24 +0000
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-39c8ee87f7eso19061961fa.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784130491; x=1784735291; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XD++Q9TRtMseiEq0aa8ZGFK72yarxB5UQYeXINPoeCo=;
 b=WIyXUvhdywmQt9Uo6yUnuuXks05Q9gahYYhLPAxwQqBM+2Y1j/f1O37MTmvMMEEEMg
 FfC/3xu4RZLJZmbrug/oKQVMzHB8TPqK6PiULK7v/7fQxip1iqTpu02XOSg6k/WivAxH
 Bb4HMSKhWCBf8rygBWA5DcuLboKlfOJwqqRllpoZUCYqifKqTA3ro7f3b+ARrTLyIfX6
 ZeBNhR9ciDx3WHMnnM0yCPQx08nDmD4Nl0rMWk+uktrxbTGTCAdUHxs2ynQgk9zxrO6O
 utiEsZog23jBgCSnw1tcKiqDMkiVqWT3dgDFGk5kDeCZczw+/aG2KXv/tDQM2X786535
 ShIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784130491; x=1784735291;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XD++Q9TRtMseiEq0aa8ZGFK72yarxB5UQYeXINPoeCo=;
 b=MKJhOjuQFpptvInEFC0iH8CKchZhA1W9CHphufqUD3yZJ70AhJz32AkKnFdNijFgqb
 kBMIy0VR7X3rd2C6N+/7yOCE4HdGiIq6tf+uXaRWbkG3EPJ1SFYdB5dkZ7w16EzHrkuM
 vCS0fzDYlbLfo79YKHHESIlH2wQqKvetzaj1Hu9ae2Fgqvcjsy2SPHykp4jqxA6WbJLz
 ikEz8aVIC1aS+n4O9TC+KJG8XQRNzaJSZhGz5D1EoavXBFXa4nmjn2IOtlHWqtCiDdmv
 xkKPyEXL7pLGKWsMo3jErtacF5cfa4JzCeJyOC1OtcC0XxaA7GDtpsOp14L+EDSKIebt
 1h0g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/SZLDGA5pbtriO5ZqN5B+72WYtadGLA4pFxOY5V35vIWAXS8dHTiZ32D0ihOkpt23jC6LUZGspm4vSShs@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwQtbpo8UAed35O7VUw+8RD6/Yo1/WXS5is0WGtR1jKfSEPTb+M
 F5yxBrvIVK/EXiNUFvTuX+rzPUdth4LtR05W+rVxMMHMTYVNzvh8qz5U+clFfYnTsSGyfGBV4sQ
 Bfa5nZ/Irxi+38tdFFfywWeaAWVLXaZXj1anA7ptjmPLnl3rrjjRlJV7SdHacV2yn11gkw8Sh8o
 fWLaGbtg==
X-Gm-Gg: AfdE7cljOkZwOv0eaOTfLAzo4do4LH6zGSMSGbgzMB1uU2f2zB+F1CseUJe/uzh5vKT
 5/ZTHv0rSahagmSm3+7nyDjZW4RlHlzcLtd3ZwT5zP0nUeRLBmknhIDXGyjxkgW4vkeCeegh27X
 E+nI8tWfO4Zy12WkyVBhwgKC3eQXGM+SzonPGIt6haLLeFVdZGJsStnQGVba6FCSvb7GtDCzWx6
 xD7k//DdRdGV9CPtTpnqYW+VeD2tkz35vJKpz9bHiDVKHBWJVPnaP3fNG5TWN8GGt45rX5L/Aok
 YDtcbUO8gqtL/pfJeDv/DrjhgcoxfgrHDA7G/ss0WWQcfIP/NLSOBp0cyDv4mOIhAEt7zkmcuPL
 khxkVUgXWD93+B9yly5UdyKEoDmGNa85/maaFSDixn84qgn7GpGJKpDjEI6T6hnHmXH0Z6Lf881
 FummO6Rjrp0liTEsaKQTCp/CMUX5oHrMDEWmf2gBcKtBJgeKe1oZ/wGB0uDmBhA/9h37xZhN3L6
 dgGds2nU5b4m/r27/cZQbX3wNNuwtAXkwzXcZ6jT9+DBHvMbVOyZ7neWjj2hFtvDPKpRMv0L+Ob
 1Hc=
X-Received: by 2002:a05:6000:178b:b0:47d:e121:1dd1 with SMTP id
 ffacd0b85a97d-47f2dcc03bfmr22416655f8f.17.1784126799296; 
 Wed, 15 Jul 2026 07:46:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e5b8sm15884524f8f.6.2026.07.15.07.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:46:38 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 14:46:37 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
X-Gerrit-Change-Number: 1787
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1787?usp=email>
X-Gerrit-Commit: eff09c2e10f41845757f14d537c4153319af6284
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 14:46:37 +0000
In-Reply-To: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
References: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk3YzBmZjQ4ZmIwMTlhYzdjMmQxZDk4MWI3YjdlNDU3OGZmNWRjZTQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <93154d14c67697e04b52e6b30db4731a78665343-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1qQ-0001BU-Ru
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: push
 route-gateway(s) for subnet-pool clients
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0833569705213619873=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0833569705213619873==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zHR7t9pig9A="; charset=UTF-8

--zHR7t9pig9A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

cron2 has posted=
 comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1787?usp=3Demail )

Change subject: push: push route-gateway(s) for s=
ubnet-pool clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3: -Code-Review


-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1787?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
Gerrit-Change-Numb=
er: 1787
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
G=
errit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: =
Wed, 15 Jul 2026 14:46:37 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Y=
es

--zHR7t9pig9A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 3:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ddd;">-Code-Review</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail">change 1787</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7c0ff48fb019ac=
7c2d1d981b7b7e4578ff5dce48 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1787 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div=
>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Comment-Date: Wed, 15 Jul 2026 14:46:37 +0000 </div>
<div st=
yle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: Yes </div>

</body></html>
--zHR7t9pig9A=--


--===============0833569705213619873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0833569705213619873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0833569705213619873==--

