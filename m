Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008DB606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QpQLVi+A;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IcXtT6ZN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LDnbari3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V/WxAffv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gsz28SZZrWWLErehd7jXtM1Axz9Gbj17uGuFlGUzzTs=; b=QpQLVi+AB6oJBxiYUkTKGUf9Z1
	QrbAl2hEmylLZE15fEPIIAtZHUOptcw01+WvpqsXioq+o/Gg5+lTbevpHjbmIqTcLpa5LU924IWhY
	E7G6MHATlIDeYdGhOKLDYKdl6HFHgatXWWZCnV1wdSQDTqw5r9YOBvi0ZkqrMFuSdrLE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWY5j-000000008Dl-0Zu6;
	Thu, 26 Nov 2026 11:56:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWY5h-000000008De-44UK
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:56:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Zri62XYKyh6QwqWex15417GQNCjEWVjoKsVdFAh2OM=; b=IcXtT6ZNbTagtwPwKWLzpKEh7z
 aoSCG6eXzN53lhKLEl0REsKoEcKiIy7EkCSbSf4r70Y4y3ndS+a0VgLF9e7MTcSWKI0OQd6NqDDKT
 NmdLF957rauD7mOSrbgHAMnmbM51VKld7rVe/zNejL52K1JG848xpchIo0p+YqVXFNxQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Zri62XYKyh6QwqWex15417GQNCjEWVjoKsVdFAh2OM=; b=LDnbari3hE4a73MfKZzkgCXrpi
 VqvGChpH9aBTNUll8TSMtPsfNaImf8p4fsrfhqu6WTbodGHcjB8Q6+CoBLcfJFBTLYiQQpvHMMjOU
 ZOul7bRg4LKdXREnzjCooavJqmrJj1xyFcMaHXK60MV1w2t59pax8oXbzqhs1vubpSXc=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWY5f-0000000068R-03lq for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:56:41 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso50258785e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 03:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795694192; x=1796298992; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+Zri62XYKyh6QwqWex15417GQNCjEWVjoKsVdFAh2OM=;
 b=V/WxAffv8/K6ekhNdu77UDx4Ro/GjFLPBLBNKn55tq6sz8Wwo8MtIQrepPM8TqpET5
 2cfeoa/KrUUPNfZVDZlJ+u10fXqB/JcAVvHUFhaX92W6y02zeYx7ap8fbXd3pBdvMprC
 dGa7dJy1YlyIgDfsSdR0L0pQ1RvzZPn+H/yXaXdtxDojK6VnvLscD9zqUS0EaSOqTpO2
 qopPatdT1emYuapx6WnA3vAPolW4/ReyE7OeadiTfJADsv2s9MaE2dFKOwNj27ir1lfX
 /p+2orD1VJf20uyvRQtfP3j8clna/bnDpXNvxnhrUJ2H9eVrrQi7hBEzbTgoos4rROAp
 IGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795694192; x=1796298992;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+Zri62XYKyh6QwqWex15417GQNCjEWVjoKsVdFAh2OM=;
 b=l+91/jnZoKRkQbv7ux5B97i4Vv5CzXy12Uuz+8dGl/mWlHHdtezhetjLcWAQNtbZRm
 Scs5tWRv/oBu+E7EC5iXzu4cPdnDiMQfE2cVNAwQALmERjB4ynmIU2gS2osPAxpqn7Cc
 B4y1+4QHxG9FWeM9jdyVipTtgViMRFomgHarAbl6j36XtA6e/ePCVYCKInuvSAssfL9N
 eokbvi4tn68ShbqHIl+x/PY5V43ut3xPTWUbY+fvKNynT7c1ACwH+qxBdotGcupMfLcX
 xFW0g1c8/jXPR3KVuQJrTKlC08u+e3cHgNYK74limVB8GayD80JorMRBBkQT6VIxcoOx
 3m0A==
X-Forwarded-Encrypted: i=1;
 AL+hErH44rCpX9gHEo4Ma2o+b1xACYGd4WBpgSyWJaWQFgonH1eOrfVNTZ614WllmQMojhJrmZbW7JRsk8BpXNgK@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+GbXxXMmxlprnw8i2pKnKr+fOKNppZBSeOcYl+SdQAx7DfPtKI
 dXOthpXksmDR1OOxD1mt4cbiqI2Q/OEJYKdH5mfTYjcNga69t57Wu4yDlFPjo4eYH9Vazpt7Lkq
 f7bPRE1jw9OQUJgbcEROFpgR6Qw/6SZq20mFPpUOsio940B2ox9JWj7XqINCIpb072uXD
X-Gm-Gg: AZFdTZcciSQaxIBD1ZASkNTNQYiyxB0Qi1LypQRpHWrYMldd0BS0va93aSLIxZMa29X
 4Y2+nl3/V9rmBVb5RbOfKLJuJoBp946HuG2soyF4Ma1Dq6qSozvIya99u5Euk4fPI/2DxAByl/y
 j1kqXrdFhvzNzv+aalWEhxOykXf39XDiFaSP1I5WDIaI4wZWwoXKj9ayzQrMmFV4isNVNKaUh8O
 WzTp/8j7zGuirMMoezv9n5IGLi/USKTl669tn/aUpLpj4EiB1lrNpYHGxok302HDpPqHWWal7YK
 yEJGQ42mbkHNeX6PfHs87913ImdQkb+B8jTrHC8gwySwCxVFAQ20z/Wgp/FNzf4pcOoN9zjkcaz
 j/yngyV6eMXxPb3nQa95QqJIRpSXpxuSd1K/m2ZAMcZFswN/l4uYOZRxpPsxHqpatG9pG2QKj8a
 50kiu3Mil4O4sBHrqpG3uXhTL8REuGTmGNsO5oUFhknTcPH7vz84z1m/8oIzqi52HgBCuwEwk64
 I2iPb2UAAFqE2UxUw6TWybdCpKFKoUhxPZIvJQaPpG2t76cLRc8npdmAQ3xvR8bgbp7Ulei3lDx
 1X8DJrxQlhCOMkM4e1uVA1XJ4R/42uVm3f/XV3zpt0eoWoAEbk7TiZ2iQQlpxRkNYTg+4hyR9QP
 MWcH0kmNdxjieK+uq6I789cEFR/AZLTR2h0sBcJUcIq1QyAG7sBMrtQarCeGbb3Wv11dDkDyGhD
 iq7wn7X/5QeIrux+AbRUCkd9JhjOwfxVBdj1dN
X-Received: by 2002:a05:600c:4504:b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4bb888284d7mr436137235e9.31.1795694192258; 
 Thu, 26 Nov 2026 03:56:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399d52sm578608195e9.6.2026.11.26.03.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 03:56:31 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 11:56:30 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837
X-Gerrit-Change-Number: 2352
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2352?usp=email>
X-Gerrit-Commit: 873b2cd4bc26da9fe39034cbd8b7add1a858082d
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 11:56:30 +0000
In-Reply-To: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
References: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjkxMDU5MDAwLkliYzU4YjljMzAyOWZmZWE0Zjg3MDkzMTc4Y2Y1MmJiYjQ2ZjZkODM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1a3d38971b7259a8552d110f00448b3bba46a022-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWY5f-0000000068R-03lq
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: fold the
 post-event-loop signal check into one condition
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1753706269990017281=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1753706269990017281==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8L+AkiJzwcY="; charset=UTF-8

--8L+AkiJzwcY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail )

Cha=
nge subject: manage: fold the post-event-loop signal check into one conditi=
on
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1:

(1 comment)

File src/openvpn/manage=2Ec:

https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2352/comment/dcfddf6b_12647a83?usp=3Demail :
PS1, Line 3761=
:                 if (signal_received || man_check_for_signals(&signal_rece=
ived))
If we clean this up maybe better to add a `if (*signal_received)` sh=
ortcut to man_check_for_signals and completely remove the `signal_received =
||`?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc58b9c3029=
ffea4f87093178cf52bbb46f6d837
Gerrit-Change-Number: 2352
Gerrit-PatchSet: 1=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comm=
ent-Date: Thu, 26 Nov 2026 11:56:30 +0000
Gerrit-HasComments: Yes
Gerrit-Ha=
s-Labels: No

--8L+AkiJzwcY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage=2Ec:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2352/comment/dcfddf6b_12647a83?usp=3Demail">P=
atch Set #1, Line 3761:</a> <code style=3D"font-family:monospace,monospace"=
>                if (signal_received || man_check_for_signals(&amp;signal_r=
eceived))</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">If we clean this up maybe better to add a `if (*signal=
_received)` shortcut to man_check_for_signals and completely remove the `si=
gnal_received ||`?</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail">change 2352</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc58b9c3=
029ffea4f87093178cf52bbb46f6d837 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 2352 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Th=
u, 26 Nov 2026 11:56:30 +0000 </div>
<div style=3D"display:none"> Gerrit-Ha=
sComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </=
div>

</body></html>
--8L+AkiJzwcY=--


--===============1753706269990017281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1753706269990017281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1753706269990017281==--

