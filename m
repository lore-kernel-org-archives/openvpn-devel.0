Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747C6CD8C9F
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pDpakk1Lo0PtCqgnQ7QzFrGaXaiLHe2LcnZfoxThofE=; b=Ni1aS0BzcjE3q8/Dl6lzsCMM8J
	qZIfUxn10cMfA8fmUo1y9qCv5H2UHdMh9ixnTTPZ1BnyVpgKnEhhrvl9RhtuMBr26udYUa510JfGd
	skjuNNuRFOWRP/vBgIfXHXgespHF3loax3364n6Sp8umQu9HYjqgrGy4/JTndjeuidmw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWYvc-0007ua-PE;
	Mon, 08 Jun 2026 12:18:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWYvQ-0007uA-TN
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 12:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=b9t9FkWt/JCjkrfaqWZmgNpnHGVkEGRZV1qUn1A78I8=; b=AGvudtrIsEuGyvk3lg0l6Xa1ge
 7cOPC+J55OnQ8DPyuprdvxnY3OlqZxSopl51Jocw442OUHFkR+czrxKpep5tjA1kUibqOw1XF76H/
 6xekjm2rMxHfgknr0gwjkj8l4LjhI0x3jvZN5DLA66cgb+b9PZ5xS5G79reGq6hAM9nk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=b9t9FkWt/JCjkrfaqWZmgNpnHGVkEGRZV1qUn1A78I8=; b=d
 GIO9tRjmxWhhM1yaLOuQ2diHa5rMHi+hWfiB0x+/JYuSREsOv/2z5+HowyotJzC5BSvP8+/HU+r+Q
 s+I67eUqXGNFp1ORAIFdhjxM10klJXZvENOLLvn5uJMDyYnsVuSXxB3aSc0B2FqK0xU5veR0noUKU
 mKqFI3eizZvYqlro=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWYvQ-0005Ce-8x for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 12:17:53 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45e9f4a3510so1926261f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 08 Jun 2026 05:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780921061; x=1781525861; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b9t9FkWt/JCjkrfaqWZmgNpnHGVkEGRZV1qUn1A78I8=;
 b=LhCPuFRELTur3nnc4uFk4e7WgPe5OEmB7X08LoKpGfLvYEHOrvviArT/BVID/7IEXk
 F6lJXumYJcTqxBHauko+4qyIK1/TCeKgCDvBITV6xe5BW5fzfjCcmhjmQb+iMJD7NycG
 gO/v3M1x7GbTPXLcGV7exlNoKZAxdEJWwOd4btiu8yo4ZOpur6PvTjoq32BhX7kZLHs5
 EGCdaIriT47RLwtVtfAyIYdp9XNbFF2mUhWL6WPTcGCI5XnC5tdjZ61La61WHD2/jqHe
 1MsPtQ3mIKMDpUlg/Lu/Ghx1z1u/RbMUlYlvWP5EUHXVgYnZW9uV7jx9xCFNWY7ugB0G
 vCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780921061; x=1781525861;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b9t9FkWt/JCjkrfaqWZmgNpnHGVkEGRZV1qUn1A78I8=;
 b=SfficWKetRnQfKZ2kW3c18Fpf1e+US4DB28VDf1waV1ztptzs4sePwuE1CpWbS7340
 wlwmIYZXRE9RxI7Bi9rgFmDJ9NAcXHRpXVZmDptzGxBkVeG9vdEAicAnU4FauKS4vbLT
 R1cn8ZzrQA0WpvpYtAxirxJxckPP2I4cQfCO1ooyc5p6EaakAQprHgtIqbUQl190Q2pj
 0nY6VjNF8ja3YsTiPkasqTGuTTVxZY0yWFVipP53g3UF0c+nTC1iC3wr7gplXN7862vi
 b8svk9lhNHvABYPembSS1DTg/U/ZTw0s8ggws+Xbx9Sf+7Mkr7bG2x/1r4XwgmswvvN+
 VTGg==
X-Gm-Message-State: AOJu0YwyUeBR92lNsV7Zwnz8tpY4JW0AZf8vrQC8N8X5W61YVwd/rUQs
 aXJ/lzJDSboBsepEXb5SfCMD8nGsk7PxmZfebsE/JK+b2ttTrgcwnJseCQzOphxJMxFBWglkOHq
 hcwvXHgM9A5iPJfNazw00isy5RqIgGA98ppEHv4NiS0+ySDqKBPW0vU5L9jiTSraVtgCOoUtCm2
 +RTF5J0g==
X-Gm-Gg: Acq92OGAr2l5tcIAECivOG0+B7Pcew2rjaYLpB+tXAThRx0KF7f7l2BSNPOD1Zgnzrb
 bAaW5Sz58mt8bnD2a5q2Qxw0H9ezQ+YjwpaAfPL8XIezowJO5b4viWHgHwjnr6cAO02QGcyuKwf
 O2FIw6duC4FIBmRCYsKLwnNgk1+9BEl3vq7TQEhUYxiaWrSiVJh3ViPe1LRPTekLHswKDEIvHGT
 v4BK16sT0+KsKvKmST0fGRj8l9aZzWyjFU/tyKOP2j2uLAbMq/zx0NI10JiTEpHn8QcfZ4dOl1I
 KQHYwUzVq8LsgYL4IztVMKw1ZkAPXBUeN6xkuC1U9kqhtgKIxOYPMlw8UkdIxNfMkybLESGHfcB
 FTxezcqLzzV5Fvr5ChSyshsGbewKVtXTpp+M5NG/Pp+OwFDLY0nEkpyo23YmcNUtWaM5Wbdu0dS
 UqLlADryYe/XcKiUOAi7H24JlKWhOZIPp5JJif+07PsaAzpcQuysL/GBt2JVVRA9xg6TGpVEYnv
 PU0wCr+WqBYQax6O4cR8C0qum5TEnpdbGiRvfl1GL88lKp/PpL+p8J/rSCufBrgWyXo6k0u2wP+
 cbfffF+7RqbLLHv9gwfff8Rj
X-Received: by 2002:a05:6000:2993:20b0:45d:3cb0:5ab1 with SMTP id
 ffacd0b85a97d-4603065272cmr18252974f8f.38.1780921060311; 
 Mon, 08 Jun 2026 05:17:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f360bd6sm55791089f8f.36.2026.06.08.05.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 05:17:39 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 8 Jun 2026 12:17:37 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
X-Gerrit-Change-Number: 1708
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1708?usp=email>
X-Gerrit-Commit: 8a9c342fce957230cde794d24e61d3fb791a4f70
X-Gerrit-Comment-Date: Mon, 8 Jun 2026 12:17:37 +0000
In-Reply-To: <gerrit.1780919555000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
References: <gerrit.1780919555000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgwOTE5NTU1MDAwLklmZjhiMzM2MTI2YTVkZmY5ODcxMjEzNjY0YjFlODU4NWZiNzBkMjFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4dc744743af50ee01d9d0cc5ec0612200d83b605-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWYvQ-0005Ce-8x
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Ensure pushed
 tun-mtu is no lower than TUN_MTU_MIN
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1987908208047368429=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1987908208047368429==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5+IyNALo/CE="; charset=UTF-8

--5+IyNALo/CE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

cron2 has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1708?usp=3Demail )

Change subject: Ensure pushed tun-mtu is no lower th=
an TUN_MTU_MIN
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1708?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
=
Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
Gerrit-Change-N=
umber: 1708
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 08 Jun 2026 12:17=
:37 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--5+IyNALo/CE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1708?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1708?usp=3Demail">change 1708</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1708?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: rele=
ase/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff8b336126=
a5dff9871213664b1e8585fb70d21e </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1708 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cro=
n2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Mon, 08 Jun 2026 12:17:37 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--5+IyNALo/CE=--


--===============1987908208047368429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1987908208047368429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1987908208047368429==--

