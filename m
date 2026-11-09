Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DC4606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=P/XCqH+U;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=liPmfuQn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QDio9NF9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Veq7tTlU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=A074BpYD65aWq3ZDyMBSQX5uAcUCgzletZxb0ZAh8Xs=; b=P/XCqH+UCC3/JGG+3CVg77QygY
	k/DD8vM/3cZatoHz9hnaXN52qLQstUBKu4VUZrMBRxoQPRTfgK1X48n9C1P6sBTkerb7HPtu4j/Xs
	rMueWJl7UfRgQljcnFWGAbBId/a3czAwZ5/U4oOiM2WBD7oYgcyfCLLTG5bRWeyut2V0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQSYE-000000001ms-33Si;
	Mon, 09 Nov 2026 16:48:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQSYD-000000001mk-2qfa
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:48:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LYoPgUfNzlLTEnyPgVg5vSjGwgDzo/JqWDYLjmbekic=; b=liPmfuQn97cmfXUga4F+a7RbBD
 SmlvrbvW2vDjNdYQyyn7jVr3RWH81g/BjtId2RWcrRNRxT/F+ZmRE2Kh3FJ2JV84mZuOwTk9430U5
 CYDTqMkGWNju7RSbb0n++vP3LhlX7ZNL9+zNDTgKxHZ8MCaJAwohX5t7MsTpLV5RDAWo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LYoPgUfNzlLTEnyPgVg5vSjGwgDzo/JqWDYLjmbekic=; b=QDio9NF9vwXxprJqWCC+jAE5oO
 F9oR7UrQWVq8h3GGOKklHinWFCrfPHZmBNiX7xq8DYc4XJus0LT/hzmrnJ5uv95Zs5wfoeCsqTsB/
 5M2ozZAW2iBoA8uuI2hg0xB7FsRFPaCmyVenE+/DEuA42t3K06KKQPiD8tPGfMyNLne0=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQSYC-000000002si-1uYj for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:48:57 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so11929385e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 08:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794242930; x=1794847730; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LYoPgUfNzlLTEnyPgVg5vSjGwgDzo/JqWDYLjmbekic=;
 b=Veq7tTlUUX7ejLFFq/qk6SBrTT/b72aqat58VPtcwjdi841d1Z0JxrW1Uegk0pFXOC
 TmsCXOCzdf2fyvMzMoiTXxn/nUtGJsHPubJgvDruSwAeqwRgO1hNcw2mk7A+vds+WTHs
 V0vGNLp4YLzRpy9dc2g/e1pM40wpXlNmKxBsC6NWpJyGg3T59IXrT8vZm2734XZHRUOl
 G5v5jJEj9B222rtY9lF1rJuevC9hmPrerqWIMxB6A++AI25GtcinESstqMkYCBQqr/G+
 NXv6ULBaMVqD9fvZsU7i6plDTOHiWRRmFUocmsExKpULB+JdzIRC3BttRZU32wwuBv6f
 ASbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794242930; x=1794847730;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LYoPgUfNzlLTEnyPgVg5vSjGwgDzo/JqWDYLjmbekic=;
 b=MAl/VDG8PlyJaQ8RxRc80krVzR2EgKNMBS/ifwqN1IB6DmmwIt9R5Vnft9b6OKWQfR
 D8T0lux5GE03raLUaombDqXRikaFjVJkrTrle9oBLF7EalkOCiTNCZsNeR/VKf7JDdOA
 9g4QPAfRSButIrZid9Oo49lB3Yj8P2oWUze8scYoTyZnuFpftnAsdygymP5rxf6Ktk40
 Q5wJQ0hTeQAGXIWNtHHekg2p6Z628jp2gdGIFG0eTM0u8WThmSTRxcDExD6KdB/guDkK
 rxkixRwggtGZOVo/MDm5B+b9nt+gvW4fQfNoGRCRqfcMjpb2bhV5QPMUEhLmcWEYZtxA
 buRQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGdurGUy6ga63JWYT261bsKqwLEk4cY9NSKF9tnGvyoXlYu8ydkDCM6G64LAvBXDU0U9wVxYzNODNhfhP5O@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+7ovoRezQ5DpBvt4o9iHB17Ar+t2ZgL5DdSuizysv2Hh6PPUZT
 fQY2oTO9xTgQAVGD2t4nPTDWloUHMEUGVTU98MTFubYbTNiOUgVpoutkQQei9s0i8AS4f3jxfPS
 wMWWeqlO/HPx9/9TykY/cRGpTwT6Cub7eAhbNKyu3W4DaYD1j6M7ZRgjzuszoHR6MM5ET
X-Gm-Gg: AYBFou0MpZ4wEk4gQN7ldzapF1VaHS/+6dtDeRNuETEFTsulbI8Qlpy+jAbR83R5Fph
 1tvgfxG5GYmAxs/0YTCZCUHqtGsKOs0CA84A9TXpk6SHZM6hu7zH3nhcJXFDMlPgKqFC3RqNpze
 p0nmScS5OAwL9GvR1bYBJVJXOV6shFF2VQA3tb1Ihq2sKmrJDrsOimybBHneyfScS1d0fhc8zOI
 VkXAtsZ4PyT1Y/pc3tJnyDNo5L2nkCWJMC/rwchBqxSMk0wccBcaX/QEuYXjZf5ebl91shxZbb1
 CZYr6GCwt+L9P8t/F4i2ZOgSUJ+84UANNC48g4hXPTn7Rda2+ZtVmeZAkeLP6BXFsaDHTV7CXPF
 RatiPNoLVt9xqtw9FLzUBPPEw2/Q2aFUunBLIXmeyWUglyelPAI9/dQcLGVhNt2bbsym4Fal1A6
 PK0bl88dxFjrgBUWXG7EEyxCM95S7Az21vZAHOD+o8GBoq2bC3PFNO9WxwmQZYXmC6YC6onEfq9
 6tSqSpcBrypE1ya5LDpio6DLPZ3/ncrGevtH0AnOBWvVVh7k6dIqG0yS/Wj3qIgNhyvw8xhcQ+T
 yKhqG35u8AbHpGooAlSclD7Iydf0UUHsKNhjRI/U7mjl84rWdIrNhHzrFq4Tr204+tA1d2T4Dvp
 olvpoN313pdmTiUpYmGBOtC6TS4CcDXvk5d03j1IjnyqFwNWteF7ugJP/bHF4CeYeWG27ravWU8
 pTgijdUn8EMVqGdMEQTIRasAOpwp1RcyySwUQ=
X-Received: by 2002:a05:600d:82d3:b0:4a7:462c:6b9e with SMTP id
 5b1f17b1804b1-4b963c9f520mr89327755e9.32.1794242929566; 
 Mon, 09 Nov 2026 08:48:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea51cbsm12053525f8f.27.2026.11.09.08.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:48:46 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 16:48:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 840af248f93e85d29d3f314fa6cdb24535b780f5
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 16:48:43 +0000
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <73e343a9dec65f2d7f75045074c933c47933d422-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQSYC-000000002si-1uYj
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove replay-persist
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1308873143209503033=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1308873143209503033==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dyz+10UkSAc="; charset=UTF-8

--Dyz+10UkSAc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Gert Doering=2E

A=
rne Schwabe has posted comments on this change by Arne Schwabe=2E ( https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail )

Change subject: Rem=
ove replay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 5:

(1 comment)

Commit Message:

https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2082/comment/6bd6f627_d42c146e?usp=3Demail :
PS5, Line=
 12: This feature saves a single packet id to persist-replay file=2E
> The =
option name is "replay-persist" (not "persist-replay")=2E
Done



-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6=
c6e0fce93815
Gerrit-Change-Number: 2082
Gerrit-PatchSet: 5
Gerrit-Owner: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 09 Nov 2026 16:48:4=
3 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--Dyz+10UkSAc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Gert Doering=2E </p>
<p>Arne Schwa=
be has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">View Change</a>=
</p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2082/comment/6bd6f627_d42c146e?usp=3Demail">Patch Set #5, Line 12:</a> =
<code style=3D"font-family:monospace,monospace">This feature saves a single=
 packet id to persist-replay file=2E</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The option name =
is &quot;replay-persist&quot; (not &quot;persist-replay&quot;)=2E</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">change 2082</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ee231d157459e6=
406f1f4c12cd6c6e0fce93815 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2082 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>=

<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Mon, 09 Nov 2026 16:48:43 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerr=
it-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: =
R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--Dyz+10UkSAc=--


--===============1308873143209503033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1308873143209503033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1308873143209503033==--

