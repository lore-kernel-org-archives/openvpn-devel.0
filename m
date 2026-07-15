Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7274CC44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9F4xZnUPHvWWhFpckUdPDQfvhwoDHfOK0nBsZrvDn+w=; b=RZPgt4taW5jjdxm/CN89CAiiQp
	WEiCtwdrl/yhDF7Z0de4J4j3t9U5N0sESD/UOoWoGx0IvVQni3pDtuDTXhVH/nrIx1VvdYzK3rGf/
	OxJB54mFXkCSeF3VLxXJO/ngElVzGK8hB3KwArHpLiGdEM98gBYg1fo3M464k1XYN1aM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1iu-00060R-3x;
	Wed, 15 Jul 2026 15:40:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1is-00060K-Lf
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:40:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=P9nC3eVknYegKP1GWYxknzSdZBToxUTImSLZWoPnb2k=; b=hA00JsOspIbVjWT2SV95rKdqMu
 86MuSDKHrGCx9Ufk9JPmvHg9Gbsf5K1iHewTAXEqNaiW9MidgIOzwATCUhYZg6X8f8dxVmC59r3PH
 8z8FB+e6Lk87hfIiEGSFpXNZKfduZH0O3lKvlFgVXz2p/V89sKM2YIz/PXLHpIAVmnQ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=P9nC3eVknYegKP1GWYxknzSdZBToxUTImSLZWoPnb2k=; b=W
 8Vj9PAvOKCQ//jfGkCMASVZEjNpjFDkUhyQKdexuS2guTBCGm2wah8oY6Dpz9rN4Q6P+LXONyfF8i
 bjljWU6GIbO/iDIWHB5KA2I8VKG8l5mh/hkJUTY2rv+Od0H3G8dJqb9okpvSxmTqqjZv+9bDD8aFG
 e+o4Np8nNIeqT+kw=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1ir-0000lo-7a for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:40:34 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so3054779f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784130027; x=1784734827; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P9nC3eVknYegKP1GWYxknzSdZBToxUTImSLZWoPnb2k=;
 b=G+GStDnYac15hqehtMJP9pmlT4FlBIOTVt9qnsvj9n87GcUt1B7Gxq0CjFINsoq9Ty
 McM+uVuZORnEbp/JayVsd/+D7cXYaM8sNxoAr62nev7YvNLTCBA8dsjiLouqIqLXzD6A
 PFc/uSJbCr3Vx/+vmmglakT/gaamM3YWKf+danF5jVHvW8NH8bt5zsP4Bth72nFu9A7R
 ioZ3SDcgISXs7y1ucl/ixQNnjlA1QcM9fL5srNYHCKLU87JcdauHmYNiawzrtWSoO4q9
 XaFVslb3YS6NY2bl+nSiQWW53UVZ/m4/xhdgZn9IylC6Gnq+2zUvdZoWMppZMwnLTJVm
 hxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784130027; x=1784734827;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P9nC3eVknYegKP1GWYxknzSdZBToxUTImSLZWoPnb2k=;
 b=DyGrPIgU0TQ3xwFYKStDc9UJVAuZA4gmvB6FCnmNBzr/FHNmGEk8FfBgcKqCLQKAs+
 dnCRHTOKnlFAUyOqu9olqn2aQjJN7DQahpnCaFTvb9n+MqK4WXAIe1p/XeyK8Np9itjO
 4YqMKJYcSYu9OPIhcXvuD1NaDJaSnpOeRPvhtWVdL3I5n9XsUi8DhJY4Bmqj5My40Vic
 4vVhv0x8lR5ExOcYOdxTS3pGzjDrf6X/a4Rc57h4Ja7a0tH3ogxNvgmN91HlEt9Tl9+o
 PrIGXxVVY0DHJsMz4UI30OIOU6f5ZnVQ1r8j6XPWClLmWhKrsBNa9SxF4dDugaSAJTZU
 B1JQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpi+k9SeXkl08DiZFwVk1wzvUUIQHFJEyZTc2pcPPt4W9e7D7h+9m8AtJOC8qs4nRwln8qR6jsuCAx4FNDo@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzqwfyk0isLVUCBY0vzN0I/M9AWeBNu63w2lyzpdjyyaCk6mVHV
 OJ3C0EIP2a9BgAh7dp1ORTWxX1rxRjQ3y12z0E7ej/YcnBLpDiE/ii+KxC8jFfZNwl66wyrBlE/
 /D01bfSuaFv+1q0rNaG9XlnOeQanfmLf1VQA3d/xXCk4o1bQZo6/BvO4rAIzqq6kd4chf7mY4b4
 9T1o4Kfw==
X-Gm-Gg: AfdE7cn/O+qxLTvqL5yw9EuCjmKkffS3bHNOKTu6LDoWclGOoKN6GjDE0cirQyTbfZx
 973RJYFJPKYfxDcmAQ9wt1hRpr38WrAsELE02hAH8qvn600ujv/5Tbg3v3CB78Be8TJQ3ZbsEHw
 R/Omq3qZJ5jntw1+HKSznsjJuPB10AH72DxxoX9bu083Lg4lONSCEnhlq5w8qsApd9i0282+54s
 UEcZjPGjpBFE5pO0Ec/1GtDjFzrBG+npQhab0wM6yp8PTWkBvF64ik1Ha9CmZoDuvIvBk+B716K
 TFKFm6Xwh+TCAGBtpvDOfGvqeNpAmcxsLd/tciT5lEW0sXriiOb++PwO7W2bExK2oHyO2HYI/Ac
 yj2MOxoFMpypc9ZIGNwlM7Q6GGzY848o9tdzkbdGy8yu0IT6HJdlrKSyCxW2/X8zkdIz3jf5sm5
 Y7qY7Y58fXm+W8O5aiWl82WZte3UhI6Vj7z43+7Onah2QJT03Te5SK6w5hMmA4q3tASpkdkcXgO
 unN5m3EF5Gy13f9yfdMYFxzTNo0iBF/+r4njbyS/Bp+481FmtyOHU/plcm0NX63VSGm7/p3paY+
 TBU1idNW0vmWgw==
X-Received: by 2002:a5d:59a4:0:b0:472:67de:27ca with SMTP id
 ffacd0b85a97d-47f488bf7afmr8819870f8f.41.1784130026529; 
 Wed, 15 Jul 2026 08:40:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e0e4sm18495867f8f.4.2026.07.15.08.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:40:26 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 15:40:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
X-Gerrit-Change-Number: 1789
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1789?usp=email>
X-Gerrit-Commit: 08e75f6ea182acd2c9b6d4ca06b5bb35b7b7addd
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 15:40:24 +0000
In-Reply-To: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
References: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTI2NTIzMDAwLkk4MjE5YzYyOTVhY2YyOGZmMTBkZGIyZmNjMjg1ZjgxM2M0MmZhOGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5c39b0b2beba08a1d5123f7a640a44b4cb22c8d8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1ir-0000lo-7a
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: proto: correct
 802.1Q length check in is_ipv_X
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7130908152753508279=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7130908152753508279==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RWR4MplUHOI="; charset=UTF-8

--RWR4MplUHOI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1789?usp=3Demail )

Change subject: proto: correct 802=2E1Q le=
ngth check in is_ipv_X
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2:

(1 comment)

Commit Message:

http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1789/comment/04b7c223_1da50ca5?usp=3Demail :
PS1, Li=
ne 10: Signed-off-by: rootvector2 <dxbnaveed=2Ek@gmail=2Ecom>
> I would mov=
e the Signed-off-by to its usual place at the end=2E [=E2=80=A6]
Acknowledg=
ed



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8219c6295acf28f=
f10ddb2fcc285f813c42fa8fe
Gerrit-Change-Number: 1789
Gerrit-PatchSet: 2
Ger=
rit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 15 Jul 2026 15:40:2=
4 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: =
flichtenheld <frank@lichtenheld=2Ecom>

--RWR4MplUHOI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789/co=
mment/04b7c223_1da50ca5?usp=3Demail">Patch Set #1, Line 10:</a> <code style=
=3D"font-family:monospace,monospace">Signed-off-by: rootvector2 &lt;dxbnave=
ed=2Ek@gmail=2Ecom&gt;</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">I would move the Signed-off-by=
 to its usual place at the end=2E [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1789?usp=3Demail">change 1789</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f=
813c42fa8fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1789 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D=
"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Wed, 15 Jul 2026 15:40:24 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-=
To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--RWR4MplUHOI=--


--===============7130908152753508279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7130908152753508279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7130908152753508279==--

